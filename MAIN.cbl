      ******************************************************************
      * Author:    Oscar Brink
      * Date:      2018-02-11
      * Purpose:   Main program for HAMMURABI-GAME.
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. MAIN.

       DATA DIVISION.
           FILE SECTION.

           WORKING-STORAGE SECTION.
               01 WS-RESULT PIC 9(18).
               01 WS-FORM-INT PIC Z(17)9.
               01 WS-NUMTEST PIC S999.

               01 WS-CURRENT-YEAR PIC 9(2).
               01 WS-FORMAT-YEAR PIC Z9.

               01 WS-CURRENT-WHEAT PIC 9(7).

               01 WS-CURRENT-EATEN-BY-RATS PIC 9(7).
               01 WS-RATS-CHANCE PIC V99 VALUE .90.

               01 WS-ACRES PIC 9(7).

               01 WS-PRICE PIC 99.

               01 WS-FORMAT-GAME-NUMS PIC Z(6)9.

               01 WS-BOOLEANS PIC A.
                   88 WS-GAME-LOOP-STATE VALUE 'Y'
                      WHEN SET TO FALSE 'N'.

       PROCEDURE DIVISION.
           MAIN.
               DISPLAY "Welcome O Great Hammurabi."
               PERFORM INIT-GAME-STATES

               MOVE 2800 TO WS-CURRENT-WHEAT

               PERFORM 5 TIMES
                   MOVE WS-CURRENT-WHEAT TO WS-FORMAT-GAME-NUMS
                   DISPLAY "PRE WS-CURRENT-WHEAT: "WS-FORMAT-GAME-NUMS

                   CALL 'CALCULATE-RATS'
                        USING
                           WS-CURRENT-WHEAT
                           WS-RATS-CHANCE
                           WS-CURRENT-EATEN-BY-RATS

                   MOVE WS-CURRENT-EATEN-BY-RATS TO WS-FORMAT-GAME-NUMS
                   DISPLAY "WS-CURRENT-EATEN-BY-RATS: "
                           WS-FORMAT-GAME-NUMS
                   MOVE WS-CURRENT-WHEAT TO WS-FORMAT-GAME-NUMS
                   DISPLAY "POS WS-CURRENT-WHEAT: "WS-FORMAT-GAME-NUMS
                   DISPLAY "----------------------"
               END-PERFORM

      *        SET WS-GAME-LOOP-STATE TO TRUE
      *        SET WS-GAME-LOOP-STATE TO FALSE


      *        MOVE WS-RESULT TO WS-FORM-INT
      *        DISPLAY WS-FORM-INT

               ACCEPT WS-NUMTEST
               SUBTRACT 15 FROM WS-NUMTEST
               DISPLAY WS-NUMTEST

           STOP RUN.

           INIT-GAME-STATES SECTION.
               MOVE 2800 TO WS-CURRENT-WHEAT
               MOVE 200 TO WS-CURRENT-EATEN-BY-RATS
               MOVE 1 TO WS-CURRENT-YEAR
               MOVE 1000 TO WS-ACRES
               MOVE 17 TO WS-PRICE
               CALL 'GENERATE-RANDOM-SEED'
           CONTINUE.
       END PROGRAM MAIN.
