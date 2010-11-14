package MojoMvcTutorial::Model;
use strict;
use warnings;

use DBIx::Skinny connect_info => +{
    dsn => 'dbi:SQLite:mojo_mvc_tutorial',
    username => 'nobody',
    password => 'nobody',
};

1;
