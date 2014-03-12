package Weather::YR;

use 5.008008;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Weather::YR ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.25';


# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Weather::YR - Perl extension for talking to yr.no

=head1 SYNOPSIS

  use Weather::YR;

  #
  # Location forecast
  #
  use Weather::YR::Locationforecast;

  my $loc   = Weather::YR::Locationforecast->new(
    {
        'latitude'      => '59.6327',
        'longitude'     => '10.2468',
    }
  );

  my $loc_forecast = $loc->forecast;

  print $loc_forecast->[0]->{'temperature'}->{'value'} . " degrees celcius";


  #
  # Text forecast
  #
  use Weather::YR::Textforecast;

  my $text  = Weather::YR::Textforecast->new(
    {
        'language'  => 'nb',
        'forecast'  => 'land',
    }
  );

  $text_forecast    = $text->forecast;  

  print $text_forecast->{'title'};

=head1 DESCRIPTION

This Perl package contains parsers and web service clients for using web
services from yr.no.

=head2 EXPORT

None by default.


=head1 SEE ALSO

L<Weather::YR::Locationforecast>, L<Weather::YR::Textforecast>

=head1 AUTHOR

Knut-Olav Hoven, E<lt>knut-olav@hoven.wsE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Knut-Olav Hoven

This library is free software; you can redireibute it and/or modify it under the
terms as GNU GPL version 2.


=cut
