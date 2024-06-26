use strict;
use warnings;
use experimentals;
use Data::Printer;

sub convertLineToFunctionDeclaration($sourceLine) {
    my $newstring = $sourceLine =~ s/func/sub/gr;
    return $newstring;
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
        if($sourceLine eq "}") {
            push(@finalLang, "}");
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
}
';

my $finalLang = main($program);
print $finalLang;
