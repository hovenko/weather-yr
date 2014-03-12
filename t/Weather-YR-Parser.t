# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl YR.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('Weather::YR::Parser') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $sample_dt = DateTime->new(
    year    => 2008,
    month   => 3,
    day     => 18,
    hour    => 22,
    minute  => 9,
    second  => 13,
);

is(
    Weather::YR::Parser::parse_date('2008-03-18 22:09:13'),
    $sample_dt,
    'Parser for date and time'
);

is(
    Weather::YR::Parser::parse_date_iso8601('2008-03-18T22:09:13Z'),
    $sample_dt,
    'Parser for date and time (iso 8601)'
);
