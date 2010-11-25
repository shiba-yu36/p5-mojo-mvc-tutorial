package MojoMvcTutorial::Controller::Entry;

use strict;
use warnings;

use base 'Mojolicious::Controller';

use FormValidator::Simple;

# This action will render a template
sub list {
    my $c = shift;

    my @entries = $c->app->model->search('entry',{},{});

    # Render template "example/welcome.html.tx" with message
    $c->render(entries => \@entries);
}

sub new_entry {
    my $c = shift;
    $c->render(q => {});
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
            q        => $c->req,
        );
    }

    $c->app->model->create('entry', {
        title => $c->param('title'),
        body  => $c->param('body'),
    });

    $c->redirect_to('/entry/list');
}

1;
