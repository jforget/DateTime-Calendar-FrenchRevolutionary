use ExtUtils::MakeMaker;

# If this script is executed, that means that probably Module::Build
# is not installed. Therefore, Build.PL is not required.
# Yet, if any *.PL file is present at the time of WriteMakefile,
# this *.PL file will be written in the Makefile and executed at the
# time of the "make" step. So we must remove it before writing the Makefile.

if (-f 'Build.PL')
  {
    # Remove the name Build.PL from the filesystem...
    rename 'Build.PL', 'Build.sav';
    # ... and from the manifest
    local $/ = undef;
    open F, 'MANIFEST' or die $!;
    (my $manifest = <F>) =~ s/Build\.PL/Build.sav/;
    close F or die $!;
    open F, '> MANIFEST' or die $!;
    print F $manifest or die $!;
    close F or die $!;
  }

# Now, the usual stuff without being bothered by extraneous *.PL files

WriteMakefile(
    NAME		    => 'DateTime::Calendar::FrenchRevolutionary',
    VERSION_FROM	=> 'lib/DateTime/Calendar/FrenchRevolutionary.pm',
    PREREQ_PM		=> { DateTime => 0.06 },
    ABSTRACT        => 'DateTime object in the French Revolutionary calendar',
    AUTHOR          => 'Jean Forget <JFORGET@cpan.org>',
);
