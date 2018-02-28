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
               01 LS-PLAGUE-CHECK PIC A.
                   88 LS-PLAGUE-HAPPENED VALUE 'Y'
                      WHEN SET TO FALSE 'N'.
       PROCEDURE DIVISION
           USING LS-POPULATION LS-PLAGUE-CHANCE LS-PLAGUE-CHECK.
           MAIN-PROCEDURE.
               IF FUNCTION RANDOM < LS-PLAGUE-CHANCE
                       AND LS-POPULATION > 1
                   COMPUTE LS-POPULATION =
                   LS-POPULATION / 2
                   SET LS-PLAGUE-HAPPENED TO TRUE
               ELSE
                   SET LS-PLAGUE-HAPPENED TO FALSE
               END-IF
       EXIT PROGRAM.
