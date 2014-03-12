use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Weather::YR',
    LICENSE           => 'perl',
    VERSION_FROM      => 'lib/Weather/YR.pm', # finds $VERSION
    PREREQ_PM         => {
            'AutoLoader'                => 0, #5.63,
            'Class::Accessor::Fast'     => 0, #0.31,
            'Data::Dumper'              => 0, #2.121,
            'DateTime'                  => 0, #0.35,
            'DateTime::Format::ISO8601' => 0, #0.06,
            'Error'                     => 0, #0.17003,
            'File::Slurp'               => 0, #9999.12,
            'LWP::UserAgent'            => 0, #2.033,
            'NEXT'                      => 0, #0.60,
            'Params::Validate'          => 0, #0.77,
            'XML::Simple'               => 0, #2.16,
        },

    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Weather/YR.pm', # retrieve abstract from module
       AUTHOR         => 'Knut-Olav Hoven <knutolav@gmail.com>') : ()),
);
