use strict;
no warnings;

use Test::More tests => 1;

BEGIN {
    use_ok( 'Dancer::Template::TemplateDeclare' ) || print "Bail out!
";
}

diag( "Testing Dancer::Template::TemplateDeclare $Dancer::Template::TemplateDeclare::VERSION, Perl $], $^X" );
