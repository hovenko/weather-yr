package Weather::YR::Textforecast;

use strict;
use warnings;

use Weather::YR::Parser;
use Weather::YR::Textforecast::Product;
use Weather::YR::Textforecast::Forecast;

use Data::Dumper;
use XML::Simple;

use base 'Weather::YR::Base';

=head1 NAME

Weather::YR::Textforecast - Used to fetch text based forecast from YR

=head1 SYNOPSIS

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

This module returns textforecasts from YR according to specified parameters.

This module uses the data from URLs such as these:
 http://api.yr.no/weatherapi/textforecast/1.2/?forecast=land;language=nb

=head1 CONFIGURATION

=head2 url

The URL to the web service for getting the textforecasts. Defaults to version 2
of the API: B<http://api.yr.no/weatherapi/textforecast/1.2/>.

=head2 forecast

The type of forecast to get. Defaults to B<land>.

=head2 language

The language of the forecast. Defaults to norwegian bokmål, B<nb>.

=cut

__PACKAGE__->config(
    'url'       => 'http://api.yr.no/weatherapi/textforecast/1.2/',
    'forecast'  => 'land',
    'language'  => 'nb',
);


=head1 METHODS

=head2 forecast

Retrieves the forecast in a data structure representing the XML document.

=cut

sub forecast {
    my ( $self ) = @_;

    my $url     = $self->get_url();
    my $content = $self->fetch($url);

    my $forecast = $self->parse_forecast_land($content);

    return $forecast;
}

=head2 parse_forecast_land

This method parses the response from YR and returns a structure of objects.

=cut

sub parse_forecast_land {
    my ( $self, $xml ) = @_;

    my $ref = XMLin($xml,
        ForceArray      => 1,
        NormaliseSpace  => 2,
    );

    my @forecasts = ();

    foreach my $time (@{ $ref->{'time'} }) {
        $time = $self->parse_forecast_time($time);
        push @forecasts, @{ $time->{'forecasts'} };
    }

    my %forecast = (
        'title'     => $ref->{'title'}->[0],
        'product'   => parse_forecast_product($ref->{'productdescription'}),
        'forecasts' => \@forecasts,
    );


    return \%forecast;
}

=head2 parse_forecast_time(C<\%time>)

This method parses the time period of the forecast and the forecasts.

It returns a HASHREF of B<to>, B<from> and B<forecasts>.

=cut

sub parse_forecast_time {
    my ( $self, $time_ref ) = @_;

    my $to      = Weather::YR::Parser::parse_date($time_ref->{'to'});
    my $from    = Weather::YR::Parser::parse_date($time_ref->{'from'});

    my @forecasts = ();

    while (my ($type, $forecast) = each %{ $time_ref->{'forecasttype'} }) {
        my $obj = $self->parse_forecast($forecast);
        $obj->type($type);
        push @forecasts, $obj;
    }

    my %time = (
        'forecasts' => \@forecasts,
        'to'        => $to,
        'from'      => $from,
    );

    return \%time;
}

=head2 parse_forecast(C<\%forecast>)

This method parses a forecast with many locations and areas.

The class of an area does not exist yet, but we just needed a name for the
collection (L<Weather::YR::Textforecast::Area>).

It returns an instance of L<Weather::YR::Textforecast::Forecast>.

=cut

sub parse_forecast {
    my ( $self, $forecast ) = @_;

    my @locations   = $self->parse_forecast_locations($forecast);
    my @areas       = ();

    while (my ($name, $area) = each %{ $forecast->{'area'} }) {
        my @area_locations = $self->parse_forecast_locations($area);
        my %area = (
            'locations' => \@area_locations,
            'name'      => $name,
        );

        # FIXME this class does not exist yet
        #my $obj = Weather::YR::Textforecast::Area->new(\%area);
        my $obj = bless \%area, 'Weather::YR::Textforecast::Area';
        push @areas, $obj;
    }

    my %forecast = (
        'locations' => \@locations,
        'areas'     => \@areas,
    );

    my $forecast_ref = Weather::YR::Textforecast::Forecast->new(\%forecast);

    return $forecast_ref;
}

=head2 parse_forecast_locations(C<\%forecast>)

This method parses a list of forecast locations.
The forecasts are expected to be found in the HASH key of B<location>.

It returns a list of L<Weather::YR::Textforecast::Location>
(unfortunately this class does not exist, but we just needed a name on it).

=cut

sub parse_forecast_locations {
    my ( $self, $forecast ) = @_;

    my @locations   = ();

    while (my ($name, $location) = each %{ $forecast->{'location'} }) {
#        my $obj = Weather::YR::Textforecast::Location->new($location);
#        $obj->name($name);
        # FIXME This class doesn't exist, but we need a name on it ;)
        my $obj = bless $location, "Weather::YR::Textforecast::Location";
        push @locations, $obj;
    }

    return @locations;
}

=head2 parse_forecast_product

This method parses and creates a product object to store the description
about the product.

=cut

sub parse_forecast_product {
    my ( $pd ) = @_;

    my $product = Weather::YR::Textforecast::Product->new();

    $product->name( $pd->[0]->{'prodname'} );

    return $product;
}

=head2 get_url

Assembles the complete URL for the textforecast service with
the forecast type and language.

=cut

sub get_url {
    my ( $self ) = @_;

    my $baseurl     = $self->{'url'};
    my $forecast    = $self->{'forecast'};
    my $language    = $self->{'language'};
    
    my $url = "$baseurl?forecast=$forecast&language=$language";
    return $url;
}

=head1 SEE ALSO

L<Weather::YR>, L<Weather::YR::Base>

=head1 AUTHOR

Knut-Olav, E<lt>knut-olav@hoven.wsE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Knut-Olav Hoven

This library is free software; you can redireibute it and/or modify it under the
terms as GNU GPL version 2.

=cut

1;

