package DateTime::Calendar::FrenchRevolutionary::Locale::fr;

my @months_short  = qw (Vnd Bru Fri Niv Plu Vnt Ger Flo Pra Mes The Fru S-C);
my @add_days_short= qw (Vertu Génie Trav Raison Récomp Révol);
my @months = qw(Vendémiaire Brumaire  Frimaire
                Nivôse      Pluviôse  Ventôse
	        Germinal    Floréal   Prairial
	        Messidor    Thermidor Fructidor);
push @months, "jour complémentaire";

my @decade_days = qw (Primidi Duodi Tridi Quartidi Quintidi Sextidi Septidi Octidi Nonidi Décadi);
my @decade_days_short = qw (Pri Duo Tri Qua Qui Sex Sep Oct Non Déc);

# When initializing an array with lists within lists, it means one of two things:
# Either it is a newbie who does not know how to make multi-dimensional arrays,
# Or it is a (at least mildly) experienced Perl-coder who, for some reason, 
# wants to initialize a flat array with the concatenation of lists.
# I am a (at least mildly) experienced programmer who wants to use qw() and yet insert
# comments in some places.
my @feast = (
# Vendémiaire
	qw(
       0raisin           0safran           1châtaigne        1colchique        0cheval
       1balsamine        1carotte          2amarante         0panais           1cuve
       1pomme_de_terre   2immortelle       0potiron          0réséda           2âne
       1belle_de_nuit    1citrouille       0sarrasin         0tournesol        0pressoir
       0chanvre          1pêche            0navet            2amaryllis        0boeuf
       2aubergine        0piment           1tomate           2orge             0tonneau
	),
# Brumaire
	qw(
       1pomme            0céleri           1poire            1betterave        2oie
       2héliotrope       1figue            1scorsonère       2alisier          1charrue
       0salsifis         1macre            0topinambour      2endive           0dindon
       4chervis          0cresson          1dentelaire       1grenade          1herse
       5bacchante        2azerole          1garance          2orange           0faisan
       1pistache         4macjon           0coing            0cormier          0rouleau
	),
# Frimaire
	qw(
       1raiponce         0turneps          1chicorée         1nèfle            0cochon
       1mâche            0chou-fleur       0miel             0genièvre         1pioche
       1cire             0raifort          0cèdre            0sapin            0chevreuil
       2ajonc            0cyprès           0lierre           1sabine           0hoyau
       2érable-sucre     1bruyère          0roseau           2oseille          0grillon
       0pignon           0liège            1truffe           2olive            1pelle
	),
# Nivôse
	qw(
       1tourbe           1houille          0bitume           0soufre           0chien
       1lave             1terre_végétale   0fumier           0salpêtre         0fléau
       0granit           2argile           2ardoise          0grès             0lapin
       0silex            1marne            1pierre_à_chaux   0marbre           0van
       1pierre_à_plâtre  0sel              0fer              0cuivre           0chat
       2étain            0plomb            0zinc             0mercure          0crible
	),
# Pluviôse
	qw(
       5lauréole         1mousse           0fragon           0perce-neige      0taureau
       0laurier-thym     2amadouvier       4mézéréon         0peuplier         1cognée
       2ellébore         0brocoli          0laurier          2avelinier        1vache
       0buis             0lichen           2if               1pulmonaire       1serpette
       0thlaspi          4thymelé          0chiendent        5trainasse        0lièvre
       1guède            0noisetier        0cyclamen         1chélidoine       0traîneau
	),
# Ventôse
	qw(
       0tussilage        0cornouiller      0violier          0troène           0bouc
       2asaret           2alaterne         1violette         0marsault         1bêche
       0narcisse         2orme             1fumeterre        0vélar            1chèvre
       2épinard          0doronic          0mouron           0cerfeuil         0cordeau
       1mandragore       0persil           0cochléaria       1pâquerette       0thon
       0pissenlit        1sylvie           0capillaire       0frêne            0plantoir
	),
# Germinal
	qw(
       1primevère        0platane          2asperge          1tulipe           1poule
       1blette           0bouleau          1jonquille        2aulne            0couvoir
       1pervenche        0charme           1morille          0hêtre            2abeille
       1laitue           0mélèze           1ciguë            0radis            1ruche
       0gainier          1romaine          0marronnier       1roquette         0pigeon
       0lilas            2anémone          1pensée           1myrtille         0greffoir
	),
# Floréal
	qw(
       1rose             0chêne            1fougère          2aubépine         0rossignol
       2ancolie          0muguet           0champignon       1jacinthe         0rateau
       1rhubarbe         0sainfoin         0bâton-d'or       4chamérisier      0ver_à_soie
       1consoude         1pimprenelle      1corbeille-d'or   2arroche          0sarcloir
       0statice          1fritillaire      1bourrache        1valériane        1carpe
       0fusain           1civette          1buglosse         0sénevé           1houlette
	),
# Prairial
	qw(
       1luzerne          6hémérocalle      0trèfle           2angélique        0canard
       1mélisse          0fromental        0martagon         0serpolet         1faux
       1fraise           1bétoine          0pois             2acacia           1caille
       2oeillet          0sureau           0pavot            0tilleul          1fourche
       0barbeau          1camomille        0chèvrefeuille    0caille-lait      1tanche
       0jasmin           1verveine         0thym             1pivoine          0chariot
	),
# Messidor
	qw(
       0seigle           2avoine           2oignon           1véronique        0mulet
       0romarin          0concombre        2échalotte        2absinthe         1faucille
       0coriandre        2artichaut        1giroflée         1lavande          0chamois
       0tabac            1groseille        1gesse            1cerise           0parc
       1menthe           0cumin            0haricot          2orcanète         1pintade
       1sauge            2ail              1vesce            0blé              5chalémie
	),
# Thermidor
	qw(
       2épautre          0bouillon-blanc   0melon            2ivraie           0bélier
       1prèle            2armoise          0carthame         1mûre             2arrosoir
       4panis            4salicor          2abricot          0basilic          1brebis
       1guimauve         0lin              2amande           1gentiane         2écluse
       1carline          0câprier          1lentille         2aunée            1loutre
       1myrte            0colza            0lupin            0coton            0moulin
	),
# Fructidor
	qw(
       1prune            0millet           0lycoperdon       2escourgeon       0saumon
       1tubéreuse        4sucrion          2apocyn           1réglisse         2échelle
       1pastèque         0fenouil          2épine-vinette    1noix             1truite
       0citron           1cardère          0nerprun          0tagette          1hotte
       2églantier        1noisette         0houblon          0sorgho           2écrevisse
       5bagarade         1verge-d'or       0maïs             0marron           0panier
	),
# Jours complémentaires
	qw(
       1vertu            0génie            0travail          2opinion          3récompenses
       1révolution
	 ));
my @prefix = ('jour du ', 'jour de la ', "jour de l'", 'jour des ');

my %event = ();

sub new {
  return bless {},  $_[0];
}

sub month_name {
    my ($self, $date) = @_;
    return $months[$date->month_0]
}

sub month_abbreviation {
    my ($self, $date) = @_;
    return $months_short[$date->month_0]
}

sub day_name {
    my ($self, $date) = @_;
    return $decade_days[$date->day_of_decade_0];
}

sub day_abbreviation {
    my ($self, $date) = @_;
    return $decade_days_short[$date->day_of_decade_0];
}

sub feast_short {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0];
  $lb =~ s/_/ /g;
  return substr($lb, 1);
}

sub feast_long {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0];
  $lb =~ s/_/ /g;
  $lb =~ s/^(\d)/$prefix[$1 % 4]/;
  return $lb;
}

sub feast_caps {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0];
  $lb =~ s/_/ /g;
  $lb =~ s/^(\d)(.)/\u$prefix[$1 % 4]\u$2/;
  return $lb;
}

sub on_date {
  my ($self, $date) = @_;
  _load_events() unless %event;
  $event{$date->strftime('%m%d%n')} || "";
}

sub _load_events {
  %event = ('dummy', split /(\d{4}\n)/, <<'EVENTS');
0101
1 Vendémiaire I entrée des troupes françaises en Savoie
1 Vendémiaire III les postes du bois d'Aix-la-Chapelle et de Reckem sont enlevés 
par l'Armée du Nord (Jourdan)
0102
2 Vendémiaire I conquête de Chambéry
2 Vendémiaire III prise de la redoute et du camp de Costouge par l'Armée des
Pyrénées orientales (Dugommier).
2 Vendémiaire V l'Armée d'Italie (Kilmaine) met en déroute l'ennemi à Governolo.
0103
3 Vendémiaire IV affaire de Garesio (Miolis)
0104
4 Vendémiaire II l'Armée des Alpes (Verdelin) enlève de vive force les retranchements
de Chatillon ; les Piémontais sont mis en déroute et repassent la rivière de Giffe.
0105
5 Vendémiaire III défaite des Espagnols à Olia et Monteilla par l'Armée des Pyrénées
orientales (Charlet).
0106
6 Vendémiaire III capitulation de Crevecoeur devant l'Armée du Nord (Delmas)
6 Vendémiaire III reprise de Kayserlautern, d'Alsborn et autres postes environnants
par l'Armée du Rhin (Michaud)
6 Vendémiaire V l'ennemi attaque l'Armée de Sambre et Meuse (Hardy) sur les
points de Wurstatt, Nider-Ulm, Ober et Nider-Iogelheim ; l'attaque est repoussée.
0107
7 Vendémiaire I prise de la ville de Nice et de la forteresse de Montalban 
par les troupes d'Anselme.
7 Vendémiaire II l'Armée des Alpes (Verdelin) défait l'ennemi dans les gorges
de Sallanges et prend la redoute de Saint-Martin.
0108
8 Vendémiaire V 150 hommes de l'Armée d'Italie font une sortie de Mantoue pour
se procurer du fourrage. Ils doivent se rendre aux habitants de Reggio.
0109
9 Vendémiaire I les Français de Custines se rendent maîtres de la ville de Spire
après avoir enfoncé les portes à coups de canons et subi un feu de mousqueterie
dans les rues de la ville.
9 Vendémiaire II l'Armée des Alpes (Chamberlhac) enlève de vive-force les
retranchements de Mont-Cormet tenus par les Piémontais.
0111
11 Vendémiaire II les troupes de Prisy de l'Armée des Alpes enlèvent le poste
de Valmeyer à la bayonette, celles de Saint-André et de Chamberlhac enlèvent
le poste de Beaufort, celles du général-en-chef Kellerman prennent Moutiers et 
le bourg Saint-Maurice et celles de Ledoyen enlèvent de vive force le poste
du Col de la Madeleine.
11 Vendémiaire III à la bataille d'Aldenhoven, l'Armée de Sambre-et-Meuse
(Jourdan) provoque la déroute des troupes coalisées.
11 Vendémiaire V l'Armée du Rhin et Moselle (général-en-chef Moreau, 
généraux de division Desaix et Saint-Cyr) attaque sur toute la ligne et met
l'ennemi en déroute.
0112
12 Vendémiaire II les Espagnols sont forcés dans leurs camps du Boulon 
et Argelès par l'Armée des Pyrénées orientales (Delatre).
12 Vendémiaire III le pays de Juliers se rend à l'Armée de Sambre-et-Meuse (Jourdan).
0113
13 Vendémiaire I les Autrichiens sont forcés d'évacuer la ville de Worms
et les troupes de Custines y font leur entrée.
13 Vendémiaire II Armée des Pyrénées orientales : les troupes de Dagobert prennent
Campredon tandis que la garnison de Colioure (Delatre) combat la cavalerie espagnole
et la met en déroute.
13 Vendémiaire II l'Armée des Pyrénées occidentales attaque les postes d'Arau
et de la vallée d'Aure sur trois colonnes (Lasalle, Mascaron et Dat) et les enlève.
13 Vendémiaire IV Bonaparte réprime une manifestation royaliste à l'église Saint-Roch
0115
15 Vendémiaire III Cologne se rend à l'Armée de Sambre-et-Meuse (Jourdan).
0116
16 Vendémiaire V l'ennemi, bloqué à Mantoue par l'Armée d'Italie (Sahuguet) tente
une sortie de 4 600 hommes, sortie qui se solde par un échec.
0117
17 Vendémiaire I à l'approche de l'Armée française, les Autrichiens lèvent
précipitamment le siège de Lille.
17 Vendémiaire III combat et prise de Frankenthal par l'Armée du Rhin (Desaix)
0118
18 Vendémiaire II bombardement de Lyon qui ouvre ses portes aux troupes de 
Dubois-de-Crancé.
18 Vendémiaire III prise de Shelaudenbach et de Vollfstein par l'Armée du Rhin (Michaud)
et jonction avec l'Armée de la Moselle à Lautreck.
0119
19 Vendémiaire III devant Maestricht, l'Armée de Sambre-et-Meuse (Duhesme) reprend
le château de Mont-Saint-Pierre.
0120
20 Vendémiaire III l'Armée de la Moselle (Moreau) marche sur Birkenfeldt, Oberstein,
Kirn et Meisenheim.
0121
21 Vendémiaire III entrée de l'Armée du Nord (Delmas) dans Bois-le-Duc.
0122
22 Vendémiaire I Kellerman force les Prussiens à évacuer la ville de Verdun.
Il y entre et poursuit sa marche contre eux.
0123
23 Vendémiaire III l'Armée du Rhin (Michaud) prend Otterberg, Rockenhausen, 
Landsberg, Alzein et Oberhausen.
0124
24 Vendémiaire II l'Armée de la Moselle (Delaunay) combat et provoque la retraite
précipitée des coalisés qui s'étaient portés sur Bitche et Rorbach.
24 Vendémiaire III combat et prise de Gellheim et de Grunstad par 
l'Armée du Rhin (Michaud) ; les Français reprennent aussi Frankenthal.
0126
26 Vendémiaire I les Autrichiens attaquent plusieurs fois inutilement Hasnon
(Muller commandant) et sont repoussés avec perte.
26 Vendémiaire II la bataille de Wattignies près de Maubeuge est remportée
par l'Armée du Nord (Jourdan) sur les Autrichiens et le blocus de Maubeuge est levé.
26 Vendémiaire III l'Armée des Pyrénées occidentales (Moncey) prend la belle
mâture d'Iraty et les superbes fonderies d'Egay et d'Orbaycette.
26 Vendémiaire III Armée de la Moselle : les troupes du général-en-chef 
Moreau prennent Creutznach et celles de Custines prennent Worms.
26 Vendémiaire VI Armée d'Italie : traité de paix définitif à Campo-Formio
près d'Udine entre le général Bonaparte et les plénipotentiaires de l'Empereur,
roi de Hongrie et de Bohême.
26 Vendémiaire VI congrès à Rastadt pour la conclusion de la paix entre
la République française et l'Empire germanique.
0127
27 Vendémiaire II 600 républicains de l'Armée d'Italie (Dugommier) remportent
l'avantage à Gillette sur 4 000 Autrichiens, Croates et Piémontais et les
repoussent.
27 Vendémiaire III l'Armée des Pyrénées occidentales (Delabare) défait 7 000 
Espagnols près de Buruet et d'Almandos.
27 Vendémiaire III l'Armée du Rhin (Michaud) met en déroute l'ennemi près
de Kircheim et de Worms et prend ces deux villes.
0128
28 Vendémiaire II l'Armée d'Italie (Dugommier) remporte
une victoire complète à Gilette sur les Piémontais.
28 Vendémiaire III l'Armée du Nord (Souham) défait l'ennemi près de Nimègue
et détruit la légion de Rohan.
28 Vendémiaire V l'Armée du Rhin et Moselle (général-en-chef Moreau et
général de division Beaupuis) est attaquée à Retzengen et à Simonswald, les 
efforts des ennemis sont vains.
0129
29 Vendémiaire I l'Armée française (général-en-chef Custines) force les
Autrichiens à évacuer Mayence.
29 Vendémiaire III l'Armée de la Moselle (Moreau) entre dans Bingen
après avoir chassé les Prussiens des positions qu'ils tenaient en avant
de la ville.
29 Vendémiaire V l'Armée d'Italie (Casalta), débarquée en Corse, se porte
sur Bastia et chasse les Anglais qui s'étaient retirés dans le fort.
Prise également des villes de Saint-Florent et de Bonifacio.
0130
30 Vendémiaire II l'Armée des Pyrénées occidentales (Poncet) met
en déroute trois colonnes espagnoles après une fusillade de cinq heures.
30 Vendémiaire V Armée de Sambre et Meuse (général-en-chef Beurnonville,
généraux de division Championnet et Grenier) : l'ennemi passe le Rhin sur
six points depuis Bacharach jusqu'à Andernach et attaque la tête de pont
de Neuwied et est forcé à la retraite.
0201
1 Brumaire I Reprise de la ville de Longwi, les Prussiens évacuent le
territoire français.
1 Brumaire II Armée des Pyrénées orientales. Avantage sur les
espagnols dans la vallée de Baigory.
1 Brumaire II Armée du Nord. Enlèvement des postes de Warneton,
Comines, Werwick, Ronek, Alluin, Menin, Furnes et Poperingues.
1 Brumaire II Armée du Rhin, prise d'Alzey et d'Oppenheim.
0202
2 Brumaire II Armée d'Italie. Défaite à Utel de cinq mille ennemis par
neuf cents républicains, après onze heures de combat.
2 Brumaire II Armée du Rhin. Attaque du poste de Breitenstein par les
Autrichiens ; l'ennemi repoussé avec une perte considérable.
2 Brumaire II Armée de Sambre et Meuse. Prise de Coblentz ; fuite de
l'ennemi au-delà du Rhin.
2 Brumaire II Armée des Pyrénées orientales. Combat à Bhaga, dans
lequel les Espagnols sont repoussés avec perte considérable.
2 Brumaire II Armée des Pyrénées orientales. Enlèvement de vive force
des postes de Dori et Tozas et de sept retranchemens de Casteillan.
0203
3 Brumaire V Traité de paix conclu entre la République française et le
roi de Naples et des deux Siciles.
0204
4 Brumaire VI Armée d'Italie. Traité d'alliance entre la République
française et le roi de Sardaigne.
0205
5 Brumaire III Armée du Nord. Prise de Hultz, Axel et Sas-de-Gand.
5 Brumaire V Armée de Sambre et Meuse. Attaque et prise de Saint
Wendel, Kayserslautern, Kirchenpoland, Bingen et de la montagne de
Saint-Roch.
5 Brumaire V Armée du Rhin et Moselle Passage du Rhin par les
Français, prise du fort de Khel.
0207
7 Brumaire V Armée d'Italie. Sortie ennemie de Mantoue repoussée.
0208
8 Brumaire III Armée du Nord. Prise de Venlo.
0209
9 Brumaire II Armée des Pyrénées orientales. Reprise à la baïonnette,
d'une batterie ennemie, en avant de Ville longue.
0211
11 Brumaire III Armée des Pyrénées orientales. Déroute des Espagnols
sur les revers de la montagne Noire.
0212
12 Brumaire I Les Autrichiens sont forcés d'évacuer la petite ville de
Lanoy, le seul poste fermé qui leur restât sur le territoire français.
12 Brumaire III Armée de la Moselle. Entrée des Français dans
Rheinfels, évacué par douze cents ennemis.
12 Brumaire V Armée d'Italie. Prise du village de Saint-Michel ; les
ponts sur l'Adige brûlés par les Français. L'ennemi se porte sur le
Lavis, où il est battu et repoussé jusque dans le village de
Segonzano.
0214
14 Brumaire V Armée de Sambre et Meuse. Prise de Maestricht après
onze jours de tranchée ouverte.
0215
15 Brumaire V Armée d'Italie. L'ennemi ayant passé la Brenta est
obligé de la repasser après un combat meurtrier.
0216
16 Brumaire I. Bataille de Gemmapes. Par suite de cette victoire
mémorable les Français entrent dans la ville de Mons.
16 Brumaire III Armée du Nord. Prise du fort de Schenk.
0217
17 Brumaire III Armée du Nord. La sortie de la garnison de
Berg-op-zomm est repoussée à la baïonnette par les Français.
0218
18 Brumaire I. Prise de la ville de Tournay par les Français.
18 Brumaire III Armée du Nord. Entrée triomphante des Français dans
18 Brumaire VIII Coup d'état de Bonaparte : fin du Directoire, début du Consulat
Nimègue.
0219
19 Brumaire IV Armée du Nord. Prise de Burick.
0220
20 Brumaire IV Armée de Sambre et Meuse. Combat près de Creutzenach,
dans lequel l'ennemi a été forcé de repasser la Nahe.
0221
21 Brumaire V Armée d'Italie. L'armée française, sur l'Adige,
rencontre l'ennemi entre Saint-Michel et Saint-Martin, le culbute et
le poursuit l'espace de trois milles.
0222
22 Brumaire I Armée du Nord. La ville de Gand ouvre ses portes à
l'armée française.
22 Brumaire I. Prise de Charleroy par les Français.
22 Brumaire III Armée du Rhin. Prise de Monbach et de tous les postes
de la forêt en avant de ce village.
22 Brumaire III Armée du Rhin. Prise de Weissenau.
0223
23 Brumaire I. Bataille d'Anderlecht près Bruxelles. Défaite
complète de l'ennemi, l'armée française fait son entrée triomphante
dans Bruxelles.
0224
24 Brumaire I. Prise de la ville de Francfort.
24 Brumaire II Armée de l'Ouest. Défaite des rebelles de la Vendée
sous les murs de Granville.
0225
25 Brumaire V Armée d'Italie. Bataille d'Arcole : cette bataille
mémorable a duré trois jours de suite ; elle a été décidée le 27 par
la prise du village d'Arcole.
0226
26 Brumaire I. Les Français se rendent maîtres de la ville et du port
d'Ostende, évacué par les Autrichiens.
26 Brumaire I. Prise de Sainte-Remi.
26 Brumaire I. Capitulation de la ville de Malines.
26 Brumaire II Armée du Rhin L'armée surprend et enlève près de
Strasbourg trois postes ennemis vaillamment défendus.
26 Brumaire II Le siège de la ville de Granville est levé.
26 Brumaire IV Combat du champ di Pietri.
0227
27 Brumaire II Armée de la Moselle Défaite de quatre mille Autrichiens
devant Bitche. Déroute complète des Autrichiens près Lébach. Prise
de Bising et de Blise-Castel.
27 Brumaire III Armée des Pyrénées orientales. Dugommier général en
chef, tué d'un coup d'obus dans l'affaire de St. Sébastien de la
Mouga.
27 Brumaire III Armée des Pyrénées orientales. Bataille gagnée sur
les Espagnols à Saint-Sébastien.
0228
28 Brumaire I Prise des villes d'Ypres, Furnes et Bruges. Entrée des
Français dans la ville d'Anvers.
28 Brumaire II Armée du Rhin. Enlèvement de vive force du poste de
Neuviller, et de quatre autres environnants. Prise d'une forte
redoute et de sept pièces de canons près de Wantzenau.
28 Brumaire V
Traité de paix conclu entre la République française et le duc de
Parme.
0229
29 Brumaire II L'Armée du Rhin enlève deux redoutes formidables près
de Bouxweiller.
0230
30 Brumaire II Armée des Pyrénées orientales Bataille gagnée à Escola,
Liers, Vilartoly, sur cinquante mille Espagnols.
30 Brumaire II Armée de la Moselle. Défaite de douze cents hommes
d'infanterie, et de trois cents de cavalerie auprès de Blascheidt, et
de Lorentsweiller.
0301
1 Frimaire I Armée des Ardennes. Prise de la ville de Namur par les
Français.
1 Frimaire III Armée de la Moselle. Défaite de plus de quatre cents
ennemis dans la forêt de Grunnevald, près Luxembourg.
1 Frimaire V Armée d'Italie. L'ennemi est attaqué et repoussé de
position en position ; de Castel-Nobo à Rivoli, la Corona, et le long
de l'Adige jusqu'à Dolce.
0302
2 Frimaire I Armée du Rhin. Cinq mille Français mettent en déroute
toute l'armée ennemie devant Tirlemont.
2 Frimaire II Armée du Rhin. Combats successifs et enlèvement des
postes de Bouxweiller, Brumpt et Haguenau par les Français ; déroute
de l'ennemi.
2 Frimaire IV Armée d'Italie. Bataille de Loano, déroute des
Austro-Sardes ; prise de la Pietra, Loano, Finale, Vado et Savonne.
2 Frimaire V Armée du Rhin et Moselle. Sortie vigoureuse par la
garnison de Kehl ; la ligne ennemie est forcée sans tirer un coup de
fusil ; une partie de son artillerie enclouée.
0303
3 Frimaire IV Armée d'Italie. Combat d'Intrapa et de Garesio.
3 Frimaire V. Sortie faite par la garnison de Mantoue, qui est
brusquement repoussée et forcée de rentrer dans la place.
0304
4 Frimaire II Armée d'Italie. Défaite de huit cents Piémontais par
cinq cents Français, à Castel-Genest et à Brec, prise de Figaretto.
4 Frimaire III Armée des Pyrénées occidentales. Victoire remportée à
Ostés, après un combat de deux jours.
0306
6 Frimaire IV Armée d'Italie. Combat de Spinardo et autres lieux.
0307
7 Frimaire I Armée du Rhin. Prise de la ville de Liège, précédée
d'une victoire complète remportés sur les Autrichiens, après un combat
de dix heures.
7 Frimaire III Armée des Pyrénées orientales. Prise de la forteresse
de Figuières.
0308
8 Frimaire III Armée des Pyrénées orientales. Bataille gagnée sur les
Espagnols à Begara, Ascuatia et Aspetia.
0310
10 Frimaire I Armée du Nord. Capitulation de la citadelle d'Anvers
10 Frimaire II Armée du Nord. Attaque de tous les postes ennemis sur
la Lys ; quinze ennemis tués, cent quarante faits prisonniers.
10 Frimaire IV Armée de Sambre et Meuse. Attaque et prise de
Creutzenach.
0311
11 Frimaire I Armée des Ardennes. Capitulation de la citadelle de
Namur.
11 Frimaire II Armée du Rhin. Enlèvement de la redoute du pont de
Landgraben et des retranchemens de Gambsheim.
11 Frimaire III Armée du Rhin et Moselle. Enlèvement de la redoute,
dite de Merlin, devant Mayence.
11 Frimaire V. L'ennemi, sur trois colonnes, attaque la tête du pont
d'Huningue et s'empare de la demi-lune ; il en est délogé après un vif
combat.
11 Frimaire XIII Napoléon Premier est couronné Empereur des Français
11 Frimaire XIV Bataille d'Austerlitz : l'armée française écrase l'armée austro-russe
0312
12 Frimaire II Armée des Ardennes. Vigoureuse sortie de la garnison
de Givet, qui tue beaucoup d'ennemis et ne perd que cinq à six hommes,
entre Falmagne et Falmignoule.
12 Frimaire II Armée du Rhin. Combat près du bois de Gambshein.
0314
14 Frimaire II Armée du Rhin. L'ennemi, chassé du village
d'Oppendorff, est poursuivi jusqu'à Druzenheim.
14 Frimaire III Armée de la Moselle. Les républicains enlèvent de
vive force les redoutes de Salbach.
0319
19 Frimaire II Armée du Rhin. Prise des hauteurs de Dawendorff, après
une action très vive.
0321
21 Frimaire I Armée du Nord. Prise des villes de Wezem et de Wert ;
cette conquête est suivie de la prise de la ville de Ruremonde,
capitale de la Gueldre autrichienne, dans laquelle les Français font
leur entrée aux acclamation de tous les habitants.
0322
22 Frimaire II Armée de l'Ouest. Victoire remportée sur les rebelles
de la Vendée, près et dans la ville du Mans.
0323
23 Frimaire II Armée des Pyrénées occidentales. Déroute des Espagnols
près de Saint-Jean-de-Luz ; ils sont forcés de repasser la Bidassoa.
0324
24 Frimaire I. Après plusieurs combats, les troupes françaises se
rendent maîtres des villes de Mertzicq, de Fredembourg et de
Saarbruck.
0325
25 Frimaire II Armée de la Moselle. Enlèvement de vive force, par trois
différentes divisions de l'armée, des hauteurs de Marsal du Dahubruck
et de Lambach.
25 Frimaire II Armée d'Italie. Les Républicains enlèvent de vive
force les retranchements et redoutes qui défendaient Toulon.
0326
26 Frimaire I. Prise de Consarbruck.
26 Frimaire II Armée d'Italie. Prise de Toulon, fuite précipitée des
Anglais et des Espagnols.
26 Frimaire IV Armée de Sambre et Meuse. Combat sur toute la ligne
dans le Hundstruck ; l'ennemi est battu sur tous les points.
0327
27 Frimaire II Armée des Ardennes. Combat près de Philippeville,
dans le bois de Jamaïque, entre une partie de la garnison de Givet et
les Autrichiens ; l'ennemi est repoussé avec perte.
0329
29 Frimaire II Armée des Pyrénées orientales. Enlèvement à la
baïonnette par deux mille cinq cents Français, des hauteurs près
Villelongue.
0402
2 Nivôse II Armée du Rhin et Moselle. Défaite de l'ennemi à Werd.
0403
3 Nivôse II Armée du Rhin et Moselle.  Enlèvement de tous les
retranchements de Bischweiller, Druzenheim et Haguenau.
0405
5 Nivôse II Armée du Rhin et Moselle.  Déroute de l'ennemi à
Oberséebach.  Prise du château de Geisberg.
0406
Armée du Rhin et Moselle.  Evacuation forcée des lignes de la Lauter
et de Weissembourg, et levée du blocus de Landau par l'ennemi.
0407
7 Nivôse II Armée du Rhin.  Les Français enlèvent les postes de
Germersheim et Spire.
0408
8 Nivôse III Armée du Nord.  Passage du Vaal, prise de Bommel, du fort
Saint-André et de quatre postes environnants, reddition de Grave.
0413
13 Nivôse I Armée du Nord.  Un détachement de l'avant-garde française
pénètre dans le pays de Luxembourg, et s'empare des caisses de
l'Empereur, dans lesquelles se trouvent deux cent mille francs
espèces.
0414
14 Nivôse II Armée de l'Ouest.  Prise sur les rebelles de la Vendée de
l'île de Noirmoutiers.
0417
17 Nivôse II Armée du Rhin et Moselle.  Prise de Worms.
17 Nivôse III Armée des Pyrénées occidentales.  Prise du fort de la
Trinité.
0420
20 Nivôse VI Armée d'Italie.  Deux colonnes de troupes françaises
marchent sur la ville de Rome pour venger la mort du général Duphot,
et l'insulte faite à l'ambassadeur de la République française ; à leur
approche, l'insurrection éclate dans l'Ombrie ; ses habitants secouent
le joug du gouvernement papal et se déclarent libres et indépendants.
0422
22 Nivôse III Armée du Nord.  Prise de Thiel et de six forts.
0423
23 Nivôse II Armée des Pyrénées occidentales.  Enlèvement de vive
force du poste de la Montagne de Louis XIV par quatre cents
républicains.
23 Nivôse V Armée d'Italie.  Combat de Saint-Michel devant Véronne.
23 Nivôse V Armée d'Italie.  L'ennemi attaque la tête de la ligne de
Montebaldo et est repoussé.
0424
24 Nivôse III Armée du Nord.  Prise d'Heusdin.
0425
25 Nivôse V Armée d'Italie.  Bataille de Rivoli, l'ennemi en déroute
complète.
0426
26 Nivôse V Armée d'Italie.  Dix mille ennemis forcent le passage
d'Anghiari.
26 Nivôse V Armée d'Italie.  Le général Provera à la tête de six mille
hommes, attaque le faubourg Saint-Georges de Mantoue pendant toute la
journée, mais inutilement.
0427
27 Nivôse II Armée du Rhin et Moselle.  Les ennemis font une sortie du
fort Vauban et sont repoussés.
27 Nivôse V Bataille de la Favorite (faubourg de Mantoue), Wurmser
échoue dans sa sortie de Mantoue et Provera est obligé de capituler.
0428
28 Nivôse III Armée du Nord.  Prise d'Utrecht, d'Amersford et des
lignes du Greb, passage de la Lech.
0429
29 Nivôse II Armée du Rhin.  Evacuation totale du département du
Bas-Rhin par les coalisés ; reprise du fort Vauban.
29 Nivôse III Armée du Nord.  Prise de Gertuydemberg.
0502
2 Pluviôse II Armée des Pyrénées occidentales. Deux cents Français
enlèvent à la baïonette la redoute d'Harriette près Ispeguy.
2 Pluviôse III Armée du Nord. Les villes de Gorcum, Dordrecht et
d'Amsterdam se rendent aux Français.
0504
4 Pluviôse II Armée du Var. A l'approche des troupes Françaises, les
Anglais abandonnent les îles d'Hyères.
0507
7 Pluviôse V Armée d'Italie. L'ennemi, chassé au-delà de la Brenta,
est atteint à Carpenedelo, et est forcé à la retraite.
0508
8 Pluviôse V Armée d'Italie. L'ennemi poursuivi dans les gorges du
Tyrol est atteint à Avio.
0509
9 Pluviôse V Le général Murat débarque à Torgole et chasse les ennemis ; 
le général Vial les tourne et leur fait quatre cent cinquante
prisonniers. Entrée des Français dans Roveredo et Trente.
9 Pluviôse VI Armée d'Italie. Prise de la ville d'Ancône, par l'armée
française ; elle continue sa marche sur Rome par Maurata.
0510
10 Pluviôse V Armée du Rhin et Moselle. A trois heures du matin, les
Républicains sur deux colonnes, font une sortie de la tête de pont
d'Huningue et chassent l'ennemi des deux premières parallèles.
0513
13 Pluviôse I La république française déclare la guerre au roi
d'Angleterre et au stathouder de Hollande.
13 Pluviôse VI Armée d'Italie. Une des colonnes de l'armée d'Italie,
première division, traverse le territoire Génévois et établit son
quartier général à Ferney-Voltaire.
0514
14 Pluviôse V Armée d'Italie. Les Français attaquent les débris de
l'armée autrichienne derrière le Lavis et les repoussent jusqu'à
Saint-Michel.
Entrée des Français à Janola, trois à quatre mille hommes du Pape,
retranchés derrière la rivière de Senio sont mis en déroute. Entrée
des Français à Faenza et Forli.
Capitulation de Mantoue, la garnison prisonnière de guerre.
0515
15 Pluviôse III Armée des Pyrénées occidentales. Prise de Roses,
après 27 jours de siège.
Armée du Nord. Conquête de la Hollande : toutes les places fortes et
les vaisseaux de guerre restent au pouvoir des Français. Entrée des
troupes françaises à Midelbourg et à Flesingue.
0517
17 Pluviôse III Armée des Pyrénées occidentales. Déroute complette
des Espagnols à Sare et Berra.
Déroute de quinze mille Espagnols battus à Urrugne et à Chauvin-Dragon
par cinq mille républicains ; douze cents ennemis tués.
0518
18 Pluviôse V Armée d'Italie. Les avant-postes de l'ennemi repoussés
sur la droite de l'Adige ; prise de Derunbano.
0521
21 Pluviôse V Armée d'Italie. Les troupes du pape, au nombre de douze
cents hommes, sur les hauteurs en avant d'Ancône, sont enveloppées et
faites prisonnières, sans tirer un coup de fusil.
Prise d'Ancône.
21 Pluviôse VI Armée d'Italie. Les troupes françaises continuent leur
marche sur Rome.
0522
22 Pluviôse V Armée d'Italie. Prise de Lorette.
0527
27 Pluviôse VI Armée d'Italie. Entrée des Français dans Rome ; le
général Berthier se rend au capitole, où, au nom de la République
française, il proclame la République romaine.
0601
1 Ventôse II Armée du Rhin.  Les Français enlèvent de vive force le
poste d'Ogersheim.
1 Ventôse V Armée d'Italie.  Traité de paix avec le pape, conclu à
Tolentino.
0604
4 Ventôse V Armée d'Italie.  Reprise du poste de Treviso.
0605
5 Ventôse V Armée d'Italie.  Affaire de Foi : l'ennemi est chassé de
ses retranchements ; les Français tombent ensuite sur un corps de
chasseurs Tyroliens et les défont.
Les Français, attaqués à Bidole, battent complètement l'ennemi.
Kellerman passe la Piave à San-Mamma, et met en fuite un poste de
hussards ennemis qui en défendaient le passage.
0607
7 Ventôse X Naissance de Victor Hugo
0611
11 Ventôse III Armée des Pyrénées orientales.  Prise de Bezalu.
0612
12 Ventôse V Armée d'Italie.  Les Français attaquent l'ennemi à Monte
di-Savaro et le défont.
0615
15 Ventôse VI Armée en Helvétie.  Capitulation de la ville de Berne.
0616
16 Ventôse II Armée des Ardennes.  Combat près Soumoy et Cerffontaine ; 
défaite de l'ennemi.
0617
17 Ventôse I. Déclaration de guerre au roi d'Espagne.
0618
18 Ventôse II Armée de la Moselle.  Défaite de trois bataillons
autrichiens sur les hauteurs des forges de Joegerthal.
0620
20 Ventôse V.  Armée d'Italie.  Une division de l'armée française se
rend à Feltre ; à son approche l'ennemi évacue la ligne de Cordevoie
et se porte sur Bellurn.
0622
22 Ventôse V.  Armée d'Italie.  La 21e légère passe la Piave vis-à-vis
le village de Vidor, culbute l'ennemi qui vouloit s'opposer à son
passage, et le force d'évacuer son camp de la Gampana.
0623
23 Ventôse V.  Armée d'Italie.  Combat de Sacile.
Affaire de Bellurn, dans laquelle l'arrière-garde ennemie est
enveloppée et faite prisonnière.
23 Ventôse VI Après cinq combats successifs et meurtriers, les Suisses
évacuent Morat.
0626
26 Ventôse V Armée d'Italie.  Passage du Tagliamento, malgré des
forces supérieures et une résistance opiniâtre.
Prise du village de Gradisca.
0627
27 Ventôse VI Traité d'alliance et de commerce entre les Républiques
française et cisalpine.
0628
28 Ventôse V Armée d'Italie.  Prise de Palma Nova, que l'ennemi est
forcé d'évacuer.
0629
29 Ventôse V Armée d'Italie.  Prise de la ville de Gradisca.  Passage
du pont de Casasola.
0630
30 Ventôse V Armée d'Italie.  Combat de Lavis. Les troupes ennemies,
après un combat opiniâtre, sont enveloppées par les Français.
0701
1 Germinal V Armée d'Italie. Entrée des Français dans Geritz.
Affaire de Caminia, entre l'avant-garde française et l'arrière-garde
ennemie.
0702
2 Germinal IV Armée d'Italie. Combat de Tramin et Combat de
Caporetto.
0703
3 Germinal V Armée d'Italie. Combat de Clausen. L'ennemi battu à
Botzen, s'enferme dans Clausen, où il est attaqué par les Français
puis est obligé de céder.
0704
4 Germinal V Armée des Pyrénées orientales. Entrée des Français à
Trieste. Les Français s'emparent des célèbres mines d'Ydria.
0705
5 Germinal II Armée de la Moselle. Avantage remporté sur les
Prussiens, qui attaquent les avant-postes d'Apach au nord de Sierck.
5 Germinal V Armée d'Italie. Combat de Tarvis ; après une opiniâtre
résistance, l'ennemi est mis en déroute.
0706
6 Germinal V Armée d'Italie. Affaire de la Chinse ; prise de ce poste
important.
0708
8 Germinal V Armée d'Italie. Des bataillons ennemis, fraîchement
arrivés du Rhin, entreprennent de défendre la gorge d'Innsbruck ; ils
sont culbutés par la 85e demi-brigade.
0709
9 Germinal V Armée d'Italie. Les Français entrent dans la ville de
Clagenfurth, capitale de la haute et basse Carinthie ; le prince
Charles avec les débris de son armée, extrêmement découragée, fuit
devant eux.
0712
12 Germinal V Armée d'Italie. Combat des gorges de Neumarck ;
l'arrière garde ennemie est culbutée par l'avant-garde française et
les Français entrent dans Neumarck et Freissels.
0714
14 Germinal II Armée des Pyrénées occidentales. Les Français enlèvent
de vive force les retranchemens d'Ozoné, près Saint-Jean de Luz, et
mettent en fuite les Espagnols.
14 Germinal V Armée d'Italie. Les Autrichiens, vaincus sur tous les
points, évacuent le Tyrol. Le prince Charles fait sa retraite à marche
forcée sur la route de Vienne ; il est battu par la division Massena.
0715
15 Germinal V. Combat de Hundsmarck ; l'arrière-garde ennemie est
défaite par l'avant-garde française. Entrée des Français dans
Hundsmark, Kiotenfeld, Mureau et Judembourg.
0716
16 Germinal IV Armée d'Italie. Reconnaissance militaire vers Cairo ;
les postes ennemis sont culbutés.
0717
17 Germinal II Armée des Pyrénées occidentales. Défaite des Espagnols
près d'Hendaye.
Armée d'Italie. Prise du camp de Fougasse.
0718
18 Germinal II Armée d'Italie. Enlèvement de tous les postes aux
environs de Breglio, dans le comté de Nice.
18 Germinal V Suspension d'armes de cinq jours, entre les armées
française en Italie, et impériale.
0719
19 Germinal II Armée d'Italie. Prise d'Oneille.
0720
20 Germinal IV Armée d'Italie. Affaire de Voltry.
0721
21 Germinal II Armée des Pyrénées orientales. Défaite des Espagnols à
Monteilla ; prise d'Urgel.
Armée des Ardennes. Avantage signalé remporté par un faible
détachement sorti de Philippeville, qui chasse l'ennemi du bois situé
entre Villiers et Florence, et le met en déroute.
21 Germinal IV Armée d'Italie. Attaque de la redoute de Montelezimo,
défendue par les Français ; l'ennemi est repoussé.
0722
22 Germinal VI Armée de Mayence. Blocus du fort d'Ehreinbrestein.
0723
23 Germinal IV Armée d'Italie. Bataille de Montenotte ; déroute
complète des ennemis.
0725
25 Germinal III Traité de paix entre la République française et le roi
de Prusse.
25 Germinal IV Armée d'Italie. Prise de Cossaria.
0726
26 Germinal II Armée de la Moselle. Combat sur les hauteurs de
Tiperdange, entre une compagnie du 1er bataillon du Haut Rhin et
quatre-vingt chasseurs républicains, contre soixante hussards de
Wurmser et quatre cents paysans armés.
26 Germinal IV Armée d'Italie. Bataille de Millesimo, gagnée sur les
Austro-Sardes. Combat de Dego, déroute de l'ennemi. Combat et prise
de Saint-Jean, dans la vallée de la Barmida. Prise de Batisolo, de
Bagnosco et de Pontenocetto. Prise des redoutes de Montezemo.
0727
27 Germinal II Armée de la Moselle. Les Français occupent les
hauteurs de Mertzig, après en avoir chassé l'ennemi.
Armée d'Italie. Défaite de quinze cents Autrichiens à Ponte-di-Nava.
27 Germinal IV Armée d'Italie. Prise du camp retranché de la ville de
Cera.
0728
28 Germinal II Armée d'Italie. Prise d'Ormea.
0729
29 Germinal II Armée de la Moselle. Bataille d'Arlon ; prise de cette
ville, déroute complète de l'ennemi.
0802
2 Floréal I Armée des Pyrénées occidentales. Affaire de Jurgazza
Mondi, dans laquelle les troupes républicaines ont mis dans une
déroute complète un corps d'Espagnols.
0803
3 Floréal II Armée des Ardennes. Déroute complète de l'ennemi à
Aussoy, près Philippeville, après un combat de douze heures.
3 Floréal IV Armée d'Italie. Combat et prise de la ville de Mondovi.
0804
2 Floréal II Armée du Rhin. Victoire remportée auprès de
Kurweiller.
0805
5 Floréal I Armée des Pyrénées orientales. Affaire de Samouragaldi,
dans laquelle deux cents Français ont battu complètement quatre cents
Espagnols.
Bombardement de Fontarabie.
5 Floréal II Armée des Alpes. Enlèvement de vive force de toutes
les redoutes des Monts Valaisan et Saint-Bernard et du poste de la
Thuile.
5 Floréal IV Armée d'Italie. Entrée des Français dans la ville de
Bêne.
0806
6 Floréal IV Armée d'Italie. Prise de Fossano, de Cherasco, d'Alba.
0807
7 Floréal II Armée des Pyrénées occidentales. Déroute des Espagnols
et des émigrés, repoussé des postes d'Arnéguy et d'Irameaca.
Armée des Ardennes. Victoire remportée, après quatre heures d'une
résistance opiniâtre. Enlèvement de vive force, des hauteurs de Bossu ; 
entrée et réunion des armées des Ardennes et du Nord dans la ville
de Beaumont.
Armée du Nord. Prise de Courtray, après une bataille générale sur
toute la ligne, depuis Dunkerque jusqu'à Givet.
Armée des Pyrénées orientales. Les Français enlèvent de vive force le
poste du rocher d'Arrola.
Déroute de quatre mille hommes d'infanterie et de dix escadrons de
cavalerie espagnole à Roqueluche ; perte considérable de l'ennemi.
0808
8 Floréal II Armée des Pyrénées orientales. Les Français, au nombre
de trois mille, chassent dix mille ennemis du village d'Oms ; ils
enlèvent les gorges et le pont du Ceret.
0809
9 Floréal IV Armée d'Italie. Armistice conclu avec le roi de
Sardaigne.
0810
10 Floréal II Armée du Nord. Victoire à Mont-Castel sur vingt mille
Autrichiens.
Prise de Menin et d'une grande quantité d'artillerie.
Armée d'Italie. Victoire sur les Piémontais.
10 Floréal IV Entrée des Français dans la cité de Ceva et de Coni.
10 Floréal V Traité de paix entre la République française et le pape.
0811
11 Floréal II Armée des Pyrénées orientales. Bataille gagnée sur les
Espagnols, aux Albères ; enlèvement de la fameuse redoute de
Montesquiou.
11 Floréal V Armée d'Italie. Préliminaires de paix entre la
République française et l'Empereur, signés à Leoben par le général
Buonaparte et les plénipotentiaires de l'Empereur.
0812
12 Floréal II Armée du Rhin. Prise de Lambsheim et de Franckental par
les Français ; les portes de cette dernière ville sont enfoncées à
coups de canons.
0815
15 Floréal II Armée des Pyrénées orientales. Les Français occupent
les hauteurs du cap de Bearn et du pays de Las-Daines, où six mille
hommes arrivent à travers les plus nombreux obstacles ; commencement
du siége de Collioure.
15 Floréal III Armée des Pyrénées orientales. Les Espagnols attaquant
le camp de Cistella, sont complètement battus et repoussés.
0816
16 Floréal IV Armée d'Italie. Entrée des Français dans la ville de
Tortonne.
0817
17 Floréal III Armée des Pyrénées orientales. Reconnoissance générale
faite par les Français sur les hauteurs de Crespia, de Bascara et sur
la Fluvia.
0818
18 Floréal IV Armée d'Italie. Reconnoissance faite sur la rive du Pô,
vers Plaisance.
0819
19 Floréal IV Armée d'Italie. Passage du Pô par l'avant-garde
républicaine, et combat de Fombio.
0820
20 Floréal II Armée des Alpes. Prise du fort Mirabouck, après
quatorze heures d'attaque, et du poste de Villeneuve-des-Prats.
Prise de la redoute de Maupertuis.
20 Floréal III Armée des Pyrénées orientales. Attaque du camp de la
montagne de Musquirachu ; l'ennemi mis en fuite, abandonne son camp
tout tendu et tous les effets de campement ; cent quarante ennemis
tués, cinquante faits prisonniers.
20 Floréal IV Armée d'Italie. Les Autrichiens attaquent près de
Cordogno la division Laharpe, et sont vigoureusement repoussés par les
Républicains, qui s'emparent de Casale.
Conclusion de l'armistice avec le duc de Parme.
0821
21 Floréal II Armée des Ardennes. Prise de Thuin par les Français,
après un combat opiniâtre : enlèvement à la baïonnette de tous les
retranchements Autrichiens.
21 Floréal IV Armée d'Italie. Bataille de Lody : passage du pont
défendu par l'armée entière de Beaulieu.
0822
22 Floréal II Armée du Nord. Défaite des ennemis devant Tournay.
Combat de sept heures devant Courtray : déroute complète de
l'ennemi. Déroute de l'ennemi à Ingelsmunster.
22 Floréal IV Armée d'Italie. Buonaparte, général en chef. Prise de
Pizzighitone. Entrée des Français dans Crémone.
0823
23 Floréal II Armée des Ardennes. Les Français enlèvent tous les
ouvrages du camp de Merbes, d'où l'ennemi est forcé de se retirer.
Au passage de la Sambre, les grenadiers du 49e régiment s'élancent à
l'eau pour soutenir les tirailleurs, et mettent en déroute la légion
de Bourbon.
Le 68e régiment soutient seul sur un pont l'attaque des Autrichiens
supérieurs en nombre, quoiqu'en butte à l'artillerie, et conserve son
poste.
0824
24 Floréal II Armée des Ardennes. Combat opiniâtre : prise et reprise
trois fois du village de Grandreng près Beaumont.
0825
25 Floréal II Armée des Alpes. Les républicains enlèvent de vive
force les redoutes de Riveto, de la Ramasse, et autres postes sur le
Mont-Cénis.
0826
26 Floréal IV Armée d'Italie. Conclusion de la paix avec le roi de
Sardaigne.
0827
27 Floréal II Armée des Pyrénées orientales. Sortie de la garnison de
Collioure : trois mille Espagnols repoussés avec perte. Le général en
chef blessé dans cette action.
0828
28 Floréal IV Armée d'Italie. Les Français occupent Milan, Pavie et
Come.
0829
29 Floréal II Armée du Nord. Défaite de l'ennemi à Moescroen.
Bataille gagnée sur les coalisés, entre Menin et Courtray.
Armée des Ardennes. Glorieuse résistance de quinze cents Français qui
s'opposent à la marche de quatorze mille Autrichiens vers Cunfoz.
Cent cinquante jeunes gens de la première réquisition qui tiennent en
échec toute la droite de l'armée de Beaulieu devant Bouillon.
Armée des Pyrénées occidentales. Enlèvement de six magasins
ennemis. Rupture des écluses de la grande mâture royale : prise d'une
grande quantité de bestiaux.
Déroute des Espagnols, repoussés à la baïonnette jusqu'à leur camp de
Berra.
0830
30 Floréal II Armée des Pyrénées orientales. Déroute des Espagnols
près de Figuières.
Armée des Ardennes. Belle défense de cent soixante Français renfermés
et attaqués par de nombreux ennemis dans le château de Bouillon.
30 Floréal VI Bombardement d'Ostende par les Anglais, et débarquement
de quatre mille d'entre eux ; les Français les enveloppent, font deux
mille prisonniers, et forcent le reste à se rembarquer précipitemment
avec perte de cent hommes tués. Le général anglais est lui-même
grièvement blessé.
0901E
1 Prairial VII Naissance d'Honoré de Balzac
0925
25 Prairial VIII Bataille de Marengo en Italie, Kléber est assassiné au Caire
1008
8 Messidor II Victoire de Fleurus par Jourdan. Première utilisation de la
reconnaissance aérienne par le capitaine Coutelle, à bord du ballon L'Entreprenant
1103
3 Thermidor III Victoire de Hoche à Quiberon contre les royalistes
1109
9 Thermidor II La chute de Robespierre
1118
18 Thermidor IV Victoire de Bonaparte sur Wurmser à Castiglione
1303
Jour du travail V Mort du général Hoche
1305
Jour des récompenses IV Mort du général Marceau, âgé de 27 ans, à Altenkirchen
EVENTS
  delete $event{dummy};
}

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
"Dansons la carmagnole, vive le son du canon.";
