# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl YR.t'

#########################

use Test::More tests => 6;
use File::Slurp; # needed to read XML file
BEGIN { use_ok('Weather::YR::Textforecast') };

#########################

my $xml_file    = 'doc/example/textforecast-1.5/textforecast-land.xml';

# Doesn't really matter what type of forecast we enter here, we will read the
# XML document from a local file.
my $forecast = Weather::YR::Textforecast->new(
    {
        'forecast'  => 'land',
        'language'  => 'nb',
        'url'       => 'http://api.yr.no/weatherapi/textforecast/1.5/',
    }
);

is(
    $forecast->get_url,
    'http://api.yr.no/weatherapi/textforecast/1.5/?forecast=land&language=nb',
    'Assemble URL with forecast and language parameters'
);

ok(
    -f $xml_file,
    'Textforecast sample XML file exists'
);

my $xml         = read_file($xml_file);
my $parsed_ref  = $forecast->parse_forecast_land($xml);

isa_ok(
    $parsed_ref,
    'HASH',
    'The parsed data in returns is a HASHREF'
);

ok(
    $parsed_ref->{'title'},
    'Forecast contains a title'
);



# Testing overriding the URL
{
    my $forecast_url = Weather::YR::Textforecast->new(
        {
            'forecast'  => 'land',
            'language'  => 'nn',
            'url'       => 'http://api.yr.no/weatherapi/textforecast/1.3-someother/',
        }
    );
    
    is(
        $forecast_url->get_url,
        'http://api.yr.no/weatherapi/textforecast/1.3-someother/?forecast=land&language=nn',
        'Override URL'
    );
}

#use Data::Dumper;
#write_file('xml-simple.out', Dumper $parsed_ref );

