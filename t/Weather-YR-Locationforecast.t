# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl YR.t'

#########################

use Test::More tests => 24;
use File::Slurp; # required for reading XML file

BEGIN { use_ok('Weather::YR::Locationforecast') };

#########################

my $xml_file    = 'doc/example/locationforecast-sande.xml';

# Doesn't really matter what coordinates we enter here, we will read the
# XML document from a local file.
my $l_forecast = Weather::YR::Locationforecast->new(
    {
        # Geo codes for Sande (VE.)
        'latitude'  => '59.6327',
        'longitude' => '10.2468',
        'url'       => 'http://api.yr.no/weatherapi/locationforecast/1.4/',
    }
);

is(
    $l_forecast->get_url,
    'http://api.yr.no/weatherapi/locationforecast/1.4/?lon=10.2468&lat=59.6327',
    'Assemble URL with latitude and longitude'
);

ok(
    -f $xml_file,
    'Locationforecast sample XML file exists'
);


my $xml         = read_file($xml_file);
my $parsed_ref  = $l_forecast->parse_weatherdata($xml);

isa_ok(
    $parsed_ref,
    'ARRAY',
    'The parsed data in return is an ARRAYREF'
);

my $forecast        = $parsed_ref->[0];
my $forecast_precip = $parsed_ref->[5];
my $forecast_symbol = $parsed_ref->[6];

# All forecasts should be of type Weather::YR::Locationforecast::Forecast
isa_ok(
    $forecast,
    'Weather::YR::Locationforecast::Forecast',
    'The first forecast is of type Weather::YR::Locationforecast::Forecast'
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


#
# Checking the forecast data
#
is(
    $forecast->{'winddirection'}->{'deg'},
    338.7,
    'Parsed wind direction'
);

is(
    $forecast->{'windspeed'}->{'mps'},
    3.3,
    'Parsed wind speed'
);

is(
    $forecast->{'temperature'}->{'value'},
    '-1.0',
    'Parsed temperature'
);

is(
    $forecast->{'pressure'}->{'value'},
    1007.8,
    'Parsed pressure'
);

is(
    $forecast->{'cloudiness'}->{'percent'},
    1.4,
    'Parsed cloudiness'
);

is(
    $forecast->{'fog'}->{'percent'},
    '0.0',
    'Parsed fog'
);

is(
    $forecast->{'clouds'}->{'low'}->{'percent'},
    0.4,
    'Parsed low clouds'
);

is(
    $forecast->{'clouds'}->{'medium'}->{'percent'},
    0.8,
    'Parsed medium clouds'
);

is(
    $forecast->{'clouds'}->{'high'}->{'percent'},
    '0.0',
    'Parsed medium clouds'
);

is(
    $forecast->{'location'}->{'latitude'},
    59.6327,
    'Parsed location latitude'
);

is(
    $forecast->{'location'}->{'longitude'},
    10.2468,
    'Parsed location longitude'
);

is(
    $forecast->{'location'}->{'altitude'},
    40,
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

is(
    $forecast_precip->{'value'},
    6.7,
    'Parsed precipitation value'
);


#
# Testing forecast symbol
#
is (
    $forecast_symbol->{'number'},
    1,
    'Parsed symbol number'
);

is (
    $forecast_symbol->{'name'},
    'SUN',
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
