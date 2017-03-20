domains %Section domains mempunyai 2 manfaat utama. yaitu pertama, kita dapat memberikan nama yang berarti untuk domain, walaupun secara internal domain tersebut sama tipenya dengan domain yang telah ada; yang kedua, kita dapat mendeklarasi domain khusus yang digunakan untuk mendeklarasikan struktur data yang tidak didefinisikan oleh standar domain. Dengan mendeklarasikan domain juga dapat mencegah kesalahan logika pada program
  angka = integer %type domains dipakai pada predikat yang memiliki variable bertipe integer/bilangan bulat

predicates %Ketika mendeklarasikan suatu predikat, kita memberitahu Visual Prolog domain dari argumen yang dimiliki predikat tersebut.
  menitdetik(angka,angka) - procedure (i,o) %merupakan kata kunci yang mirip seperti method dalam netbeans
  detikmenit(angka,angka) - procedure (i,o) %merupakan kata kunci yang mirip seperti method dalam netbeans


clauses %section ini meletakkan fakta dan aturan. Ketika mencari jawaban, Visual Prolog akan mencari dari bagian paling atas dari section clauses, melihat setiap fakta dan aturan untuk mendapat jawaban benar, hingga ke bagian paling bawah dari section ini.
  menitdetik(X,Menitdetik):- %jika method menitdetik dijalankan maka variable X,Menitdetik dijalankan dengan rumus Menitdetik=X*60  
	Menitdetik=X*60.
  detikmenit(X,Detikmenit):- %jika method menitdetik dijalankan maka variable X,Menitdetik dijalankan dengan rumus Menitdetik=X*60
	Detikmenit=X/60.

goal %
 menitdetik(1,Menitdetik), %Jadi Menitdetik merupakan variable yang khusus untuk menunjuk waktu 1 menit = 60 detik
 detikmenit(360,Detikmenit). %Jadi Detikmenit merupakan variale yang khusus untuk menunjuk waktu 360 detik = 6 menit