use ExtUtils::MakeMaker;
WriteMakefile(
    NAME		    => 'DateTime::Calendar::FrenchRevolutionary',
    VERSION_FROM	=> 'lib/DateTime/Calendar/FrenchRevolutionary.pm',
    PREREQ_PM		=> { DateTime => 0.06 },
    ABSTRACT        => 'DateTime object in the French Revolutionary calendar',
    AUTHOR          => 'Jean Forget <JFORGET@cpan.org>',
);
