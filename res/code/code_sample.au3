#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7

; Checks To See If The Internet Is Connected

ConsoleWrite("Internet Is Connected" & " = " & _IsInternetConnected() & @CRLF) ; ( Returns "True" Or "False" )

Func _IsInternetConnected()
    Local $aReturn = DllCall('connect.dll', 'long', 'IsInternetConnected')
    If @error Then
        Return SetError(1, 0, False)
    EndIf
    Return $aReturn[0] = 0
EndFunc ;==>_IsInternetConnected

#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7

; Dumps a string in three lines as character, hex and decimal. A new output block is started after $iLength characters

_StringDump("1234567890" & @CRLF & "abcdefghij", 5)
Exit

Func _StringDump($sString, $iLength)

    Local $sStringAsc, $sStringDec, $sStringHex, $sChar, $iIndex, $iPos = 1
    For $iIndex = 1 To StringLen($sString)
        $sChar = StringMid($sString, $iIndex, 1)
        If Asc($sChar) >= 32 Then
            $sStringAsc = $sStringAsc & "  " & $sChar & " "
        Else
            $sStringAsc = $sStringAsc & "  . "
        EndIf
        $sStringHex = $sStringHex & " " & Hex(Asc(StringMid($sString, $iIndex, 1)), 2) & " "
        $sStringDec = $sStringDec & StringRight("00" & Asc(StringMid($sString, $iIndex, 1)), 3) & " "
    Next
    While $iPos < StringLen($sString)
        ConsoleWrite(StringStripWS(StringMid($sStringAsc, ($iPos * 4) - 3, $iLength * 4), 2) & @LF)
        ConsoleWrite(StringStripWS(StringMid($sStringHex, ($iPos * 4) - 3, $iLength * 4), 2) & @LF)
        ConsoleWrite(StringStripWS(StringMid($sStringDec, ($iPos * 4) - 3, $iLength * 4), 2) & @LF & @LF)
        $iPos += $iLength
    WEnd

EndFunc   ;==>_StringDump

#include-once
#include <File.au3>
#include <array.au3>
;Test function to write comments to an ini file
Global $IniFile = @ScriptDir & "\Test.ini"
FileOpen($IniFile, 2)
IniWrite($IniFile, "Test1", 1, 1)
IniWrite($IniFile, "Test1", 2, 2)
IniWrite($IniFile, "Test1", 3, 3)
IniWrite($IniFile, "Test1", 4, 4)
IniWrite($IniFile, "Test2", 1, 1)
IniWrite($IniFile, "Test2", 2, 2)
IniWrite($IniFile, "Test2", 3, 3)
IniWrite($IniFile, "Test3", 1, 1)
IniWrite($IniFile, "Test3", 2, 2)
IniWrite($IniFile, "Test3", 3, 3)
Global $Test = _IniWriteSectionComment($IniFile, "Test1", "This is a comment that comes before a section name", 1)
$Test = _IniWriteSectionComment($IniFile, "Test2", "This is a comment that comes after a section name", 0)
$Test = _IniWriteSectionComment($IniFile, "Test3", "This is a multi-line comment|that comes after a section name", 0)
$Test = _IniWriteSectionComment($IniFile, "Test4", "This will cause an error by referencing a non-existent section name", 0)
ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $Test = ' & $Test & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
$Test = _IniWriteSectionComment($IniFile, "Test3", "This is a NEW multi-line comment|that comes after a section name", 0)
$Test = _IniWriteSectionComment($IniFile, "Test3", "This is a multi-line comment|that comes before a section name", 1)
;~ $Test = _IniStripComments($IniFile, 0, "Test3", 1) ; This will strip the comments from before the section Test3
; #FUNCTION# ====================================================================================================================
; Name...........: _IniWriteSectionComment
; Description ...: Writes comment(s) to an .ini file
; Syntax.........: _IniWriteSectionComment($IWSC_FileName, $IWSC_SectionName, $IWSC_Comment[, $IWSC_ForeAft = 1])
; Parameters ....: $IWSC_FileName      - String path of the file to write to.
;                 $IWSC_SectionName    - The section of the ini file to comment.
;                 $IWSC_Comment     - String that contains the comment for the section name.
;                 $IWSC_ForeAft     - Optional: Specifies where to put the comment in relation to the section name
;                                        default is before the section name.
; Return values .: Success - Returns a 1
;                 Failure - Returns a 0
;                 @Error  - 0 = No error.
;                 |1 = file not found
;                 |2 = Could not read/split file
;                 |3 = Not an .ini file
;                 |4 = Section Name not found
; Author ........: Bob Marotte (BrewManNH)
; Modified.......:
; Remarks .......: $IWSC_ForeAft specifies whether to put the comments before or after the section name, 1 = before/0 = after
;                 To write multiline comments, separate the lines with the "|" (pipe) character, see example below.
; Related .......:
; Link ..........:
; Example .......: $Test = _IniWriteSectionComment($IniFile, "Settings", "Now is the time for all good|men to come to the aid of their country", 1)
; ===============================================================================================================================
Func _IniWriteSectionComment($IWSC_FileName, $IWSC_SectionName, $IWSC_Comment, $IWSC_ForeAft = 1)
 Local $aFileRead
 If FileExists($IWSC_FileName) Then
  Local $IWSC_fHnd = FileOpen($IWSC_FileName, 0)
  If $IWSC_fHnd = -1 Then
   Return SetError(2, 0, 0)
  EndIf
  Local $Return = _FileReadToArray($IWSC_FileName, $aFileRead)
  If $Return = 0 Then
   Return SetError(2, 0, 0)
  EndIf
  Local $aSectionNames = IniReadSectionNames($IWSC_FileName)
  If @error Then
   Return SetError(3, 0, 0)
  EndIf
  If _ArraySearch($aSectionNames, $IWSC_SectionName) < 0 Then
   Return SetError(4, 0, 0)
  EndIf
  Local $aTempArray = StringSplit($IWSC_Comment, "|")
  Local $IWSC_Index = _ArraySearch($aFileRead, "[" & $IWSC_SectionName & "]")
  Local $aHolder[UBound($aFileRead) + UBound($aTempArray) - 1]
  If $IWSC_ForeAft Then
   For $I = 0 To $IWSC_Index - 1
    $aHolder[$I] = $aFileRead[$I]
   Next
   For $I = $IWSC_Index To $aTempArray[0] + $IWSC_Index - 1
    $aHolder[$I] = "; " & $aTempArray[$I - ($IWSC_Index - 1)]
   Next
   For $I = $IWSC_Index To $aFileRead[0]
    $aHolder[$I + $aTempArray[0]] = $aFileRead[$I]
   Next
  Else
   For $I = 0 To $IWSC_Index
    $aHolder[$I] = $aFileRead[$I]
   Next
   For $I = $IWSC_Index + 1 To $aTempArray[0] + $IWSC_Index
    $aHolder[$I] = "; " & $aTempArray[$I - ($IWSC_Index)]
   Next
   For $I = $IWSC_Index + 1 To $aFileRead[0]
    $aHolder[$I + $aTempArray[0]] = $aFileRead[$I]
   Next
  EndIf
  _ArrayDelete($aHolder, 0)
  _FileWriteFromArray($IWSC_FileName, $aHolder)
 Else
  Return SetError(1, 0, 0)
 EndIf
 Return SetError(0, 0, 1)
EndFunc   ;==>_IniWriteSectionComment
; #FUNCTION# ====================================================================================================================
; Name...........: _IniStripComments
; Description ...: Strips comment(s) from an .ini file
; Syntax.........: _IniStripComments($ISC_FileName[, $ISC_All = 1[, $ISC_SectionName=""[, $ISC_ForeAft = 1]]])
; Parameters ....: $ISC_FileName        - String path of the file to work with
;                 $ISC_All           - Strip all comments in the ini file (default is yes)
;                 $ISC_SectionName   - The section of the ini file to strip comments from, can not be left blank.
;                 $ISC_ForeAft       - Optional: Specifies where to strip the comments in relation to the section name
;                                        default is before the section name.
; Return values .: Success - Returns a 1
;                 Failure - Returns a 0
;                 @Error  - 0 = No error.
;                 |1 = file not found
;                 |2 = Could not read/split file
;                 |3 = Not an .ini file
;                 |4 = Section Name not found or not specified
; Author ........: Bob Marotte (BrewManNH)
; Modified.......:
; Remarks .......: $ISC_ForeAft specifies whether to strip the comments before or after the section name, 1 = before/0 = after
;                 If you use the $ISC_All = 1 option, then the other parameters after it are ignored.
; Related .......:
; Link ..........:
; Example .......: $Test = _IniWriteSectionComment($IniFile, "Settings", "Now is the time for all good|men to come to the aid of their country", 1)
; ===============================================================================================================================
Func _IniStripComments($ISC_FileName, $ISC_All = 1, $ISC_SectionName="", $ISC_ForeAft = 1)
 Local $aFileRead
 If FileExists($ISC_FileName) Then
  Local $ISC_fHnd = FileOpen($ISC_FileName, 0)
  If $ISC_fHnd = -1 Then
   Return SetError(2, 0, 0)
  EndIf
  Local $Return = _FileReadToArray($ISC_FileName, $aFileRead)
  If $Return = 0 Then
   Return SetError(2, 0, 0)
  EndIf
  Local $aSectionNames = IniReadSectionNames($ISC_FileName)
  If @error Then
   Return SetError(3, 0, 0)
  EndIf
  If $ISC_All = 1 Then
   For $I = $aFileRead[0] To 1 Step -1
    If StringLeft($aFileRead[$I], 1) = ";" Then
     _ArrayDelete($aFileRead, $I)
    EndIf
   Next
   _ArrayDelete($aFileRead, 0)
   _FileWriteFromArray($ISC_FileName, $aFileRead)
   Return 1
  EndIf
  If _ArraySearch($aSectionNames, $ISC_SectionName) < 0 Or $ISC_SectionName = "" Then
   Return SetError(4, 0, 0)
  EndIf
  Local $aSectionNames = IniReadSectionNames($ISC_FileName)
  If @error Then
   Return SetError(3, 0, 0)
  EndIf
  If _ArraySearch($aSectionNames, $ISC_SectionName) < 0 Then
   Return SetError(4, 0, 0)
  EndIf
  Local $ISC_Index = _ArraySearch($aFileRead, "[" & $ISC_SectionName & "]")
  Local $aHolder[$aFileRead[0] + 1]
  If $ISC_ForeAft Then
   For $I = 0 To $ISC_Index - 1
    $aHolder[$I] = $aFileRead[$I]
   Next
   For $I = $ISC_Index - 1 To 0 Step -1
    If StringLeft($aHolder[$I], 1) = ";" Then
     _ArrayDelete($aHolder, $I)
     _ArrayDelete($aFileRead, $I)
     $aFileRead[0] = $aFileRead[0] - 1
     $ISC_Index -= 1
    Else
     ExitLoop
    EndIf
   Next
   For $I = $ISC_Index To $aFileRead[0]
    $aHolder[$I] = $aFileRead[$I]
   Next
  Else
   Local $tmpIndex = $ISC_Index
   For $I = 0 To $ISC_Index
    $aHolder[$I] = $aFileRead[$I]
   Next
   For $I = $ISC_Index + 1 To $aFileRead[0]
    If StringLeft($aFileRead[$I], 1) = ";" Then
     $ISC_Index += 1
    Else
     ExitLoop
    EndIf
   Next
   For $I = $ISC_Index + 1 To $aFileRead[0]
    $aHolder[$I] = $aFileRead[$I]
   Next
   For $I = $aFileRead[0] To $tmpIndex Step -1
    If $aHolder[$I] = "" Then
     _ArrayDelete($aHolder, $I)
    EndIf
   Next
  EndIf
  _ArrayDelete($aHolder, 0)
  _FileWriteFromArray($ISC_FileName, $aHolder)
 Else
  Return SetError(1, 0, 0)
 EndIf
 Return SetError(0, 0, 1)
EndFunc   ;==>_IniStripComment