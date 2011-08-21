use strict;
no warnings;

use Test::More tests => 1;

BEGIN {
    use_ok( 'Dancer::Template::Declare' ) || print "Bail out!
";
}

diag( "Testing Dancer::Template::Declare $Dancer::Template::Declare::VERSION, Perl $], $^X" );
