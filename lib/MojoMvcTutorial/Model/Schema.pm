package MojoMvcTutorial::Model::Schema;
use strict;
use warnings;

use DBIx::Skinny::Schema;
use DateTime;
use DateTime::Format::Strptime;
use DateTime::Format::MySQL;
use DateTime::TimeZone;


my $timezone = DateTime::TimeZone->new(name => 'Asia/Tokyo');
install_inflate_rule '^.+_at$' => callback {
    inflate {
        my $value = shift;
        my $dt = DateTime::Format::Strptime->new(
            pattern   => '%Y-%m-%d %H:%M:%S',
            time_zone => $timezone,
        )->parse_datetime($value);
        return DateTime->from_object( object => $dt );
    };
    deflate {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

install_utf8_columns qw/title body/;

install_table 'entry' => schema {
    pk 'id';
    columns qw/
                  id title body created_at updated_at
              /;
};

1;

__DATA__;
DROP TABLE if EXISTS `entry`;
CREATE TABLE `entry` (
       `id` int(11) unsigned auto_increment NOT NULL,
       `title` tinytext,
       `body`  text,
       `created_at` timestamp NOT NULL,
       `updated_at` timestamp NOT NULL,
       PRIMARY KEY (`id`)
);
