      ******************************************************************
      * Author:    Oscar Brink
      * Date:      2018-02-26
      * Purpose:   Calculates the amount of plague-deaths for the game.
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. CALCULATE-PLAGUE.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           LINKAGE SECTION.
               01 LS-POPULATION PIC 9(4).
               01 LS-PLAGUE-CHANCE PIC V99.
       PROCEDURE DIVISION USING LS-POPULATION LS-PLAGUE-CHANCE.
           MAIN-PROCEDURE.
               IF FUNCTION RANDOM < LS-PLAGUE-CHANCE
                   COMPUTE LS-POPULATION =
                   LS-POPULATION / 2
               END-IF

       EXIT PROGRAM.
