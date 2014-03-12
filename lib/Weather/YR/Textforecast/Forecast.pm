package Weather::YR::Textforecast::Forecast;

use strict;
use warnings;

use base qw/Class::Accessor::Fast/;

=head1 NAME

Weather::YR::Textforecast::Forecast - Stores data about a forecast

=head1 DESCRIPTION

This module stores data about a forecast.

=head1 METHODS

=head2 new

=cut

sub new {
    my ( $class, $args ) = @_;

    $args ||= {};
    my $self = bless $args, $class;

    return $self;
}

=head2 type

Accessor for the forecast type.

=cut

__PACKAGE__->mk_accessors(qw/type/);

=head1 SEE ALSO

L<Weather::YR::Textforecast>

=head1 AUTHOR

Knut-Olav, E<lt>knut-olav@hoven.wsE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Knut-Olav Hoven

This library is free software; you can redireibute it and/or modify it under the
terms as GNU GPL version 2.

=cut

1;

