# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl YR.t'

#########################

use Test::More tests => 7;
BEGIN { use_ok('Weather::YR::Locationforecast') };
BEGIN { use_ok('Weather::YR::Textforecast') };

#########################


# Doesn't really matter what type of forecast we enter here, we will read the
# XML document from a local file.
my $t_forecast = Weather::YR::Textforecast->new(
    {
        'forecast'  => 'land',
        'language'  => 'nb',
        'url'       => 'http://api.yr.no/weatherapi/textforecast/1.5/',
    }
);

is(
    $t_forecast->get_url,
    'http://api.yr.no/weatherapi/textforecast/1.5/?forecast=land&language=nb',
    'Assemble URL with forecast and language parameters'
);

my $l_forecast = Weather::YR::Locationforecast->new(
    {
        # Geo codes for Sande (VE.)
        'latitude'  => '59.6327',
        'longitude' => '10.2468',
        'url'       => 'http://api.yr.no/weatherapi/locationforecast/1.7/',
    }
);

is(
    $l_forecast->get_url,
    'http://api.yr.no/weatherapi/locationforecast/1.7/?lon=10.2468&lat=59.6327',
    'Assemble URL with forecast and language parameters'
);


# Regression test
is(
    $t_forecast->get_url,
    'http://api.yr.no/weatherapi/textforecast/1.5/?forecast=land&language=nb',
    'Assemble URL with forecast and language parameters'
);


$l_forecast->config(
    'url'   => 'http://example.com/someotherurl/',
);


# Regression test
is(
    $t_forecast->get_url,
    'http://api.yr.no/weatherapi/textforecast/1.5/?forecast=land&language=nb',
    'Assemble URL with forecast and language parameters'
);

is(
    $l_forecast->get_url,
    'http://example.com/someotherurl/?lon=10.2468&lat=59.6327',
    'Assemble URL with forecast and language parameters'
);

