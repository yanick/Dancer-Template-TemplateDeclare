package Dancer::Template::TemplateDeclare;
# ABSTRACT: Template::Declare wrapper for Dancer

use strict;
use FindBin;
use Template::Declare;
use Dancer::Config 'setting';

use base 'Dancer::Template::Abstract';

sub init { 
    my $self = shift;
    my %config = %{$self->config || {}};

    my %args = @_;

    @config{keys %args} = values %args;

    eval "use $_; 1;" or die $@ for @{ $config{dispatch_to} };

    Template::Declare->init(%config);
}

sub default_tmpl_ext { return 'DUMMY'; } # because Dancer requires an ext

sub view_exists { return 1; }

sub view { return $_[1] }

sub render {
    my ($self, $template, $tokens) = @_;

    return Template::Declare->show( $template => $tokens );
}

sub layout {
    my ($self, $layout, $tokens, $content) = @_;

    return Template::Declare->show( 
        join( '/', 'layout', $layout ) => {
            %$tokens, content => $content
        }
    );
}

1;

__END__

=head1 SYNOPSIS

  # in 'config.yml'
  template: 'TemplateDeclare'

  engines:
    TemplateDeclare:
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

In order to use this engine, set the template to 'TemplateDeclare' in the configuration
file:

    template: TemplateDeclare

=head1 Template::Declare  CONFIGURATION

Parameters can also be passed to the L<Template::Declare> interpreter via
the configuration file, like so:

    engines:
        TemplateDeclare:
            dispatch_to:
                - Some::Template
                - Some::Other::Template

All the dispatch classes are automatically 
loaded behind the scene.

=head1 USING LAYOUTS

If the layout is set to I<$name>,
the template C</layout/$name> will be used and
passed via the C<content> argument.

For example, a simple C<main> layout would be:

    template '/layout/main' => sub {
        my ( $self, $args ) = @_;

        html {
            body { 
                outs_raw $args->{content} 
            } 
        } 
    };


=head1 SEE ALSO

L<Dancer>, L<Template::Declare>.

=cut
