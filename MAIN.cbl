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
               01 WS-NUMTEST PIC S9(2).

               01 WS-YEAR PIC 9(2).
               01 WS-FORMAT-YEAR PIC Z9.

               01 WS-WHEAT PIC 9(7).
               01 WS-PLANTED-ACRES PIC 9(7).
               01 WS-HARVEST PIC 9(7).

               01 WS-EATEN-BY-RATS PIC 9(7).
               01 WS-RATS-CHANCE PIC V99 VALUE .90.

               01 WS-ACRES PIC 9(7).
               01 WS-ACRES-BUY-AMOUNT PIC S9(7).

               01 WS-PRICE PIC 99.

               01 WS-POPULATION PIC 9(4).
               01 WS-FOOD PIC 9(7).

               01 WS-FORMAT-GAME-NUMS PIC Z(6)9.

               01 WS-GAME-LOOP PIC A.
                   88 WS-GAME-LOOP-STATE VALUE 'Y'
                      WHEN SET TO FALSE 'N'.
                   88 WS-MENU-LOOP-STATE VALUE 'Y'
                      WHEN SET TO FALSE 'N'.
               01 WS-CALC-CHECKS PIC A.
                   88 WS-CALC-VALID VALUE 'Y'
                      WHEN SET TO FALSE 'N'.


       PROCEDURE DIVISION.
           MAIN.
               DISPLAY "Welcome O Great Hammurabi."
               PERFORM INIT-GAME-STATES

               PERFORM 4 TIMES
                   MOVE WS-YEAR TO WS-FORMAT-YEAR
                   DISPLAY "It is year "WS-FORMAT-YEAR" of your reign."

      *            CALL 'CALCULATE-RATS'
      *                USING
      *                    WS-WHEAT
      *                    WS-RATS-CHANCE
      *                    WS-EATEN-BY-RATS

                   MOVE WS-WHEAT TO WS-FORMAT-GAME-NUMS
                   DISPLAY "WS-WHEAT: "WS-FORMAT-GAME-NUMS
                   DISPLAY "WS-PRICE: "WS-PRICE
                   DISPLAY "Input WS-ACRES-BUY-AMOUNT: "
                   ACCEPT WS-ACRES-BUY-AMOUNT

                   DISPLAY "--------------"
      *            MOVE WS-WHEAT TO WS-FORMAT-GAME-NUMS
                   DISPLAY "PRE WS-WHEAT: "WS-FORMAT-GAME-NUMS

                   MOVE WS-ACRES TO WS-FORMAT-GAME-NUMS
                   DISPLAY "PRE WS-ACRES: "WS-FORMAT-GAME-NUMS

                   DISPLAY "WS-ACRES-BUY-AMOUNT: "WS-ACRES-BUY-AMOUNT

                   CALL 'LAND-TRANSACTION'
                       USING
                           WS-PRICE
                           WS-ACRES-BUY-AMOUNT
                           WS-WHEAT
                           WS-ACRES
                           WS-CALC-CHECKS

                   MOVE WS-WHEAT TO WS-FORMAT-GAME-NUMS
                   DISPLAY "POS WS-WHEAT: "WS-FORMAT-GAME-NUMS

                   MOVE WS-ACRES TO WS-FORMAT-GAME-NUMS
                   DISPLAY "POS WS-ACRES: "WS-FORMAT-GAME-NUMS

                   IF WS-CALC-VALID
                       DISPLAY "OK TRANSACT"
                   ELSE
                       DISPLAY "FAIL TRANSACT"
                   END-IF

      *            MOVE WS-EATEN-BY-RATS TO WS-FORMAT-GAME-NUMS
      *            DISPLAY "WS-EATEN-BY-RATS: "
      *                    WS-FORMAT-GAME-NUMS
                   MOVE WS-WHEAT TO WS-FORMAT-GAME-NUMS
                   DISPLAY "POS WS-WHEAT: "WS-FORMAT-GAME-NUMS
                   DISPLAY "----------------------"

                   PERFORM END-YEAR
               END-PERFORM

      *        SET WS-GAME-LOOP-STATE TO TRUE
      *        SET WS-GAME-LOOP-STATE TO FALSE


      *        MOVE WS-RESULT TO WS-FORM-INT
      *        DISPLAY WS-FORM-INT

      *        ACCEPT WS-NUMTEST
      *        SUBTRACT 15 FROM WS-NUMTEST
      *        DISPLAY WS-NUMTEST

           STOP RUN.

           INIT-GAME-STATES SECTION.
               MOVE 2800 TO WS-WHEAT
               MOVE 200 TO WS-EATEN-BY-RATS
               MOVE 1 TO WS-YEAR
               MOVE 1000 TO WS-ACRES
               MOVE 17 TO WS-PRICE
               MOVE 100 TO WS-POPULATION
               CALL 'GENERATE-RANDOM-SEED'
           CONTINUE.

           PLANT-ACRES SECTION.
               DISPLAY "WS-ACRES: "WS-ACRES
               DISPLAY "Input WS-PLANTED-ACRES: "
               ACCEPT WS-PLANTED-ACRES     *> Change this: input in main
               IF WS-PLANTED-ACRES > WS-ACRES
                       OR WS-PLANTED-ACRES > WS-WHEAT
                   DISPLAY "Input invalid."
                   SET WS-CALC-VALID TO FALSE
               ELSE
                   CALL 'CALCULATE-HARVEST'
                       USING
                           WS-PLANTED-ACRES
                           WS-HARVEST
                           WS-WHEAT
               END-IF
           CONTINUE.

           END-YEAR SECTION.
               COMPUTE WS-FOOD = WS-FOOD / 20
               IF WS-FOOD < (WS-POPULATION)
                   MOVE WS-FOOD TO WS-POPULATION
               END-IF
               COMPUTE WS-PRICE = (FUNCTION RANDOM * 9) + 17
               ADD 1 TO WS-YEAR
           CONTINUE.
       END PROGRAM MAIN.
