use strict;
use warnings;

use Test::More tests => 1;                      # last test to print

use lib 't/apps/Foo/lib';

use Foo;
use Dancer::Test appdir => 't/apps/Foo/'; 

response_content_is [GET => '/'], "\n<h1>hi there</h1>", 
    "template recognized";

