package Weather::YR::Parser;

use strict;
use warnings;

use DateTime;
use DateTime::Format::ISO8601;


=head1 NAME

Weather::YR::Parser - Helps to parse special types of data.

=head1 DESCRIPTION

This module is a helper to parse different types of data, such as dates.

=head1 METHODS

=head2 parse_date(B<STRING>)

This method parses a date string and returns a object reference to an instance
of L<DateTime>.

It takes the timestamp in the following format:
 YYYY-MM-DD HH:MM:SS

=cut

sub parse_date {
    my ( $str ) = @_;

    my ($year, $month, $day, $hour, $minute, $sec)
        = $str =~ m{
            (\d{4}) -
            (\d{2}) -
            (\d{2})
            \s
            (\d{2}) :
            (\d{2}) :
            (\d{2})
        }x;

    my $date = DateTime->new(
        'year'      => $year,
        'month'     => $month,
        'day'       => $day,
        'hour'      => $hour,
        'minute'    => $minute,
        'second'    => $sec,
    );

    return $date;
}

=head2 parse_date_iso8601

This method parses a date string and returns a object reference to an instance
of L<DateTime>.

It takes the timestamp in the format specified in ISO 8601.

Example:
 2008-03-16T10:49:13Z

=cut

sub parse_date_iso8601 {
    my ( $str ) = @_;
    my $dt = DateTime::Format::ISO8601->parse_datetime($str);
    return $dt;
}


=head1 SEE ALSO

=head1 AUTHOR

Knut-Olav, E<lt>knut-olav@hoven.wsE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Knut-Olav Hoven

This library is free software; you can redireibute it and/or modify it under the
terms as GNU GPL version 2.

=cut

1;

