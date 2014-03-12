package Weather::YR::Locationforecast::Forecast::Precip;

use strict;
use warnings;

use base qw/
    Weather::YR::Locationforecast::Forecast
    Class::Accessor::Fast
/;

=head1 NAME

Weather::YR::Locationforecast::Forecast::Precip - Stores precipitation data about a
forecast

=head1 DESCRIPTION

This module stores symbol data about a forecast.

=head1 METHODS

=head2 unit

Accessor for the unit description of the precipitation value.

=head2 value

Accessor for the value of precipitation in weight of the unit.

=cut

__PACKAGE__->mk_accessors(qw/
    unit
    value
/);

=head1 SEE ALSO

L<Weather::YR::Locationforecast>, L<Weather::YR::Locationforecast::Forecast>

=head1 AUTHOR

Knut-Olav, E<lt>knut-olav@hoven.wsE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Knut-Olav Hoven

This library is free software; you can redireibute it and/or modify it under the
terms as GNU GPL version 2.

=cut

1;

