use strict;
use warnings;
use experimentals;
use Data::Printer;

sub convertLineToFunctionDeclaration($sourceLine) {
    my $newstring = $sourceLine =~ s/func/sub/gr;
    return $newstring;
}

sub lhsAndRhsConvert {
    my ($sourceLine) = @_;
    my @sourceLines = split("=", $sourceLine);
    my $lhs = $sourceLines[0];
    my $rhs = $sourceLines[1];
    $lhs =~ s/^\s+//;
    $rhs =~ s/\s+$//;

    print ":::::\n";
    print $lhs;
    print $rhs;
    print ":::::\n";
    return 2;
    
}

sub convertLang {
    my (@sourceLines) = @_;
    my @finalLang;
    foreach my $sourceLine (@sourceLines) {
        if($sourceLine =~ /func/) {
            push(@finalLang, convertLineToFunctionDeclaration($sourceLine));
        }
        if($sourceLine =~ /^.*?\(.*?\);$/) {
            push(@finalLang, $sourceLine);
        }
        if($sourceLine eq "{") {
            push(@finalLang, "{");
        }
        if($sourceLine eq "}") {
            push(@finalLang, "}");
        }
        if($sourceLine =~ /=/) {
            my $lhsRhsConvertedSourceLine = lhsAndRhsConvert($sourceLine);
            push(@finalLang, $lhsRhsConvertedSourceLine);
        }
    }

    return @finalLang;
}

sub main($source) {
    my @array = split "\n", $source;
    my @programLines;
    foreach my $string (@array) {
        $string =~ s/^\s+//;
        $string =~ s/\s+$//;
        push(@programLines, $string) if ($string ne "");
    }

    my @convertedLang = convertLang(@programLines);
    my $finalLang = join("\n", @convertedLang);
    return $finalLang;
}

my $program = '
func main() {
    print("printing print");
    my var = 2 + 4;
}
';

my $finalLang = main($program);
print $finalLang;
