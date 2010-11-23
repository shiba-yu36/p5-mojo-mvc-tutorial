package MojoMvcTutorial;

use strict;
use warnings;

use base 'Mojolicious';

use HTML::FillInForm::Lite qw(fillinform);
use MojoX::Renderer::Xslate;
use Text::Xslate qw(html_builder);

__PACKAGE__->attr(model => sub { MojoMvcTutorial::Model->new });

# This method will run once at server start
sub startup {
    my $self = shift;

    # Routes
    my $r = $self->routes;

    # namespace
    $r->namespace('MojoMvcTutorial::Controller');

    # Default route
    $r->route('/:controller/:action/:id')->to('example#welcome', id => 1);

    # use Xslate
    my $xslate = MojoX::Renderer::Xslate->build(
        mojo             => $self,
        template_options => {
            function => { fillinform => html_builder(\&fillinform) },
        },
    );
    $self->renderer->add_handler(tx => $xslate);
}

1;
