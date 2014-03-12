package Weather::YR::Textforecast::Product;

use strict;
use warnings;

use base qw/Class::Accessor::Fast/;

=head1 NAME

Weather::YR::Textforecast::Product - Stores a product type description

=head1 DESCRIPTION

This module stores a product type description of the forecasts.

=head1 METHODS

=head2 name

Accessor for the name of the product.

=head2 description

Accessor for the product description.

=cut

__PACKAGE__->mk_accessors('name');
__PACKAGE__->mk_accessors('description');

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

