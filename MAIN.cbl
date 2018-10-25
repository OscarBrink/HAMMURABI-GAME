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
               01 WS-HARVEST-PER-ACRE PIC 9.

               01 WS-EATEN-BY-RATS PIC 9(7).
               01 WS-RATS-CHANCE PIC V99 VALUE .90.

               01 WS-ACRES PIC 9(7).
               01 WS-ACRES-BUY-AMOUNT PIC S9(7).

               01 WS-PRICE PIC 99.

               01 WS-POPULATION PIC 9(4).
               01 WS-PLAGUE-CHANCE PIC V99 VALUE .10.
               01 WS-FOOD PIC 9(7).

               01 WS-FORMAT-GAME-NUMS PIC Z(6)9.

               01 WS-GAME-STATES PIC A.
                   88 WS-GAME-LOOP-STATE VALUE 'Y'
                      WHEN SET TO FALSE 'N'.
                   88 WS-MENU-LOOP-STATE VALUE 'Y'
                      WHEN SET TO FALSE 'N'.
               01 WS-MODULE-CHECKS PIC A.
                   88 WS-MODULE-BOOL VALUE 'Y'
                      WHEN SET TO FALSE 'N'.
               01 WS-PLAGUE-CHECK PIC A.
                   88 WS-PLAGUE-HAPPENED VALUE 'Y'
                      WHEN SET TO FALSE 'N'.


       PROCEDURE DIVISION.
           MAIN.
               DISPLAY "Welcome O Great Hammurabi."
               PERFORM INIT-GAME-STATES

               PERFORM 2 TIMES

                   PERFORM PRINT-YEAR-INFO

      *            CALL 'CALCULATE-RATS'
      *                USING
      *                    WS-WHEAT
      *                    WS-RATS-CHANCE
      *                    WS-EATEN-BY-RATS

                   DISPLAY "Input WS-ACRES-BUY-AMOUNT: "
                   ACCEPT WS-ACRES-BUY-AMOUNT

                   DISPLAY "Input WS-FOOD: "
                   ACCEPT WS-FOOD

                   PERFORM PLANT-ACRES
                   MOVE WS-HARVEST-PER-ACRE TO WS-FORMAT-GAME-NUMS
                   DISPLAY "WS-HARVEST-PER-ACRE: "WS-FORMAT-GAME-NUMS

                   DISPLAY "--------------"
      *            MOVE WS-WHEAT TO WS-FORMAT-GAME-NUMS
      *            DISPLAY "PRE WS-WHEAT: "WS-FORMAT-GAME-NUMS

                   MOVE WS-ACRES TO WS-FORMAT-GAME-NUMS
                   DISPLAY "PRE WS-ACRES: "WS-FORMAT-GAME-NUMS

                   DISPLAY "WS-ACRES-BUY-AMOUNT: "WS-ACRES-BUY-AMOUNT

                   CALL 'LAND-TRANSACTION'
                       USING
                           WS-PRICE
                           WS-ACRES-BUY-AMOUNT
                           WS-WHEAT
                           WS-ACRES
                           WS-MODULE-CHECKS

                   MOVE WS-WHEAT TO WS-FORMAT-GAME-NUMS
                   DISPLAY "POS WS-WHEAT: "WS-FORMAT-GAME-NUMS

                   MOVE WS-ACRES TO WS-FORMAT-GAME-NUMS
                   DISPLAY "POS WS-ACRES: "WS-FORMAT-GAME-NUMS

                   IF WS-MODULE-BOOL
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

      *    Prints info about the current year, assuming that
      *    info has been updated
           PRINT-YEAR-INFO SECTION.
      *        Print year
               MOVE WS-YEAR TO WS-FORMAT-YEAR
               DISPLAY "It is year "WS-FORMAT-YEAR" of your reign."
               
               IF WS-PLAGUE-HAPPENED
                   DISPLAY "A terrible plague struck, killing"
      -                 " half of the population!"
               END-IF

      *        Print population
               MOVE WS-POPULATION TO WS-FORMAT-GAME-NUMS
               DISPLAY "WS-POPULATION: "WS-FORMAT-GAME-NUMS

      *        Print wheat and price
               MOVE WS-WHEAT TO WS-FORMAT-GAME-NUMS
               DISPLAY "WS-WHEAT: "WS-FORMAT-GAME-NUMS
               DISPLAY "WS-PRICE: "WS-PRICE
           CONTINUE.

           PLANT-ACRES SECTION.
               DISPLAY "WS-ACRES: "WS-ACRES
               DISPLAY "Input WS-PLANTED-ACRES: "
               ACCEPT WS-PLANTED-ACRES     *> Change this: input in main
               IF WS-PLANTED-ACRES > WS-ACRES
                       OR WS-PLANTED-ACRES > WS-WHEAT
                   DISPLAY "Input invalid."
                   SET WS-MODULE-BOOL TO FALSE
               ELSE
                   CALL 'CALCULATE-HARVEST'
                       USING
                           WS-PLANTED-ACRES
                           WS-HARVEST
                           WS-WHEAT
                           WS-HARVEST-PER-ACRE
               END-IF
           CONTINUE.

           END-YEAR SECTION.
               SUBTRACT WS-FOOD FROM WS-WHEAT
      *        Run plague.
               CALL 'CALCULATE-PLAGUE'
                   USING WS-POPULATION WS-PLAGUE-CHANCE WS-PLAGUE-CHECK
      *        Calculate starving people.
               COMPUTE WS-FOOD = WS-FOOD / 20
               IF WS-FOOD < (WS-POPULATION)
                   MOVE WS-FOOD TO WS-POPULATION
               END-IF
      *        Generate new market price for land.
               COMPUTE WS-PRICE = (FUNCTION RANDOM * 9) + 17
               ADD 1 TO WS-YEAR
           CONTINUE.
       END PROGRAM MAIN.

