# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl YR.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
BEGIN { use_ok('Weather::YR::Base') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

Weather::YR::Base->config(
    'url'   => 'http://example.com',
);

my $dummy = Weather::YR::Base->new();

ok(my $ua = Weather::YR::Base::get_ua());
is($dummy->get_url(), 'http://example.com');

# Merging to new configuration
$dummy->merge_config(
    {
        'url'   => 'http://www.example.com',
    }
);

is($dummy->get_url(), 'http://www.example.com');

