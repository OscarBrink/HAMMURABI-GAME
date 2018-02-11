      ******************************************************************
      * Author: Oscar Brink
      * Date: 2018-02-11
      * Purpose:
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
               01 LS-CURRENT-WHEAT PIC 9(7).

       PROCEDURE DIVISION USING LS-CURRENT-WHEAT LS-RATS-CHANCE.
           DISPLAY "LS-RATS-CHANCE: "LS-RATS-CHANCE

           COMPUTE WS-RANDOM-DBL = FUNCTION RANDOM
           DISPLAY "WS-RANDOM-DBL Chance: "WS-RANDOM-DBL

           IF WS-RANDOM-DBL < LS-RATS-CHANCE
               COMPUTE WS-RANDOM-DBL = ((FUNCTION RANDOM) * .30 + .70)
               DISPLAY "WS-RANDOM-DBL changenum: "WS-RANDOM-DBL
               COMPUTE LS-CURRENT-WHEAT = LS-CURRENT-WHEAT *
                       WS-RANDOM-DBL

       EXIT PROGRAM.
