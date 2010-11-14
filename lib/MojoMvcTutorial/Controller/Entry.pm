package MojoMvcTutorial::Controller::Entry;

use strict;
use warnings;

use base 'MojoMvcTutorial::Controller';

use MojoMvcTutorial::Model;

# This action will render a template
sub list {
    my $self = shift;

    my $entries = MojoMvcTutorial::Model->search('entry',{},{});

    # Render template "example/welcome.html.tx" with message
    $self->render(entries => $entries);
}

1;
