# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl YR.t'

#########################

use Test::More tests => 27;
use File::Slurp; # required for reading XML file

BEGIN { use_ok('Weather::YR::Locationforecast') };

#########################

my $xml_file    = 'doc/example/1.8/locationforecast.xml';
-f $xml_file or die "File doesnt exist: $xml_file";

# Doesn't really matter what coordinates we enter here, we will read the
# XML document from a local file.
my $l_forecast = Weather::YR::Locationforecast->new(
    {
        # Geo codes for Sande (VE.)
        'latitude'  => '59.6327',
        'longitude' => '10.2468',
        'url'       => 'http://api.yr.no/weatherapi/locationforecast/1.8/',
    }
);

is(
    $l_forecast->get_url,
    'http://api.yr.no/weatherapi/locationforecast/1.8/?lon=10.2468&lat=59.6327',
    'Assemble URL with latitude and longitude'
);



my $xml         = read_file($xml_file);
my $parsed_ref  = $l_forecast->parse_weatherdata($xml);

isa_ok(
    $parsed_ref,
    'ARRAY',
    'The parsed data in return is an ARRAYREF'
);

my $forecast        = $parsed_ref->[0];
my $forecast_precip = $parsed_ref->[2];
my $forecast_symbol = $parsed_ref->[1];

# All forecasts should be of type Weather::YR::Locationforecast::Forecast
isa_ok(
    $forecast,
    'Weather::YR::Locationforecast::Forecast',
    'The first forecast is of type Weather::YR::Locationforecast::Forecast'
);

isa_ok(
    $forecast_precip,
    'Weather::YR::Locationforecast::Forecast',
    'A precip forecast is of type Weather::YR::Locationforecast::Forecast'
);

isa_ok(
    $forecast_symbol,
    'Weather::YR::Locationforecast::Forecast',
    'A symbol forecast is of type Weather::YR::Locationforecast::Forecast'
);

isa_ok(
    $parsed_ref->[scalar @$parsed_ref - 1],
    'Weather::YR::Locationforecast::Forecast',
    'The last forecast is of type Weather::YR::Locationforecast::Forecast'
);

# The first forecast should be a full forecast
isa_ok(
    $forecast,
    'Weather::YR::Locationforecast::Forecast::Full',
    'The first forecast is of type Weather::YR::Locationforecast::Forecast::Full'
);

# Precip and symbol forecast types
isa_ok(
    $forecast_precip,
    'Weather::YR::Locationforecast::Forecast::Precip',
    'A precip forecast is of type Weather::YR::Locationforecast::Forecast::Precip'
);

isa_ok(
    $forecast_symbol,
    'Weather::YR::Locationforecast::Forecast::Symbol',
    'A symbol forecast is of type Weather::YR::Locationforecast::Forecast::Symbol'
);


#
# Checking the forecast data
#
ok(
    exists $forecast->{'winddirection'}->{'deg'},
    'Parsed wind direction'
);

ok(
    exists $forecast->{'windspeed'}->{'mps'},
    'Parsed wind speed'
);

ok(
    exists $forecast->{'temperature'}->{'value'},
    'Parsed temperature'
);

ok(
    exists $forecast->{'pressure'}->{'value'},
    'Parsed pressure'
);

ok(
    exists $forecast->{'cloudiness'}->{'percent'},
    'Parsed cloudiness'
);

ok(
    exists $forecast->{'fog'}->{'percent'},
    'Parsed fog'
);

ok(
    exists $forecast->{'clouds'}->{'low'}->{'percent'},
    'Parsed low clouds'
);

ok(
    exists $forecast->{'clouds'}->{'medium'}->{'percent'},
    'Parsed medium clouds'
);

ok(
    exists $forecast->{'clouds'}->{'high'}->{'percent'},
    'Parsed medium clouds'
);

ok(
    exists $forecast->{'location'}->{'latitude'},
    'Parsed location latitude'
);

ok(
    exists $forecast->{'location'}->{'longitude'},
    'Parsed location longitude'
);

ok(
    exists$forecast->{'location'}->{'altitude'},
    'Parsed location altitude'
);


#
# Testing precipitation
#
is(
    $forecast_precip->{'unit'},
    'mm',
    'Parsed precipitation unit'
);

ok(
    exists $forecast_precip->{'value'},
    'Parsed precipitation value'
);


#
# Testing forecast symbol
#
ok(
    exists $forecast_symbol->{'number'},
    'Parsed symbol number'
);

ok(
    exists $forecast_symbol->{'name'},
    'Parsed symbol name/id'
);

# Override the URL
my $forecast_url = Weather::YR::Locationforecast->new(
    {
        # Geo codes for Sande (VE.)
        'latitude'  => '59.6327',
        'longitude' => '10.2468',
        'url'       => 'http://api.yr.no/weatherapi/locationforecast/1.5-someother/',
    }
);

is(
    $forecast_url->get_url,
    'http://api.yr.no/weatherapi/locationforecast/1.5-someother/?lon=10.2468&lat=59.6327',
    'Override the URL'
);

undef $forecast_url;
