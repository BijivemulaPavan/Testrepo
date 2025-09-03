000100*************************                                         00010000
000200 IDENTIFICATION DIVISION.                                         00020000
000300*************************                                         00030000
000400                                                                  00040000
000500 PROGRAM-ID.    MXBPW030.                                         00050000
000600 INSTALLATION.  TEST.                                             00060000
000700 DATE-WRITTEN.  AUGUST  2000.                                     00070000
000800 DATE-COMPILED.                                                   00080000
000900*================================================================*00090000
001000*                                                                |00100000
001100* MAX SYSTEM STANDARD PROGRAM DESCRIPTION AREA                   |00110000
001200*                                                                |00120000
001300*================================================================*00130000
001400* PROGRAM  | MXBPW030 | TRANS ID | N/A  |                        |00140000
001500*----------+----------+----------+------+------------------------*00150000
001600* DESCRIPTION:                                                   |00160000
001700*                                                                |00170000
001800*      THIS MODULE WILL PROVIDE INFORMATION FOR A GIVEN SET OF   |00180000
001900* RULE AND CONTROL ENTITY DEPENDING ON THE FUNCTION IT IS CALLED |00190000
002000* FOR SO THAT THE CALLING PROGRAM (INSTEAD OF HARDCODING) CAN    |00200000
002100* DO THE NECESSARY PROCESSING BASED ON THE RESULT DETERMINED BY  |00210000
002200* THIS ROUTINE. FOR EXAMPLE... IF A PROGRAM WANTS TO KNOW        |00220000
002300* WHETHER THE CONTROL ENTITY IT IS PROCESSING IS ELIGIBLE FOR    |00230000
002400* VAT, IT CAN CALL THIS PROGRAM. THIS PROGRAM WILL READ THE RULE |00240000
002500* SET TABLE TO DETERMINE WHETHER THIS CONTROL ENTITY HAS BEEN    |00250000
002600* DEFINED FOR THE VAT ELIGIBILITY RULE AND SEND THE RESULT BACK  |00260000
002700* TO CALLING PROGRAM INDICATING WHETHER THIS CONTROL ENTITY IS   |00270000
002800* ELIGIBLE FOR VAT OR NOT. MORE DETAIL DOCUMENTATION ON THIS     |00280000
002900* PROGRAM IS AT G:\SHARED\PROJECTS\00.636 CANTREX. IF YOU DON'T  |00290000
002910* FIND THIS FOLDER THEN CONTACT YOUR GROUP MANAGER.              |00300000
003000*                                                                |00310000
003100* INPUT PARAMETERS                     CRITERIA                  |00320000
003200*                                                                |00330000
003300* MXWW30-FUNCTION            EDIT    DFLT    CONV    TRUE    LIST|00340000
003400* MXWW30-BUS-RULE-NAME       REQD    REQD    REQD    REQD    REQD|00350000
003500* MXWW30-CNTL-ENT-NO         REQD    REQD    REQD    REQD    REQD|00360000
003600* MXWW30-SRC-TEXT-VALUE      REQD*   N/A     REQD*   N/A     N/A |00370000
003700* MXWW30-SRC-NO-VALUE        REQD*   N/A     REQD*   N/A     N/A |00380000
003800*                                                                |00390000
003900* OUTPUT PARAMETERS                    CRITERIA                  |00400000
004000*                                                                |00410000
004100* MXWW30-STATUS-CODE         YES     YES     YES     YES     YES |00420000
004200* MXWW30-RESULT-DATA-TYPE    N/A     YES     YES     N/A     YES |00430000
004300* MXWW30-RESULT-CNTL-ENT-NO  YES     YES     YES     YES     YES |00440000
004400* MXWW30-RESULT-NO-VALUE     N/A     YES*    YES*    N/A     YES*|00450000
004500* MXWW30-RESULT-TEXT-VALUE   N/A     YES*    YES*    N/A     YES*|00460000
004600*                                                                |00470000
004700* ENTRIES MARKED WITH AN * INDICATE THAT EITHER THE -NO OR THE   |00480000
004800* -TEXT FIELD SHOULD/WILL BE POPULATED; THEY ARE MUTUALLY        |00490000
004900* EXCLUSIVE                                                      |00500000
005000*                                                                |00510000
005100*                                                                |00520000
005200* THE ONLINE VERSION IS MXCPW030.                                |00530000
005300*                                                                |00540000
005400*================================================================*00550000
005500/                                                                 00560000
005600*                                                                 00570000
005700*================================================================*00580000
005800*   CALL   | PROGRAM DESCRIPTION                                 |00590000
005900*----------+-----------------------------------------------------*00600000
006000* NONE     |                                                     |00610000
006100*================================================================*00620000
006200/                                                                 00630000
006300*================================================================*00640000
006400*  TABLE   |   VIEW   |     DESCRIPTION                          |00650000
006500*----------+-----------------------------------------------------*00660000
006600* TBMCN00  | VWMCN00  | CONTROL ENTITY                           |00670000
006700* TBMCTWRH | VWMCTWRH | RULE SET HEADER                          |00680000
006800* TBMCTWRD | VWMCTWRD | RULE SET DETAIL                          |00690000
006900*================================================================*00700000
007000*   PLAN   | BIND INCLUDE MEMBERS                                |00710000
007100*----------+-----------------------------------------------------*00720000
007200* PBMPW030 | MXBPW030                                            |00730000
007300*-----------------------------------------------------------------00740000
007400/                                                                 00750000
008100/*********************                                            00880000
008200 ENVIRONMENT DIVISION.                                            00890000
008300**********************                                            00900000
008400                                                                  00910000
008500 CONFIGURATION SECTION.                                           00920000
008600                                                                  00930000
008700 SOURCE-COMPUTER.   IBM-3090.                                     00940000
008800 OBJECT-COMPUTER.   IBM-3090.                                     00950000
008900                                                                  00960000
009000                                                                  00970000
009100*************************                                         00980000
009200 DATA DIVISION.                                                   00990000
009300*************************                                         01000000
009400                                                                  01010000
009500/************************                                         01020000
009600 WORKING-STORAGE SECTION.                                         01030000
009700*************************                                         01040000
009800                                                                  01050000
009900 01  WS-WORKING-STORAGE.                                          01060000
010000     05  WS-SAVE-VALUE-FROM-NO       PIC S9(13)V9(4) COMP-3       01070000
010100                                     VALUE ZEROES.                01080000
010200     05  WS-SAVE-VALUE-FROM-TEXT     PIC  X(30) VALUE SPACES.     01090000
010300     05  WS-SAVE-FUNCTION            PIC  X(04) VALUE SPACES.     01100000
010400     05  WS-SAVE-BUS-RULE-NAME       PIC  X(24) VALUE SPACES.     01110000
010500     05  WS-SAVE-CNTL-ENT-NO         PIC S9(04) COMP VALUE ZEROS. 01120000
      *T22122-S                                                         01120100
010500     05  WS-DATE                     PIC  X(10) VALUE SPACES.     01121000
      *T22122-E                                                         01122000
010600     05  WS-EOF-FLAG                 PIC  X(01) VALUE 'Y'.        01130000
010700         88  WS-IS-EOF               VALUE 'Y'.                   01140000
010800         88  WS-NOT-EOF              VALUE 'N'.                   01150000
010900     05  WS-MISC-DATA.                                            01160000
011000         10  WS-CN00-FETCH            PIC X.                      01170000
011100             88  WS-CN00-NOT-FOUND    VALUE 'N'.                  01180000
011200             88  WS-CN00-FOUND        VALUE 'Y'.                  01190000
011300         10  WS-COUNT-VARS.                                       01200000
011400             15 WS-COUNT              PIC S9(09) COMP VALUE ZEROS.01210000
011500             15 CNTL-ENT-INDX1        PIC S9(09) COMP VALUE ZEROS.01220000
011600         10  WS-MIN-NO-NULL-IND       PIC S9(04) COMP VALUE ZEROS.01230000
011700         10  WS-MIN-TEXT-NULL-IND     PIC S9(04) COMP VALUE ZEROS.01240000
011800*+-------------------------------------------------+              01250000
011900*|      C O N S T A N T S                          |              01260000
012000*+-------------------------------------------------+              01270000
012100     05  CNTL-ENT-TABLE               PIC X(4000)                 01280000
012200                                      VALUE LOW-VALUES.           01290000
012300     05  FILLER REDEFINES CNTL-ENT-TABLE.                         01300000
      *CLJB-1018-S                                                      01301000
012400*        10  WS-CNTL-ENT-TABLE        OCCURS 500  TIMES           01310000
012400         10  WS-CNTL-ENT-TABLE        OCCURS 2000 TIMES           01311000
      *CLJB-1018-E                                                      01312000
012500                                      INDEXED BY CNTL-ENT-INDX.   01320000
012600             15  WS-CNTL-ENT-NO       PIC S9(04) COMP.            01330000
012700             15  WS-REGION-NO         PIC S9(04) COMP.            01340000
012800             15  WS-AREA-NO           PIC S9(04) COMP.            01350000
012900             15  WS-COMPANY-NO        PIC S9(04) COMP.            01360000
013000                                                                  01370000
      * ITG 107288 - S                                                  01380000
      *+---------------------------------------------------------------+01390000
      *  WS FIELDS FOR RULE TABLE                                      *01400000
      *+---------------------------------------------------------------+01410000
                                                                        01420000
           05  WS-MIN-VALUE-FROM-NO         PIC S9(13)V9(4) COMP-3      01430000
                                            VALUE ZEROES.               01440000
           05  WS-MIN-VALUE-FROM-TEXT       PIC  X(30) VALUE SPACES.    01450000
           05  WS-RULES-PROCESSED-FLAG      PIC  X(01) VALUE 'N'.       01460000
               88  WS-RULES-NOT-PROCESSED   VALUE 'N'.                  01470000
               88  WS-RULES-PROCESSED       VALUE 'Y'.                  01480000
           05  WS-NEW-MIN-FLAG              PIC  X(01) VALUE 'N'.       01490000
               88  WS-NO-NEW-MIN            VALUE 'N'.                  01500000
               88  WS-NEW-MIN               VALUE 'Y'.                  01510000
           05  WS-TABLE-LOAD-FLAG           PIC  X     VALUE SPACES.    01520000
               88  WS-TABLE-LOAD-NO         VALUE ' '.                  01530000
               88  WS-TABLE-LOAD-YES        VALUE 'Y'.                  01540000
                                                                        01550000
      *+---------------------------------------------------------------+01560000
      *  WS FIELDS FOR RULE TABLE                                      *01570000
      *+---------------------------------------------------------------+01580000
                                                                        01590000
       01  RULE-TABLE                       PIC X(294000).              01600000
       01  FILLER REDEFINES RULE-TABLE.                                 01610000
           05  WS-ENV-RULE-TABLE            OCCURS 2000 TIMES           01620000
                                            ASCENDING KEY IS            01630000
                                            WS-BUS-RULE-NAME,           01640000
                                            WS-BUS-RULE-TYPE-CODE,      01650000
                                            WS-RULE-CNTL-ENT-NO,        01660000
      *                                     WS-DEFAULT-FLAG,            01670000
                                            WS-RESULT-NO,               01680000
                                            WS-RESULT-TEXT,             01690000
                                            WS-VALUE-FROM-NO,           01700000
                                            WS-VALUE-TO-NO,             01710000
                                            WS-VALUE-FROM-TEXT,         01720000
                                            WS-VALUE-TO-TEXT            01730000
                                            INDEXED BY RULE-INDX.       01740000
               10  WS-BUS-RULE-NAME         PIC X(24).                  01750000
               10  WS-BUS-RULE-TYPE-CODE    PIC X(01).                  01760000
               10  WS-RESULT-TYPE-IND       PIC X(01).                  01770000
               10  WS-VALUE-TYPE-IND        PIC X(01).                  01780000
               10  WS-RULE-CNTL-ENT-NO      PIC S9(4)       COMP.       01790000
               10  WS-DEFAULT-FLAG          PIC X(01).                  01800000
               10  WS-RESULT-NO             PIC S9(13)V9(4) COMP-3.     01810000
               10  WS-RESULT-TEXT           PIC X(30).                  01820000
               10  WS-VALUE-FROM-NO         PIC S9(13)V9(4) COMP-3.     01830000
               10  WS-VALUE-FROM-TEXT       PIC X(30).                  01840000
               10  WS-VALUE-TO-NO           PIC S9(13)V9(4) COMP-3.     01850000
               10  WS-VALUE-TO-TEXT         PIC X(30).                  01860000
      *+---------------------------------------------------------------+01870000
      *  WS FIELDS FOR ENTITY TABLES                                   *01880000
      *+---------------------------------------------------------------+01890000
                                                                        01900000
       01  ENT-TABLE                        PIC X(12000).               01910000
       01  FILLER REDEFINES ENT-TABLE.                                  01920000
           05  WS-ENV-ENT-TABLE             OCCURS 1500 TIMES           01930000
                                            ASCENDING KEY IS            01940000
                                            WS-ENT-CNTL-ENT-NO          01950000
                                            INDEXED BY ENT-INDX.        01960000
               10  WS-ENT-CNTL-ENT-NO       PIC S9(4) COMP.             01970000
               10  WS-ENT-REGION-NO         PIC S9(4) COMP.             01980000
               10  WS-ENT-AREA-NO           PIC S9(4) COMP.             01990000
               10  WS-ENT-COMPANY-NO        PIC S9(4) COMP.             02000000
      * ITG 107288 - E                                                  02010000
013100/                                                                 02020000
013200*+---------------------------------------------+                  02030000
013300*|  D C L G E N S  A N D   C O P Y B O O K S   |                  02040000
013400*+---------------------------------------------+                  02050000
013500                                                                  02060000
013600*  DB2 SQL RETURN AREA                                            02070000
013700                                                                  02080000
013800     EXEC SQL                                                     02090000
013900        INCLUDE SQLCA                                             02100000
014000     END-EXEC.                                                    02110000
014100/                                                                 02120000
014200*  RULE SET DEFINITION HEADER                                     02130000
014300                                                                  02140000
014400     EXEC SQL                                                     02150000
014500        INCLUDE VWMCTWRH                                          02160000
014600     END-EXEC.                                                    02170000
014700/                                                                 02180000
014800*  RULE SET DEFINITION DETAIL                                     02190000
014900                                                                  02200000
015000     EXEC SQL                                                     02210000
015100        INCLUDE VWMCTWRD                                          02220000
015200     END-EXEC.                                                    02230000
015300/                                                                 02240000
015400*  CONTROL ENTITY TABLE                                           02250000
015500                                                                  02260000
015600     EXEC SQL                                                     02270000
015700        INCLUDE VWMCN00                                           02280000
015800     END-EXEC.                                                    02290000
                                                                        02300000
      * ITG 107288 - S                                                  02310000
      *+---------------------------------------------------------------+02320000
      *  CURSOR DECLARATIONS FOR RULE AND ENTITY TABLES                *02330000
      *+---------------------------------------------------------------+02340000
                                                                        02350000
           EXEC SQL                                                     02360000
             DECLARE RULETBL CURSOR FOR                                 02370000
                 SELECT A.BUS_RULE_NAME,                                02380000
                        A.BUS_RULE_TYPE_CODE,                           02390000
                        A.RESULT_TYPE_IND,                              02400000
                        A.VALUE_TYPE_IND,                               02410000
                        B.CNTL_ENT_NO,                                  02420000
                        B.DEFAULT_FLAG,                                 02430000
                        B.RESULT_NO,                                    02440000
                        B.RESULT_TEXT,                                  02450000
                        B.VALUE_FROM_NO,                                02460000
                        B.VALUE_FROM_TEXT,                              02470000
                        B.VALUE_TO_NO,                                  02480000
                        B.VALUE_TO_TEXT                                 02490000
                 FROM VWMCTWRH A,                                       02500000
                 VWMCTWRD B                                             02510000
                 WHERE A.BUS_RULE_NAME = B.BUS_RULE_NAME                02520000
                       ORDER BY 1,5,7,8,9,11,10,12                      02530000
                 WITH UR                                                02540000
           END-EXEC.                                                    02550000
                                                                        02560000
           EXEC SQL                                                     02570000
                DECLARE ENTTBL  CURSOR FOR                              02580000
                SELECT CNTL_ENT_NO,                                     02590000
                       REGION_NO,                                       02600000
                       AREA_NO,                                         02610000
                       COMPANY_NO                                       02620000
                       FROM VWMCN00                                     02630000
                       ORDER BY 1                                       02640000
                WITH UR                                                 02650000
           END-EXEC.                                                    02660000
      * ITG 107288 - E                                                  02670000
015900                                                                  02680000
016000/****************                                                 02690000
016100 LINKAGE SECTION.                                                 02700000
016200*****************                                                 02710000
016300     EXEC SQL                                                     02720000
016400          INCLUDE MXWW30                                          02730000
016500     END-EXEC.                                                    02740000
016600                                                                  02750000
016700/**********************************************************       02760000
016800 PROCEDURE DIVISION USING MXWW30-INPUT-OUTPUT-VARS.               02770000
016900**********************************************************        02780000
017000                                                                  02790000
017100**************************************                            02800000
017200 0000-MAINLINE.                                                   02810000
017300**************************************                            02820000
017400* ITG 107288 - S                                                  02830000
017500*    EXEC SQL                                                     02840000
017600*         INCLUDE MXWP30                                          02850000
017700*    END-EXEC.                                                    02860000
017800                                                                  02870000
           EXEC SQL                                                     02880000
                INCLUDE MXWP30B                                         02890000
           END-EXEC.                                                    02900000
                                                                        02910000
      *+---------------------------------------------------------------+02920000
      *|  LOAD RULE & ENTITY TABLES                                    |02930000
      *+---------------------------------------------------------------+02940000
                                                                        02950000
       1100-LOAD-TABLES.                                                02960000
                                                                        02960100
      *T22122-S                                                         02960200
           MOVE SPACES         TO WS-DATE.                              02961000
                                                                        02962000
           EXEC SQL                                                     02963000
                SET :WS-DATE = CURRENT DATE                             02964000
           END-EXEC.                                                    02965000
      *T22122-E                                                         02966000
                                                                        02970000
           PERFORM 1110-LOAD-RULE-TABLE     THRU 1110-EXIT.             02980000
           PERFORM 1120-LOAD-RULE-ENT-TABLE THRU 1120-EXIT.             02990000
                                                                        03000000
           SET WS-TABLE-LOAD-YES            TO TRUE.                    03010000
                                                                        03020000
       1100-EXIT.                                                       03030000
           EXIT.                                                        03040000
                                                                        03050000
      *+---------------------------------------------------------------+03060000
      *|  LOADING RULE TABLES VALUES INTO A WORKING STORAGE VARIABLES  |03070000
      *+---------------------------------------------------------------+03080000
                                                                        03090000
       1110-LOAD-RULE-TABLE.                                            03100000
                                                                        03110000
           MOVE HIGH-VALUES                 TO RULE-TABLE.              03120000
                                                                        03130000
           EXEC SQL                                                     03140000
                OPEN RULETBL                                            03150000
           END-EXEC.                                                    03160000
                                                                        03170000
           EVALUATE SQLCODE                                             03180000
             WHEN 0                                                     03190000
               CONTINUE                                                 03200000
                                                                        03210000
             WHEN OTHER                                                 03220000
               SET MXWW30-STATUS-SQL-ERR    TO TRUE                     03230000
               MOVE '1110-'                 TO MXWW30-PARA-ID           03240000
               MOVE 'VWMCTWRD'              TO MXWW30-TBL-NAME          03250000
               MOVE SQLCODE                 TO MXWW30-SQLCODE           03260000
               MOVE SQLCA                   TO MXWW30-SQLCA             03270000
               GOBACK                                                   03280000
           END-EVALUATE.                                                03290000
                                                                        03300000
           SET RULE-INDX TO 1.                                          03310000
               PERFORM                                                  03320000
                  WITH TEST AFTER                                       03330000
                  UNTIL SQLCODE = +100                                  03340000
                   OR RULE-INDX > 1999                                  03350000
                                                                        03360000
                  EXEC SQL                                              03370000
                       FETCH RULETBL                                    03380000
                             INTO :DCLVWMCTWRH.BUS-RULE-NAME            03390000
                                 ,:DCLVWMCTWRH.BUS-RULE-TYPE-CODE       03400000
                                 ,:DCLVWMCTWRH.RESULT-TYPE-IND          03410000
                                 ,:DCLVWMCTWRH.VALUE-TYPE-IND           03420000
                                 ,:DCLVWMCTWRD.CNTL-ENT-NO              03430000
                                 ,:DCLVWMCTWRD.DEFAULT-FLAG             03440000
                                 ,:DCLVWMCTWRD.RESULT-NO                03450000
                                 ,:DCLVWMCTWRD.RESULT-TEXT              03460000
                                 ,:DCLVWMCTWRD.VALUE-FROM-NO            03470000
                                 ,:DCLVWMCTWRD.VALUE-FROM-TEXT          03480000
                                 ,:DCLVWMCTWRD.VALUE-TO-NO              03490000
                                 ,:DCLVWMCTWRD.VALUE-TO-TEXT            03500000
                  END-EXEC                                              03510000
                                                                        03520000
                  EVALUATE SQLCODE                                      03530000
                    WHEN 0                                              03540000
                      MOVE BUS-RULE-NAME      OF DCLVWMCTWRH            03550000
                                 TO WS-BUS-RULE-NAME (RULE-INDX)        03560000
                      MOVE BUS-RULE-TYPE-CODE OF DCLVWMCTWRH            03570000
                                 TO WS-BUS-RULE-TYPE-CODE (RULE-INDX)   03580000
                      MOVE RESULT-TYPE-IND    OF DCLVWMCTWRH            03590000
                                 TO WS-RESULT-TYPE-IND    (RULE-INDX)   03600000
                      MOVE VALUE-TYPE-IND     OF DCLVWMCTWRH            03610000
                                 TO WS-VALUE-TYPE-IND     (RULE-INDX)   03620000
                      MOVE CNTL-ENT-NO        OF DCLVWMCTWRD            03630000
                                 TO WS-RULE-CNTL-ENT-NO   (RULE-INDX)   03640000
                      MOVE DEFAULT-FLAG       OF DCLVWMCTWRD            03650000
                                 TO WS-DEFAULT-FLAG       (RULE-INDX)   03660000
                      MOVE RESULT-NO          OF DCLVWMCTWRD            03670000
                                 TO WS-RESULT-NO          (RULE-INDX)   03680000
                      MOVE RESULT-TEXT        OF DCLVWMCTWRD            03690000
                                 TO WS-RESULT-TEXT        (RULE-INDX)   03700000
                      MOVE VALUE-FROM-NO      OF DCLVWMCTWRD            03710000
                                 TO WS-VALUE-FROM-NO      (RULE-INDX)   03720000
                      MOVE VALUE-FROM-TEXT    OF DCLVWMCTWRD            03730000
                                 TO WS-VALUE-FROM-TEXT    (RULE-INDX)   03740000
                      MOVE VALUE-TO-NO        OF DCLVWMCTWRD            03750000
                                 TO WS-VALUE-TO-NO        (RULE-INDX)   03760000
                      MOVE VALUE-TO-TEXT      OF DCLVWMCTWRD            03770000
                                 TO WS-VALUE-TO-TEXT      (RULE-INDX)   03780000
                      SET RULE-INDX UP BY 1                             03790000
                                                                        03800000
                    WHEN  +100                                          03810000
                      CONTINUE                                          03820000
                    WHEN OTHER                                          03830000
                      SET MXWW30-STATUS-SQL-ERR                         03840000
                                            TO TRUE                     03850000
                      MOVE '1110-'          TO MXWW30-PARA-ID           03860000
                      MOVE 'VWMCTWRD'       TO MXWW30-TBL-NAME          03870000
                      MOVE SQLCODE          TO MXWW30-SQLCODE           03880000
                      MOVE SQLCA            TO MXWW30-SQLCA             03890000
                      GOBACK                                            03900000
                  END-EVALUATE                                          03910000
              END-PERFORM.                                              03920000
                                                                        03930000
              EXEC SQL                                                  03940000
                   CLOSE RULETBL                                        03950000
              END-EXEC.                                                 03960000
                                                                        03970000
              EVALUATE SQLCODE                                          03980000
                WHEN 0                                                  03990000
                  CONTINUE                                              04000000
                                                                        04010000
                WHEN OTHER                                              04020000
                  SET MXWW30-STATUS-SQL-ERR TO TRUE                     04030000
                  MOVE '1110-'              TO MXWW30-PARA-ID           04040000
                  MOVE 'VWMCTWRD'           TO MXWW30-TBL-NAME          04050000
                  MOVE SQLCODE              TO MXWW30-SQLCODE           04060000
                  MOVE SQLCA                TO MXWW30-SQLCA             04070000
                  GOBACK                                                04080000
              END-EVALUATE.                                             04090000
                                                                        04100000
       1110-EXIT.                                                       04110000
           EXIT.                                                        04120000
                                                                        04130000
      *+---------------------------------------------------------------+04140000
      *|  LOADING ENTITY TABLE VALUES INTO A WORKING STORAGE FIELDS    |04150000
      *+---------------------------------------------------------------+04160000
                                                                        04170000
       1120-LOAD-RULE-ENT-TABLE.                                        04180000
                                                                        04190000
           MOVE HIGH-VALUES TO ENT-TABLE.                               04200000
                                                                        04210000
           EXEC SQL                                                     04220000
                 OPEN ENTTBL                                            04230000
           END-EXEC.                                                    04240000
                                                                        04250000
           EVALUATE SQLCODE                                             04260000
             WHEN 0                                                     04270000
               CONTINUE                                                 04280000
                                                                        04290000
             WHEN OTHER                                                 04300000
               SET MXWW30-STATUS-SQL-ERR    TO TRUE                     04310000
               MOVE '1120-'                 TO MXWW30-PARA-ID           04320000
               MOVE 'VWMCN00'               TO MXWW30-TBL-NAME          04330000
               MOVE SQLCODE                 TO MXWW30-SQLCODE           04340000
               MOVE SQLCA                   TO MXWW30-SQLCA             04350000
               GOBACK                                                   04360000
           END-EVALUATE.                                                04370000
                                                                        04380000
           SET ENT-INDX                     TO 1.                       04390000
           PERFORM                                                      04400000
              WITH TEST AFTER                                           04410000
              UNTIL SQLCODE = +100                                      04420000
              OR ENT-INDX > 1499                                        04430000
                                                                        04440000
              EXEC SQL                                                  04450000
                   FETCH ENTTBL                                         04460000
                   INTO :DCLVWMCN00.CNTL-ENT-NO                         04470000
                       ,:DCLVWMCN00.REGION-NO                           04480000
                       ,:DCLVWMCN00.AREA-NO                             04490000
                       ,:DCLVWMCN00.COMPANY-NO                          04500000
              END-EXEC                                                  04510000
                                                                        04520000
              EVALUATE SQLCODE                                          04530000
                WHEN 0                                                  04540000
                  MOVE CNTL-ENT-NO        OF DCLVWMCN00                 04550000
                           TO WS-ENT-CNTL-ENT-NO    (ENT-INDX)          04560000
                  MOVE REGION-NO          OF DCLVWMCN00                 04570000
                           TO WS-ENT-REGION-NO      (ENT-INDX)          04580000
                  MOVE AREA-NO            OF DCLVWMCN00                 04590000
                           TO WS-ENT-AREA-NO        (ENT-INDX)          04600000
                  MOVE COMPANY-NO         OF DCLVWMCN00                 04610000
                           TO WS-ENT-COMPANY-NO     (ENT-INDX)          04620000
                  SET ENT-INDX UP BY 1                                  04630000
                                                                        04640000
                WHEN  +100                                              04650000
                  CONTINUE                                              04660000
                                                                        04670000
                WHEN OTHER                                              04680000
                  SET MXWW30-STATUS-SQL-ERR TO TRUE                     04690000
                  MOVE '1120-'              TO MXWW30-PARA-ID           04700000
                  MOVE 'VWMCN00'            TO MXWW30-TBL-NAME          04710000
                  MOVE SQLCODE              TO MXWW30-SQLCODE           04720000
                  MOVE SQLCA                TO MXWW30-SQLCA             04730000
                  GOBACK                                                04740000
              END-EVALUATE                                              04750000
           END-PERFORM.                                                 04760000
                                                                        04770000
           EXEC SQL                                                     04780000
                CLOSE ENTTBL                                            04790000
           END-EXEC.                                                    04800000
                                                                        04810000
           EVALUATE SQLCODE                                             04820000
             WHEN 0                                                     04830000
               CONTINUE                                                 04840000
                                                                        04850000
             WHEN OTHER                                                 04860000
               SET MXWW30-STATUS-SQL-ERR    TO TRUE                     04870000
               MOVE '1120-'                 TO MXWW30-PARA-ID           04880000
               MOVE 'VWMCN00'               TO MXWW30-TBL-NAME          04890000
               MOVE SQLCODE                 TO MXWW30-SQLCODE           04900000
               MOVE SQLCA                   TO MXWW30-SQLCA             04910000
               GOBACK                                                   04920000
           END-EVALUATE.                                                04930000
                                                                        04940000
       1120-EXIT.                                                       04950000
           EXIT.                                                        04960000
      * ITG 107288 - E                                                  04970000
                                                                        04980000