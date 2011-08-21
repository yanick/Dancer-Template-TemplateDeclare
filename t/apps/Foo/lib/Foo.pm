package Foo;
use Dancer ':syntax';

use Dancer::Template::Declare;

use FindBin;

our $VERSION = '0.1';

set appname => 'Foo';

set views => $FindBin::Bin.'/apps/Foo/views';

set engines => {
    declare => { 
        dispatch_to => [ 'TD' ],
    },
};

set template => 'declare';

get '/' => sub {
    template 'simple';
};

true;
