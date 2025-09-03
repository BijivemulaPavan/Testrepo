000010*************************                                         10/27/99
000020 IDENTIFICATION DIVISION.                                         MXBPW020
000030*************************                                            LV008
000040
000050 PROGRAM-ID.    MXBPW020.
000060 INSTALLATION.  TEST.
000070 DATE-WRITTEN.  JANUARY 1999.
000080 DATE-COMPILED.
000090*================================================================*
000100*                                                                |
000110* MAX SYSTEM STANDARD PROGRAM DESCRIPTION AREA                   |
000120*                                                                |
000130*================================================================*
000140* PROGRAM  | MXBPW020 | TRANS ID | N/A  |                        |
000150*----------+----------+----------+------+------------------------*
000160* DESCRIPTION:                                                   |
000170*                                                                |
000180*      CUSTOMER NAME/ADDRESS/PHONE NUMBER EDIT AND REFORMAT.     |
000190*               COMMON ON-LINE CALLED SUBROUTINE                 |
000200*                                                                |
000210*                                                                |
000220* THE FUNCTIONS OF THIS PROGRAM ARE VARIABLE DEPENDING ON THE    |
000230* ACTION INDICATED IN THE MXCW020-ACTION FIELD PASSED TO IT BY   |
000240* THE CALLING PROGRAM.                                           |
000250*                                                                |
000260* THE PROGRAM HAS TWO PRIMARY FUNCTIONS,                         |
000270*      1. IT IS USED TO EDIT THE VALUES ENTERED FOR CUSTOMER     |
000280*         NAME AND ADDRESS INFORMATION IN IMAX (IE. FIELD        |
000290*         LENGTHS, DATA TYPE, ETC).                              |
000300*                                                                |
000310*      2. IT IS USED TO FORMAT OR MASK THE SUPPLIED VALUES       |
000320*         BACK TO THE CALLING PROGRAM ACCORDING TO THE           |
000330*         FORMATTING MASKS LOCATED ON THE XXXXXXXX TABLE.        |
000340*                                                                |
000350* THIS IS THE ON-LINE VERSION. A BATCH VERSION ALSO EXISTS.      |
000360*                                                                |
000370* THE ONLINE VERSION IS MXBPW020.                                |
000380*                                                                |
000390*                                                                |
000400*                                                                |
000410*                                                                |
000420*                                                                |
000430*                                                                |
000440*================================================================*
000450/
000460*
000470*================================================================*
000480*   CALL   | PROGRAM DESCRIPTION                                 |
000490*----------+-----------------------------------------------------*
000500* MXBCABT  |  MAX STANDARD ABORT ROUTINE.                        |
000510*================================================================*
000520/
000530*================================================================*
000540*  TABLE   |   VIEW   |     DESCRIPTION                          |
000550*----------+-----------------------------------------------------*
000560* NONE.    |     -    |           -                              |
000570*================================================================*
000580*   PLAN   | BIND INCLUDE MEMBERS                                |
000590*----------+-----------------------------------------------------*
000600*          |                                                     |
000610*-----------------------------------------------------------------
000620/
000690/*********************
000700 ENVIRONMENT DIVISION.
000710**********************
000720
000730 CONFIGURATION SECTION.
000740
000750 SOURCE-COMPUTER.   IBM-3090.
000760 OBJECT-COMPUTER.   IBM-3090.
000770
000780
000790*************************
000800 DATA DIVISION.
000810*************************
000820
000830/************************
000840 WORKING-STORAGE SECTION.
000850*************************
000860
000870 01  WS-WORKING-STORAGE.
000880
000890*+-------------------------------------------------+
000900*|      C O N S T A N T S                          |
000910*+-------------------------------------------------+
000920     05  WS-CONSTANTS.
000930         10  WS-PGM-NAME              PIC X(08) VALUE 'MXBPW020'.
000940         10  WS-ABEND-CODE            PIC S9(04)  COMP
000950                                           VALUE +7700.
000960
000970/+-------------------------------------------------+
000980*|    E R R O R  M E S S A G E  H A N D L I N G    |
000990*+-------------------------------------------------+
001000 01  WS-MESSAGE-CODE                  PIC X(06) VALUE SPACE.
001010 01  WS-MSG-NOT-FND                   PIC X(75) VALUE ALL '?'.
001020 01  TPO-ERRMSG1                      PIC X(76).
001030 01  WS-MSG-KEY                       PIC X(06).
001040 01  WS-MSG-KEY-X REDEFINES WS-MSG-KEY.
001050     05  FILLER                       PIC X(02).
001060     05  FILLER                       PIC X(01).
001070         88 INFORMATION-MSG                      VALUE 'I'.
001080     05  FILLER                       PIC X(03).
001090 01  WS-MSG-ERROR                     PIC X(05) VALUE '****'.
001100 01  WS-MSG-INFO                      PIC X(05) VALUE 'INF: '.
001110 01  WS-MSG-CNT                       PIC S9(04) COMP.
001120 01  WS-INSERT-CNT                    PIC S9(04) COMP.
001130 01  WS-NUMERIC-4                     PIC 9(04).
001140 01  WS-MSG.
001150     05  WS-MSG-HEADER                PIC X(05) VALUE '**** '.
001160     05  WS-MSG-DESC.
001170         10 WS-MSG-CHAR OCCURS 74 TIMES  PIC X(01).
001180     05  WS-MSG-TEST REDEFINES WS-MSG-DESC.
001190         10 FILLER                    PIC X(67).
001200         10 WS-MSG-TEST-SPACE         PIC X(01).
001210         10 WS-MSG-TEST-KEY           PIC X(06).
001220     05  WS-MSG-REGION-X REDEFINES WS-MSG-DESC.
001230         10 FILLER                    PIC X(72).
001240         10 WS-MSG-REGION-SPACE       PIC X(01).
001250         10 WS-MSG-REGION             PIC X(01).
001260 01  REPLACE-CHAR                     PIC X(01) VALUE '#'.
001270
001280
001290     EXEC SQL
001300          INCLUDE MXWW03
001310     END-EXEC.
001320/
001330     EXEC SQL
001340          INCLUDE MX0C01
001350     END-EXEC.
001360
001370         05  FILLER                   PIC X.
001380/
001390     EXEC SQL
001400          INCLUDE MXWW020
001410     END-EXEC.
001420/
001430*+---------------------------------------------+
001440*|  D C L G E N S  A N D   C O P Y B O O K S   |
001450*+---------------------------------------------+
001460*
001470/
001480*    DB2 SQL RETURN AREA
001490*
001500     EXEC SQL
001510        INCLUDE SQLCA
001520     END-EXEC.
001530/
001540*  COUNTRY TABLE
001550
001560*  NAME/ADDRESS FORMAT TABLE
001570
001580     EXEC SQL
001590        INCLUDE VWMCTCFM
001600     END-EXEC.
001610/
001620*  REGION CODE TABLE
001630
001640     EXEC SQL
001650        INCLUDE VWMCTREG
001660     END-EXEC.
001670/
001680*  COUNTRY CODE TABLE
001690
001700     EXEC SQL
001710        INCLUDE VWMCTSCY
001720     END-EXEC.
001730/
001740*  ERROR-MESSAGE TABLE
001750
001760     EXEC SQL
001770        INCLUDE VWMCTDSM
001780     END-EXEC.
001790
001800/****************
001810 LINKAGE SECTION.
001820*****************
001830     EXEC SQL
001840          INCLUDE MXCW020
001850     END-EXEC.
001860
001870/**********************************************************
001880 PROCEDURE DIVISION USING MXCW020-ADDR-PHONE-FORMAT.
001890**********************************************************
001900
001910**************************************
001920 0000-MAINLINE.
001930**************************************
001940
001950     MOVE 'USA'                       TO MXCA-USER-COUNTRY.
001960
001970     EXEC SQL
001980          INCLUDE MXPW020
001990     END-EXEC.
002000
002010/**************************************************************
002020***             ERROR MESSAGE HANDLING                      ***
002030***************************************************************
002040     EXEC SQL
002050          INCLUDE MXZP01
002060     END-EXEC.
002070
002080     EXEC SQL
002090          INCLUDE MXWP02
002100     END-EXEC.
002110