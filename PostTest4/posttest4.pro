domains                                                         	%Domains menyatakan jenis suatu variabel atau argumen
  name,sex,occupation,object,vice,substance = symbol		      	%pada baris pertama, nama,jender,pekerjaan,benda,alasan,zat dideklarasikan menggunakan tipe data symbol
  age=integer							      	%pada baris kedua, umur dideklarasikan menggunakan tipe data integer

predicates								%predicates digunakan untuk mendeklarasikan relasi. Pendeklaraasian ini penting karena jika tidak Turbo Prolog tidak akan mengenalnya
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), 		
  nondeterm (i,o,o,i), nondeterm (i,o,i,o)				%relasi dari orang yaitu nama,umur, jender dan pekerjaan
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)		%relasi dari selingkuh yaitu nama dan nama
  killed_with(name,object) - determ (i,o)				%relasi dari terbunuh dengan yaitu nama dengan benda apa
  killed(name) - procedure (o)						%relasi dari tebunuh yaitu nama
  killer(name) - nondeterm (o)						%relasi dari predikat pembunuh yaitu parameter nama
  motive(vice) - nondeterm (i)						%relasi dari predikat motif adalah parameter alasan 
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)		%relasi dari predikat ternodai yaitu dengan parameter nama dan zat
  owns(name,object) - nondeterm (i,i)					%relasi dari predikat milik yaitu parameter nama dan benda
  operates_identically(object,object) - nondeterm (o,i)			%relasi dari predikat cara  kerjanya mirip yaitubenda danbenda
  owns_probably(name,object) - nondeterm (i,i)				%relasi dari predikat kemungkinan milik yaitu parameter nama dan benda
  suspect(name) - nondeterm (i)						%relasi dari predikat dicurigai yaitu parameternama

/* * * Facts about the murder * * */
clauses									%clauses berisi fakta
  person(bert,55,m,carpenter).						%menjelaskan bahwa bert adalah orang berumur 55 gender laki-laki dan pekerjaan tukang kayu
  person(allan,25,m,football_player).					%menjelaskan bahwa allan adalah orang berumur 25, gender laki dan pekerjaan pemain sepak bola
  person(allan,25,m,butcher).						%menjelaskan bahwa allan adalah orang berumur 25, gender laki-laki dan pekerjaan tukang jagal
  person(john,25,m,pickpocket).						%menjelaskan bahwa john adalah orang berumur 25, bergender laki-laki dan pekerjaan pencopet

  had_affair(barbara,john).						%menjelaskan bahwa barbara selingkuh dengan john
  had_affair(barbara,bert).						%menjelaskan bahwa barbara selingkuh dengan bert
  had_affair(susan,john).						%menjelaskan bahwa susan selingkuh dengan john

  killed_with(susan,club).						%susan terbunuh dengan pentungan
  killed(susan).							%susan yang terbunuh

  motive(money).							%motif karena uang
  motive(jealousy).							%motif karena cemburu
  motive(righteousness).						%motif karena uang

  smeared_in(bert,blood).						%bert ternodai darah
  smeared_in(susan,blood).						%susan ternodai darah
  smeared_in(allan,mud).						%allan ternodai lumpur
  smeared_in(john,chocolate).						%john ternodai coklat
  smeared_in(barbara,chocolate).					%barbara ternodai coklat

  owns(bert,wooden_leg).						%bert memiliki kaki palsu
  owns(john,pistol).							%john memiliki pistol

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club).				%cara kerja kaki palsu mirip denganpentungan 
  operates_identically(bar, club).					%cara kerja balok mirip dengan pentungan
  operates_identically(pair_of_scissors, knife).			%cara kerja gunting mirip dengan pisau
  operates_identically(football_boot, club).				%cara kerja sepatu bola mirip dengan pentungan

  owns_probably(X,football_boot):-					%kemungkinan sepatu bola milik X jika maka
	person(X,_,_,football_player).					%X dan orang lainnya pemain sepakbola
  owns_probably(X,pair_of_scissors):-					%kemungkinan gunting milik X jika maka
	person(X,_,_,hairdresser).					%X dan orang lainnya adalah pekerja salon
  owns_probably(X,Object):-						%kemungkinan benda milik X jika maka
	owns(X,Object).							%X memiliki benda itu

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-								%X dicurigai jika maka
	killed_with(susan,Weapon) ,					%Susan terbunuh dengan senjata dan
	operates_identically(Object,Weapon) ,				%Cara kerja benda tersebut mirip dengan senjata dan
	owns_probably(X,Object).					%Kemungkinan X memiliki benda 

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *			
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-								%X dicurigai jika maka
	motive(jealousy),						%cemburu adalah motifnya dan
	person(X,_,m,_),						%X adalah orang tersebut yang berjender m dan
	had_affair(susan,X).						%susan selingkuh dengan X

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *				
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-								%X dicurigai jika maka
	motive(jealousy),						%cemburu adalah motifnya dan
	person(X,_,f,_),						%X adalah orang tersebut yang berjender f dan
	had_affair(X,Man),						%Laki - laki tersebut selingkuh dengan X dan
	had_affair(susan,Man).						%susan selingkuh dengan laki-laki

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-								%X dicurigai jika maka
	motive(money),							%motifnya karena uang dan
	person(X,_,_,pickpocket).					%X adalah seorang pencopet
	
  killer(Killer):-							%pembunuh tersebut dikatakan pembunuh jika maka
	person(Killer,_,_,_),						%orang tersebut adalah pembunuh dan orang lainnya dan
	killed(Killed),							%jika orang tersebut terbunuh dan
	Killed <> Killer, /* It is not a suicide */			%relasi dari terbunuh adalah pembunuh dan /* bukan bunuh diri */
	suspect(Killer),						%pembunuh tersebut dicurigai dan
	smeared_in(Killer,Goo),						%pembunuh ternodai oleh zat dan
	smeared_in(Killed,Goo).						%yang terbunuh ternodai oleh zat

goal									%Goal adalah jawaban yang berisi pernyataan dan pertanyaan
  killer(X).								%Jawaban dari pembunuh tersebut adalah bert
  									%karena pembunuh yang ternodai zat adalah bert
  									%Yang terdapat di rule ada dua yaitu susan dan bert yang ternodai dengan zat yaitu darah
									%karena di goal yang ditanyakan adalah pembunuh maka jawabannya berd
									%sebab susan adalah orang yang terbunuh				