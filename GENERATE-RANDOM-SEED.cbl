      ******************************************************************
      * Author:    Oscar Brink
      * Date:      2018-02-11
      * Purpose:   Runs RANDOM once with current time as seed.
      *            Based entirely on code from:
      *                https://community.microfocus.com/microfocus/
      *                cobol/net_express__server_express/w/
      *                knowledge_base/2294/
      *                calculating-a-random-number-in-cobol
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. GENERATE-RANDOM-SEED.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
               01 WS-RND-SEED-X PIC X(8).
               01 WS-RND-SEED-9 REDEFINES WS-RND-SEED-X PIC 9(8).
               01 WS-RND-DBL COMP-2.

       PROCEDURE DIVISION.
           MOVE 32768 TO WS-RND-SEED-9
           PERFORM UNTIL WS-RND-SEED-9 < 32768
               ACCEPT WS-RND-SEED-X FROM TIME
               MOVE FUNCTION REVERSE(WS-RND-SEED-X) TO WS-RND-SEED-X
               COMPUTE WS-RND-SEED-9 = WS-RND-SEED-9 / 3060
           END-PERFORM

           COMPUTE WS-RND-DBL = FUNCTION RANDOM(WS-RND-SEED-9)
       EXIT PROGRAM.

