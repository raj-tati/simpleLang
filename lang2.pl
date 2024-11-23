use v5.38;
use experimentals;
use Data::Printer;

sub getFunctionDetails($prog) {
    my $pt = {};
    if($prog =~ /^sub\s+(.*)?\((.*)?\)\s+{\s+(.*)?\s+}/) {
        $pt->{"functionName"} = $1;
        $pt->{"functionArgs"} = $2;
        $pt->{"functionBody"} = $3;
    }

    return $pt;
}

sub isFunctionCall($body) {
    if($body =~ /(.*)?\((.*)?\)/) {
        return 1;
    } else {
        return 0;
    }
}

sub translit($pt) {
    my $functionName = $pt->{functionName};
    my $functoinArgs = $pt->{functionArgs};
    my $functionBody = $pt->{functionBody};

    if(isFunctionCall($functionBody)) {
        $functionBody = $functionBody;
        # change this on new rules
    }

    if ((defined($functoinArgs))) {
        my $newProgram = "function " . $functionName
                            . "(" . $functoinArgs . ")"
                            . "{" . $functionBody . "}";
        return $newProgram;
    }
}

sub main($program) {
    my @program = split(" ", $program);
    my $prog = join(" ", @program);
    my $pt = getFunctionDetails($prog);
    my $newProgram = translit($pt);
    print $newProgram;
}

my $program = "sub main() {
    print('Hello');
}";
main($program);

