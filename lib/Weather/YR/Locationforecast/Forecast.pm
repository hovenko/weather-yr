package Weather::YR::Locationforecast::Forecast;

use strict;
use warnings;

use base qw/Class::Accessor::Fast/;

=head1 NAME

Weather::YR::Locationforecast::Forecast - Stores data about a forecast

=head1 DESCRIPTION

This module stores data about a forecast.

=head1 METHODS

=head2 new(B<$args>)

Constructor.

=cut

sub new {
    my ( $class, $args ) = @_;

    $args ||= {};
    my $self = bless $args, $class;

    return $self;
}

=head2 type

Accessor for the forecast type.

=head2 meta

Accessor for meta data

=head2 to

Accessor for the to date

=head2 from

Accessor for the from date

=head2 location

Accessor for the geo data

=cut

__PACKAGE__->mk_accessors(qw/
    type
    meta
    to
    from
    location
/);

=head1 SEE ALSO

L<Weather::YR::Locationforecast>

=head1 AUTHOR

Knut-Olav, E<lt>knut-olav@hoven.wsE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Knut-Olav Hoven

This library is free software; you can redireibute it and/or modify it under the
terms as GNU GPL version 2.

=cut

1;

