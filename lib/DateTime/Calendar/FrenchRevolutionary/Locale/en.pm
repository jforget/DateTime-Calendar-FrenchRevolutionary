package DateTime::Calendar::FrenchRevolutionary::Locale::en;

my @months_short  = qw (Vin Fog Fro Sno Rai Win Bud Flo Mea Rea Hea Fru S-C);

# based on Thomas Carlyle's book:
my @months = qw(Vintagearious Fogarious Frostarious
		Snowous       Rainous   Windous
		Buddal        Floweral  Meadowal
		Reapidor      Heatidor  Fruitidor);

push @months, "additional day";

my @decade_days = qw (Firsday Seconday Thirday Fourday Fifday Sixday Sevenday Eightday Nineday Tenday);
my @decade_days_short = qw (Fir Two Thi Fou Fif Six Sev Eig Nin Ten);

# When initializing an array with lists within lists, it means one of two things:
# Either it is a newbie who does not know how to make multi-dimensional arrays,
# Or it is a (at least mildly) experienced Perl-coder who, for some reason, 
# wants to initialize a flat array with the concatenation of lists.
# I am a (at least mildly) experienced programmer who wants to use qw() and yet insert
# comments in some places.
# This array is mainly based on http://www.kokogiak.com/frc/default.asp
# Used with permission from Alan Taylor
my @feast = (
# Vendémiaire
	qw(
       grapes			saffron		sweet_chestnut	colchic		horse
       balsam			carrot		?amaranthe	parsnip		vat
       potato			?immortality	squash		reseda		ass
       ?beauty_of_the_night	pumpkin		buckwheat	sunflower	press
       hemp			peach		turnip		amarillis	ox
       eggplant			pepper		tomato		barley		barrel
	),
# Brumaire
	qw(
       apple		celery		pear			beet		goose
       ?heliotrope	fig		black_salsify		?service_tree	plow
       salsify		water_caltrop	jerusalem_artichoke	endive		turkey
       ?chervis		cress		plumbago		?grenade	harrows
       ?bacchante	?azerole	?garance		orange		pheasant
       pistachio	?macjonc	quince			?cormier	roller
	),
# Frimaire
	qw(
       ?raiponce 	turnips		chicory		medlar		pig
       ?chews		cauliflower	honey		juniper		pick
       wax		horseradish	cedar		fir_tree	roe-deer
       gorse		cypress		ivy		?sabine		grub-hoe
       maple_sugar	heather		reed		sorrel		cricket
       ?pinion		liege		truffle		olive		shovel
	),
# Nivôse
	qw(
       peat		 coal		bitumen		sulphur		dog
       lava		 topsoil	manure		saltpeter	flail
       granite		 clay		slate		sandstone	rabbit
       flint		 ?marne	  	limestone	marble		horse_carriage
       ?gypsum		 salt		iron		copper		cat
       tin		 lead		zinc		mercury		sifter
	),
# Pluviôse
	qw(
       ?laureole	moss		?fragon		?sleet		bull
       thyme		?amadouvier	?mézéréon	poplar		axe
       hellebore	broccoli	laurel	        ?avelinier	cow
       boxwood		lichen		yew		?breath		billhook
       ?thlaspi		thimele		grass		?trainasse	hare
       ?guède		hazel_tree	?cyclamen	chelidonium	sleigh
	),
# Ventôse
	qw(
       ?tussilage	dogwood		?violier	privet		billygoat
       ?asaret		?alaterne	violet		?marceau	spade
       narcissus	elm		?fumeterre	hedge_mustard	goat
       spinach		?doronic	pimpernel	chervil		twine
       mandrake	        parsley		?cochléaria	daisy		tuna
       dandelion	?sylve		capillary	ash		dibble
	),
# Germinal
	qw(
       primula		plane_tree	asparagus	tulip		hen
       white_beet	birch		jonquil		alder		hatchery
       periwinkle	?charm		morel		beech		bee
       lettuce		larch		hemlock		radish		hive
       ?gainier		?roman_lettuce	chestnut_tree	?rocket		pigeon
       lilac		anemone		?thought	bilberry	?transplants
	),
# Floréal
	qw(
       rose		oak			fern		hawthorn	nightingale
       ?ancolie		lily_of_the_valley	mushroom	hyacinth	rake
       rhubarb		?sainfoin		?gold_bar	chamerops	silkworm
       ?consound	burnet			?gold_basket	orache		hoe
       ?statice		fritillaire		?bourache	?valerian	carp
       ?charcoal	chive			?buglosse	?sénevé		shepherd_staff
	),
# Prairial
	qw(
       alfalfa		?hémérocalle	clover		angelic		duck
       balm		wheat		?martagon	wild_thyme	scythe
       strawberry	?bétoine	pea		?acacia		?quail
       carnation	elder_tree	poppy		lime		pitchfork
       barbel		?camomile	honeysuckle	curds		tench
       jasmine		vervain		thyme		peony		carriage
	),
# Messidor
	qw(
       rye		oats		onion		veronique	mule
       rosemary		cucumber	shallot		wormwood	sickle
       coriander	artichoke	clove		lavender	?chamois
       tobacco		currant		gess		cherry		park
       mint		?cumin		bean		?orcanète	guinea_hen
       sage		garlic		tare		corn		chalemy
	),
# Thermidor
	qw(
       german_wheat	?soup_stock	melon		ryegrass	ram
       ?prêle		?armoise	carthame	blackberry	watering_can
       ?parsnip		salicorne	apricot		basil		ewe
       ?marshmallow	flax		almond		gentian		waterlock
       carline		caper		?lens		?aunée		otter
       myrtle		?colza		?lupin		cotton		mill
	),
# Fructidor
	qw(
       plum		?millet		?lycoperdon	barley		salmon
       tuberose		sucrion		?apocyn		liquorice	stepladder	
       watermelon	fennel		barberry	nut		trout
       lemon		?cardère	buckthorn	?tagette	?basket
       wild_rose	hazelnut	hops		sorghum		crayfish
       bitter_orange	goldenrod	corn		chestnut	basket
	),
# Jours complémentaires
	qw(
       virtue            genius            labour          opinion          rewards
       revolution
	 ));

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
  $lb =~ s/^\?//;
  $lb =~ s/_/ /g;
  return substr($lb, 1);
}

sub feast_long {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0] . " day";
  $lb =~ s/^\?//;
  $lb =~ s/_/ /g;
  return $lb;
}

sub feast_caps {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0] . " Day";
  $lb =~ s/^\?//;
  $lb =~ s/_/ /g;
  return ucfirst($lb);
}

sub on_date {
  my ($self, $date) = @_;
  _load_events() unless %event;
  $event{$date->strftime('%m%d%n')} || "";
}

sub _load_events {
  %event = ('dummy', split /(\d{4}\n)/, <<'EVENTS');
0101
1 Vendémiaire I The French troops enter Savoie
1 Vendémiaire III The outposts in the woods of Aachen and Reckem are
taken by the Army of North (Jourdan)
0102
2 Vendémiaire I Conquest of Chambéry
2 Vendémiaire III The  Costouge redoubt and camp are taken by the Army
of Eastern Pyrenees (Dugommier).
2 Vendémiaire V The Army of Italy (Kilmaine) routs the enemy at Governolo.
0103
3 Vendémiaire IV affair of Garesio (Miolis)
0104
4 Vendémiaire II The Army of Alps (Verdelin) takes the entrenchments of
Chatillon; the Piemontese rout across the Giffe river
0105
5 Vendémiaire III The Spanish are defeated in Olia and Monteilla by the
Army of Eastern Pyrenees (Charlet).
0106
6 Vendémiaire III Surrender at Crevecoeur to the Army of the North (Delmas)
6 Vendémiaire III Kayserlautern, Alsborn and other surrounding outposts
are taken again by the Army of the Rhine (Michaud)
6 Vendémiaire V The enemy attacks the Armée of Sambre et Meuse (Hardy) at
Wurstatt, Nider-Ulm, Ober and  Nider-Iogelheim; the attack is repulsed.
0107
7 Vendémiaire I Anselm's troops conquer the city of Nice and the  Montalban fortress. 
7 Vendémiaire II The Army of Alps (Verdelin) defeats the enemy in the  Sallanges 
defiles and takes the Saint-Martin redoubt.
0108
8 Vendémiaire V 150 men from the Army of Italy sortie from Mantoue to forage.
They must surrender to the people of Reggio.
0109
9 Vendémiaire I  Custines' Frenchs conquer the Spire city after having
blown the gates with cannon and endured musketry fire in the streets.
9 Vendémiaire II The Army of Alps (Chamberlhac) takes the entrenchments at
Mont-Cormet, previously held by Piemontese.
0111
11 Vendémiaire II Prisy's troops (Army of Alps) take the Valmeyer outpost
after a bayonet charge, Saint-André's and Chamberlhac's troops take the Beaufort
outpost, General-in-Chief Kellerman's troops take Moutiers and the Saint-Maurice
town and Ledoyen's troops storm the Madeleine pass outpost. 
11 Vendémiaire III during the battle of Aldenhoven, the Army of Sambre-et-Meuse
(Jourdan) routs the coalised troops.
11 Vendémiaire V the Army of Rhine and Moselle (general-in-chief Moreau, 
division generals Desaix and Saint-Cyr) attacks on the whole front and routs the enemy.
0112
12 Vendémiaire II The Spanish troops are repulsed back in their camps in the Boulon 
and Argelès by the Army of Eastern Pyrenees (Delatre).
12 Vendémiaire III the land of Juliers surrenders to the Army of Sambre-et-Meuse (Jourdan).
0113
13 Vendémiaire I the Austrians must leave the city of  Worms
and Custines' troops enter the city.
13 Vendémiaire II Army of Eastern Pyrenees : Dagobert's troops take
Campredon while the Colioure garrison (Delatre) fights and routs the Spanish cavalry.
13 Vendémiaire II arrayed in three columns (Lasalle, Mascaron and
Dat), the Army of Western Pyrenees attacks and takes the Arau and Aure
valley outposts.
13 Vendémiaire IV Bonaparte represses a royalist demonstration near Saint-Roch church
0115
15 Vendémiaire III Cologne surrenders to the Army of Sambre-et-Meuse (Jourdan).
0116
16 Vendémiaire V the enemy, blockaded in Mantoue by the Army of Italy (Sahuguet) 
attempt a  4,600-troop sortie but fails.
0117
17 Vendémiaire I as the French Army comes near, the  Austrians lift
the siege of Lille.
17 Vendémiaire III fight for and capture of Frankenthal by the Army of the Rhine (Desaix)
0118
18 Vendémiaire II bombardment of Lyon, which opens her gates to
Dubois-de-Crancé's troops.
18 Vendémiaire III capture of Shelaudenbach and Vollfstein by the Army of the Rhine (Michaud)
which links with the Army of Moselle in Lautreck.
0119
19 Vendémiaire III before Maestricht, the Army of Sambre-et-Meuse (Duhesme) takes back
the  Mont-Saint-Pierre castle.
0120
20 Vendémiaire III the Army of Moselle (Moreau) marches on Birkenfeldt, Oberstein,
Kirn and Meisenheim.
0121
21 Vendémiaire III the Army of the North (Delmas) enters in Bois-le-Duc.
0122
22 Vendémiaire I Kellerman forces the Prussians to leave the city of Verdun.
He enters Verdun and continues his march to the Prussians.
0123
23 Vendémiaire III the Army of the Rhine (Michaud) takes Otterberg, Rockenhausen, 
Landsberg, Alzein and Oberhausen.
0124
24 Vendémiaire II the Army of Moselle (Delaunay) fights and routs the
Coalised wchich had advanced on Bitche and Rorbach.
24 Vendémiaire III fight for and capture of Gellheim and Grunstad by
the Army of the Rhine (Michaud); the Frenchs capture also Frankenthal.
0125
25 Vendémiaire II combat near Sarreguemines; the Army of Moselle (Delaunay)
repulses the enemy.
0126
26 Vendémiaire I the Austrians attack and fail several times Hasnon
(Muller commander), they are repulsed having suffered many losses.
26 Vendémiaire II the battle of Wattignies near Maubeuge is won
by the Army of the North (Jourdan) against the Austrians and the blockade of 
Maubeuge is lifted.
26 Vendémiaire III The Army of Western Pyrenees (Moncey) takes
Iraty and the wonderful forges of Egay and Orbaycette.
26 Vendémiaire III Army of Moselle :  general-in-chief 
Moreau's troops take Creutznach and Custines' troops take Worms.
26 Vendémiaire VI Army of Italy: peace traity in Campo-Formio
near Udine between  general Bonaparte and the plenipotentiaries
of the Emperor, king of Hungary and Bohemia.
26 Vendémiaire VI congress in Rastadt to conclude peace between the 
French Republic and the German Empire.
0127
27 Vendémiaire II 600 republican troops from the Army of Italy (Dugommier) 
take a tactical advantage in  Gillette over 4,000 Austrians, Croats and Piemontese
and repulse them.
27 Vendémiaire III The Army of Western Pyrenees (Delabare) defeats 7,000 
Spanish troops near Buruet and Almandos.
27 Vendémiaire III The Army of the Rhine (Michaud) routs the enemy near
Kircheim and Worms and captures both cities.
0128
28 Vendémiaire II The Army of Italy (Dugommier) achieves a complete
victory at Gilette over the Piemontese.
28 Vendémiaire III The Armée of the North (Souham) defeats the enemy near Nimegen
and destroys the legion of Rohan.
28 Vendémiaire V The Army of the Rhin and Moselle (general-in-chief Moreau and
division general Beaupuis) is attacked in Retzengen and Simonswald, but
the enemy efforts fail.
0129
29 Vendémiaire I The French Army (general-in-chief Custines) forces the
Austrians to leave Mayence.
29 Vendémiaire III The Armée of Moselle (Moreau) enters  Bingen
after having expelled the Prussians from the positions they held before the town.
29 Vendémiaire V the Army of Italy (Casalta), debarking in Corsica, advances to
Bastia and expels the English from the fort where they had retired.
Saint-Florent and Bonifacio also captured.
0130
30 Vendémiaire II the Army of Western Pyrenees (Poncet) 
routs three Spanish columns after a five-hour firefight.
30 Vendémiaire V Army of Sambre and Meuse (general-in-chief Beurnonville,
division generals Championnet and Grenier): the enemy crosses the Rhine at
six points from Bacharach up to Andernach and attacks the Neuwied bridgehead 
but is forced to retreat.
0201
1 Brumaire I Longwi taken back, the Prussians evacuate the French
territory.
1 Brumaire II Army of Eastern Pyrenees.  Advantage over the Spanish
Army in the valley of Baigory.
1 Brumaire II Army of the North. The outposts of Warneton, Comines,
Werwick, Ronek, Alluin, Menin, Furnes et Poperingues are taken.
1 Brumaire II Army of the Rhine. Alzey and Oppenheim captured.
0202
2 Brumaire II Army of Italy. 5 000 enemies defeated in Utel.
2 Brumaire II Army of the Rhine. The Austrians attack the outpost of
Breitenstein and is repulsed.
2 Brumaire II Army of Sambre and Meuse.  Coblentz taken, the enemy
crosses the Rhine and flees.
2 Brumaire II Army of Eastern Pyrenees.  Fighting in Bhaga, the
Spanish are repulsed.
2 Brumaire II Army of Eastern Pyrenees. The outposts of Dori and Tozas
and the entranchements in Casteillan are taken.
0203
3 Brumaire V Peace treaty signed between the French Republic and the
King of Naples and the Two-Sicilies.
0204
4 Brumaire VI Army of Italy. Treaty of alliance between the French
Republic and the King of Sardinia.
0205
5 Brumaire III Army of the North. Hultz, Axel and Sas-de-Gand taken.
5 Brumaire V Army of Sambre and Meuse.  Attack and capture of Saint
Wendel, Kayserslautern, Kirchenpoland, Bingen and the Saint-Roch
mountain.
5 Brumaire V Army of the Rhine et Moselle. Crossing of the Rhine by
the French, capture of the Khel fort.
0207
7 Brumaire V Army of Italy. An enemy sortie from Mantoue is repulsed.
0208
8 Brumaire III Army of the North.  Capture of Venlo.
0209
9 Brumaire II Army of Eastern Pyrenees. A battery before Ville longue
is taken by a bayonet charge.
0211
11 Brumaire III Army of Eastern Pyrenees. The Spanish troops are routed on
the reverse slope of the montagne Noire.
0212
12 Brumaire I The Austrians must evacuate the small town Lanoy, the
last closed outpost they still had on the French territory.
12 Brumaire III Army de la Moselle. The French enter Rheinfels,
evacuated by 12 000 enemies.
12 Brumaire V Army of Italy.  Capture of the Saint-Michel  village.
The French burn the bridges on the Adige. The enemy turns to Lavis,
where it is beaten and repulsed to the Segonzano village.
0214
14 Brumaire V Army of Sambre and Meuse. Capture of Maestricht.
0215
15 Brumaire V Army of Italy. The enemy attacks across Brenta and
crosses back after a murderous fight.
0216
16 Brumaire I.  Battle of Gemmapes. Following this victory, the
Frenchs enter Mons.
16 Brumaire III Army of the North. The fort of Schenk is taken.
0217
17 Brumaire III Army of the North. The sortie of the Berg-op-zomm
garrison is repulsed by a French bayonet charge.
0218
18 Brumaire I. The French capture Tournay.
18 Brumaire III Army of the North.  Triumphant entry of the French
into Nimègue.
18 Brumaire VIII Bonaparte's coup: end of the Directoire, beginning of the Consulate
0219
19 Brumaire IV Army of the North.  Burick taken.
0220
20 Brumaire IV Army of Sambre and Meuse. Fight near Creutzenach,
during which the enemy must cross back the Nahe river.
0221
21 Brumaire V Army of Italy.  The French army, on the Adige river,
meets the enemy between Saint-Michel and Saint-Martin and repulses
him.
0222
22 Brumaire I Army of the North.  The city of Gand open her gates to
the French army.
22 Brumaire I. Charleroy taken by the Frenchs.
22 Brumaire III Army of the Rhine.  Monbach and neighbour outposts
taken.
22 Brumaire III Army of the Rhine. Capture of Weissenau.
0223
23 Brumaire I.  Battle of Anderlecht near Bruxelles.  The enemy is
completely defeated, the French army enters triumphantly in Bruxelles.
0224
24 Brumaire I.  Capture of Frankfurt.
24 Brumaire II Army of the West. The Vendean rebels are defeated
before the walls of Granville.
0225
25 Brumaire V Army of Italy.  Battle of Arcole. This battle lasts for
three days and the decision is made when the Arcole village is taken
on 27.
0226
26 Brumaire I. The Frenchs control the town and harbour of Ostende,
evacuated by the Austrians.
26 Brumaire I.  Sainte-Remi captured.
26 Brumaire I. The town of Malines capitulates.
26 Brumaire II Army of the Rhine. The army launches a surprise attack
and captures three enemy outposts near Strasburg.
26 Brumaire II The siege of Granville is lifted.
26 Brumaire IV Fight of champ di Pietri.
0227
27 Brumaire II Army de la Moselle. 4 000 Austrians defeated before
Bitche.  The Austrians near Lebach are utterly routed.  Bising and
Blise-Castel captured.
27 Brumaire III Army of Eastern Pyrenees. General-in-chief Dugommier
is killed by a shell in the skirmish of St. Sebastien de la Mouga.
27 Brumaire III Army of Eastern Pyrenees. Victorious battle against
the Spanish at Saint-Sebastien.
0228
28 Brumaire I The cities of Ypres, Furnes and Bruges are captured.
The Frenchs enter Anvers.
28 Brumaire II Army of the Rhine. The Neuviller outpost and four other
are taken. A big redoubt and 7 guns are captured near Wantzenau.
28 Brumaire V Peace treaty signed between the French Republic and the
Duke of Parme.
0229
29 Brumaire II The Army of the Rhine captures two redoubts near
Bouxweiller.
0230
30 Brumaire II Army of Eastern Pyrenees. Victorious battle at Escola,
Liers, Vilartoly, against 50 000 Spanish troops.
30 Brumaire II Army of Moselle. 12 000 infantry and 300 cavalry
defeated near Blascheidt, and Lorentsweiller.
0301
1 Frimaire I Army of Ardennes. Namur captured by the Frenchs.
1 Frimaire III Army of the Moselle. More than 400 enemies defeated
in the forest of Grunnevald, near Luxembourg.
1 Frimaire V Army of Italy. The enemy is attacked and repulsed from
each position to the next; from Castel-Nobo to Rivoli, la Corona, 
and along the Adige river until Dolce.
0302
2 Frimaire I Army of the Rhine. 5 000 Frenchs rout the whole enemy
army before Tirlemont.
2 Frimaire II Army of the Rhine. Several fights and capture by the
Frenchs of the Bouxweiller, Brumpt and Haguenau outposts; the enemy
routs.
2 Frimaire IV Army of Italy. Battle of Loano, the Austro-Sards rout.
Capture of la Pietra, Loano, Finale, Vado and Savonne.
2 Frimaire V Army of the Rhine And Moselle. The Kehl garrison sorties.
The enemy line is pushed through without a single shot. Part of its
artillery is spiked.
0303
3 Frimaire IV Army of Italy. Fight at Intrapa and Garesio.
3 Frimaire V. Sortie by the garrison of Mantoue, which is repulsed.
0304
4 Frimaire II Army of Italy. 800 Piemontese defeated by 500 Frenchs at
Castel-Genest and Brec, capture of Figaretto.
4 Frimaire III Army of Western Pyrenees. Victory in Ostés, after a
two-day fight.
0306
6 Frimaire IV Army of Italy. Fights in Spinardo and other places.
0307
7 Frimaire I Army of the Rhine. The city of Liege is taken, following
a complete victory on the Austrians after a 10-hour fight.
7 Frimaire III Army of Eastern Pyrenees. Capture of the Figuières
fortress.
0308
8 Frimaire III Army of Eastern Pyrenees. Battle won against the
Spanish at Begara, Ascuatia and Aspetia.
0310
10 Frimaire I Army of the North. Capitulation of the Anvers citadelle.
10 Frimaire II Army of the North. Attack of all the enemy outposts on
the Lys.
10 Frimaire IV Army of Sambre et Meuse. Attack and capture of
Creutzenach.
0311
11 Frimaire I Army of Ardennes. Capitulation of the Namur citadelle.
11 Frimaire II Army of the Rhine. The redoubt of the Landgraben
bridge and the entrenchments at Gambsheim are taken.
11 Frimaire III Army of the Rhine And Moselle. The redoubt known as
"Merlin redoubt" before Mayence is taken.
11 Frimaire V. The enemy, arrayed in three columns, attacks the
bridghead at Huningue and takes a fortification; it is repulsed after
a fierce fighting.
11 Frimaire XIII Napoléon 1st is crowned Emperor of the French
11 Frimaire XIV Austerlitz battle: the French army crushes the Austro-Russian army
0312
12 Frimaire II Army of Ardennes. Strong sortie of the Givet garrison,
which inflicts many enemy casualties while losing only 5 to 6 troops,
between Falmagne and Falmignoule.
12 Frimaire II Army of the Rhine. Fight near the Gambshein wood.
0314
14 Frimaire II Army of the Rhine. The enemy, expelled from the
Oppendorff village, is pursued until Druzenheim.
14 Frimaire III Army of the Moselle. The Republic's troops storm the
Salbach redoubts.
0319
19 Frimaire II Army of the Rhine. After a fierce action the Dawendorff
highground is captured.
0321
21 Frimaire I Army of the North. Capture of Wezem, Wert and Ruremonde,
in which the Frenchs enter triumphantly.
0322
22 Frimaire II Army of the West. Victory against the Vendean rebels
near Le Mans.
0323
23 Frimaire II Army of Western Pyrenees. The Spanish troops are routed
near Saint-Jean-de-Luz ; they must cross the Bidassoa.
0324
24 Frimaire I. After several fights, the French troops take the towns
of Mertzicq, Fredembourg and Saarbruck.
0325
25 Frimaire II Army of the Moselle. Three divisions take the
highgrounds of Marsal, Dahubruck and Lambach.
25 Frimaire II Army of Italy. The French troops take the entrenchments
and the redoubts that were defending Toulon.
0326
26 Frimaire I. Capture of Consarbruck.
26 Frimaire II Army of Italy. Toulon conquered, the English and
Spanish troops flee.
26 Frimaire IV Army of Sambre and Meuse. Fight on the whole
Hundstruck line; the enemy is beaten everywhere.
0327
27 Frimaire II Army of Ardennes. Fight near Philippeville, in the
Jamaique wood, between a party from the Givet garrison and the
Austrians; the enemy is repusled with losses.
0329
29 Frimaire II Army of Eastern Pyrenees. 2 500 French troops execute a
bayonet charge and take the highgrounds near Villelongue.
0402
2 Nivôse II Army of the Rhine and Moselle. The enemy defeated at Werd.
0403
3 Nivôse II Army of the Rhine and Moselle.  All entrenchments at
Bischweiller, Druzenheim and Haguenau are taken.
0405
5 Nivôse II Army of the Rhine and Moselle. The enemy is routed at
Oberséebach.  Capture of the castle of Geisberg.
0406
Army of the Rhine and Moselle. The enemy is forced to evacuate the
lines of Lauter and Weissembourg and to lift the blockade of Landau.
0407
7 Nivôse II Army of the Rhine.  The Frenchs capture the outposts at
Germersheim and Spire.
0408
8 Nivôse III Army of the North.  Crossing of the Vaal, capture of
Bommel and the Saint-André fort, surrender of Grave.
0413
13 Nivôse I Army of the North. Elements of the French vanguard enter
the region of Luxembourg and grab the Emperor's warchest.
0414
14 Nivôse II Army of the West. The island of Noirmoutiers is taken
from the Vendean rebels.
0417
17 Nivôse II Army of the Rhine and Moselle.  Worms captured.
17 Nivôse III Army of Western Pyrenees.  Trinité fort captured.
0420
20 Nivôse VI Army of Italy. Two French columns converge on Rome to
avenge the death of general Duphot and the insult to the ambassador of
the French Republic. When they are nearing, the people raise and
overthrow the papal government.
0422
22 Nivôse III Army of the North.  Capture of Thiel and six forts.
0423
23 Nivôse II Army of Western Pyrenees. 400 Republican troops storm the
"poste de la Montagne" of Louis XIV.
23 Nivôse V Army of Italy.  Fight of  Saint-Michel before Verona.
23 Nivôse V Army of Italy. The enemy attacks the Montebaldo line and
is repulsed.
0424
24 Nivôse III Army of the North.  Capture of Heusdin.
0425
25 Nivôse V Army of Italy.  Rivoli battle, the enemy is completely
routed.
0426
26 Nivôse V Army of Italy. 10 000 enemy troops cross at Anghiari.
26 Nivôse V Army of Italy. General Provera, leading 6 000 troops,
attacks the Saint-George suburb of Mantoue to no effect.
0427
27 Nivôse II Army of the Rhine and Moselle. The enemies sortie from
the Vauban fort but they are repulsed.
27 Nivôse V Battle of the Favorite (suburb of Mantoue), Wurmser
sorties from Mantoue and fails, and Provera must capitulate.
0428
28 Nivôse III Army of the North.  Capture of Utrecht, Amersford and
the Greb lines, crossing of the Lech.
0429
29 Nivôse II Army of the Rhine. The coalized evacuate completely the
Lower-Rhine department. The Vauban fort is taken back.
29 Nivôse III Army of the North.  Capture of Gertuydemberg.
0502
2 Pluviôse II Army of Western Pyrenees. 200 Frenchs storm the
Harriette redoubt near Ispeguy.
2 Pluviôse III Army of the North. The towns of Gorcum, Dordrecht and
Amsterdam surrender to the Frenchs.
0504
4 Pluviôse II Army of Var. As the French are nearing, the English
leave the Hyeres islands.
0507
7 Pluviôse V Army of Italy. The enemy, repulsed beyond the Brenta, is
reached at Carpenedelo, and forced to retreat.
0508
8 Pluviôse V Army of Italy. The enemy, pursued in the Tyrol gorges, is
reached at Avio.
0509
9 Pluviôse V. General Murat lands in Torgole and repulses the enemy;
General Vial outflank them. The French enter in Roveredo and Trente.
9 Pluviôse VI Army of Italy. Capture of the town of Ancône, by the
French army, which continues toward Rome through Maurata.
0510
10 Pluviôse V Army of the Rhine and Moselle. At three in the morning,
the Republican army sorties from the Huningue brigdgehead and repulses
the enemy.
0513
13 Pluviôse I The French Republic declares war on the King of England
and the Stathouder of Holland.
13 Pluviôse VI Army of Italy. A column of the Army of Italy crosses
the Geneva region and establishes its headquarter in Ferney-Voltaire.
0514
14 Pluviôse V Army of Italy. The French attack the remnants of the
Austrian army behind the Lavis and repulse them.
The French enter Janola, Faenza and Forli.
Capitulation of Mantoue.
0515
15 Pluviôse III Army of Western Pyrenees. Capture of Roses, after a
27-day siege.
Army of the North. Conquest of Holland: all the fortresses and
warships are controlled by the French. The French troops enter
Midelbourg and Flesingue.
0517
17 Pluviôse III Army of Western Pyrenees. Complete Spanish rout at
Sare and Berra.
15 000 Spanish are vanquished and routed at Urrugne and
Chauvin-Dragon.
0518
18 Pluviôse V Army of Italy. The enemy outposts are repulsed on the
Adige right bank.  Derunbano captured.
0521
21 Pluviôse V Army of Italy. The Pope's troops, on the highground
before Ancona, are surrounded and taken prisoners without a single
shot. Ancona captured.
21 Pluviôse VI Army of Italy. The French troops continue their advance
on Rome.
0522
22 Pluviôse V Army of Italy. Capture of Lorette.
0527
27 Pluviôse VI Army of Italy. The French enter in Rome. General
Berthier goes to the Capitol where, on behalf of the French Republic,
he proclaims the Roman Republic.
0601
1 Ventôse II Army of the Rhine. The French capture du Ogersheim
outpost.
1 Ventôse V Army of Italy. Treaty of peace with the Pope, signed in
Tolentino.
0604
4 Ventôse V Army of Italy. The Treviso outpost is taken back.
0605
5 Ventôse V Army of Italy. The enemy is repulsed out of its
entrenchments in Foi. Then the French encounter a Tyrolian Jäger corps
and defeat them.
The French, attacked in Bidole, smash the enemy. Kellerman crosses
the Piave in San-Mamma, and routs some enemy hussards who were
defending the crossing.
0607
7 Ventôse X Birth of Victor Hugo
0611
11 Ventôse III Army of Eastern Pyrenees. Bezalu captured.
0612
12 Ventôse V Army of Italy. The French attack the enemy at Monte
di-Savaro and beat him.
0615
15 Ventôse VI Army of Helvetia. Capitulation of the city of Berne.
0616
16 Ventôse II Army of Ardennes. Fight near Soumoy and Cerffontaine;
the enemy is defeated.
0617
17 Ventôse I. War is declared on the King of Spain.
0618
18 Ventôse II Army of the Moselle. Three Austrian batallions are
defeated on the Joegerthal highground.
0620
20 Ventôse V Army of Italy. A French division goes to Feltre; as it
nears the town, the enemy evacuates the Cordevoie line and goes to
Bellurn.
0622
22 Ventôse V Army of Italy. The 21th Light crosses the Piava opposite
to the Vidor village and repulses the enemy.
0623
23 Ventôse V Army of Italy. Fight in Sacile. Fight in Bellurn, in
which the enemy rearguard is surrounded and taken prisoner.
23 Ventôse VI. After five murderous fights, the Swiss evacuate Morat.
0626
26 Ventôse V Army of Italy. Crossing of the Tagliamento, despite a
superior enemy force and a deliberate resistance. The Gradisca village
is taken.
0627
27 Ventôse VI Treaty of alliance and trade between the French and
Cisalpin Republics.
0628
28 Ventôse V Army of Italy. Capture of Palma Nova, which the enemy
must evacuate.
0629
29 Ventôse V Army of Italy. Capture of the town of Gradisca. Crossing
of the Casasola bridge.
0630
30 Ventôse V Army of Italy. Fight of Lavis. The enemy troops are
surrounded by the French.
0701
1 Germinal V Army of Italy. The French enter Geritz. Affair of
Caminia, between the French vanguard and the enemy rearguard.
0702
2 Germinal IV Army of Italy. Fight at Tramin and at Caporetto.
0703
3 Germinal V Army of Italy. Fight at Clausen. The enemy, beaten in
Botzen, withdraws inside Clausen, where it is attacked by the French
and forced to yield.
0704
4 Germinal V Army of Eastern Pyrenees. The French enter Trieste and
take the famous mines of Ydria.
0705
5 Germinal II Army of the Moselle. The French prevail against the
Prussians who attack the outposts of Apach, North of Sierck.
5 Germinal V Army of Italy. Fight at Tarvis; after a fierce
resistance, the enemy is routed.
0706
6 Germinal V Army of Italy. Affair of the Chinse; this important 
position is taken.
0708
8 Germinal V Army of Italy. Enemy batallions, fresh from the Rhine
front, attempt to defend the Innsbruck defile; they are repulsed by
the 85th half-brigade.
0709
9 Germinal V Army of Italy. The French enter the town of Clagenfurth,
capital of Higher and Lower Carinthie; Prince Charles flees with the
remnants of his army.
0712
12 Germinal V Army of Italy. Fight in the gorges of Neumarck; the
enemy rearguard is repulsed by the French vanguard and the French
enter Neumarck and Freissels.
0714
14 Germinal II Army of Western Pyrenees. The French storm the Ozone
entranchments, near Saint-Jean de Luz and rout the Spanish troops.
14 Germinal V Army of Italy. The Austrians, beaten everywhere,
evacuate Tyrol. Prince Charles retreat toward Vienna and is beaten by
the Massena division.
0715
15 Germinal V. Fight at Hundsmarck; the enemy rearguard is defeated by
the French vanguard. The French enter Hundsmark, Kiotenfeld, Mureau
and Judembourg.
0716
16 Germinal IV Army of Italy. Military reconnaissance toward Cairo;
the enemy outposts are repulsed.
0717
17 Germinal II Army of Western Pyrenees. Spanish defeat near Hendaye.
Army of Italy. Capture of the Fougasse camp.
0718
18 Germinal II Army of Italy. Capture of all the posts near Breglio,
in the county of Nice.
18 Germinal V Five-day halt of the fighting between the French army
and the Imperial army in Italy.
0719
19 Germinal II Army of Italy. Capture of Oneille.
0720
20 Germinal IV Army of Italy. Affair of Voltry.
0721
21 Germinal II Army of Eastern Pyrenees. Spanish defeat at Monteilla;
Urgel captured.
Army of Ardennes. A small detachment from Philippeville prevails and
repulses the enemy from the woods between Villiers and Florence, and
routs it.
21 Germinal IV
Army of Italy. Attack of the Montelezimo redoubt, defended by the
French; the enemy is repulsed.
0722
22 Germinal VI Armée de Mayence. Blockade of the Ehreinbrestein fort.
0723
23 Germinal IV Army of Italy. Battle of Montenotte; the enemy is
completely routed.
0725
25 Germinal III Peace treaty between the French Republic and the King
of Prussia.
25 Germinal IV Army of Italy. Capture of Cossaria.
0726
26 Germinal II Army of the Moselle. Fight on the highgrounds of
Tiperdange, between a company from the 1st Batallion of Haut Rhin and
eighty Republican Chasseurs, against sixty Hussards of Wurmser and
four hundred armed peasants.
26 Germinal IV Army of Italy. Battle of Millesimo, won against the
Austro-Sardes. Fight at Dego, the enemy is routed. Fight and capture
of Saint-Jean, if the valley of Barmida. Capture of Batisolo, Bagnosco
and Pontenocetto. Capture of the Montezemo redoubts.
0727
27 Germinal II Army of the Moselle. The French occupy the highground
of Mertzig, the enemy having been repulsed.
Army of Italy. Fifteen hundred Austrians defeated at Ponte-di-Nava.
27 Germinal IV Army of Italy. Capture of the fortified town of Cera.
0728
28 Germinal II Army of Italy. Capture of Ormea.
0729
29 Germinal II Army of the Moselle. Battle of Arlon; the town is taken
and the enemy is completely routed.
0802
2 Floréal I Army of Western Pyrenees.  Skirmish in Jurgazza Mondi,
during which the republican troops completely rout a Spanish corps.
0803
3 Floréal II Army of the Ardennes. Complete rout of the enemy at
Aussoy, near Philippeville, after a 12-hour fight.
3 Floréal IV Army of Italy. Fight and conquest of the town of Mondovi.
0804
2 Floréal II Army of the Rhine. Victory near Kurweiller.
0805
5 Floréal I Army of Eastern Pyrenees.  Skirmish in Samouragaldi,
during which 200 French troops defeat 400 Spanish troops.
Bombardment of Fontarabie.
5 Floréal II Army of the Alps. All the redoubts in Mount Valaisan and
Mount Saint-Bernard are stormed.
5 Floréal IV Army of Italy.  The French troops enter the town of Bêne.
0806
6 Floréal IV Army of Italy. Capture of Fossano, Cherasco and Alba.
0807
7 Floréal II Army of Western Pyrenees.  The Spanish and Emigrate
troops are repulsed from Arnéguy and Irameaca.
Army of the Ardennes. Victory after a hard-fought 4-hour fight.  The
Bossu high-grounds are stormed. The Army of Ardennes and the Army of
the North enter Beaumont and link with each other.
Army of the North. Capture of Courtray, after a general battle on the
whole front, from Dunkirk to Givet.
Army of Eastern Pyrenees. The French troops capture the rock of
Arrola.
4000 Spanish infantry troops and 10 Spanish cavalry squadrons rout at
Roqueluche.
0808
8 Floréal II Army of Eastern Pyrenees.  3000 French troops repulse
10000 enemy troops from the village of Oms. They take the defile and
the bridge of Ceret.
0809
9 Floréal IV Army of Italy.  Armistice signed with the king of
Sardinia.
0810
10 Floréal II Army of the North.  Victory at Mont-Castel over 20000
Austrians.
Capture of Menin and much artillery.
Army of Italy.  Victory over the Piemontese.
10 Floréal IV The French troops enter the cities of Ceva and Coni.
10 Floréal V Treaty of peace between the French Republic and the pope.
0811
11 Floréal II Army of Eastern Pyrenees.  Victorious battle against
Spanish troops, at Albères; storming of the famous Montesquiou
redoubt.
11 Floréal V Army of Italy.  Peace preliminaries between the French
Republic and the Austrian Emperor, signed at Leoben by general
Buonaparte and the Emperor's plenipotentiaries.
0812
12 Floréal II Army of the Rhine. Capture of Lambsheim and Franckental
by the French; the gates of the latter town are destroyed by
cannon-fire.
0815
15 Floréal II Army of Eastern Pyrenees.  The French occupy the
high-grounds of cap de Bearn and of the land of Las-Daines.  The siege
of Collioure begins.
15 Floréal III Army of Eastern Pyrenees. The Spanish troops attack the
Cistella camp but are beaten and repulsed.
0816
16 Floréal IV Army of Italy. The French enter the town of Tortonne.
0817
17 Floréal III Army of Eastern Pyrenees. General reconnaissance by the
French on the Crespia and Bascara highgrounds and on the Fluvia.
0818
18 Floréal IV Army of Italy. Reconnaissance on the Po bank, toward
Plaisance.
0819
19 Floréal IV Army of Italy. The Republican vanguard crosses the Po.
Fight in Fombio.
0820
20 Floréal II Army of the Alps. The Mirabouck fort is taken, after a
14-hour attack. The Villeneuve-des-Prats outpost is captured.
Capture of the Maupertuis redoubt.
20 Floréal III Army of Eastern Pyrenees. Attack of the camp of the
Musquirachu montain; the enemy flees and discards its camp, already
set-up.
20 Floréal IV Army of Italy. Near Cordogno, the Austrians attack the
Laharpe division, and are strongly repulsed by the Republican troops
which take Casale.
Armistice concluded with the Duke of Parma.
0821
21 Floréal II Army of the Ardennes.  Capture of Thuin by the French
troops, after a hard-fought fight. Bayonet charge against all the
Austrian entrenchments.
21 Floréal IV Army of Italy.  Battle of Lody: crossing of the bridge
defended by Beaulieu's complete army.
0822
22 Floréal II Army of the North. The enemy is defeated before Tournay.
7-hour fight before Courtray: the enemy is completely routed.  The
enemy is routed at Ingelsmunster.
22 Floréal IV Army of Italy. Capture of Pizzighitone. The French enter
Crémone.
0823
23 Floréal II Army of the Ardennes. The French capture all fieldworks
in the Merbes camp, from which the enemy retreat.
During the crossing of the Sambre, the 49th Regiment grenadiers throw
themselves into the water to help the skirmishers and rout the Boubon
Legion.
The 68th Regiment defends alone a bridge attacked by more Austrians
and do not yield.
0824
24 Floréal II Army of the Ardennes. Hard-fought combat: the village of
Grandreng near Beaumont is taken and retaken three times.
0825
25 Floréal II Army of the Alps. The Republican troops storms the
Riveto and la Ramasse redoubts and other outposts on Mount-Cenis.
0826
26 Floréal IV Army of Italy. Peace is concluded with the king of
Sardinia.
0827
27 Floréal II Army of Eastern Pyrenees. The Collioure garrison
sorties.  3000 Spanish troops are repulsed with loss. The
general-in-chief is wounded during this action.
0828
28 Floréal IV Army of Italy. The French occupy Milan, Pavie and Come.
0829
29 Floréal II Army of the North. The enemy is defeated at Moescroen.
Victorious battle against the coalised, between Menin and Courtray.
Army of the Ardennes. Glorious resistance of 1500 French troops
against the advance of 14000 Austrians toward Cunfoz. 150 conscripts
hold agains the right wing of Beaulieu's army, before Bouillon.
Army of Western Pyrenees. Six enemy depots are taken. The Spanish
troops are repulsed by a bayonet attack until their camp in Berra.
0830
30 Floréal II Army of Eastern Pyrenees. The Spanish troops rout near
Figuières.
Army of the Ardennes. 160 French in the castel of Bouillon defend
against numerous enemies.
30 Floréal VI Bombardment of Ostende by the English, and 4000 English
troops land. The French surround them, take 2000 prisoners and cause
the remainder to reimbark. The English general is seriously wounded.
0901
1 Prairial VII Birth of Honoré de Balzac
0925
25 Prairial VIII Battle of Marengo in Italy, Kleber is assassinated in Cairo the same day.
1008
8 Messidor II Victory of Fleurus by Jourdan. First use of aerial reco, by 
Captain Coutelle in the balloon "L'Entreprenant".
1103
3 Thermidor III Victory of Hoche at Quiberon against Royalist forces
1109
9 Thermidor II Demise of Robespierre
1118
18 Thermidor IV Victory of Bonaparte against Wurmser at Castiglione
1303
Jour du travail V Death of General Hoche
1305
Jour des récompenses IV Death of General Marceau, age 27, at Altenkirchen
EVENTS
  delete $event{dummy};
}

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
"Ah ! ça ira ! ça ira !";
