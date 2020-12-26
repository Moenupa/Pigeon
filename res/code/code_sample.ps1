# Instead of performing "DescribeLogGroup" and "DescribeLogStream" API calls to ensure
# the objects exist and to find the correct SequenceToken, attempt to write the log
# entry and leverage known exceptions to create any pre-requisites.
$listOfEvents = New-Object -TypeName 'System.Collections.Generic.List[Amazon.CloudWatchLogs.Model.InputLogEvent]'

$logEntry1 = New-Object -TypeName 'Amazon.CloudWatchLogs.Model.InputLogEvent'
$logEntry1.Message = 'A new message 1'
$logEntry1.Timestamp = (Get-Date).ToUniversalTime()
$null = $listOfEvents.Add($logEntry1)

$logEntry2 = New-Object -TypeName 'Amazon.CloudWatchLogs.Model.InputLogEvent'
$logEntry2.Message = 'A new message 2'
$logEntry2.Timestamp = (Get-Date).ToUniversalTime()
$null = $listOfEvents.Add($logEntry2)

$logGroupName = 'MyLogGroup'
$logStreamName = 'MyLogStream'
$splat = @{
    LogEvent      = $listOfEvents
    LogGroupName  = $logGroupName
    LogStreamName = $logStreamName
    ErrorAction   = 'Stop'
}

# This could be swapped out with a for loop
while ($true)
{
    try
    {
        if (-not([String]::IsNullOrWhiteSpace($sequenceToken)))
        {
            $splat.SequenceToken = $sequenceToken
        }

        # All non-handled exceptions will throw and break out of the while loop
        $sequenceToken = Write-CWLLogEvent @splat
        break
    }
    catch
    {
        # Depending where this call is executed, PowerShell may wrap exceptions
        # inside other Runtime exceptions. If it does, a specific catch statement
        # for each defined Exception will not always work. Instead we'll use a global
        # catch statement and parse the exception message to identify the cause.
        if ($_.Exception.Message -like '*The next batch can be sent with sequenceToken:*')
        {
            # This exception can often be caught with the following catch statements:
            #  - catch [Amazon.CloudWatchLogs.Model.DataAlreadyAcceptedException]
            #  - catch [Amazon.CloudWatchLogs.Model.InvalidSequenceTokenException]
            # Sample Exception Message:
            #   - 'The given batch of log events has already been accepted. The next batch can be sent with sequenceToken: 1234567890'
            # We are using wildcards in case the exception is wrapped.
            $sequenceToken = $_.Exception.Message.Split(':')[-1].Trim().TrimEnd(')')

            # The exception may return the string 'null'. If this is the case, the API
            # call was made with a SequenceToken when it is not required.
            if ($sequenceToken -eq 'null')
            {
                # Ensure the splat does not include the SequenceToken
                if ($splat.SequenceToken)
                {
                    $splat.Remove('SequenceToken')
                }

                # Remove the SequenceToken variable
                Remove-Variable -Name 'sequenceToken'
            }
        }
        elseif ($_.Exception.Message -like '*The specified log group does not exist.*')
        {
            # This exception can often be caught with the following catch statements:
            #  - catch [Amazon.CloudWatchLogs.Model.ResourceNotFoundException]
            # Sample Exception Message:
            #   - 'The specified log group does not exist.'
            # We are using wildcards in case the exception is wrapped.
            New-CWLLogGroup -LogGroupName $logGroupName -ErrorAction 'Stop'
            New-CWLLogStream -LogGroupName $logGroupName -LogStreamName $logStreamName -ErrorAction 'Stop'

            # A new CloudWatch Log Stream does not require a SequenceToken. Make
            # sure we don't use one by removing the splat property and the variable.
            if ($splat.SequenceToken)
            {
                $splat.Remove('SequenceToken')
            }

            Remove-Variable -Name 'sequenceToken' -ErrorAction 'SilentlyContinue'
        }
        elseif ($_.Exception.Message -like '*The specified log stream does not exist.*')
        {
            # This exception can often be caught with the following catch statements:
            #  - catch [Amazon.CloudWatchLogs.Model.ResourceNotFoundException]
            # Sample Exception Message:
            #   - 'The specified log stream does not exist.'
            # We are using wildcards in case the exception is wrapped.
            New-CWLLogStream -LogGroupName $logGroupName -LogStreamName $logStreamName -ErrorAction 'Stop'

            # A new CloudWatch Log Stream does not require a SequenceToken. Make
            # sure we don't use one by removing the splat property and the variable.
            if ($splat.SequenceToken)
            {
                $splat.Remove('SequenceToken')
            }

            Remove-Variable -Name 'sequenceToken' -ErrorAction 'SilentlyContinue'
        }
        else
        {
            # Additional logic can be added to handle other exceptions that may occur
            throw
        }
    }
}

# Retrieve the SQS Queue Arn
# Uses the "sqs:GetQueueAttributes" IAM Policy
$queueArn = (Get-SQSQueueAttribute -QueueUrl $queueUrl -AttributeName 'QueueArn').QueueArn

# Create a new SQS Policy. This example allows an SNS Topic to send messages
# to the SQS Queue.
# Uses the "sqs:SetQueueAttributes" IAM Policy
$policy = @"
{
  "Version": "2008-10-17",
  "Statement": [
      {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "SQS:SendMessage",
      "Resource": "$queueArn",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:sns:us-west-2:902800236179:MySNSTopic"
          }
      }
    }
  ]
}
"@
Set-SQSQueueAttribute -QueueUrl $sqsQueueUrl -Attribute @{ Policy = $policy }