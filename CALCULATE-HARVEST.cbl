      ******************************************************************
      * Author:    Oscar Brink
      * Date:      2018-02-12
      * Purpose:   Calculates harvest for HAMMURABI-GAME using random
      *            value between 1 and 6.
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. CALCULATE-HARVEST.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
               01 WS-HARVEST-PER-ACRE PIC 9.

           LINKAGE SECTION.
               01 LS-PLANTED-ACRES PIC 9(7).
               01 LS-HARVEST PIC 9(7).
               01 LS-WHEAT PIC 9(7).

       PROCEDURE DIVISION
           USING LS-PLANTED-ACRES LS-HARVEST LS-WHEAT.
           MAIN-PROCEDURE.
               COMPUTE WS-HARVEST-PER-ACRE = (FUNCTION RANDOM * 6) + 1

               COMPUTE LS-HARVEST =
                       WS-HARVEST-PER-ACRE * LS-PLANTED-ACRES

               ADD LS-HARVEST TO LS-WHEAT
       EXIT PROGRAM.
