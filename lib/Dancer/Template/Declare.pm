package Dancer::Template::Declare;
# ABSTRACT: Template::Declare wrapper for Dancer

use strict;
use FindBin;
use Template::Declare;
use Dancer::Config 'setting';

use base 'Dancer::Template::Abstract';

my $root_dir;

sub init { 
    my $self = shift;
    my $config = $self->config || {};

    my %args = @_;

    @$config{keys %args} = values %args;

    eval "use $_; 1;" or die $@ for @{ $config->{dispatch_to} };

    Template::Declare->init(%$config);

    $root_dir = setting('views') || $FindBin::Bin . '/views';
}

sub default_tmpl_ext { return 'DUMMY'; } # because Dancer requires an ext

sub render {
    my ($self, $template, $tokens) = @_;

    $template =~ s/\Q$root_dir//;  # cut the leading path
    $template =~ s/\.DUMMY$//;     # and the dummy extension
    
    return Template::Declare->show( $template => $tokens );
}

sub layout {
    my ($self, $layout, $tokens, $content) = @_;

    return $content;
}

1;

__END__

=head1 SYNOPSIS

  # in 'config.yml'
  template: 'declare'

  engines:
    declare:
        dispatch_to:
            - A::Template::Class
            - Another::Template::Class

  # in the app
 
  get '/foo', sub {
    template 'foo' => {
        title => 'bar'
    };
  };

=head1 DESCRIPTION

This class is an interface between Dancer's template engine abstraction layer
and the L<Template::Declare> templating system. 

In order to use this engine, set the template to 'declare' in the configuration
file:

    template: declare

=head1 Template::Declare  CONFIGURATION

Parameters can also be passed to the L<Template::Declare> interpreter via
the configuration file, like so:

    engines:
        declare:
            dispatch_to:
                - Some::Template
                - Some::Other::Template

All the dispatch classes are automatically 
loaded behind the scene.

=head1 BUGS AND LIMITATIONS

L<Dancer::Template::Declare> doesn't work with layouts yet.

=head1 SEE ALSO

L<Dancer>, L<Template::Declare>.

=cut
