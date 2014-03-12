package Weather::YR::Base;

use strict;
use warnings;

use Error qw/:try/;
use LWP::UserAgent;

use Weather::YR;

=head1 NAME

Weather::YR::Base - Base class for all YR service classes.

=head1 DESCRIPTION

This module contains helper functions for all other YR service classes.

=head1 CONFIGURATION

This base class contains no default configuration. To set default configuration
parameters in your sub class, configure a C<%CONFIG> variable in your class.

=cut

my %CONFIG = ();


=head1 METHODS

=head2 new(C<\%args>)

Constructor. Takes parameters as a B<HASHREF> that will be merged with the
default configuration in L</%CONFIG>.

=cut

sub new {
    my ( $class, $args ) = @_;

    my $config  = $CONFIG{$class} || {};
    my %config  = %$config;
    my $self    = bless \%config, $class;

    $self->merge_config($args);

    return $self;
}

=head2 config(C<%args>)

Sets default package configuration values.

=cut

sub config {
    my ($self, %args) = @_;

    if (ref $self) {
        $self->merge_config(\%args);
    }
    else {
        my $class = $self;
        $CONFIG{$class} ||= {};
        while (my ($key, $value) = each %args) {
            $CONFIG{$class}{$key} = $value;
        }
    }
}

=head2 fetch

This method will try to fetch the content of the web service.

=cut

sub fetch {
    my ( $self, $url ) = @_;

    my $ua          = $self->get_ua();
    my $response    = $ua->get($url);

    return $response->content
        if $response->is_success;

    Error::Simple->throw("Unable to fetch content at url $url"); 
}

=head2 get_ua

Creates and returns an user agent instance which can be used to fetch data
from the YR web services.

=cut

sub get_ua {
    my $ua = LWP::UserAgent->new();
    $ua->timeout(15);
    $ua->env_proxy;

    my $version = $Weather::YR::VERSION;
    $ua->agent(sprintf('Perl Weather::YR/%s ', $version));

    return $ua;
}

=head2 get_url

This method should be overridden by a subclass. By default it will return the
value of C<< $self->{url} >>.

=cut

sub get_url {
    my ( $self ) = @_;
    return $self->{'url'};
}


=head2 merge_config

Method for overriding values in the object with values from a HASHREF.

=cut

sub merge_config {
    my ( $self, $args ) = @_;

    return unless $args;
    @$self{keys %$args} = values %$args;
}

=head1 SEE ALSO

L<Weather::YR>

=head1 AUTHOR

Knut-Olav, E<lt>knut-olav@hoven.wsE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Knut-Olav Hoven

This library is free software; you can redireibute it and/or modify it under the
terms as GNU GPL version 2.

=cut

1;

