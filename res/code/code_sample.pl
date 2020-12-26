#!/usr/bin/perl

use strict;
use warnings;

sub single_line {
    my @strings = @_;
    for (@strings) {
        s/\s+/ /g;
        s/^\s+|\s+$//g;
    }
    return wantarray ? @strings : $strings[0];
}


my $sql = single_line "
    select query_accession,query_tag,hit_accession,hit_tag,significance
    from summaryTables
    where query_id = ?;
";

print "[$sql]\n";


#Prints the message using two different delimeters.
print "Hello, world!\n";
print qq=Did you say "Hello?"\n=;

# This prints the arguments in the same way as args4, but it re-constructs
# the list.  (Of course, if you really needed the list again, you probably
# wouldn't print it this way, but it demonstrates the push operator.)
while($item = shift @ARGV) {
    print "$item\n";
    push @newargs, $item;
}
print "[@newargs]\n";
0x123fed

#
# One more approach is to use the array/hash conversion rules to
# build keyword parameters, with defaults.
#

use strict;

# Print a string one or more times under all sorts of controls.
sub barko {
    # Check for correct pairing.
    @_ % 2 == 0 or
        die "barko: Odd number of arguments.\n";

    # Store the parms, with defaults.
    my %parms = ( 'string' => 'snake',  # String to print
                  'between' => '',      # Place between chars.
                  'repeat' => 1,        # Repeat this many times.
                  'cascade' => 0,       # Move each line right this much more.
                  'blankafter' => 1,    # Extra blank line afterwards.
                  @_);
    # Now %parms is a list of keyword => value pairs as sent, using
    # defaults for keys not sent.

    # Add the between to the string.
    my $str = substr($parms{'string'}, 1);
    $str =~ s/(.)/$parms{'between'}$1/g;
    $str = substr($parms{'string'}, 0, 1) . $str;

    # Printin' time!
    my $preamt = 0;
    for(my $n = $parms{'repeat'}; $n--; ) {
        print ((' ' x $preamt), "$str\n");
        $preamt += $parms{'cascade'};
    }
    print "\n" if $parms{'blankafter'};
	
	
}

# Call with various options.  These can be sent in any order.
barko;
barko(repeat => 3, string => 'BOZON', cascade => 1);
barko(between => ' ');
barko(between => '<->', repeat => 5);
barko(string => '** done **', blankafter => 0);

#!/usr/bin/perl

use LWP;
use HTTP::Request::Common;
use HTML::TreeBuilder;
use strict;

@ARGV == 1 or die "Specify a single URL.\n";

# Basic objects.

# Return the tree of the URL.
sub tree_of {
    my $url = shift @_;
    my $tree = HTML::TreeBuilder->new;

    $url =~ s/^file\://;
    if($url =~ /^([a-z]+)\:/) {
        # Receive the remote data.
        my $ua = LWP::UserAgent->new(agent => "parsepage/1.0 libwww-perl");
        my $req = HTTP::Request->new(GET => $url);
        sub rcvdata {
            my($data, $response, $protocol) = @_;
            if($response->content_type() eq 'text/html') {
                $tree->parse($data);
            } else {
                $tree->eof;
            }
        }
        my $resp = $ua->request($req, \&rcvdata);

        if($resp->is_success) {
            if($resp->content_type() ne 'text/html') {
                $resp->code(410);
                $resp->message("Not HMTL");
                return (0, $resp);
            }
            $tree->eof;
            $tree->elementify();
            return (1, $tree);
        } else {
            return (0, $resp);
        }
    } elsif(-r $url) {
        $tree->parse_file($url);
        $tree->elementify();
        return (1, $tree);
    } else {
        return (0, HTTP::Response->new(404, "Cannot read $url"));
    }
}

# Print a string, with indent and wrap.
sub prstr {
    my $ind = shift @_;
    my $str = shift @_;
    my $newind = $ind;
    my $wid = 78 - $ind;
    my $newwid = $wid - 5;
    my $oldsp = ' ' x $ind;
    my $newsp = ' ' x ($ind + 5);
    my $sp = $oldsp;

    return if($str =~ /^\s*$/m);

    $str =~ s/^\s+//;
    while(length($str) > $wid) {
        $str =~ s/^(.{1,$wid})\s+// or 
            $str =~ s/^(\S+)\s+// or last;
        print "$sp$1\n";
        $sp = $newsp;
        $wid = $newwid;
        #print "FRED: $wid ", length($str), "\n";
    }
    $str =~ s/\n\s*/\n$newsp/g;
    print "$sp$str\n";
}

# Print the node.
sub pnode {
    my $ind = shift @_;
    my $node = shift @_;

    if(ref $node) {
        prstr($ind, $node->starttag());
    } else {
        prstr($ind, HTML::Entities::encode($node));
    }
}

# Print the tree.
sub scan_tree {
    my $ind = shift @_;
    my $node = shift @_;

    pnode($ind, $node);
    if(ref $node) {
        foreach my $e($node->content_list()) {
            scan_tree($ind + 2, $e);
        }
        if(!$HTML::Tagset::emptyElement{$node->tag()}) {
            print (' ' x $ind);
            print '</', $node->tag(), ">\n";
        }
    }
}

my ($succ, $tree) = tree_of($ARGV[0]);
if($succ) { scan_tree(0, $tree); }
else { die "GET $ARGV[0] failed: ", $tree->code, ": ", $tree->message, "\n";}