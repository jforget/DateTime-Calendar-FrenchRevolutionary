# Copyright (c) 2003, 2004, 2010, 2011 Jean Forget. All rights reserved.

package DateTime::Calendar::FrenchRevolutionary::Locale;

use strict;

use vars qw($VERSION);
$VERSION = '0.11'; # same as parent module DT::C::FR

sub load {
  my ($self, $lang) = @_;
  my $real_class = "DateTime::Calendar::FrenchRevolutionary::Locale::$lang";
  eval "require $real_class";
  die $@ if $@;
  return $real_class->new();
}
# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
"Amour sacré de la patrie, conduis soutiens nos bras vengeurs.";
