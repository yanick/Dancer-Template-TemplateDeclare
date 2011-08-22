use strict;
use warnings;

use Test::More tests => 3;                      # last test to print

use lib 't/apps/Foo/lib';

use Foo;
use Dancer::Test appdir => 't/apps/Foo/'; 

response_content_is [GET => '/'], "\n<h1>hi there</h1>", 
    "template recognized";

response_content_is [GET => '/layout'], 
    "\n<html>\n<h1>hi there</h1>\n</html>", 
    "with layout";

response_content_is [GET => '/bad_layout'], 
    '', 
    "with bad layout";
