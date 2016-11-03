#
#     Configuration script for DateTime::Calendar::FrenchRevolutionary
#     Copyright (c) 2003, 2004, 2010, 2011, 2012, 2014, 2016 Jean Forget. All rights reserved.
#
#     This program is distributed under the same terms as Perl 5.16.3:
#     GNU Public License version 1 or later and Perl Artistic License
#
#     You can find the text of the licenses in the F<LICENSE> file or at
#     L<http://www.perlfoundation.org/artistic_license_1_0>
#     and L<http://www.gnu.org/licenses/gpl-1.0.html>.
#
#     Here is the summary of GPL:
#
#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 1, or (at your option)
#     any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program; if not, write to the Free Software Foundation,
#     Inc., <http://www.fsf.org/>.
#
use strict;

unless (eval "use Module::Build::Compat 0.02; 1" ) {
    print "This module requires Module::Build to install itself.\n";

    require ExtUtils::MakeMaker;
    my $yn = ExtUtils::MakeMaker::prompt
        ('  Install Module::Build from CPAN?', 'y');

    if ($yn =~ /^y/i) {
        require Cwd;
        require File::Spec;
        require CPAN;

        # Save this 'cause CPAN will chdir all over the place.
        my $cwd = Cwd::cwd();
        my $makefile = File::Spec->rel2abs($0);

        CPAN::Shell->install('Module::Build::Compat');

        chdir $cwd or die "Cannot chdir() back to $cwd: $!";
        exec $^X, $makefile, @ARGV;  # Redo now that we have Module::Build
    } else {
        warn " *** Cannot install without Module::Build.  Exiting ...\n";
        exit 1;
    }
}
Module::Build::Compat->run_build_pl(args => \@ARGV);
Module::Build::Compat->write_makefile();
