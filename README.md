
# (ITA) Proximity Pong

Proximity Pong è nato per l'apertura al pubblico del [TechLab](http://techlab.tl).

Il Pong, uno dei primi videogiochi del mondo, con un interazione completamente diversa: spostati avanti e indietro per controllare le 'racchette' e sfida i tuoi amici con precisione e velocità!

Arduino si occupa di leggere i dati inviati dai sensori ad ultrasuoni ( che misurano la loro distanza dagli oggetti ) e si occupa di inviarli ad uno sketch realizzato tramite Processing in cui è implementata una versione base del gioco Pong.


## Materiale Utilizzato

- 2 * SRF05 - proximity sensors
- 1 * Arduino Uno
- un piccolo pannello di legno
- 4 * viti
- 4 * chiodi

## Strumenti utilizzati

- Breadboard
- Saldatore a stagno
- Macchina a taglio laser
- Cacciavite
- Martello

## Software Utilizzato

- [Arduino](http://arduino.cc)
- [Processing](http://processing.org)

## Come giocare

Per giocare a Pong bisogna aver collegato correttamente Arduino ai sensori, aver collegato Arduino al computer ( deve infatti essere possibile comunicare con Arduino tramite porta seriale ) e si deve infine lanciare lo sketch di Processing.

Il sensore di sinistra muove la racchetta di sinistra, e viceversa.

Esistono 2 tasti con funzioni speciali, utilizzabili tramite la tastiera del computer su cui è in esecuzione lo sketch di Processing:

- `r`: riavvia il gioco, resettando i punteggi
- `SPAZIO`: mette in pausa il gioco, permettendo di riprenderlo in un altro momento ( premendo nuovamente `SPAZIO` )


# (ENG) Proximity Pong

Proximity Pong is born for the [TechLab](http://techlab.tl) opening.

Pong, one of the first videogame ever, with a new type of interactivity: move yourself backward or onward to control the paddle and challenge your frind using precision and speed!

Arduino reads from sensors and sends data to a Processing sketch which implements a base version of the Pong game.


## Material used

- 2 * SRF05 - proximity sensors
- 1 * Arduino Uno
- a little wood panel
- 4 * screws
- 4 * nails

## Tools used 

- Breadboard
- Soldering iron
- Lasercutter

## Software used

- [Arduino](http://arduino.cc)
- [Processing](http://processing.org)

## How to play

To play pong you need to have correctly patched Arduino with the 2 sensors, have Arduino correctly connected with your computer ( must be possible to comunicate via serial communication ) and you must run the Processing sketch.

Left sensor move the left paddle, and viceversa.

Other 2 keys with special functions exists, usable from the pc keyboard:

- `r`: restart the game, resetting the scores
- `SPACE`: pause the game ( you can recover it pressing `SPACE` again )
