package Weather::YR::Locationforecast::Forecast::Full;

use strict;
use warnings;

use base qw/
    Weather::YR::Locationforecast::Forecast
    Class::Accessor::Fast
/;

=head1 NAME

Weather::YR::Locationforecast::Forecast::Full - Stores data about a forecast

=head1 DESCRIPTION

This module stores data about a forecast.

=head1 METHODS

=head2 winddirection

Accessor for the wind direction.

=head2 windspeed

Accessor for the wind speed.

=head2 temperature

Accessor for the temperature data.

=head2 pressure

Accessor for the pressure data.

=head2 fog

Accessor for the fog data.

=head2 cloudiness

Accessor for the cloudiness.

=head2 clouds

Accessor for the clouds data, for low, medium and high clouds.

=cut

__PACKAGE__->mk_accessors(qw/
    winddirection
    windspeed
    temperature
    pressure
    fog
    cloudiness
    clouds
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

