domains
orang,makanan,rasa=symbol

predicates
nondeterm
suka(orang,makanan)
nondeterm
berasa(makanan,rasa)
nondeterm
makan(makanan)

clauses
suka(didit,X):-makan(X),berasa(X,keju).
berasa(roti,tawar).
berasa(pia,coklat).
berasa(pia,susu).
berasa(pia,keju).
makan(roti).
makan(kripik).
makan(pia).

goal
suka(didit,Apa"\n"),write("didit suka makan ",Apa).

