package MojoMvcTutorial::Model;
use strict;
use warnings;

use DBIx::Skinny connect_info => +{
    dsn => 'dbi:mysql:mojo_mvc_tutorial',
    username => 'root',
    password => '',
};

1;
