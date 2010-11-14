package MojoMvcTutorial::Controller::Entry;

use strict;
use warnings;

use base 'MojoMvcTutorial::Controller';

use MojoMvcTutorial::Model;

use FormValidator::Simple;

# This action will render a template
sub list {
    my $c = shift;

    my @entries = MojoMvcTutorial::Model->search('entry',{},{});

    # Render template "example/welcome.html.tx" with message
    $c->render(entries => \@entries);
}

sub new_entry {
    my $c = shift;
}

sub post {
    my $c = shift;

    $c->redirect_to('/entry/list') unless $c->req->method eq 'POST';

    # validate
    my $result = FormValidator::Simple->check($c => [
        title => ['NOT_BLANK', ['LENGTH', 1, 50]],
        body  => ['NOT_BLANK', ['LENGTH', 1, 65535]],
    ]);

    if ($result->has_error) {
        return $c->render(
            template => 'entry/new_entry',
            result   => $result,
            req      => $c->req,
        );
    }

    MojoMvcTutorial::Model->create('entry', {
        title => $c->param('title'),
        body  => $c->param('body'),
    });

    $c->redirect_to('/entry/list');
}

1;
