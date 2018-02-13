      ******************************************************************
      * Author:    Oscar Brink
      * Date:      2018-02-12
      * Purpose:   Calculates wheat eaten by rats for HAMMURABI-GAME.
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. CALCULATE-RATS.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
               01 WS-RANDOM-DBL PIC V99.
               01 WS-RANDOM-INT PIC 99.

           LINKAGE SECTION.
               01 LS-RATS-CHANCE PIC V99.
               01 LS-WHEAT PIC 9(7).
               01 LS-EATEN-BY-RATS PIC 9(7).

       PROCEDURE DIVISION
       USING LS-WHEAT LS-RATS-CHANCE LS-EATEN-BY-RATS.
      *    DISPLAY "LS-RATS-CHANCE: "LS-RATS-CHANCE

           COMPUTE WS-RANDOM-DBL = FUNCTION RANDOM
      *    DISPLAY "WS-RANDOM-DBL Chance: "WS-RANDOM-DBL

           IF WS-RANDOM-DBL < LS-RATS-CHANCE
               COMPUTE WS-RANDOM-DBL = ((FUNCTION RANDOM) * .30 + .01)
               DISPLAY "WS-RANDOM-DBL changenum: "WS-RANDOM-DBL
               COMPUTE LS-EATEN-BY-RATS = LS-WHEAT *
                       WS-RANDOM-DBL
               SUBTRACT LS-EATEN-BY-RATS FROM LS-WHEAT
           ELSE
               MOVE 0 TO LS-EATEN-BY-RATS
           END-IF

       EXIT PROGRAM.
