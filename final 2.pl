%% final de septiembre 2020, yugioh

monstruo(magoOscuro,2500,2100,1998,hechizero).
monstruo(dragonBlanco,3000,2500,1998,dragon).
monstruo(ojosRojos,2400,2000,1998,dragon).
monstruo(magoDelTiempo,500,400,2003,hechizero).
monstruo(grafa,2700,1800,2011,demonio).
monstruo(jinzo,2400,1500,2004,maquina).
monstruo(neos,2500,2000,2006,guerrero).

magia(monstruoRenacido,invocar,1).
magia(agujeroNegro,destruir,3).

trampa(cilindrosMagicos,danio,3).
trampa(juicioSolemne,destruir,3).

protagonista(yugi,primera(magoOscuro, 10)).
protagonista(kaiba,primera(dragonBlanco, 5)).
protagonista(jaden,segunda(neos, 10)).


estaLimitada(Carta):-
    magia(Carta,_,1).

estaLimitada(Carta):-
    trampa(Carta,_,1).

monstruoUtil(Monstruo):-
    monstruo(Monstruo,_,_,_,_),
    tieneMuchoAtaque(Monstruo).

tieneMuchoAtaque(Monstruo):-
    monstruo(Monstruo,Ataque,_,_,_),
    Ataque > 2450.

monstruoConocido(Monstruo):-
    monstruo(Monstruo,_,_,X,_),
    monstruoUtil(Monstruo),
    X < 2000.

inmune(jinzo, Carta):-
    trampa(Carta,_,_).

inmune(Monstruo, Carta):-
    monstruo(Monstruo,_,_,_,hechizero),
    magia(Carta,_,_).

puedeDestruir(Carta, Monstruo):-
    not(inmune(Monstruo, Carta)),
    trampa(Carta,destruir,_).

puedeDestruir(Carta, Monstruo):-
    not(inmune(Monstruo, Carta)),
    magia(Carta,destruir,_).

puedeDestruir(Atacante, Defensor):-
    monstruo(Atacante, X, _, _, _),
    monstruo(Defensor, Y, _, _, _),
    X >= Y.

personajeConocido(Personaje):-
    protagonista(Personaje, primera(_,_)).

asDelProta(Nombre, As):-
    protagonista(Nombre, primera(As, _)).

asDelProta(Nombre, As):-
    protagonista(Nombre, segunda(As, _)).

mejorPersonaje(Personaje):-
    personajeConocido(Personaje),
    asDelProta(Personaje, As),
    forall(magia(Carta, _, _), not(puedeDestruir(Carta, As))).
