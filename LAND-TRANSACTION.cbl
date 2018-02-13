      ******************************************************************
      * Author:    Oscar Brink
      * Date:      2018-02-12
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. YOUR-PROGRAM.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
               01 WS-TRANSACTION-PRICE PIC 9(7).
           LINKAGE SECTION.
               01 LS-PRICE PIC 99.
               01 LS-AMOUNT PIC S9(7).
               01 LS-WHEAT PIC 9(7).
               01 LS-ACRES PIC 9(7).
               01 LS-TRANSACTION-VALID PIC A.

       PROCEDURE DIVISION.
           IF LS-AMOUNT > LS-ACRES
               MOVE 'N' TO LS-TRANSACTION-VALID
               EXIT PROGRAM
           END-IF

           COMPUTE WS-TRANSACTION-PRICE = LS-AMOUNT * LS-PRICE
           IF WS-TRANSACTION-PRICE > LS-WHEAT
               MOVE 'N' TO LS-TRANSACTION-VALID
               EXIT PROGRAM
           END-IF

           ADD LS-AMOUNT TO LS-ACRES
           SUBTRACT WS-TRANSACTION-PRICE FROM LS-WHEAT

       EXIT PROGRAM.
