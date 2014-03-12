package Weather::YR::Locationforecast::Forecast::Symbol;

use strict;
use warnings;

use base qw/
    Weather::YR::Locationforecast::Forecast
    Class::Accessor::Fast
/;

=head1 NAME

Weather::YR::Locationforecast::Forecast::Symbol - Stores symbol data about a forecast

=head1 DESCRIPTION

This module stores symbol data about a forecast.

=head1 METHODS

=head2 name

Accessor for the name of the symbol.

=head2 number

Accessor for the number identification of the symbol.

=cut

__PACKAGE__->mk_accessors(qw/
    name
    number
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

