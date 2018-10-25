      ******************************************************************
      * Author:    Oscar Brink
      * Date:      2018-02-13
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. LAND-TRANSACTION.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
               01 WS-TRANSACTION-PRICE PIC S9(7).
           LINKAGE SECTION.
               01 LS-PRICE PIC 99.
               01 LS-AMOUNT PIC S9(7).
               01 LS-WHEAT PIC 9(7).
               01 LS-ACRES PIC 9(7).
               01 LS-CALC-CHECKS PIC A.
                   88 LS-CALC-VALID VALUE 'Y'
                      WHEN SET TO FALSE 'N'.

       PROCEDURE DIVISION
       USING LS-PRICE LS-AMOUNT LS-WHEAT LS-ACRES LS-CALC-CHECKS.
           DISPLAY "LS-AMOUNT: "LS-AMOUNT
      *    ----TEMP-----------------------
           COMPUTE WS-TRANSACTION-PRICE = LS-AMOUNT * LS-PRICE
           DISPLAY "WS-TRANSACTION-PRICE: "WS-TRANSACTION-PRICE
      *    -------------------------------
           IF (LS-AMOUNT * -1) > LS-ACRES
               SET LS-CALC-VALID TO FALSE
               EXIT PROGRAM
           END-IF

      *    COMPUTE WS-TRANSACTION-PRICE = LS-AMOUNT * LS-PRICE
           IF WS-TRANSACTION-PRICE > LS-WHEAT
               SET LS-CALC-VALID TO FALSE
               EXIT PROGRAM
           END-IF

           ADD LS-AMOUNT TO LS-ACRES
           SUBTRACT WS-TRANSACTION-PRICE FROM LS-WHEAT
           SET LS-CALC-VALID TO TRUE

       EXIT PROGRAM.

