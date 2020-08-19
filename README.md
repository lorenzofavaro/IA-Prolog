# Progetto Prolog

Questo progetto è stato realizzato per l'esame di Intelligenza Artificiale e Laboratorio del corso di Laurea Magistrale all'Università di Torino.

## Setup
- Installare [SWI-Prolog](https://www.swi-prolog.org/download/stable).
- Installare [VSCode](https://code.visualstudio.com/download) e l'apposita estensione [VSC-Prolog](https://marketplace.visualstudio.com/items?itemName=arthurwang.vsc-prolog).
- Clonare il progetto.

## Il problema
Un sistema intelligente è collocato in uno spazio di n righe ed m colonne, in cui sono posti degli ostacoli. Il sistema si trova in una delle celle del labirinto e, muovendosi all’interno dello stesso, deve raggiungere una casella di uscita.

Il sistema può muoversi nelle quattro direzioni (nord, sud, est, ovest) e non in diagonale e, ovviamente, non può raggiungere una cella contenente un ostacolo.

Il sistema conosce la configurazione del labirinto (dimensioni, posizione degli ostacoli, uscite).

<p align="center">
  <img src="https://github.com/lorenzofavaro/IA-Prolog/blob/master/labyrinths/maze10.png"/>
</p>

## Struttura del progetto
- `labyrinths` contiene tutte le basi di conoscenza rappresentanti le mappe di labirinti.
- `actions.pl` descrive tutte le azioni possibili effettuabili dal sistema, a prescindere dall'algoritmo utilizzato.
  - il predicato `acceptable(S)` controlla se la posizione `S` esiste all'interno del labirinto.
  - `applicable(action, S)` dev'essere usata prima di ogni `move/3` per verificare che lo spostamento sia corretto.
  - `move(action, S, S1)` restituisce la nuova posizione `S1` effettuando lo spostamento derivato da `action` a partire dalla posizione di partenza `S`.
- `utils.pl` specifica ulteriori predicati.
  - `heuristic(S, S1, Distance)` calcola il valore di euristica `Distance` mediante la distanza di Manhattan tra le posizioni `S` ed `S1`
- `load_maze.pl` effettua la load della mappa selezionata.

## Algoritmi di ricerca
### A*
- `a_star.pl` implementa l'algoritmo di ricerca A*. La struttura dati principale è la lista `[[Actions], pos(X, Y), f(n)]` che contiene per ogni tassello esplorato del labirinto le azioni necessarie, la sua posizione e la sua funzione di costo. L'algoritmo è implementato da 4 predicati:
  - `a_star` dà inizio all'algoritmo, controllando i parametri forniti (come la posizione di inizio e fine) e stampa la soluzione.
  - `a_star_search/3` è il predicato che implementa la ricerca A*; ha 3 parametri, il primo è la lista dei nodi di frontiera, il secondo è la lista di nodi già visitati, mentre il terzo è la lista di azioni che rappresenta la soluzione.
  - `expand/3` genera i figli di un nodo, controllando tutte le azioni permesse in quel nodo.
  - `add/3` concatena in modo ordinato (in base alla funzione di costo) i nodi generati da `expand/3` a quelli già presenti, creando la nuova frontiera.
### IDA*
- `ida_star.pl` implementa l'algoritmo di ricerca IDA*. Per la gestione del limite asserisce nuovi fatti dinamicamente. Si basa su 3 predicati:
  - `ida_star` dà inizio all'algoritmo, controllando i parametri forniti (come la posizione di inizio e fine).
  - `ida_main/3` utilizza `ida_search/5` per la ricerca del percorso e permette di incrementare il limite di volta in volta, nel caso una soluzione non sia stata ancora trovata.
  - `ida_search/5` è il predicato che implementa la ricerca IDA*.
### Iterative Deepening
- `iterative_deepening.pl` implementa l'algoritmo di ricerca Iterative Deepening. È costituito da 3 predicati:
  - `iterative_deepening` dà inizio all'algoritmo, controllando i parametri forniti (come la posizione di inizio e fine) e setta il limite massimo di profondità a `Rows` x `Columns`.
  - `iterative_deepening_search/5` incrementa il limite di volta in volta, nel caso una soluzione non sia stata ancora trovata.
  - `depth_search/4` effettua la DFS attenendosi al limite di profondità attuale.

