predicates
nondeterm peran(symbol,symbol,symbol)
nondeterm melawan(symbol,symbol)
nondeterm tewas_dengan(symbol,symbol)
nondeterm tewas(symbol)
nondeterm pelaku(symbol)
nondeterm alasan(symbol)
nondeterm ditemukan(symbol,symbol)
nondeterm memiliki(symbol,symbol) 
nondeterm bagai(symbol,symbol)
nondeterm dicurigai_memiliki(symbol,symbol)
nondeterm terduga(symbol)

clauses
peran(reza,i,pengusaha).
peran(wahid,i,petani).
peran(dian,i,karyawan).
peran(rizki,i,nelayan).

melawan(wahid,reza).
melawan(riski,dian).
melawan(wahid,dianl).

tewas_dengan(riski,silet).
tewas(riski).

alasan(lahan).
alasan(selingkuh).
alasan(sakithati).

ditemukan(reza,darah).
ditemukan(wahid,anting).
ditemukan(dian,hp).
ditemukan(riski,darah).

memiliki(reza,kayu).
memiliki(wahid,cutter).

bagai(kayu,pentungan).
bagai(tombak,bamburuncing).
bagai(cutter,pisau).
bagai(linggis,cangkul).

dicurigai_memiliki(P,balok) :- peran(P,_,pekerja_buruh).
dicurigai_memiliki(P,cutter) :- peran(P,_,seorang_karyawan).
dicurigai_memiliki(P,Barang) :- memiliki(P,Barang).

terduga(P) :- tewas_dengan(riski,Alat) ,bagai(Barang,Alat),dicurigai_memiliki(P,Barang).
terduga(P) :-alasan(lahan),peran(P,i,_),melawan(riski,P).
terduga(P) :-alasan(lahan),peran(P,y,_),melawan(P,Pria),melawan(wahid,Pria).
terduga(P) :-alasan(selingkuh),peran(P,_,_nelayan).
pelaku(P) :-peran(P,_,_),tewas(Dibunuh),
Dibunuh <> P,terduga(P),
ditemukan(P,Cairan),ditemukan(Dibunuh,Cairan).

Goal
pelaku(P).










