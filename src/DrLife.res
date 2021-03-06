� �� 0�  d   
mainWindow�  	leftAlign�  CenterAlign�  
rightAlign�  topAlign�  VcenterAlign�  bottomAlignl  initialConditions�  
horizgroup�  	vertgroup�  
singleRule�  
multiRulesv  rules�  ovrFont�  defaultFont~  fontst  horiztagy  ovrHorizu  vertTagz  ovrVertr  
horizCellss  	vertCells�  
ssOverride�  speedTagh  starti  pauseg  step�  
checkPoint�  resetPatternf  stopm  	sleepTimex  	wrapEdges|  loadingtext}  loadPercent�  pauseTag�  	stopAtGen�  
adjustView�   �   �   �    �  patternText� 
 patternTitle�   �  lambdaValue�   �  	numStates�  ruletext�  ruleUsed�   �  caType�   �  neighborHood�  	textColor� 	 patternOutput�  	eTimeText�  
eTimeValue�  genText�  generationCount�   �  
population�   �  density�  cellspergentext�  numCells�  cellspersectext�  cellsPer�  	cellstext�  	genPerSec�   �  maxPopulation�   �  growth�  cols�  xValue�  rows�  yValue�   �  � gifFile� 
gifDisplay� exit�   �  � currentPattern�  � checkPointDescription�  �  � checkPoints� activateCheckPoint� addCheckPoint� deleteCheckPoint� cancelX   _ 	viewblockf  g  p  j 	firstLinek lastLineq numLinesSelectedc snapshoth  i  t  l firstcolumnm 
lastColumnr numColumnsSelecteda getData\ 	applyViewo  s  u subPatterns� pauseProcessingd processSubpatternx  y  n insertAtRow{ insertAtCol rotate0� 	rotate180� rotate90� 	rotate270� clearSelectione addSubpatternz  }  v  w waitingb 	closeView~  |  �   �	 	errorText� errorContinue    %  ,
 changeCriteria.  - currentCriteria$  " existingRules# selectedRules& 
moveItemUp' moveItemDown( 
deleteItem* 
clearItems) 	loadQueue/ 	numQueued! exitCyclicRules+  �   � game� nbrHood� rules2�  �  �  �  � states� randomizeFactor� horizCells2� 
vertCells2�  �  � 
randomfile� cancelCreate� closeRandom�  �  �  @   A gameIDC neighborhoodIDD patternsE
 ruleIDJ 
calcLambdaH 
dispLambdaK cancelDevelopmentI exitRuleDescr�  �  �  �  ��� 0�1 checkConfig�/* called from INIT     */
PARSE version ver .
IF ver <> 'REXXSAA' THEN
  DO
    CALL mainWindow.Hide
    CALL D200.Hide
    errorText = 'This is the Classic Rexx version. Use DrlifeO.exe for Object REXX.'
    rc = ModalFor('D700',, 'Messages')
    RETURN 1
  END
configOK = IniGet('configSet', 'General', cfgFile)
IF configOK = 0 THEN
  DO
    CALL mainWindow.Hide
    CALL D200.Hide
    errorText = 'Edit the Drlife.cfg file before continuing. Change the "configSet" field to 1  '
    rc = ModalFor('D700',, 'Messages')
    RETURN 1
  END
RETURNdisplayBinaryArray�/* called from 'calcBinaryArray', 'selectPattern' */
PARSE ARG currentRow
CR = '0D'x
LF = '0A'x
DO t=1 to cellsHoriz
  outString = outString||A.currentRow.t 
  IF LENGTH(outstring) > displaylimit THEN outstring = ''
END
outString = outString||CR||LF
CALL VAL 'outStr', outString
CALL notify 'D200', 'outputText' 
IF VAL('delayTime') > 0 THEN CALL SLEEP VAL('delayTime')
RETURNcalcBinaryArray�/* called from 'generate' */
outString = ''
DO i = 1 FOR cellsVert 
  CALL SLEEP 1 
  IF VAL('ended') = 1 THEN LEAVE
  wrapEdges = VAL('wrap')
  CALL USE 'pauseResource', 1
  ip1 = i + 1
  DO j = 1 FOR cellsHoriz
    IF wrapEdges = 1 THEN CALL calcTailsJ
    ELSE
      CALL calcTailsJnoWrap
    CALL calcBinary
  END /* j */
  CALL NOTIFY 'D200', 'generationCount', gen
  gen = gen + 1
  CALL displayBinaryArray i
  /* release use of pauseResource */
  CALL USE 'pauseResource', 0
END  /* i */
RETURN
calcBinary�/* called from 'calcBinaryArray' */
/* general routine for binary C.A. 1-255 & 1-4,294,967,296 (2exp32)  */
/* p1 - p32  from decodeBinaryRule */
IF radius = 1 THEN
  DO
    threeCells = A.i.jm1||A.i.j||A.i.jp1
    SELECT
      WHEN threeCells = 000 THEN A.ip1.j = p1
      WHEN threeCells = 001 THEN A.ip1.j = p2
      WHEN threeCells = 010 THEN A.ip1.j = p3
      WHEN threeCells = 011 THEN A.ip1.j = p4
      WHEN threeCells = 100 THEN A.ip1.j = p5
      WHEN threeCells = 101 THEN A.ip1.j = p6
      WHEN threeCells = 110 THEN A.ip1.j = p7
      WHEN threeCells = 111 THEN A.ip1.j = p8
    OTHERWISE
    END
  END
IF radius = 2 THEN
  DO
    fiveCells = A.i.jm2||A.i.jm1||A.i.j||A.i.jp1||A.i.jp2
    SELECT
      WHEN fiveCells = 00000 THEN A.ip1.j = p1
      WHEN fiveCells = 00001 THEN A.ip1.j = p2
      WHEN fiveCells = 00010 THEN A.ip1.j = p3
      WHEN fiveCells = 00011 THEN A.ip1.j = p4
      WHEN fiveCells = 00100 THEN A.ip1.j = p5
      WHEN fiveCells = 00101 THEN A.ip1.j = p6
      WHEN fiveCells = 00110 THEN A.ip1.j = p7
      WHEN fiveCells = 00111 THEN A.ip1.j = p8
      WHEN fiveCells = 01000 THEN A.ip1.j = p9
      WHEN fiveCells = 01001 THEN A.ip1.j = p10
      WHEN fiveCells = 01010 THEN A.ip1.j = p11
      WHEN fiveCells = 01011 THEN A.ip1.j = p12
      WHEN fiveCells = 01100 THEN A.ip1.j = p13
      WHEN fiveCells = 01101 THEN A.ip1.j = p14
      WHEN fiveCells = 01110 THEN A.ip1.j = p15
      WHEN fiveCells = 01111 THEN A.ip1.j = p16
      WHEN fiveCells = 10000 THEN A.ip1.j = p17
      WHEN fiveCells = 10001 THEN A.ip1.j = p18
      WHEN fiveCells = 10010 THEN A.ip1.j = p19
      WHEN fiveCells = 10011 THEN A.ip1.j = p20
      WHEN fiveCells = 10100 THEN A.ip1.j = p21
      WHEN fiveCells = 10101 THEN A.ip1.j = p22
      WHEN fiveCells = 10110 THEN A.ip1.j = p23
      WHEN fiveCells = 10111 THEN A.ip1.j = p24
      WHEN fiveCells = 11000 THEN A.ip1.j = p25
      WHEN fiveCells = 11001 THEN A.ip1.j = p26
      WHEN fiveCells = 11010 THEN A.ip1.j = p27
      WHEN fiveCells = 11011 THEN A.ip1.j = p28
      WHEN fiveCells = 11100 THEN A.ip1.j = p29
      WHEN fiveCells = 11101 THEN A.ip1.j = p30
      WHEN fiveCells = 11110 THEN A.ip1.j = p31
      WHEN fiveCells = 11111 THEN A.ip1.j = p32
    OTHERWISE
    END
  END
RETURN
calcWeightedLifeArray�/* Called from 'generate' */
/* calc new values for each cell in A. */
B. = ''
nC = 0
oldAlive = pop
CALL NOTIFY 'mainWindow', 'loadText', 'Calc %' 
DO i = 1 FOR cellsVert
 IF VAL('ended') = 1 THEN RETURN
 DO k = 1 to 5
   IF i = (k/5) * cellsVert THEN CALL NOTIFY 'mainWindow', 'percentDone', k * 20 
 END
 IF wrapEdges = 1 THEN CALL calcTailsI
 ELSE
   CALL calcTailsInoWrap   
 DO j = 1 FOR cellsHoriz
   IF wrapEdges = 1 THEN CALL calcTailsJ
   ELSE
     CALL calcTailsJnoWrap
   SELECT
       WHEN state = 2 THEN
          nC = A.im1.jm1 * T.1 + A.im1.j * T.2 + A.im1.jp1 * T.3 + ,
               A.i.jm1 * T.4 + A.i.j * T.5 + A.i.jp1 * T.6 + , 
               A.ip1.jm1 * T.7 + A.ip1.j * T.8 + A.ip1.jp1 * T.9
       WHEN state > 2 THEN
          IF colors = 0 THEN
          nC = (A.im1.jm1=1) * T.1 + (A.im1.j=1) * T.2 + (A.im1.jp1=1) * T.3 + ,
               (A.i.jm1=1)   * T.4 + (A.i.j=1)   * T.5 + (A.i.jp1=1)   * T.6 + , 
               (A.ip1.jm1=1) * T.7 + (A.ip1.j=1) * T.8 + (A.ip1.jp1=1) * T.9
          ELSE  
          nC = (A.im1.jm1>0) * T.1 + (A.im1.j>0) * T.2 + (A.im1.jp1>0) * T.3 + ,
               (A.i.jm1>0)   * T.4 + (A.i.j>0)   * T.5 + (A.i.jp1>0)   * T.6 + , 
               (A.ip1.jm1>0) * T.7 + (A.ip1.j>0) * T.8 + (A.ip1.jp1>0) * T.9
   OTHERWISE   
   END
   CALL calcWeightedLife
  END /* j */
END  /* i */
maxAlive = MAX(oldAlive, pop, maxAlive)
IF oldAlive > 0 THEN
  gro = FORMAT((pop - oldAlive) / oldAlive * 100,,2)
ELSE
  gro = 0
den = FORMAT(pop / (cellsVert * cellsHoriz) * 100,,2)
DO i = 1 TO cellsVert
  DO j = 1 TO cellsHoriz
    IF B.i.j >= 0 THEN A.i.j = B.i.j
  END
END
RETURNcalcWeightedLife�/* Called from 'calcWeightedLifeArray'  */
/* general routine for Sxxx/Bxxx/xx type rules   */
/* nC is count of neighbors for A.i.j   */
SELECT
  WHEN A.i.j = 0 THEN 
    /* rule for birth  */
    DO
      /* optimized: A.i.j is zero & no neighbors, and */ 
      /* the Snn/Bnn rule has no zeros in Bnn, so remains zero */
      IF nC = 0 & bCntHasZeros = 0 THEN RETURN 
      ELSE 
        DO k = 0 to nCmax   
          IF nC = bCnt.k THEN 
            DO
              pop = pop + 1
              B.i.j = 1
              RETURN
            END
        END
    END
  WHEN A.i.j = 1 & state = 2 THEN 
    /* rule for survival   */
    DO
      DO k = 0 TO nCmax
        /* optimized: if A.i.j = 1 and neighbors are valid, then remain = 1 */ 
        IF nC = sCnt.k THEN RETURN 
      END
      pop = pop - 1
      B.i.j = 0
    END
  WHEN A.i.j = 1 & state > 2 THEN     
    DO 
      DO k = 0 TO nCmax
        IF nC = sCnt.k THEN
          DO
            IF colors > 0 THEN B.i.j = 2
            ELSE
              B.i.j = 1 
            RETURN 
          END
      END
      /* cell dies  */
      IF history > 0 THEN B.i.j = 2
      ELSE
        DO
          pop = pop - 1
          B.i.j = 0
        END
    END
  WHEN A.i.j > 1 THEN
      DO
        IF history > 0 & colors = 0 THEN
          DO
            /* like GENERATIONS  */
            newValue = (A.i.j + 1) // state       
            IF newValue = 0 THEN
              DO
                pop = pop - 1
                B.i.j = 0
              END
            ELSE
              B.i.j = newValue
            RETURN 
          END
        IF history = 0 & colors > 0 THEN
          DO
            DO k = 0 TO nCmax
              IF nC = sCnt.k THEN
                 DO
                   newValue = (A.i.j + 1) // state       
                   IF newValue = 0 THEN B.i.j = 1
                   ELSE
                     B.i.j = newValue
                   RETURN
                 END 
            END
            pop = pop - 1
            B.i.j = 0
          END 
      END
OTHERWISE
END
RETURNcalcSecondOrderLifeArray�/* Called from 'generate' for SECOND ORDER CA.s */
/* calc new values for each cell in A. */
DO i = 1 TO cellsVert
  DO j = 1 TO cellsHoriz
    future.i.j = ''
  END
END
nC = 0
oldAlive = pop
CALL NOTIFY 'mainWindow', 'loadText', 'Calc %' 
DO i = 1 FOR cellsVert
 IF VAL('ended') = 1 THEN RETURN
 DO k = 1 to 5
   IF i = (k/5) * cellsVert THEN CALL NOTIFY 'mainWindow', 'percentDone', k * 20 
 END
 IF wrapEdges = 1 THEN CALL calcTailsI
 ELSE
   CALL calcTailsInoWrap   
 DO j = 1 FOR cellsHoriz
   IF wrapEdges = 1 THEN CALL calcTailsJ
   ELSE
     CALL calcTailsJnoWrap
   IF radius = 1 THEN
          nC = A.im1.jm1 * T.1 + A.im1.j * T.2 + A.im1.jp1 * T.3 + ,
               A.i.jm1   * T.4 + A.i.j   * T.5 + A.i.jp1   * T.6 + , 
               A.ip1.jm1 * T.7 + A.ip1.j * T.8 + A.ip1.jp1 * T.9
   ELSE  /* radius = 2 */
          nC = A.im2.jm2 * T.1  + A.im2.jm1 * T.2  + A.im2.j * T.3  + A.im2.jp1 * T.4  + A.im2.jp2 * T.5 + ,
               A.im1.jm2 * T.6  + A.im1.jm1 * T.7  + A.im1.j * T.8  + A.im1.jp1 * T.9  + A.im1.jp2 * T.10 + ,
               A.i.jm2   * T.11 + A.i.jm1   * T.12 + A.i.j   * T.13 + A.i.jp1   * T.14 + A.i.jp2   * T.15 + , 
               A.ip1.jm2 * T.16 + A.ip1.jm1 * T.17 + A.ip1.j * T.18 + A.ip1.jp1 * T.19 + A.ip1.jp2 * T.20 + ,
               A.ip2.jm2 * T.21 + A.ip2.jm1 * T.22 + A.ip2.j * T.23 + A.ip2.jp1 * T.24 + A.ip2.jp2 * T.25 
   CALL calcSecondOrderLife
  END /* j */
END  /* i */
maxAlive = MAX(oldAlive, pop, maxAlive)
IF oldAlive > 0 THEN
  gro = FORMAT((pop - oldAlive) / oldAlive * 100,,2)
ELSE
  gro = 0
den = FORMAT(pop / (cellsVert * cellsHoriz) * 100,,2)
DO i = 1 TO cellsVert
  DO j = 1 TO cellsHoriz
    IF future.i.j >= 0 THEN A.i.j = future.i.j
  END
END
RETURNcalcSecondOrderLife�/* Called from 'calcSecondOrderLifeArray' */
/* general routine for Sxxx/Bxxx/2 type rules */
/* state must be 2 for second order C.A. s */
/* nC is count of neighbors for A.i.j */
SELECT
  WHEN A.i.j = 0 THEN 
    /* rule for birth  */
    DO  
      DO k = 0 to nCmax   
        IF nC = bCnt.k THEN 
          DO
            future.i.j = (1 && past.i.j)
            IF future.i.j = 1 THEN pop = pop + 1
            past.i.j = 0
            RETURN
          END
      END /* k=0 to nCmax  */
      /* no birth  */
      future.i.j = (0 && past.i.j)
      IF future.i.j = 1 THEN pop = pop + 1
      past.i.j = 0
    END /* when  */ 
  WHEN A.i.j = 1 THEN 
    /* rule for survival   */
    DO
      DO k = 0 TO nCmax
        IF nC = sCnt.k THEN
          DO
            future.i.j = (1 && past.i.j)
            IF future.i.j = 0 THEN pop = pop - 1
            past.i.j = 1
            RETURN 
          END
      END /* k = 0 to nCmax  */
      /* no survival  */
      future.i.j = (0 && past.i.j)
      IF future.i.j = 0 THEN pop = pop - 1
      past.i.j = 1
    END /* when  */ 
OTHERWISE
END
RETURNparseRandom�/* called from 'getFileData'  */
ruleDefined = 0
DO UNTIL dataLine = '' /* starting at first line of pattern file */
  twoChar = SUBSTR(dataLine,1,2)
  SELECT 
    WHEN twoChar = '#R' THEN NOP 
    WHEN twoChar = '#C' | twoChar = '#D' THEN CALL setComment
    WHEN twoChar = '#G' THEN gameType = TRANSLATE(SUBSTR(dataLine, 9))
    WHEN twoChar = '#N' THEN nbhType = SUBSTR(dataLine, 12)
    WHEN twoChar = 'x ' THEN
       DO 
         PARSE VAR dataLine '=' newPatWidth ', y =' newPatHeight', rule = 'ruleType 
         patWidth = MAX(newPatWidth, patWidth)
         patHeight = MAX(newPatHeight, patHeight) 
         CALL getRuleData
       END
    WHEN twoChar = '' THEN LEAVE
  OTHERWISE
    DO
      CALL parseCellData
      CALL getRuleData 
    END
  END 
  IF commentRead = 0 THEN commentData = patFile
  dataLine = STRIP(LINEIN(patFile,, 1), 'L')
END /* DO until no more dataLines */
numLines = k - 1
tempWidth = 0
DO i = 1 to numLines
  tempWidth = MAX(LENGTH(patternData.i), tempWidth)
END
patWidth = MAX(tempWidth, patWidth)
patHeight = MAX(numLines, patHeight)
RETURN
parseAscii�/* called from 'getFileData'  */
ruleDefined = 0
nbhType = 'M8'
gameType = 'LIFE'
DO UNTIL dataLine = '' /* starting at first line of pattern file */
  twoChar = SUBSTR(dataLine,1,2)
  SELECT 
    WHEN twoChar = '#C' | twoChar = '#D' THEN CALL setComment
    WHEN twoChar = 'x ' THEN
       DO 
         PARSE VAR dataLine '=' newPatWidth ', y =' newPatHeight', rule = 'ruleType 
         patWidth = MAX(newPatWidth, patWidth)
         patHeight = MAX(newPatHeight, patHeight) 
         /* if rule is missing, default to LIFE  */
         IF ruleType = '' THEN ruleType = 'S23/B3/2' 
         /* make sure rule is in Sxx/Bxx format for LIFE rules */
         PARSE VAR ruleType firstHalf '/' secondHalf '/' state
         IF state = '' THEN state = 2
         IF SUBSTR(firstHalf, 1, 1) = 'B' THEN
           ruleType = secondHalf||'/'||firstHalf||'/'||state
         IF SUBSTR(firstHalf, 1, 1) = 'S' THEN 
           ruleType = firstHalf||'/'secondHalf||'/'||state
         IF POS(9, ruleType) > 0 THEN nbhType = 'M9' 
         ruleDefined = 1
         CALL getRuleData
       END
    WHEN twoChar = '' THEN LEAVE
  OTHERWISE
    DO
      CALL parseCellData
      CALL getRuleData 
    END
  END 
  IF commentRead = 0 THEN commentData = patFile
  dataLine = STRIP(LINEIN(patFile,, 1), 'L')
END /* DO until no more dataLines */
IF ruleType = '' | ruleType = 'none' | ruleType = 0 THEN
 DO
   ruleType = 'S23/B3/2'
   CALL getRuleData
 END
IF POS(9, ruleType) > 0 THEN nbhType = 'M9'
numLines = k -1
tempWidth = 0
DO i = 1 to numLines
  tempWidth = MAX(LENGTH(patternData.i), tempWidth)
END
patWidth = MAX(tempWidth, patWidth)
patHeight = MAX(numLines, patHeight) 
RETURN
loadRules2�/* called from D900 nbrHood listbox (nbrHood_Select) */
CALL rules2.Delete
DO i = 1 TO numRules
  SELECT
    WHEN TRANSLATE(game.Item(game.Select())) = 'BINARY' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'D' THEN
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
    WHEN TRANSLATE(game.Item(game.Select())) = 'LIFE' THEN
      DO
        PARSE VAR ruleValue.i . '/' . '/' stateNum
        IF SUBSTR(ruleValue.i, 1, 1) = 'S' & stateNum = 2 THEN
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
      END
    WHEN TRANSLATE(game.Item(game.Select())) = 'GENERATIONS' THEN
      DO
        PARSE VAR ruleValue.i . '/' . '/' stateNum
        IF SUBSTR(ruleValue.i, 1, 1) = 'S' & stateNum > 2 THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
      END
    WHEN TRANSLATE(game.Item(game.Select())) = 'MARGOLUS' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'M' THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
    WHEN TRANSLATE(game.Item(game.Select())) = 'WEIGHTED LIFE' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'S' THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
    WHEN TRANSLATE(game.Item(game.Select())) = 'CYCLIC CA' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'R' THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
    WHEN TRANSLATE(game.Item(game.Select())) = 'SECOND ORDER' THEN 
      DO
        PARSE VAR ruleValue.i . '/' . '/' stateNum
        IF stateNum = 2 THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
      END
    WHEN TRANSLATE(game.Item(game.Select())) = 'SELF REPLICATING' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'X' THEN
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL rules2.Add ruleItem,"L", ruleValue.i
         END
  OTHERWISE
  END 
END
RETURNloadNbrhoods�/* called from SELECT event of game listbox (game_SELECT), and apply Config menu option */
CALL nbrHood.Delete
rc = IniEnumSections(neighborhoodSections., neighbors)
DO i = 1 TO neighborhoodSections.0
  neighborhoodTitle.i = IniGet('TITLE', neighborhoodSections.i, neighbors)
  nbhValue = SUBSTR(neighborhoodSections.i, 10)
  SELECT
    WHEN TRANSLATE(game.Item(game.Select())) = 'BINARY' THEN
        IF SUBSTR(nbhValue, 1,1) = 'B' THEN 
         CALL nbrHood.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(game.Item(game.Select())) = 'LIFE' THEN
       DO
         nbrHood = SUBSTR(nbhValue, 1,3)
         IF nbrHood = 'M8' | nbrHood = 'M9' | nbrHood = 'M24'| nbrHood = 'M25'| nbrHood = 'V4'| nbrHood = 'V5' | nbrHood = 'V12' | (nbrHood >= 'U00' & nbrHood <= 'U99') THEN 
          CALL nbrhood.Add neighborhoodTitle.i,"L", nbhValue
       END
    WHEN TRANSLATE(game.Item(game.Select())) = 'GENERATIONS' THEN
       DO
         nbrHood = SUBSTR(nbhValue, 1,3)
         IF nbrHood = 'M8' | nbrHood = 'M9' | nbrHood = 'M24'| nbrHood = 'M25'| nbrHood = 'V4'| nbrHood = 'V5' | nbrHood = 'V12' | (nbrHood >= 'U00' & nbrHood <= 'U99') THEN 
          CALL nbrhood.Add neighborhoodTitle.i,"L", nbhValue
       END
    WHEN TRANSLATE(game.Item(game.Select())) = 'MARGOLUS' THEN
        IF SUBSTR(nbhValue, 1,2) = 'P' THEN 
         CALL nbrHood.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(game.Item(game.Select())) = 'SELF REPLICATING' THEN
        IF SUBSTR(nbhValue, 1,1) = 'X' THEN 
         CALL nbrHood.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(game.Item(game.Select())) = 'CYCLIC CA' THEN
        IF SUBSTR(nbhValue, 1,1) = 'M' | SUBSTR(nbhValue, 1,1) = 'V' THEN 
         CALL nbrHood.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(game.Item(game.Select())) = 'SECOND ORDER' THEN
       DO
         nbrHood = SUBSTR(nbhValue, 1,3)
         IF nbrHood = 'M8' | nbrHood = 'M9' | nbrHood = 'M24'| nbrHood = 'M25'| nbrHood = 'V4'| nbrHood = 'V5' | nbrHood = 'V12' THEN 
         CALL nbrHood.Add neighborhoodTitle.i,"L", nbhValue
       END
  OTHERWISE
  END
END
IF nbrHood.Item() = 0 THEN
  DO
    CALL rules2.Delete
    CALL rules2.Text('')
  END
RETURNdecodeMargolusRule�/* called from 'cycle' */
PARSE VAR ruleType 'MS,D'new.0';'new.1';'new.2';'new.3';'new.4';'new.5';'new.6';'new.7';'new.8';'new.9';'new.10';'new.11';'new.12';'new.13';'new.14';'new.15
block.0 = 0000
block.1 = 1000
block.2 = 0100
block.3 = 1100
block.4 = 0010
block.5 = 1010
block.6 = 0110
block.7 = 1110
block.8 = 0001
block.9 = 1001
block.10 = 0101
block.11 = 1101
block.12 = 0011
block.13 = 1011
block.14 = 0111
block.15 = 1111
DO k = 0 TO 15
 index = new.k
 blockOut.k = block.index
END
state = 2
RETURN
loadRuleID�/* called from D320 neighborhoodID listbox (neighborhoodID_Select) */
CALL ruleID.Delete
DO i = 1 TO numRules
  SELECT
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'BINARY' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'D' THEN
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL ruleID.Add ruleItem,"L", ruleValue.i
         END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'LIFE' THEN
      DO
        PARSE VAR ruleValue.i . '/' . '/' stateNum
        IF SUBSTR(ruleValue.i, 1, 1) = 'S' & stateNum = 2 THEN
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL ruleID.Add ruleItem,"L", ruleValue.i
         END
      END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'GENERATIONS' THEN
      DO
        PARSE VAR ruleValue.i . '/' . '/' stateNum
        IF SUBSTR(ruleValue.i, 1, 1) = 'S' & stateNum > 2 THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL ruleID.Add ruleItem,"L", ruleValue.i
         END
      END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'MARGOLUS' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'M' THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL ruleID.Add ruleItem,"L", ruleValue.i
         END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'CYCLIC CA' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'R' THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL ruleID.Add ruleItem,"L", ruleValue.i
         END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'SECOND ORDER' THEN 
      DO
        PARSE VAR ruleValue.i . '/' . '/' stateNum
        IF stateNum = 2 THEN 
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL ruleID.Add ruleItem,"L", ruleValue.i
         END
      END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'SELF REPLICATING' THEN
        IF SUBSTR(ruleValue.i, 1, 1) = 'X' THEN
          DO
            ruleItem = ruleValue.i '--'ruleTitle.i
            CALL ruleID.Add ruleItem,"L", ruleValue.i
         END
  OTHERWISE
  END 
END
RETURNloadNeighborhoods�/* called from SELECT event of gameID listbox (gameID_SELECT), and apply Config menu option */
CALL neighborhoodID.Delete
rc = IniEnumSections(neighborhoodSections., neighbors)
DO i = 1 TO neighborhoodSections.0
  neighborhoodTitle.i = IniGet('TITLE', neighborhoodSections.i, neighbors)
  nbhValue = SUBSTR(neighborhoodSections.i, 10)
  SELECT
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'BINARY' THEN
        IF SUBSTR(nbhValue, 1,1) = 'B' THEN 
         CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'LIFE' THEN
       DO
         nbrHood = SUBSTR(nbhValue, 1,3)
         IF nbrHood = 'M8' | nbrHood = 'M9' | nbrHood = 'M24'| nbrHood = 'M25'| nbrHood = 'V4'| nbrHood = 'V5' | nbrHood = 'V12' | (nbrHood >= 'U00' & nbrHood <= 'U99') THEN 
          CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
       END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'GENERATIONS' THEN
       DO
         nbrHood = SUBSTR(nbhValue, 1,3)
         IF nbrHood = 'M8' | nbrHood = 'M9' | nbrHood = 'M24'| nbrHood = 'M25'| nbrHood = 'V4'| nbrHood = 'V5' | nbrHood = 'V12' | (nbrHood >= 'U00' & nbrHood <= 'U99') THEN 
          CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
       END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'MARGOLUS' THEN
        IF SUBSTR(nbhValue, 1,2) = 'P' THEN 
         CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'SELF REPLICATING' THEN
        IF SUBSTR(nbhValue, 1,1) = 'X' THEN 
         CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'CYCLIC CA' THEN
        IF SUBSTR(nbhValue, 1,1) = 'M' | SUBSTR(nbhValue, 1,1) = 'V' THEN 
         CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'SECOND ORDER' THEN
       DO
         nbrHood = SUBSTR(nbhValue, 1,3)
         IF nbrHood = 'M8' | nbrHood = 'M9' | nbrHood = 'M24'| nbrHood = 'M25'| nbrHood = 'V4'| nbrHood = 'V5' | nbrHood = 'V12' THEN 
          CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
       END
    WHEN TRANSLATE(gameID.Item(gameID.Select())) = 'WEIGHTED LIFE' THEN
        IF SUBSTR(nbhValue, 1,1) = 'W' THEN 
          CALL neighborhoodID.Add neighborhoodTitle.i,"L", nbhValue
  OTHERWISE
  END
END
IF neighborhoodID.Item() = 0 THEN
  DO
    CALL ruleID.Delete
    CALL ruleID.Text('')
  END
RETURN
loadGameID�/* called from init event of D320 gameID listbox (gameID_Init), D900 game listbox (game_Init) and apply Config menu option */
numGames = 0
rc = IniEnumSections(gameSections., cfgFile)
DO i = 1 TO gameSections.0
  IF SUBSTR(gameSections.i,1,4) = 'GAME' THEN
   DO
    numGames = numGames + 1
    gameTitle.numGames = IniGet('TITLE', gameSections.i, cfgFile)
   END
END
IF windowID = 320 THEN
    DO
      CALL gameID.Delete 
      DO i = 1 to numGames
        IF TRANSLATE(gameTitle.i) = 'SELF REPLICATING' THEN ITERATE
        IF TRANSLATE(gameTitle.i) = 'WEIGHTED LIFE' THEN ITERATE
        CALL gameID.Add gameTitle.i,"L", TRANSLATE(gameTitle.i) 
      END
    END
ELSE /* windowID = 900 */
    DO
      CALL game.Delete
      DO i = 1 to numGames
        IF TRANSLATE(gameTitle.i) = 'SELF REPLICATING' THEN ITERATE
        IF TRANSLATE(gameTitle.i) = 'WEIGHTED LIFE' THEN ITERATE
        CALL game.Add gameTitle.i,"L", TRANSLATE(gameTitle.i)
      END
    END
RETURNgetDefaultNeighbors�/* called from 'selectPattern' */
SELECT
  WHEN gameType = 'LIFE' THEN
    DO
      nbhType = 'M8'
      nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
    END
  WHEN gameType = 'GENERATIONS' THEN
    DO
      nbhType = 'M8'
      nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
    END
  WHEN gameType = 'BINARY' THEN
    DO
      nbhType = 'B2'
      nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
    END
  WHEN gameType = 'MARGOLUS' THEN
    DO
      nbhType = 'P'
      nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
    END
  WHEN gameType = 'SELF REPLICATING' THEN
    DO
      nbhType = 'X'  
      nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
    END
  WHEN gameType = 'CYCLIC CA' THEN
    DO
      nbhType = 'M8'  
      nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
    END
  WHEN gameType = 'SECOND ORDER' THEN
    DO
      nbhType = 'M8'  
      nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
    END
OTHERWISE
END
RETURNcalcTailsJnoWrap�/* called from 'calcLifeArray' & 'calcLifeArray2' */
/* wrapEdges = 0  */
/* radius >= 1  */
SELECT 
  WHEN j = 1 THEN
   DO
     jp1 = 2
     jm1 = 0       
   END
  WHEN j = cellsHoriz THEN
   DO
     jp1 = 0
     jm1 = j - 1
   END
OTHERWISE
   DO
     jp1 = j + 1
     jm1 = j - 1
   END
END
IF radius = 1 THEN RETURN 
/* radius >= 2  */
SELECT  
  WHEN j = 1 THEN
   DO
     jp2 = 3
     jm2 = 0 
   END
  WHEN j = 2 THEN
   DO
     jp2 = 4
     jm2 = 0 
   END
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp2 = 0
     jm2 = j - 2
   END
  WHEN j = cellsHoriz THEN
   DO
     jp2 = 0
     jm2 = j - 2
   END   
OTHERWISE
   DO
     jp2 = j + 2
     jm2 = j - 2
   END
END /* select  */
IF radius = 2 THEN RETURN
/* radius >= 3  */
SELECT 
  WHEN j = 1 THEN
   DO
     jp3 = 4
     jm3 = 0
   END 
  WHEN j = 2 THEN
   DO
     jp3 = 5
     jm3 = 0
   END 
  WHEN j = 3 THEN
   DO
     jp3 = 6
     jm3 = 0
   END 
  WHEN j = cellsHoriz - 2 THEN
   DO
     jp3 = 0
     jm3 = j - 3 
   END 
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp3 = 0
     jm3 = j - 3  
   END 
  WHEN j = cellsHoriz  THEN
   DO
     jp3 = 0
     jm3 = j - 3
   END
OTHERWISE
   DO
     jp3 = j + 3
     jm3 = j - 3
   END 
END
IF radius = 3 THEN RETURN
/* radius >= 4  */
SELECT 
  WHEN j = 1 THEN
   DO
     jp4 = 5
     jm4 = 0
   END 
  WHEN j = 2 THEN
   DO
     jp4 = 6
     jm4 = 0
   END 
  WHEN j = 3 THEN
   DO
     jp4 = 7
     jm4 = 0
   END 
  WHEN j = 4 THEN
   DO
     jp4 = 8
     jm4 = 0 
   END 
  WHEN j = cellsHoriz - 3 THEN
   DO
     jp4 = 0
     jm4 = j - 4
   END 
  WHEN j = cellsHoriz - 2 THEN
   DO
     jp4 = 0
     jm4 = j - 4 
   END 
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp4 = 0
     jm4 = j - 4  
   END 
  WHEN j = cellsHoriz THEN
   DO
     jp4 = 0
     jm4 = j - 4
   END 
OTHERWISE
   DO
     jp4 = j + 4
     jm4 = j - 4
   END 
END
IF radius = 4 THEN RETURN
/* radius = 5  */
SELECT  
  WHEN j = 1 THEN
   DO
     jp5 = 6
     jm5 = 0
   END 
  WHEN j = 2 THEN
   DO
     jp5 = 7
     jm5 = 0
   END 
  WHEN j = 3 THEN
   DO
     jp5 = 8
     jm5 = 0
   END 
  WHEN j = 4 THEN
   DO
     jp5 = 9
     jm5 = 0
   END 
  WHEN j = 5 THEN
   DO
     jp5 = 10
     jm5 = 0
   END 
  WHEN j = cellsHoriz - 4 THEN
   DO
     jp5 = 0
     jm5 = j - 5
   END 
  WHEN j = cellsHoriz - 3 THEN
   DO
     jp5 = 0
     jm5 = j - 5
   END 
  WHEN j = cellsHoriz - 2 THEN
   DO
     jp5 = 0
     jm5 = j - 5 
   END 
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp5 = 0
     jm5 = j - 5  
   END 
  WHEN j = cellsHoriz THEN
   DO
     jp5 = 0
     jm5 = j - 5
   END 
OTHERWISE
   DO
     jp5 = j + 5
     jm5 = j - 5
   END 
END
RETURNcalcTailsInoWrap�/* called from 'calcLifeArray' & 'calcLifeArray2' */
/* wrapEdges = 0  */
/* radius >= 1  */
SELECT 
  WHEN i = 1 THEN
   DO
     ip1 = 2
     im1 = 0       
   END
  WHEN i = cellsVert THEN
   DO
     ip1 = 0
     im1 = i - 1
   END
OTHERWISE
   DO
     ip1 = i + 1
     im1 = i - 1
   END
END
IF radius = 1 THEN RETURN 
/* radius >= 2  */
SELECT  
  WHEN i = 1 THEN
   DO
     ip2 = 3
     im2 = 0 
   END
  WHEN i = 2 THEN
   DO
     ip2 = 4
     im2 = 0 
   END
  WHEN i = cellsVert - 1 THEN
   DO
     ip2 = 0
     im2 = i - 2
   END
  WHEN i = cellsVert THEN
   DO
     ip2 = 0
     im2 = i - 2
   END   
OTHERWISE
   DO
     ip2 = i + 2
     im2 = i - 2
   END
END /* select  */
IF radius = 2 THEN RETURN
/* radius >= 3  */
SELECT 
  WHEN i = 1 THEN
   DO
     ip3 = 4
     im3 = 0
   END 
  WHEN i = 2 THEN
   DO
     ip3 = 5
     im3 = 0
   END 
  WHEN i = 3 THEN
   DO
     ip3 = 6
     im3 = 0
   END 
  WHEN i = cellsVert - 2 THEN
   DO
     ip3 = 0
     im3 = i - 3 
   END 
  WHEN i = cellsVert - 1 THEN
   DO
     ip3 = 0
     im3 = i - 3  
   END 
  WHEN i = cellsVert  THEN
   DO
     ip3 = 0
     im3 = i - 3
   END
OTHERWISE
   DO
     ip3 = i + 3
     im3 = i - 3
   END 
END
IF radius = 3 THEN RETURN
/* radius >= 4  */
SELECT 
  WHEN i = 1 THEN
   DO
     ip4 = 5
     im4 = 0
   END 
  WHEN i = 2 THEN
   DO
     ip4 = 6
     im4 = 0
   END 
  WHEN i = 3 THEN
   DO
     ip4 = 7
     im4 = 0
   END 
  WHEN i = 4 THEN
   DO
     ip4 = 8
     im4 = 0 
   END 
  WHEN i = cellsVert - 3 THEN
   DO
     ip4 = 0
     im4 = i - 4
   END 
  WHEN i = cellsVert - 2 THEN
   DO
     ip4 = 0
     im4 = i - 4 
   END 
  WHEN i = cellsVert - 1 THEN
   DO
     ip4 = 0
     im4 = i - 4  
   END 
  WHEN i = cellsVert THEN
   DO
     ip4 = 0
     im4 = i - 4
   END 
OTHERWISE
   DO
     ip4 = i + 4
     im4 = i - 4
   END 
END
IF radius = 4 THEN RETURN
/* radius = 5  */
SELECT  
  WHEN i = 1 THEN
   DO
     ip5 = 6
     im5 = 0
   END 
  WHEN i = 2 THEN
   DO
     ip5 = 7
     im5 = 0
   END 
  WHEN i = 3 THEN
   DO
     ip5 = 8
     im5 = 0
   END 
  WHEN i = 4 THEN
   DO
     ip5 = 9
     im5 = 0
   END 
  WHEN i = 5 THEN
   DO
     ip5 = 10
     im5 = 0
   END 
  WHEN i = cellsVert - 4 THEN
   DO
     ip5 = 0
     im5 = i - 5
   END 
  WHEN i = cellsVert - 3 THEN
   DO
     ip5 = 0
     im5 = i - 5
   END 
  WHEN i = cellsVert - 2 THEN
   DO
     ip5 = 0
     im5 = i - 5 
   END 
  WHEN i = cellsVert - 1 THEN
   DO
     ip5 = 0
     im5 = i - 5  
   END 
  WHEN i = cellsVert THEN
   DO
     ip5 = 0
     im5 = i - 5
   END 
OTHERWISE
   DO
     ip5 = i + 5
     im5 = i - 5
   END 
END
RETURNvonNeumannCellStats�/* called from 'calcCyclicArray' */
/* radius 1 cells  */
cellState. = 0
cell.1 = A.im1.j
cell.2 = A.i.jm1
cell.3 = A.i.jp1
cell.4 = A.ip1.j
DO m = 1 TO 4
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 1 THEN RETURN
/* radius 2 cells  */
cell.1 = A.im2.j
cell.2 = A.im1.jm1 
cell.3 = A.im1.jp1 
cell.4 = A.i.jm2
cell.5 = A.i.jp2
cell.6 = A.ip1.jm1 
cell.7 = A.ip1.jp1
cell.8 = A.ip2.j
DO m = 1 TO 8
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 2 THEN RETURN
/* radius 3 cells  */
cell.1 = A.im3.j
cell.2 = A.im2.jm1
cell.3 = A.im2.jp1
cell.4 = A.im1.jm2
cell.5 = A.im1.jp2
cell.6 = A.i.jm3
cell.7 = A.i.jp3
cell.8 = A.ip1.jm2
cell.9 = A.ip1.jp2
cell.10 = A.ip2.jm1
cell.11 = A.ip2.jp1
cell.12 = A.ip3.j
DO m = 1 TO 12
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 3 THEN RETURN
/* radius 4 cells  */
cell.1 = A.im4.j
cell.2 = A.im3.jm1
cell.3 = A.im3.jp1
cell.4 = A.im2.jm2
cell.5 = A.im2.jp2
cell.6 = A.im1.jm3
cell.7 = A.im1.jp3
cell.8 = A.i.jm4
cell.9 = A.i.jp4
cell.10 = A.ip1.jm3
cell.11 = A.ip1.jp3
cell.12 = A.ip2.jm2
cell.13 = A.ip2.jp2
cell.14 = A.ip3.jm1
cell.15 = A.ip3.jp1
cell.16 = A.ip4.j
DO m = 1 TO 16
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 4 THEN RETURN
/* radius 5 cells  */
cell.1 = A.im5.j
cell.2 = A.im4.jm1
cell.3 = A.im4.jp1
cell.4 = A.im3.jm2
cell.5 = A.im3.jp2
cell.6 = A.im2.jm3
cell.7 = A.im2.jp3
cell.8 = A.im1.jm4
cell.9 = A.im1.jp4
cell.10 = A.i.jm5
cell.11 = A.i.jp5
cell.12 = A.ip1.jm4
cell.13 = A.ip1.jp4
cell.14 = A.ip2.jm3
cell.15 = A.ip2.jp3
cell.16 = A.ip3.jm2
cell.17 = A.ip3.jp2
cell.18 = A.ip4.jm1
cell.19 = A.ip4.jp1
cell.20 = A.ip5.j
DO m = 1 TO 20
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
RETURNmooreCellStats�/* called from 'calcCyclicArray' */
/* radius 1 cells  */
cellState. = 0
cell.1 = A.im1.jm1
cell.2 = A.im1.j
cell.3 = A.im1.jp1
cell.4 = A.i.jm1
cell.5 = A.i.jp1
cell.6 = A.ip1.jm1
cell.7 = A.ip1.j
cell.8 = A.ip1.jp1
DO m = 1 TO 8
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 1 THEN RETURN
/* radius 2 cells  */
cell.1 = A.im2.jm2
cell.2 = A.im2.jm1
cell.3 = A.im2.j
cell.4 = A.im2.jp1
cell.5 = A.im2.jp2
cell.6 = A.im1.jm2
cell.7 = A.im1.jp2
cell.8 = A.i.jm2
cell.9 = A.i.jp2
cell.10 = A.ip1.jm2
cell.11 = A.ip1.jp2
cell.12 = A.ip2.jm2
cell.13 = A.ip2.jm1
cell.14 = A.ip2.j
cell.15 = A.ip2.jp1
cell.16 = A.ip2.jp2
DO m = 1 TO 16
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 2 THEN RETURN
/* radius 3 cells  */
cell.1 = A.im3.jm3
cell.2 = A.im3.jm2
cell.3 = A.im3.jm1
cell.4 = A.im3.j
cell.5 = A.im3.jp1
cell.6 = A.im3.jp2
cell.7 = A.im3.jp3
cell.8 = A.im2.jm3
cell.9 = A.im2.jp3
cell.10 = A.im1.jm3
cell.11 = A.im1.jp3
cell.12 = A.i.jm3
cell.13 = A.i.jp3
cell.14 = A.ip1.jm3
cell.15 = A.ip1.jp3
cell.16 = A.ip2.jm3
cell.17 = A.ip2.jp3
cell.18 = A.ip3.jm3
cell.19 = A.ip3.jm2
cell.20 = A.ip3.jm1
cell.21 = A.ip3.j
cell.22 = A.ip3.jp1
cell.23 = A.ip3.jp2
cell.24 = A.ip3.jp3
DO m = 1 TO 24
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 3 THEN RETURN
/* radius 4 cells  */
cell.1 = A.im4.jm4
cell.2 = A.im4.jm3
cell.3 = A.im4.jm2
cell.4 = A.im4.jm1
cell.5 = A.im4.j
cell.6 = A.im4.jp1
cell.7 = A.im4.jp2
cell.8 = A.im4.jp3
cell.9 = A.im4.jp4
cell.10 = A.im3.jm4
cell.11 = A.im3.jp4
cell.12 = A.im2.jm4
cell.13 = A.im2.jp4
cell.14 = A.im1.jm4
cell.15 = A.im1.jp4
cell.16 = A.i.jm4
cell.17 = A.i.jp4
cell.18 = A.ip1.jm4
cell.19 = A.ip1.jp4
cell.20 = A.ip2.jm4
cell.21 = A.ip2.jp4
cell.22 = A.ip3.jm4
cell.23 = A.ip3.jp4
cell.24 = A.ip4.jm4
cell.25 = A.ip4.jm3
cell.26 = A.ip4.jm2
cell.27 = A.ip4.jm1
cell.28 = A.ip4.j
cell.29 = A.ip4.jp1
cell.30 = A.ip4.jp2
cell.31 = A.ip4.jp3
cell.32 = A.ip4.jp4
DO m = 1 TO 32
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
IF radius = 4 THEN RETURN
/* radius 5 cells  */
cell.1 = A.im5.jm5
cell.2 = A.im5.jm4
cell.3 = A.im5.jm3
cell.4 = A.im5.jm2
cell.5 = A.im5.jm1
cell.6 = A.im5.j
cell.7 = A.im5.jp1
cell.8 = A.im5.jp2
cell.9 = A.im5.jp3
cell.10 = A.im5.jp4
cell.11 = A.im5.jp5
cell.12 = A.im4.jm5
cell.13 = A.im4.jp5
cell.14 = A.im3.jm5
cell.15 = A.im3.jp5
cell.16 = A.im2.jm5
cell.17 = A.im2.jp5
cell.18 = A.im1.jm5
cell.19 = A.im1.jp5
cell.20 = A.i.jm5
cell.21 = A.i.jp5
cell.22 = A.ip1.jm5
cell.23 = A.ip1.jp5
cell.24 = A.ip2.jm5
cell.25 = A.ip2.jp5
cell.26 = A.ip3.jm5
cell.27 = A.ip3.jp5
cell.28 = A.ip4.jm5
cell.29 = A.ip4.jp5
cell.30 = A.ip5.jm5
cell.31 = A.ip5.jm4
cell.32 = A.ip5.jm3
cell.33 = A.ip5.jm2
cell.34 = A.ip5.jm1
cell.35 = A.ip5.j
cell.36 = A.ip5.jp1
cell.37 = A.ip5.jp2
cell.38 = A.ip5.jp3
cell.39 = A.ip5.jp4
cell.40 = A.ip5.jp5
DO m = 1 TO 40
  aState = cell.m
  cellState.aState = cellState.aState + 1
END
RETURN
calcCyclic�/* Called from 'calcCyclicArray' */
IF A.i.j > 0 THEN
  DO
    nextState = (A.i.j + 1) // state
    IF ghSwitch = 1 THEN
      DO
        B.i.j = nextState 
        IF B.i.j = 0 THEN pop = pop - 1
      END
    ELSE /* ghSwitch = 0 */
      IF cellState.nextState >= threshold THEN
        DO
          B.i.j = nextState
          IF B.i.j = 0 THEN pop = pop - 1
        END
  END 
ELSE /* a.i.j = 0 */
  IF cellState.1 >= threshold THEN
    DO
      B.i.j = 1
      pop = pop + 1
    END
RETURN
calcTailsJ�/* called from 'calcLifeArray', 'calcLifeArray2', and 'calc_CA_array' */
/* wrapEdges = 1  */
/* radius >= 1  */
SELECT 
  WHEN j = 1 THEN
   DO
     jp1 = 2
     jm1 = cellsHoriz       
   END
  WHEN j = cellsHoriz THEN
   DO
     jp1 = 1
     jm1 = j - 1
   END
OTHERWISE
   DO
     jp1 = j + 1
     jm1 = j - 1
   END
END
IF radius = 1 THEN RETURN 
/* radius >= 2  */
SELECT  
  WHEN j = 1 THEN
   DO
     jp2 = 3
     jm2 = cellsHoriz - 1 
   END
  WHEN j = 2 THEN
   DO
     jp2 = 4
     jm2 = cellsHoriz 
   END
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp2 = 1
     jm2 = j - 2
   END
  WHEN j = cellsHoriz THEN
   DO
     jp2 = 2
     jm2 = j - 2
   END   
OTHERWISE
   DO
     jp2 = j + 2
     jm2 = j - 2
   END
END /* select  */
IF radius = 2 THEN RETURN
/* radius >= 3  */
SELECT 
  WHEN j = 1 THEN
   DO
     jp3 = 4
     jm3 = cellsHoriz - 2
   END 
  WHEN j = 2 THEN
   DO
     jp3 = 5
     jm3 = cellsHoriz - 1
   END 
  WHEN j = 3 THEN
   DO
     jp3 = 6
     jm3 = cellsHoriz
   END 
  WHEN j = cellsHoriz - 2 THEN
   DO
     jp3 = 1
     jm3 = j - 3 
   END 
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp3 = 2
     jm3 = j - 3  
   END 
  WHEN j = cellsHoriz  THEN
   DO
     jp3 = 3
     jm3 = j - 3
   END
OTHERWISE
   DO
     jp3 = j + 3
     jm3 = j - 3
   END 
END
IF radius = 3 THEN RETURN
/* radius >= 4  */
SELECT 
  WHEN j = 1 THEN
   DO
     jp4 = 5
     jm4 = cellsHoriz - 3
   END 
  WHEN j = 2 THEN
   DO
     jp4 = 6
     jm4 = cellsHoriz - 2
   END 
  WHEN j = 3 THEN
   DO
     jp4 = 7
     jm4 = cellsHoriz - 1
   END 
  WHEN j = 4 THEN
   DO
     jp4 = 8
     jm4 = cellsHoriz 
   END 
  WHEN j = cellsHoriz - 3 THEN
   DO
     jp4 = 1
     jm4 = j - 4
   END 
  WHEN j = cellsHoriz - 2 THEN
   DO
     jp4 = 2
     jm4 = j - 4 
   END 
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp4 = 3
     jm4 = j - 4  
   END 
  WHEN j = cellsHoriz THEN
   DO
     jp4 = 4
     jm4 = j - 4
   END 
OTHERWISE
   DO
     jp4 = j + 4
     jm4 = j - 4
   END 
END
IF radius = 4 THEN RETURN
/* radius = 5  */
SELECT  
  WHEN j = 1 THEN
   DO
     jp5 = 6
     jm5 = cellsHoriz - 4
   END 
  WHEN j = 2 THEN
   DO
     jp5 = 7
     jm5 = cellsHoriz - 3
   END 
  WHEN j = 3 THEN
   DO
     jp5 = 8
     jm5 = cellsHoriz - 2
   END 
  WHEN j = 4 THEN
   DO
     jp5 = 9
     jm5 = cellsHoriz - 1
   END 
  WHEN j = 5 THEN
   DO
     jp5 = 10
     jm5 = cellsHoriz
   END 
  WHEN j = cellsHoriz - 4 THEN
   DO
     jp5 = 1
     jm5 = j - 5
   END 
  WHEN j = cellsHoriz - 3 THEN
   DO
     jp5 = 2
     jm5 = j - 5
   END 
  WHEN j = cellsHoriz - 2 THEN
   DO
     jp5 = 3
     jm5 = j - 5 
   END 
  WHEN j = cellsHoriz - 1 THEN
   DO
     jp5 = 4
     jm5 = j - 5  
   END 
  WHEN j = cellsHoriz THEN
   DO
     jp5 = 5
     jm5 = j - 5
   END 
OTHERWISE
   DO
     jp5 = j + 5
     jm5 = j - 5
   END 
END
RETURN
calcTailsI�/* called from 'calcLifeArray' & 'calcLifeArray2' */
/* wrapEdges = 1  */
/* radius >= 1  */
SELECT 
  WHEN i = 1 THEN
   DO
     ip1 = 2
     im1 = cellsVert       
   END
  WHEN i = cellsVert THEN
   DO
     ip1 = 1
     im1 = i - 1
   END
OTHERWISE
   DO
     ip1 = i + 1
     im1 = i - 1
   END
END
IF radius = 1 THEN RETURN 
/* radius >= 2  */
SELECT  
  WHEN i = 1 THEN
   DO
     ip2 = 3
     im2 = cellsVert - 1 
   END
  WHEN i = 2 THEN
   DO
     ip2 = 4
     im2 = cellsVert 
   END
  WHEN i = cellsVert - 1 THEN
   DO
     ip2 = 1
     im2 = i - 2
   END
  WHEN i = cellsVert THEN
   DO
     ip2 = 2
     im2 = i - 2
   END   
OTHERWISE
   DO
     ip2 = i + 2
     im2 = i - 2
   END
END /* select  */
IF radius = 2 THEN RETURN
/* radius >= 3  */
SELECT 
  WHEN i = 1 THEN
   DO
     ip3 = 4
     im3 = cellsVert - 2
   END 
  WHEN i = 2 THEN
   DO
     ip3 = 5
     im3 = cellsVert - 1
   END 
  WHEN i = 3 THEN
   DO
     ip3 = 6
     im3 = cellsVert
   END 
  WHEN i = cellsVert - 2 THEN
   DO
     ip3 = 1
     im3 = i - 3 
   END 
  WHEN i = cellsVert - 1 THEN
   DO
     ip3 = 2
     im3 = i - 3  
   END 
  WHEN i = cellsVert  THEN
   DO
     ip3 = 3
     im3 = i - 3
   END
OTHERWISE
   DO
     ip3 = i + 3
     im3 = i - 3
   END 
END
IF radius = 3 THEN RETURN
/* radius >= 4  */
SELECT 
  WHEN i = 1 THEN
   DO
     ip4 = 5
     im4 = cellsVert - 3
   END 
  WHEN i = 2 THEN
   DO
     ip4 = 6
     im4 = cellsVert - 2
   END 
  WHEN i = 3 THEN
   DO
     ip4 = 7
     im4 = cellsVert - 1
   END 
  WHEN i = 4 THEN
   DO
     ip4 = 8
     im4 = cellsVert 
   END 
  WHEN i = cellsVert - 3 THEN
   DO
     ip4 = 1
     im4 = i - 4
   END 
  WHEN i = cellsVert - 2 THEN
   DO
     ip4 = 2
     im4 = i - 4 
   END 
  WHEN i = cellsVert - 1 THEN
   DO
     ip4 = 3
     im4 = i - 4  
   END 
  WHEN i = cellsVert THEN
   DO
     ip4 = 4
     im4 = i - 4
   END 
OTHERWISE
   DO
     ip4 = i + 4
     im4 = i - 4
   END 
END
IF radius = 4 THEN RETURN
/* radius = 5  */
SELECT  
  WHEN i = 1 THEN
   DO
     ip5 = 6
     im5 = cellsVert - 4
   END 
  WHEN i = 2 THEN
   DO
     ip5 = 7
     im5 = cellsVert - 3
   END 
  WHEN i = 3 THEN
   DO
     ip5 = 8
     im5 = cellsVert - 2
   END 
  WHEN i = 4 THEN
   DO
     ip5 = 9
     im5 = cellsVert - 1
   END 
  WHEN i = 5 THEN
   DO
     ip5 = 10
     im5 = cellsVert
   END 
  WHEN i = cellsVert - 4 THEN
   DO
     ip5 = 1
     im5 = i - 5
   END 
  WHEN i = cellsVert - 3 THEN
   DO
     ip5 = 2
     im5 = i - 5
   END 
  WHEN i = cellsVert - 2 THEN
   DO
     ip5 = 3
     im5 = i - 5 
   END 
  WHEN i = cellsVert - 1 THEN
   DO
     ip5 = 4
     im5 = i - 5  
   END 
  WHEN i = cellsVert THEN
   DO
     ip5 = 5
     im5 = i - 5
   END 
OTHERWISE
   DO
     ip5 = i + 5
     im5 = i - 5
   END 
END
RETURN
calcCyclicArray�/* called from 'generate' */
/* calc new values for each cell in A. */
B. = ''
oldAlive = pop
CALL NOTIFY 'mainWindow', 'loadText', 'Calc %' 
DO i = 1 FOR cellsVert
IF VAL('ended') = 1 THEN RETURN
 DO k = 1 to 5
   IF i = (k/5) * cellsVert THEN CALL NOTIFY 'mainWindow', 'percentDone', k * 20 
 END
 IF wrapEdges = 1 THEN CALL calcTailsI
 ELSE
   CALL calcTailsInoWrap 
 DO j = 1 FOR cellsHoriz
   IF wrapEdges = 1 THEN CALL calcTailsJ
   ELSE
     CALL calcTailsJnoWrap 
   SELECT 
     WHEN SUBSTR(nbhType, 1, 1) = 'M' THEN CALL mooreCellStats
     WHEN SUBSTR(nbhType, 1, 1) = 'V' THEN CALL vonNeumannCellStats
   OTHERWISE
   END
  CALL calcCyclic 
  END /* j */
END  /* i */
maxAlive = MAX(oldAlive, pop, maxAlive)
IF oldAlive > 0 THEN
  gro = FORMAT((pop - oldAlive) / oldAlive * 100,,2)
ELSE
  gro = 0
den = FORMAT(pop / (cellsVert * cellsHoriz) * 100,,2)
DO i = 1 TO cellsVert
  DO j = 1 TO cellsHoriz
    IF B.i.j >= 0 THEN A.i.j = B.i.j
  END
END
RETURNdecodeCyclicRule�/* called from 'parseMcell', 'cycle' */
PARSE VAR ruleType 'R' radius '/T' threshold '/C' state '/N' nbrHood '/' gh 
IF gh = '' THEN ghSwitch = 0
ELSE
 ghSwitch = 1
SELECT
  WHEN nbrHood = 'M' THEN 
    DO
      SELECT
        WHEN radius = 1 THEN
          DO
            nbhType = 'M8'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 2 THEN
          DO
            nbhType = 'M24'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 3 THEN
          DO
            nbhType = 'M48'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 4 THEN
          DO
            nbhType = 'M80'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 5 THEN
          DO
            nbhType = 'M120'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END

      OTHERWISE
      END /* select moore radius */
    END /* do */
  WHEN nbrHood = 'N' THEN 
    DO
      SELECT
        WHEN radius = 1 THEN
          DO
            nbhType = 'V4'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 2 THEN
          DO
            nbhType = 'V12'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 3 THEN
          DO
            nbhType = 'V24'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 4 THEN
          DO
            nbhType = 'V40'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
        WHEN radius = 5 THEN
          DO
            nbhType = 'V60'
            nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
          END
      OTHERWISE
      END /* select von Neumann radius  */
    END /* do  */     
OTHERWISE
END /* select nbrhood  */
RETURN	charToNum�/* called from 'decodeLifeRule', 'loadArray' */
charTable = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ#'
oldChar = ARG(1)
newNum = POS(oldChar, charTable) - 1
RETURN newNum	numToChar�/* called from 'decodeWeightedLifeRule', 'displayArray', 'randomData' */
PROCEDURE
charTable = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
aNum = ARG(1) + 1
newChar = SUBSTR(charTable, aNum, 1)
RETURN newChardecodeWeightedLifeRule�/* called from 'parseMCell' */
activeCells = 0
totalCells = 9
radius = 1
commaCount = 0
position = 1
DO UNTIL position = 0
  position = POS(",", ruleType, position)
  IF position <> 0 THEN
    DO
      commaCount = commaCount + 1
      position = position + 1
    END
END
theRest = ruleType
DO p = 1 TO commaCount + 1
  PARSE VAR theRest part.p ',' theRest
  SELECT
    WHEN SUBSTR(part.p, 1, 2) = 'NW' THEN T.1 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'NN' THEN T.2 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'NE' THEN T.3 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'WW' THEN T.4 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'ME' THEN
      DO
        T.5 = SUBSTR(part.p, 3)
        IF T.5 > 0 THEN nbhType = 'M9'
        ELSE
          nbhType = 'M8'
      END  
    WHEN SUBSTR(part.p, 1, 2) = 'EE' THEN T.6 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'SW' THEN T.7 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'SS' THEN T.8 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'SE' THEN T.9 = SUBSTR(part.p, 3)
    WHEN SUBSTR(part.p, 1, 2) = 'RS' THEN sPart = sPart||numToChar(SUBSTR(part.p, 3))
    WHEN SUBSTR(part.p, 1, 2) = 'RB' THEN bPart = bPart||numToChar(SUBSTR(part.p, 3))
    WHEN SUBSTR(part.p, 1, 2) = 'HI' THEN history = SUBSTR(part.p, 3)
  OTHERWISE
  END
END
IF history > 0 THEN ruleType = 'S'sPart'/B'bPart'/'history
ELSE
  ruleType = 'S'sPart'/B'bPart'/'2 
DO p = 1 TO 9
  IF T.p > 0 THEN activeCells = activeCells + 1
END 
titleAppend = ' (Weighted 'T.1||T.2||T.3||T.4||T.5||T.6||T.7||T.8||T.9 ')' 
RETURNgetNeighbors�/* called from 'setupExecution' & CALCULATE Pb on D320 */
r = 1
nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors)
IF gameType = 'WEIGHTED LIFE' THEN nbhTitle = nbhTitle ||titleAppend 
IF nbhTitle = 0 THEN
  DO
    errorText = 'The neighborhood 'nbhType' is missing from Drlife.nbh .'
    rc = ModalFor('D700',, 'Messages') 
    RETURN 1
  END
IF gameType <> 'WEIGHTED LIFE' THEN 
  DO 
    nbhTemplate = IniGet('nbhData.'r, 'TEMPLATE.'nbhType, neighbors)
    DO UNTIL theData = ''
      r = r + 1
      theData = IniGet('nbhData.'r, 'TEMPLATE.'nbhType, neighbors)
      IF theData <> '' THEN nbhTemplate = nbhTemplate||theData
    END
  END
ELSE
  nbhTemplate = T.1||T.2||T.3||T.4||T.5||T.6||T.7||T.8||T.9
totalCells = LENGTH(nbhTemplate)
SELECT
  WHEN totalCells = 3 THEN radius = 1
  WHEN totalCells = 5 THEN radius = 2
  WHEN totalCells > 5 THEN radius = (SQRT(totalCells) - 1) / 2
OTHERWISE
END 
activeCells = 0 
T. = ''
DO count = 1 TO totalCells
  T.count = SUBSTR(nbhTemplate, count, 1)
  IF T.count >= 1 THEN activeCells = activeCells + 1
END
RETURNsingleRuleAllowed�/* called from mainWindow singleRule radiobutton */
frameSize = D800.Frame()
IF frameSize = '0 0 0 0' THEN NOP
ELSE
 DO
   CALL D800.Close
   CALL VAL 'cyclicRule', 0
 END
RETURN
inSheath�/* called from setUndefinedRules */
PROCEDURE
PARSE ARG t,r,b,l
f = 0
IF ( (t=1) | (t=2) | (t=4) | (t=6) | (t=7) ) THEN f = f + 1
IF ( (r=1) | (r=2) | (r=4) | (r=6) | (r=7) ) THEN f = f + 1
IF ( (b=1) | (b=2) | (b=4) | (b=6) | (b=7) ) THEN f = f + 1
IF ( (l=1) | (l=2) | (l=4) | (l=6) | (l=7) ) THEN f = f + 1
IF f > 1 THEN RETURN 1
RETURN 0setUndefinedRules�/* called from 'parseSRCARules' */
DO a = 0 to 8
 DO b = 0 to 8
  DO c = 0 to 8
   DO d = 0 to 8
    DO e = 0 to 8
      IF srcaRule.a.b.c.d.e = -1 THEN
        DO
          IF a=8 THEN srcaRule.a.b.c.d.e = 0
          ELSE 
             IF (b=8 | c=8 | d=8 | e=8) THEN
              SELECT
                WHEN (a=0 | a=1) THEN
                 DO
                    IF ( (b>=2 & b<=7) | (c>=2 & c<=7) | (d>=2 & d<=7 ) | (e>=2 & e<=7) ) THEN
                      srcaRule.a.b.c.d.e = 8
                    ELSE
                      srcaRule.a.b.c.d.e = a
                 END
                WHEN (a=2 | a=3 | a=5) THEN srcaRule.a.b.c.d.e = 0
                WHEN (a=4 | a=6 | a=7) THEN srcaRule.a.b.c.d.e = 1
              OTHERWISE
              END
          ELSE
            DO
              SELECT
                WHEN a=0 THEN
                  DO
                    IF ( (b=1 | c=1 | d=1 | e=1) & inSheath(b,c,d,e) ) THEN
                      srcaRule.a.b.c.d.e = 1
                    ELSE
                      srcaRule.a.b.c.d.e = 0
                  END  
                WHEN a=1 THEN
                  DO
                    IF ( (b=7 | c=7 | d=7 | e=7) & inSheath(b,c,d,e) ) THEN
                      srcaRule.a.b.c.d.e = 7
                    ELSE
                      IF ( (b=6 | c=6 | d=6 | e=6) & inSheath(b,c,d,e) ) THEN
                        srcaRule.a.b.c.d.e = 6
                      ELSE
                       IF ( (b=4 | c=4 | d=4 | e=4) & inSheath(b,c,d,e) ) THEN
                        srcaRule.a.b.c.d.e = 4
                  END
               WHEN a=2 THEN             
                  DO
                    IF (b=3 | c=3 | d=3 | e=3) THEN srcaRule.a.b.c.d.e = 1
                    ELSE
                      IF (b=2 | c=2 | d=2 | e=2) THEN srcaRule.a.b.c.d.e = 2
                  END
               WHEN (a=4 | a=6 | a=7) THEN
                  IF ( (b=0 | c=0 | d=0 | e=0) & inSheath(b,c,d,e) ) THEN
                    srcaRule.a.b.c.d.e = 0
              OTHERWISE
              END /* select */
            END /* do */
        END /* if then do */
    END /* e */
   END /* d */
  END /* c */
 END /* b */
END /* a */
srcaRule.1.1.1.5.2 = 8
srcaRule.1.1.5.2.1 = 8
srcaRule.1.5.2.1.1 = 8
srcaRule.1.2.1.1.5 = 8
DO a = 0 to 8
 DO b = 0 to 8
  DO c = 0 to 8
   DO d = 0 to 8
    DO e = 0 to 8
      IF srcaRule.a.b.c.d.e = -1 THEN srcaRule.a.b.c.d.e = 8
    END /* e */
   END /* d */
  END /* c */
 END /* b */
END /* a */
RETURNclearUndefinedRules�/* called from parseSRCARules */
DO a = 0 to 8
 DO b = 0 to 8
  DO c = 0 to 8
   DO d = 0 to 8
    DO e = 0 to 8
      IF srcaRule.a.b.c.d.e = -1 then srcaRule.a.b.c.d.e = a
    END
   END
  END
 END
END
RETURNgetRuleData�/*  called from 'getFileData' */
ruleFound = 0
DO i = 1 TO numRules
  IF ruleType = ruleValue.i THEN 
    DO
      CALL rules.Select i
      ruleFound = 1
    END
  IF ruleFound = 1 THEN RETURN
END
IF rulefound = 0 THEN CALL rules.Select 0
CALL checkLimit 
RETURNcalcSRCATailsY�/* called from calcSRCAArray */
IF i = cellsVert THEN
        DO
          IF wrapEdges = 1 THEN ip1 = 1
          ELSE ip1 = cellsVert 
        END 
ELSE ip1 = i + 1
IF i = 1  THEN 
         DO
          IF wrapEdges = 1 THEN im1 = cellsVert 
          ELSE im1 = 1
         END
ELSE im1 = i - 1
RETURN
calcSRCATailsX�/* called from calcSRCAArray */
IF j = cellsHoriz THEN 
       DO
        IF wrapEdges = 1 THEN jp1 = 1
        ELSE jp1 = cellsHoriz 
       END
ELSE jp1 = j + 1
IF j = 1 THEN 
       DO
        IF wrapEdges = 1 THEN jm1 = cellsHoriz 
        ELSE jm1 = 1
       END
ELSE jm1 = j - 1
RETURN
loadSRCARulef/* called from 'cycle' */
PARSE VAR ruleType '/' state 
rc = CVREAD(srcaCVfile, 'srcaRule.')
RETURNloadGridArrayv/* called from 'cycle' */
DO i = 1 to CellsVert
  DO j = 1 TO cellsHoriz
    grid.1.j.i = A.i.j
  END
END
RETURNcalcSRCAArray�/* called from 'generate' */
oldAlive = pop
next = 3 - cd
pop = 0
DO j = 1 TO cellsHoriz  
  IF VAL('ended') = 1 THEN RETURN
  DO k = 1 to 5
    IF j = (k/5) * cellsHoriz THEN CALL NOTIFY 'mainWindow', 'percentDone', k * 20 
  END
  CALL calcSRCATailsX 
  DO i = 1 TO cellsVert
    CALL calcSRCATailsY 
    c = grid.cd.j.i
    t = grid.cd.j.im1
    r = grid.cd.jp1.i
    b = grid.cd.j.ip1
    l = grid.cd.jm1.i
    grid.next.j.i = srcaRule.c.t.r.b.l 
    A.i.j = grid.next.j.i
    IF A.i.j > 0 THEN pop = pop + 1
  END
END
cd = 3 - cd
maxAlive = MAX(oldAlive, pop, maxAlive)
IF oldAlive > 0 THEN
  gro = FORMAT((pop - oldAlive) / oldAlive * 100,,2)
ELSE
  gro = 0
den = FORMAT((pop / (cellsVert * cellsHoriz)) * 100,,2)
RETURNparseSRCARules�/* called from 'parseSRCA' */
DO a = 0 TO 8
 DO b = 0 TO 8
  DO c = 0 TO 8  
   DO d = 0 TO 8
    DO e = 0 TO 8
     srcaRule.a.b.c.d.e = -1
    END
   END
  END
 END
END
ruleSize = LENGTH(ruleData) 
DO p = 1 TO ruleSize BY 7   
  c = SUBSTR(ruleData, p, 1)
  t = SUBSTR(ruleData, p + 1, 1)
  r = SUBSTR(ruleData, p + 2, 1)
  b = SUBSTR(ruleData, p + 3, 1)
  l = SUBSTR(ruleData, p + 4, 1)
  i = SUBSTR(ruleData, p + 5, 1)
  srcaRule.c.t.r.b.l = i
  srcaRule.c.l.t.r.b = i
  srcaRule.c.b.l.t.r = i
  srcaRule.c.r.b.l.t = i
END
IF handleRules = 0 THEN CALL clearUndefinedRules
IF handleRules = 1 THEN CALL setUndefinedRules
DROP ruleData
RETURN	parseSRCA�/* called from 'getFileData' */
numComments = 0
k = 0
ruleData = ''
nbhTitle = 'Self Replicating'
nbhType = 'X'
DO UNTIL dataLine = ''
  threeChar = SUBSTR(dataLine,1,3)
  SELECT
    WHEN threeChar = '#D ' THEN CALL setComment
    WHEN threeChar = '#GA' THEN
      DO
        PARSE VAR dataLine '#GAME ' gameType
        gameType = TRANSLATE(gameType)
      END 
     WHEN threeChar = '#BO' THEN
       DO 
         PARSE VAR dataLine '#BOARD ' newPatWidth 'x' newPatHeight
         patWidth = MAX(newPatWidth, patWidth)
         patHeight = MAX(newPatHeight, patHeight) 
       END
    WHEN threeChar = '#RE' THEN 
       DO
         PARSE VAR dataLine '#REPRULE ' srcaRule '/' state
         ruleFound = 0
         ruleType = srcaRule'/'state
         DO i = 1 TO numRules
           IF TRANSLATE(ruleType) = ruleValue.i THEN 
             DO
               CALL rules.Select i
               ruleFound = 1
             END
           IF ruleFound = 1 THEN LEAVE
         END
       IF rulefound = 0 THEN CALL rules.Select 0 
       CALL checkLimit 
       END
    WHEN threeChar = '#LO' THEN 
       DO
         k = k + 1
         rawLoopData = STRIP(SUBSTR(dataLine, 7), 'B', '"')
         DO i = 1 TO LENGTH(rawLoopData)
           aChar = SUBSTR(rawLoopData, i, 1)
           IF aChar = ' ' THEN patternData.k = patternData.k||'0'
           ELSE
             patternData.k = patternData.k||aChar
         END
       END 
    WHEN threeChar = '#RU' THEN ruleData = ruleData||STRIP(SUBSTR(dataLine, 7), 'B', '"')
    WHEN threeChar = '#WR' THEN
       DO
        PARSE VAR dataLine '#WRAP ' wrap
        IF wrap = 0 THEN
          DO
            CALL VAL 'wrap', 0
            CALL mainWindow.wrapEdges.Select 0
          END
        ELSE 
          DO
            CALL VAL 'wrap', 1 
            CALL mainWindow.wrapEdges.Select 1 
          END
       END
    WHEN threeChar = '#SD' THEN PARSE VAR dataLine '#SDSRRULES ' handleRules
    WHEN threeChar = '  ' THEN LEAVE
  OTHERWISE
  END /* select */
  IF commentRead = 0 THEN commentData = patFile
  dataLine = STRIP(LINEIN(patFile,, 1), 'L')
END /* do until no more dataLines */
CALL parseSRCARules
numLines = k 
RETURNdecodeBinaryRule�/* called from 'cycle' */
PARSE VAR ruleType decimalValue '/' state
decimalRule = STRIP(decimalValue, 'L', 'D')
SELECT
  WHEN radius = 1 THEN
    DO
      binRule = convertBase10(decimalRule, 2, 0)
      ruleLength = LENGTH(binRule)
      IF ruleLength < 8 THEN binRule = COPIES(0, 8 - ruleLength) || binRule
      PARSE VAR binRule p8 +1 p7 +1 p6 +1 p5 +1 p4 +1 p3 +1 p2 +1 p1
    END
  WHEN radius = 2 THEN
    DO
      /* 256 - (2 exp 32) binRule = 32 digits   */
      binRule = convertBase10(decimalRule, 2, 0)
      ruleLength = LENGTH(binRule)
      IF ruleLength < 32 THEN binRule = COPIES(0, 32 - ruleLength) || binRule
       PARSE VAR binRule p32 +1 p31 +1 p30 +1 p29 +1 p28 +1 p27 +1 p26 +1 p25 +1 p24 +1 p23 +1 p22 +1 p21 +1 p20 +1 p19 +1 p18 +1 p17 +1 p16 +1 p15 +1 p14 +1 p13 +1 p12 +1 p11 +1 p10 +1 p9 +1 p8 +1 p7 +1 p6 +1 p5 +1 p4 +1 p3 +1 p2 +1 p1
    END
OTHERWISE
END
RETURNcalcMargolusTailsJ�/* called from 'calcMargolusArray' */
IF partition = 0 THEN 
  DO
    jp1 = j + 1
    RETURN
  END
IF partition = 1 THEN
  DO
    IF wrapEdges = 0 THEN jp1 = j + 1
    ELSE
      DO
        IF j = horizLimit THEN jp1 = 1
        ELSE 
          jp1 = j + 1
      END
  END
RETURNcalcMargolusArray�/* called from generate */
oldAlive = pop
CALL NOTIFY 'mainWindow', 'loadText', 'Calc %'
IF partition = 0 THEN
  DO
    startValue = 1
    vertLimit = cellsVert
    horizLimit = cellsHoriz
  END
IF partition = 1 THEN
  DO
    startValue = 2
    IF wrapEdges = 0 THEN
      DO 
        vertLimit = cellsVert - 1
        horizLimit = cellsHoriz - 1
      END
    ELSE
      DO
        vertLimit = cellsVert
        horizLimit = cellsHoriz
      END
  END
DO i = startValue TO vertLimit BY 2
 IF VAL('ended') = 1 THEN RETURN
  DO k = 1 to 5
    IF i = (k/5) * vertLimit THEN CALL NOTIFY 'mainWindow', 'percentDone', k * 20 
  END
  CALL calcMargolusTailsI   
  DO j = startValue TO horizLimit BY 2
    CALL calcMargolusTailsJ      
    CALL calcMargolus  
  END
END
maxAlive = MAX(oldAlive, pop, maxAlive)
IF oldAlive > 0 THEN
  gro = FORMAT((pop - oldAlive) / oldAlive * 100,,2)
ELSE
  gro = 0
den = FORMAT(pop / (cellsVert * cellsHoriz) * 100,,2)
IF partition = 0 THEN partition = 1
ELSE
   partition = 0
RETURNcalcMargolus�/* called from 'calcMargolusArray' */
blockIn = A.i.j||A.i.jp1||A.ip1.j||A.ip1.jp1
blockInPop = A.i.j + A.i.jp1 + a.ip1.j + a.ip1.jp1
DO k = 0 TO 15
  IF blockIn = block.k THEN
    DO
      A.i.j     = SUBSTR(blockOut.k, 1,1)
      A.i.jp1   = SUBSTR(blockOut.k, 2,1)
      A.ip1.j   = SUBSTR(blockOut.k, 3,1)
      A.ip1.jp1 = SUBSTR(blockOut.k, 4,1)
     LEAVE  
    END
END
blockOutPop = A.i.j + A.i.jp1 + a.ip1.j + a.ip1.jp1
pop = pop + blockOutPop - blockInPop
RETURNcalcMargolusTailsI�/* called from 'calcMargolusArray' */
IF partition = 0 THEN 
  DO
    ip1 = i + 1
    RETURN
  END
IF partition = 1 THEN
  DO
    IF wrapEdges = 0 THEN ip1 = i + 1
    ELSE
      DO
        IF i = vertLimit THEN ip1 = 1
        ELSE
           ip1 = i + 1
      END
  END
RETURNparseMCellData�/* called from 'parseMCell' */
repeatCount = 0
DO charCount = 4 to LENGTH(dataLine) /* first 3 chars are '#L '   */
  aChar = SUBSTR(dataLine, charCount,1)
  SELECT
        /* extended RLE format: determine repeat count  */
    WHEN aChar >=0 & aChar <= 9 THEN 
        DO
          repeatCount = aChar   /* units count  */
          aChar = SUBSTR(dataLine,charCount+1,1)
          IF aChar >=0 & aChar <= 9 THEN 
            DO
              repeatCount = repeatCount * 10 + aChar  /* tens count  */
              charCount = charCount + 1
              aChar = SUBSTR(dataLine,charCount+1,1)
              IF aChar >=0 & aChar <= 9 THEN 
                DO
                  repeatCount = repeatCount * 10 + aChar /* hundreds count  */
                  charCount = charCount + 1
                END
            END
        END
           /* extended RLE format: add a zero for a '.' character (dead cell)    */
    WHEN aChar = '.' & repeatCount = 0 THEN patternData.k = patternData.k||'0' 
    WHEN aChar = '.' & repeatCount > 0 THEN
        DO
          patternData.k = patternData.k||COPIES('0',repeatCount) 
          repeatCount = 0
        END
          /* extended RLE format: add a 1 for a character 'A' (live cell) */
    WHEN aChar >= 'A' & aChar <= 'X' & repeatCount = 0 THEN patternData.k = patternData.k||TRANSLATE(aChar, mCellTableOut, mCellTableIn) 
    WHEN aChar >= 'A' & aChar <= 'X' & repeatCount > 0 THEN
        DO
          patternData.k = patternData.k||COPIES(TRANSLATE(aChar, mCellTableOut, mCellTableIn), repeatCount) 
          repeatCount = 0
        END 
          /* extended RLE format: '$' character is a new line  */
    WHEN aChar = '$' & repeatCount = 0 THEN 
        DO
          k = k +1
          /* handle a second '$' character  */
          aChar = SUBSTR(dataLine,charCount+1,1)
          IF aChar = '$' THEN
            DO
              patternData.k ='0'
              charCount = charCount + 1
              k = k + 1
            END  
        END 
    WHEN aChar = '$' & repeatCount > 0 THEN 
        DO
          k = k + 1
          DO repeatCount - 1 
            patternData.k ='000' /* insert a row of zeros  */
            k = k + 1
          END
          repeatCount = 0
        END
          /* RLE format: '!' character is EOF   */
    WHEN aChar = '!' | aChar = ' ' THEN RETURN   
  OTHERWISE
  END /* select  */
END
RETURN
parseMCell�/* called from 'getFileData' */
ruleType = ''
colors = 0
sPart = ''
bPart = ''
mCellTableIn  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
mCellTableOut = '123456789ABCDEFGHIJKLMNOPQ'
DO UNTIL dataLine = ''
  threeChar = SUBSTR(dataLine,1,3)
  SELECT
    WHEN threeChar = '#GA' THEN
      DO
        PARSE VAR dataLine '#GAME ' gameType
        gameType = TRANSLATE(gameType)
        IF gameType <> 'LIFE' & gameType <> 'GENERATIONS' & gameType <> 'MARGOLUS' & gameType <> 'WEIGHTED LIFE' & gameType <> 'CYCLIC CA' & gameType <> 'SECOND ORDER' THEN
          DO
            errorText = 'The MCell format 'gameType' is not supported.'
            rc = ModalFor('D700',, 'Messages')
            CALL resetText
            CALL resetButtons
            RETURN 1
          END 
      END 
    WHEN threeChar = '#D ' THEN CALL setComment
    WHEN threeChar = '#BO' THEN
       DO 
         PARSE VAR dataLine '#BOARD ' newPatWidth 'x' newPatHeight
         patWidth = MAX(newPatWidth, patWidth)
         patHeight = MAX(newPatHeight, patHeight) 
       END
    WHEN threeChar = '#CC' THEN
       DO
         PARSE VAR dataLine '#CCOLORS ' colors 
         state = colors         
       END 
    WHEN threeChar = '#RU' THEN
       DO 
         PARSE VAR dataLine '#RULE ' ruleData
         /* if rule is missing, default to LIFE  */
         IF ruleData = '' THEN ruleType = 'S23/B3/2'
         SELECT
           WHEN gameType = 'MARGOLUS' THEN 
             DO
               nbhType = 'P'
               nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
               preventResize = 1
               ruleType = ruleData
             END 
           WHEN gameType = 'LIFE' | gameType = 'GENERATIONS' | gameType = 'SECOND ORDER' THEN 
             DO
               PARSE VAR ruleData sRules '/' bRules '/' state
               IF state = '' THEN state = 2
               ruleType = 'S'||sRules'/B'bRules'/'state
               nbhType = 'M8'
               nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
             END
           WHEN gameType = 'WEIGHTED LIFE' THEN 
             DO
               ruleType = ruleType||ruleData
               preventResize = 1
               CALL decodeWeightedLifeRule 
             END 
           WHEN gameType = 'CYCLIC CA' THEN
             DO
               preventResize = 1
               ruleType = ruleData
               nbhType = 'M8'
               nbhTitle = IniGet('TITLE', 'TEMPLATE.'nbhType, neighbors) 
               CALL decodeCyclicRule
             END
         OTHERWISE
         END
        CALL getRuleData
       END
    WHEN threeChar = '#WR' THEN
       DO
        PARSE VAR dataLine '#WRAP ' wrap
        IF wrap = 0 THEN
          DO
            CALL VAL 'wrap', 0
            CALL mainWindow.wrapEdges.Select 0
          END
        ELSE 
          DO
            CALL VAL 'wrap', 1 
            CALL mainWindow.wrapEdges.Select 1 
          END
       END
    WHEN threeChar = '#L ' THEN CALL parseMCellData
    WHEN threeChar = '  ' THEN LEAVE
  OTHERWISE
  END /* select */
  IF commentRead = 0 THEN commentData = patFile
  dataLine = STRIP(LINEIN(patFile,, 1), 'L')
END /* do until no more dataLines */
numLines = k 
RETURNconvertBase10�/* called from 'randomData' & 'cycle' */
/* function to convert a base 10 number to base y, then return mod value */
/* convertBase10(decimalNum, outputBase, truncate)    */
PROCEDURE
NUMERIC DIGITS 11
PARSE ARG decimalValue , outputBase, truncate
baseChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
outputValue = ''
IF decimalValue = 0 THEN RETURN 0
DO UNTIL decimalValue = 0
  curRest = decimalValue // outputBase
  decimalValue = decimalValue % outputBase
  outputValue = SUBSTR(baseChars, curRest + 1, 1) || outputValue
END
valueLength = LENGTH(outputValue)
IF valueLength > 1 & truncate = 1 THEN RETURN SUBSTR(outputValue, valueLength, 1) 
RETURN  outputValue initCellSliders�/* called from init of slider controls  */
CALL Range 13 
CALL Font defaultFont
CALL Item 1,'Value', '.24'
CALL Item 2,'Value', '.5' 
CALL Item 3,'Value', 1 
CALL Item 4,'Value', 2 
CALL Item 5,'Value', 3 
CALL Item 6,'Value', 4 
CALL Item 7,'Value', 5 
CALL Item 8,'Value', 6
CALL Item 9,'Value', 7 
CALL Item 10,'Value', 8
CALL Item 11,'Value', 9 
CALL Item 12,'Value', '10 '
CALL Item 13,'Value', ' Cust'
CALL Select 1
cellsHoriz = 24
cellsVert = 24
RETURNrotate�/* called from 'getSubpattern' */
PARSE ARG rotation
DO m = 1 TO numRowsInserted
  DO n = 1 TO numColsInserted
    element.m.n = SUBSTR(embedData.m, n, 1)
  END
END
IF rotation = 90 | rotation = 270 THEN
DO
  temp = numRowsInserted
  numRowsInserted = numColsInserted
  numColsInserted = temp
END
embedData. = ''
SELECT
  WHEN rotation = 90 THEN
    DO m = 1 TO numRowsInserted
      DO n = numColsInserted TO 1 BY -1
        embedData.m = embedData.m||element.n.m
      END
    END
  WHEN rotation = 180 THEN
    DO
      index = numRowsInserted
      DO m = 1 TO numRowsInserted 
        DO n = numColsInserted TO 1 BY -1
          embedData.m = embedData.m||element.index.n
        END
        index = index -1
      END
    END
  WHEN rotation = 270 THEN
    DO
      index = numRowsInserted
      DO m = 1 TO numRowsInserted 
        DO n = 1  TO numColsInserted
          embedData.m = embedData.m||element.n.index
        END
        index = index - 1  
      END
    END
OTHERWISE
END
RETURNaddCRLF�/* called from 'processSubpattern'  */
/* adds CRLF to newString  */
outString = ''
stringPart. = ''
numLines = endLine - startLine + 1
numCols = endColumn - startColumn + 1
charCount = 0
numCells = MIN(numLines * numCols, displayLimit)
numParts = numCells % 245 + 1 
DO i= startLine TO endLine
   DO j= startColumn TO endColumn
     charCount = charCount + 1  
     k = charCount % 245 + 1
     stringPart.k = stringPart.k||SUBSTR(newString, charCount, 1) 
   END
   stringPart.k = stringPart.k||CR||LF
END 
DO k = 1 FOR numParts
outString = outString||stringPart.k
END
RETURN	stripCRLF�/* called from 'reloadArray', and 'processSubpattern' */
stringLength = LENGTH(startingString)
startingString = TRANSLATE(startingString, inputTable, xlateTable) 
newString = ''
DO i = 1 FOR stringLength
  aChar = SUBSTR(startingString, i, 1)
  IF (aChar = CR) | (aChar = LF) THEN ITERATE
  newString = newString||aChar
END
RETURNprocessSubpattern�/* called from D600 ADD button (addSubpattern_Click) */
startingString = D200.patternOutput.Text()
CALL stripCRLF
/* newString is now data  */ 
lineWidth = endColumn - startColumn + 1
beginRow = insertAtRow - startLine + 1
beginColumn = insertAtCol - startColumn + 1
DO s = 1 TO numRowsInserted
  overLayPosition = ( beginRow - 1) * lineWidth + beginColumn 
  newString = OVERLAY(embedData.s, newString, overLayPosition)
  beginRow = beginRow + 1
END
newString = TRANSLATE(newString, xlateTable, inputTable)
CALL addCRLF
CALL D200.patternOutput.Text outString
CALL VAL 'patternChanged', 1
CALL subPatterns.Select 0
CALL insertAtRow.Text 0
CALL insertAtCol.Text 0
CALL rotate0.Enable
CALL rotate0.Select 1
CALL rotate90.Enable
CALL rotate180.Enable
CALL rotate270.Enable
CALL processSubpattern.Disable
CALL addSubpattern.Disable
CALL D200.Focus
RETURNgetSubpattern�/* called from D600 SELECTED button (processSubpattern_Click) */
insertAtRow = insertAtRow.Text()
insertAtCol = insertAtCol.Text()
IF insertAtRow = 0 | insertAtCol = 0 THEN
  DO
    errorText = 'The row or Column is zero.'
    rc = ModalFor('D700',, 'Messages')
    RETURN
  END
error = 0
IF insertAtRow > endLine | insertAtRow < startLine THEN
  DO
    errorText = 'The row must be between 'startLine' and 'endLine
    rc = ModalFor('D700',, 'Messages')
    error = 1
  END
IF insertAtCol > endColumn | insertAtCol < startColumn THEN
  DO
    errorText = 'The column must be between 'startcolumn' and 'endColumn
    rc = ModalFor('D700',, 'Messages')
    error = 1
  END
IF error = 1 THEN RETURN
embedData. = ''
anEmbed = subPatterns.Item(subPatterns.Select(), 'Data')
CALL getEmbedData
SELECT
  WHEN rotate0.Select() THEN NOP
  WHEN rotate90.Select() THEN CALL  rotate 90
  WHEN rotate180.Select() THEN CALL rotate 180
  WHEN rotate270.Select() THEN CALL rotate 270
OTHERWISE
END 
CALL rotate0.Disable
CALL rotate90.Disable
CALL rotate180.Disable
CALL rotate270.Disable
CALL addSubpattern.Enable
RETURN
getEmbedData�/* called from 'embeddedPatterns' & 'getSubpattern' */
  r = 1
  embedData.r = IniGet(data.r, anEmbed, embeds)
  DO UNTIL theData = ''
   r = r + 1   
   theData = IniGet(data.r, anEmbed, embeds)  
   IF theData <> '' THEN embedData.r = theData
  END
  numRowsInserted = r - 1
  numColsInserted = LENGTH(embedData.1)
RETURNresetVariablesO/* called from mainWindow global control radio button */
ruleType = ''
RETURNcombin�/* called in 'calcLambda'. Returns # of combinations: n things taken r at a time */
PROCEDURE
PARSE ARG n, r                       
SELECT
  WHEN r < 0 | n < r THEN RETURN 0
  WHEN r = n THEN RETURN 1
  WHEN r > (n - r) THEN r = n - r
OTHERWISE
END
nom = 1
DO j = n - r + 1 TO n
 nom = nom * j
END
RETURN nom / fact(r)fact�/* called in 'combin'. Returns the factorial value of ARG  */
PROCEDURE
n = ARG(1)
f = 1
DO j = 2 to n
 f = f * j
END
RETURN f

calcLambda�/* called from 'cycle' & LAMBDA pushbutton on D320 */
lambda = 0
SELECT
  WHEN gameType  = 'BINARY' THEN
    DO
      IF decimalRule < 256 THEN bitCount = 8
      ELSE
         bitCount = 32
      nq = 0 /* number of cells in quiescent state for this rule  */ 
      binRule = convertbase10(decimalRule, 2, 0)
      DO m = 1 TO bitCount
        IF SUBSTR(binRule, m, 1) = 0 THEN nq = nq + 1
      END
      N = POW(state, activeCells + 1)
      lambda = FORMAT((N - nq)/ N, 1, 4)
    END
  WHEN gameType = 'LIFE' | gameType = 'GENERATIONS' THEN
    DO
      nActive = 0
      DO m = 1 TO 9 /* activeCells calculated in getNeighbors  */
        IF sCnt.m <> '' THEN nActive = nActive + combin(activeCells, sCnt.m)
        IF bCnt.m <> '' THEN nActive = nActive + combin(activeCells, bCnt.m)
     END
    /* total # transitions possible = #states raised to # neighbors + 1 power */ 
    N = POW(state, activeCells + 1)
    lambda = FORMAT(nActive / N, 1, 4)
    END
OTHERWISE
  lambda = 'N/A'
END
RETURNreloadArray�/* called from 'startExecution', 'pauseExecution', and 'generate' */
/* startingString is set by  select of pattern     */
/* and/or entered from keyboard                    */
IF VAL('inCycle') = 1 THEN
  DO
   CALL NOTIFY 'D200', 'getText'
   CALL sleep VAL('stringWaitTime')
   startingString = VAL('changedText')
  END
ELSE
  startingString = D200.patternOutput.Text()
CALL stripCRLF
DROP startingString
CALL loadArray newString 
CALL VAL 'patternChanged', 0 
rc = CVWRITE(cellCVfile, 'A.')
IF gameType = 'SELF REPLICATING' THEN rc = CVWRITE(srcaCVfile, 'srca.')
RETURN
loadEmbeds�/* called from 'configOptions' and menu to apply edit changes */
rc = IniEnumSections(embedSections., embeds) 
DO i = 1 TO embedSections.0
  embedTitle.i = IniGet('title', embedSections.i, embeds)
END
IF VAL('inCycle') = 1 THEN RETURN
frameSize = D600.Frame()
IF frameSize = '0 0 0 0' THEN RETURN
CALL D600.subPatterns.Delete
DO i = 1 to embedSections.0
  CALL D600.subPatterns.Add embedTitle.i ,"L", embedSections.i
END
RETURNembeddedPatterns�/* called from 'loadArray' */
DO m = 1 TO numEmbeds
  PARSE VAR embed.m tag ',' tag2 ','beginRow ',' beginCol
  anEmbed = 'EMBED.'tag||tag2
  CALL getEmbedData
  endRow = beginRow + numRowsInserted -1
  IF endRow > cellsVert THEN endRow = cellsVert
  endCol = beginCol + numColsInserted -1
  if endCol > cellsHoriz THEN endCol = cellsHoriz
  DO i = beginRow TO endRow
    embedDataRow = i - beginRow + 1 
    DO j = beginCol TO endCol
      embedDataCol = j - beginCol + 1
      A.i.j = SUBSTR(embedData.embedDataRow, embedDataCol, 1)
      IF A.i.j > 0 THEN pop = pop + 1
   END /* j  */
  END /* i  */
END /* numEmbed  */
RETURN
readThread�/* called from 'snapshot' */
PARSE ARG cellCVfile gifFile cellsHoriz cellsVert '#' colorText '#' colorBackgnd
rc = CVREAD(cellCVfile, 'A.')
CALL loadGIFfromArray gifFile
CALL NOTIFY 'D600', 'gifCreated', gifFile
RETURN
waitThread�/* called from 'snapshot' */
window = ARG(1)
indicator = ''
DO FOREVER
  IF VAL('ended') = 1 | VAL('endWait') = 1 THEN LEAVE
  indicator = indicator'*'
  IF LENGTH(indicator) > 30 THEN indicator = '*'
  CALL NOTIFY window, 'waiting', indicator
  CALL SLEEP 500
END
RETURNsyncVars�	/* called from D200 NOTIFY event. Updates main thread from cycle thread vars */ 
syncVars = 1
rc = VARREAD(cycleVars, 'I')
CALL setSliders
CALL VAL 'outString', ''
CALL D200.patternOutput.Font fontName.selectedFont
CALL D200.numStates.Text state
CALL D200.neighborhood.Text nbhTitle
CALL D200.caType.Text caType
CALL D200.lambdaValue.Text lambda
CALL D200.patternOutput.Font fontName.selectedFont
CALL mainWindow.Fonts.Select selectedFont
CALL mainWindow.initialConditions.Select patNum
DO i = 1 TO numRules
 IF ruleType = ruleValue.i THEN 
   DO
     CALL ruleUsed.Text ruleTitle.i
     CALL mainWindow.rules.Select i 
   END
END
CALL D200.patternTitle.Delete 
DO k = 1 TO numComments
  CALL D200.patternTitle.Add commentData.k, 'L'
END
CALL D200.patterntitle.Text commentData.1
CALL D200.xValue.Text formatNum(cellsHoriz)
CALL D200.yValue.Text formatNum(cellsVert)
IF SUBSTR(ruleType, 1, 1) = 'D' THEN CALL D200.numCells.Text formatNum(cellsHoriz)
ELSE
 CALL D200.numCells.Text formatNum(cellsHoriz * cellsVert)
CALL VAL 'ended', 0
CALL D200.eTimeValue.Text ''
CALL D200.cellsPer.Text ''
CALL D200.genPerSec.Text ''
RETURNcreateSyncVars�/* called in 'cycle' after restoring all thread vars from a cpFile */
/* used when activating a checkpoint  */ 
/* save selected vars to update main thread with syncVars routine */
rc = DOSDEL(cycleVars)
rc = VARWRITE(cycleVars, 'I', 'cellsVert', 'cellsHoriz', 'cellCVfile', 'ruleType', 'xlateTable', 'nbhType', 'neighbors', 'largePattern', 'pop', 'displayLimit', 'ruleQueue', 'embeds', 'inputTable', 'srcaCVfile', 'T.', 'totalCells', 'activeCells') 
rc = VARWRITE(cycleVars, 'I', 'gameType', 'radius', 'state', 'threshold', 'ghSwitch', 'selectedFont', 'nbhTitle', 'caType', 'lambda', 'numComments', 'commentData.')
IF bpCyclicRule = 1 THEN
  DO 
    CALL VAL 'criteria', activeCriteria
    CALL VAL 'cyclicRule', bpCyclicRule   
    DO WHILE QUEUED() > 0
      PULL
    END
    DO k = 1 to numQueued
      QUEUE queueRule.k
    END
  END
CALL NOTIFY 'D200', 'sync'
RETURNgetCPFileName�/* CALLED from D500 SAVE button (addCheckpoint_Click) to get a new checkpoint number */
/* and create a cpFile name    */
cpNum = IniGet('nextCPNum', 'General', cfgFile) 
cpNum = RIGHT(cpNum, 3, '0')
cpFile = cpFilesDir'\chkpt'||cpNum||'.dat'
nextCpNum = cpNum + 1
IF nextCpNum = 1000 THEN rc = IniSet('nextCPNum', 001, 'General', cfgFile)
ELSE
  rc = IniSet('nextCPNum', nextCpNum, 'General', cfgFile)
RETURNloadCheckPoints�/* called from init event of D500 checkPoints listbox, and apply Config menu option */
frameSize = D500.Frame()
IF frameSize = '0 0 0 0' THEN RETURN
CALL checkPoints.Delete
rc = IniEnumSections(bpSections., checkPointFile)
DO i = 1 TO bpSections.0
  bpName.i = IniGet('bpDescription', bpSections.i, checkPointFile)
  bpFile.i = IniGet('bpFileSpec', bpSections.i, checkPointFile)
  IF bpName.i <> '' THEN CALL checkPoints.Add bpName.i ,"L", bpFile.i
END
numBreakPoints = bpSections.0
RETURN	soundBeep//* called from D700 open */
CALL sound 200, .5
checkPoint�/* called from mainWindow 'CP/RS' button (checkpoint_Click) to save, activate, or delete checkpoints */
syncVars = 1
IF startThreadTID = 0 THEN
  DO
    IF initialConditions.Select() = 0 THEN CALL selectPattern 4
    CALL startExecution
    CALL pauseExecution
    parms = modalFor('D500',, 'Checkpoint/Restart')
  END
ELSE
/* 'cycle' thread is active */
  IF gameType = 'BINARY' THEN
   DO
    errorText = 'Binary rules and Checkpoint/Restart are incompatible features.'
    CALL stopExecution
    rc = ModalFor('D700',, 'Messages')
    CALL resetText
    CALL resetButtons
    CALL adjustView.Select 0 
   END 
  ELSE
  parms = modalFor('D500',, 'Checkpoint/Restart')
RETURN
editParmW/* called in 'selectPattern' */
parm = ARG(1)
IF parm = '' THEN parm = 0
RETURN parm
getPattern�	/* called from selectPattern to get location of pattern data */
commentData. = ''
patternData. = ''
patLocation  = TRANSLATE(IniGet('patternFrom', section, patterns))
IF ovrRideNeighbor = '' THEN ovrRideNeighbor = TRANSLATE(IniGet('altNeighbor', section, patterns))
SELECT
    WHEN patLocation = 'KEYBOARD' THEN IF ovrRideNeighbor <> '' THEN nbhType = ovrRideNeighbor   
    WHEN patLocation = 'PROMPT' THEN 
        DO
          CALL selectRule ruleUsed
          CALL getFileData patLocation
          IF RESULT = 1 THEN RETURN 1
          IF patFile = '' THEN 
            DO
              CALL initialConditions.Select 0
              RETURN 1
            END 
        END
    WHEN patLocation = 'HERE' THEN
        DO
          IF ovrRideNeighbor <> '' THEN nbhType = ovrRideNeighbor
          i = 1
          patternData.i = IniGet(patData.i, section, patterns)
          DO UNTIL patternData.i = ''
            i = i + 1
            patternData.i = IniGet(patData.i, section, patterns)
          END
        END
    OTHERWISE
    DO 
     /* patLocation is a file name */
     CALL getFileData  patternDir'\'patLocation
     IF RESULT = 1 THEN RETURN 1
    END
END
RETURN
ovrVertCells�/* called from 'selectPattern' */
SELECT
  WHEN vertCells.Select() = 1 THEN cellsVert = 24
  WHEN vertCells.Select() = 2 THEN cellsVert = 50
  WHEN vertCells.Select() = 3 THEN cellsVert = 100
  WHEN vertCells.Select() = 4 THEN cellsVert = 200
  WHEN vertCells.Select() = 5 THEN cellsVert = 300
  WHEN vertCells.Select() = 6 THEN cellsVert = 400
  WHEN vertCells.Select() = 7 THEN cellsVert = 500
  WHEN vertCells.Select() = 8 THEN cellsVert = 600
  WHEN vertCells.Select() = 9 THEN cellsVert = 700
  WHEN vertCells.Select() = 10 THEN cellsVert = 800
  WHEN vertCells.Select() = 11 THEN cellsVert = 900
  WHEN vertCells.Select() = 12 THEN cellsVert = 1000
OTHERWISE
END
RETURNovrHorizCells�/* called from 'selectPattern' */
SELECT
 WHEN horizCells.Select() = 1 THEN cellsHoriz = 24 
 WHEN horizCells.Select() = 2 THEN cellsHoriz = 50
 WHEN horizCells.Select() = 3 THEN cellsHoriz = 100
 WHEN horizCells.Select() = 4 THEN cellsHoriz = 200
 WHEN horizCells.Select() = 5 THEN cellsHoriz = 300
 WHEN horizCells.Select() = 6 THEN cellsHoriz = 400
 WHEN horizCells.Select() = 7 THEN cellsHoriz = 500
 WHEN horizCells.Select() = 8 THEN cellsHoriz = 600
 WHEN horizCells.Select() = 9 THEN cellsHoriz = 700
 WHEN horizCells.Select() = 10 THEN cellsHoriz = 800
 WHEN horizCells.Select() = 11 THEN cellsHoriz = 900
 WHEN horizCells.Select() = 12 THEN cellsHoriz = 1000
OTHERWISE
END
RETURNgc�/* called from interpret of 'criteria' to determine next section of cyclic criteria */ 
/* to be inspected. Then activate (or not) the rule queue  */
criteriaPart = ARG(1)
cycle = 1
RETURNupdateCriteria�/* called from D800 enter key in combo box (changeCriteria_Enter) */
IF index = 'INDEX' | index = 0 THEN    /* add the item   */
  DO
    changeOnData = changeCriteria.Text()
    IF changeOnData = '' THEN RETURN
    i = 1
    DO UNTIL changeCriteria.i = ''
      i = i + 1
    END
    index = i  /* first blank variable is also first empty 'CONDITION.x'  */
    conditionNum = 'CONDITION.'index
    CALL changeCriteria.Add changeOnData, 'L', conditionNum
    numChangeCriteria = numChangeCriteria + 1
    changeCriteria.index = changeOnData
    CALL IniSet 'switch', changeOnData, conditionNum, switchRules 
    CALL changeCriteria.Text ''
    index = 0
    CALL VAL 'criteria', changeOnData
    CALL currentCriteria.Text changeOnData
    CALL loadChangeCriteria
  END
ELSE /* index > 0  change or delete the item */
  DO
   changeOnData = changeCriteria.Text()
   IF changeOnData = '' THEN /* delete existing item  */
     DO
       conditionNum = changeCriteria.Item(index, 'Data')
       CALL changeCriteria.Delete index
       CALL IniDel 'switch', conditionNum, switchRules
       DROP changeCriteria.index
       numChangeCriteria = numChangeCriteria - 1
       CALL currentCriteria.Text ''
       CALL VAL 'criteria', ''
       CALL changeCriteria.Select 0
     END
   ELSE /* change existing item  */
     DO
      CALL changeCriteria.Item index, 'Value', changeOnData
      conditionNum = changeCriteria.Item(index, 'Data')
      CALL IniSet 'switch', changeOnData, conditionNum, switchRules 
      CALL changeCriteria.Text ''
      CALL currentCriteria.Text changeOnData
      changeCriteria.index = changeOnData
      CALL VAL 'criteria', changeOnData
      CALL changeCriteria.Select 0
      index = 0
     END
  END
RETURNloadChangeCriteria�/* called from D800 changeCriteria listbox (changeCriteria_Init) & apply edit changes menu click */
frameSize = D800.Frame()
IF frameSize = '0 0 0 0' THEN RETURN
CALL D800.changeCriteria.Delete
rc = IniEnumSections(criteriaSections., switchRules)
DO i = 1 TO criteriaSections.0
 changeCriteria.i = IniGet('switch', criteriaSections.i, switchRules)
 IF changeCriteria.i <> '' THEN CALL D800.changeCriteria.Add changeCriteria.i , "L", 'CONDITION.'i
END
numChangeCriteria = criteriaSections.0
RETURNreIndex�/* called from D800 UP, DOWN, and DELETE buttons ex. (deleteItem_Click) */
numItems = selectedRules.Item()
DO i = 1 TO numItems
  itemDesc = selectedRules.Item(i, 'Value')
  position = POS('. ', itemDesc, 1)
  newDesc = i||'.'||SUBSTR(itemDesc, position+1)
  CALL selectedRules.Item i, 'Value', newDesc
END
RETURNqueueCyclicRules�/* called from D800 load cyclic rules button (loadQueue_Click) & mainWindow STOP button (stop_Click) */
numSelected = D800.selectedRules.Item()
IF numSelected > 0 THEN
  DO
    CALL VAL 'cyclicRule', 0
    /* clear the queue */
    DO WHILE QUEUED() > 0
      PULL
    END
    DO i =1 to numSelected
      queueItem = D800.selectedRules.Item(i, 'Data')
      /* add rule to end of queue */
      QUEUE queueItem
    END
    CALL VAL 'cyclicRule', 1
  END
RETURN
changeRule�/* called from 'setupExecution' and 'generate' */
/* pull new ruleType from front of ruleQueue  */
IF QUEUED() > 0 THEN
  DO
    /* get rule from front of queue */
    PULL ruleType
    /* put the rule back on the end of queue */
    QUEUE ruleType
    CALL NOTIFY 'D200', 'rule', ruleType
    CALL decodeLifeRule
  END
cycle = 0
RETURNloadExistingRules�/* called from D800 existingRules listbox (existingRules_Init) & menu to apply edit changes */
frameSize = D800.Frame()
IF frameSize = '0 0 0 0' THEN RETURN
CALL D800.existingRules.Delete
DO i = 1 to numRules
  IF SUBSTR(ruleValue.i, 1, 1) = 'S' THEN
    DO
      PARSE VAR ruleValue.i 'S' . '/B' . '/' ruleState
      IF ruleState = 2 THEN 
        CALL D800.existingRules.Add ruleTitle.i' = 'ruleValue.i,"L", ruleValue.i
    END
END
RETURNsnapshot�/* called from D600 snapshot button (snapshot_Click) */
IF mainWindow.initialConditions.Select() = 0 THEN
  DO
    errorText = 'Select pattern to be used.'
    rc = modalFor('D700',, 'Messages')
    RETURN
  END
CALL VAL 'saveArray', 1
IF VAL('pauseStarted') = 0 & VAL('inCycle') = 1 THEN CALL pauseExecution
IF VAL('pauseStarted') = 0 & VAL('inCycle') = 0 THEN
  DO
    errorText = 'Pattern must be started before a snapshot is taken.'
    rc = modalFor('D700',, 'Messages')
    RETURN
  END
IF VAL('pauseStarted') = 1 THEN CALL stepExecution
CALL D600.Focus 
DO UNTIL VAL('saveArray') = 0
  CALL SLEEP 100
END
gifFile = graphicsDir'temp.gif'
rc = DOSDEL(gifFile)
windowName = 'D600' 
CALL VAL 'endWait', 0
waitThreadTID = START('waitThread', windowName)
readThreadTID = START('readThread', cellCVfile gifFile cellsHoriz cellsVert colorText colorBackgnd)
CALL D600.Focus
RETURNloadGIFfromArray�/* called from 'readThread' */
gifName = ARG(1)
im = RxgdImageCreate(cellsHoriz, cellsVert)
PARSE VAR colorBackGnd rr gg bb  
backColor  = RxgdImageColorAllocate(im, rr, gg, bb) 
PARSE VAR colorText rr gg bb 
textcolor   = RxgdImageColorAllocate(im, rr, gg, bb)
rc = RxgdImageFill(im, 0, 0, backColor)  
DO i = 1 to cellsVert      
  DO j = 1 to cellsHoriz     
    IF A.i.j >= 1 THEN CALL RxgdImageSetPixel im, j-1 , i-1 , textColor
  END /* j */
END /* i */
rc = RxgdImageGIF(im, gifName)
rc = RxgdImageDestroy(im)
RETURNxlateSection�/* called from D600 MARK button (getData_Click) */
PROCEDURE EXPOSE cellsHoriz cellsVert
PARSE ARG dimension , num
IF dimension = 'horiz' THEN
      xlated = MAX(FORMAT(num / 500 * cellsHoriz, 4, 0), 1)  
ELSE
xlated = MAX(FORMAT((500 - num) / 500 * cellsVert, 4, 0), 1)  
RETURN xlatedloadGIF�/* called from saveGif */
gifName = ARG(1)
width = cellsHoriz 
height = cellsVert  
im = RxgdImageCreate(width, height)
PARSE VAR colorBackGnd '#' rr gg bb  
backColor  = RxgdImageColorAllocate(im, rr, gg, bb)
PARSE VAR colorText '#' rr gg bb 
textcolor   = RxgdImageColorAllocate(im, rr, gg, bb)
rc = RxgdImageFill(im, 0, 0, backColor)
data = VAL('outStr') 
count = 0
DO i = 1 to height      
  DO j = 1 to width + 2     
    count = count + 1 
    aChar = SUBSTR(data, count, 1)
    IF aChar = CR | aChar = LF THEN ITERATE  
    IF aChar >= 1 THEN CALL RxgdImageSetPixel im, j-1 , i-1 , textColor
  END /* j */
END /* i */
  rc = RxgdImageGIF(im, gifName)
  rc = RxgdImageDestroy(im)
RETURN	applyView�/* called from D600 APPLY button (applyView_Click)  */
IF D600.firstLine.Text() = '' THEN RETURN
CALL D600.getData.Disable
CALL D600.applyView.Disable
CALL VAL 'partialDisplay', 1
CALL VAL 'strLine', D600.firstLine.Text()
CALL VAL 'enLine', D600.lastLine.text()
CALL VAL 'strCol', D600.firstColumn.text()
CALL VAL 'enCol', D600.lastColumn.text()
CALL D600.viewblock.text ''
CALL D600.c607.text "#E 0"
IF VAL('pauseStarted') = 1 & startThreadTID > 0 THEN CALL pauseExecution
ELSE
IF startThreadTID = 0 THEN
  DO
   CALL startExecution
   CALL pauseExecution
  END
CALL D200.Focus
RETURN
selectView�/* called by mainWindow check box (adjustView_Click) */
CALL D600.Open "", 'Select Section/Embeds'
CALL D600.Focus
startColumn = VAL('strCol')
endColumn   = VAL('enCol')
startLine   = VAL('strLine')
endLine     = VAL('enLine')
CALL D600.firstLine.Text startLine
CALL D600.lastLine.text endLine
CALL D600.numLinesSelected.Text endLine - startLine + 1
CALL D600.firstColumn.text startColumn
CALL D600.lastColumn.text endColumn
CALL D600.numColumnsSelected.Text endColumn - startColumn + 1
CALL D600.snapShot.Enable
CALL D600.getData.Disable
CALL D600.applyView.Disable
RETURN
checkLimit�/* called from getFileData */
IF rounded(patWidth) * rounded(patHeight) > displayLimit THEN largePattern = 1
ELSE largePattern = 0
RETURNparseLife105�/* called from getFileData. For life 1.05 format files */
gameType = 'LIFE'
minColumn = 999 ; patWidthInFile = -999
minRow = 999 ; patHeightInFile = -999
s = 0  /* count of cellGroups in LIFE 1.05 file  */
t = 0  /* count of cell data lines in a group  */
numComments = 0
DO UNTIL dataLine = ''
   oneChar = SUBSTR(dataLine, 1, 1)
   twoChar = SUBSTR(dataLine, 1, 2)
   IF twoChar = '#C' | twoChar = '#D' THEN CALL setComment
   IF twoChar = '#N' THEN
     DO
       ruleType = 'S23/B3/2'
       nbhType = 'M8' 
     END
   IF twoChar = '#R' THEN 
     DO
       PARSE VAR dataLine '#R' leftPart '/' rightPart '/' state
       IF state = '' THEN state = 2
       leftPart =  STRIP(leftPart, 'L')||'/'
       ruleType = leftPart||rightPart||'/'||state
       IF POS(9, ruleType) > 0 THEN nbhType = 'M9' 
       ELSE
          nbhType = 'M8'
     END
   CALL getRuleData
   IF twoChar = '#P' THEN
        DO
          s = s + 1
          t = 0  /* count of cellData lines in this group */
          PARSE VAR dataLine '#P' aColumnOffset aRowOffset
          minColumn = MIN(minColumn, aColumnOffset)
          minRow =    MIN(minRow, aRowOffset)
          cellGroup.s.colOffset = aColumnOffset
          cellGroup.s.rowOffset = aRowOffset
        END 
   /* if no groups defined in file, then create one  */ 
   IF (s = 0 & oneChar = '*') | (s = 0 & oneChar = '.') THEN
     DO
     s = s + 1
     minColumn = MIN(minColumn, -5)
     minRow =    MIN(minRow, -5)
     cellGroup.s.colOffset = -5
     cellGroup.s.rowOffset = -5
     END
   IF oneChar <> '#' & oneChar <> '' THEN
        DO
          t = t + 1  /* number of data rows  */
          cellGroup.s.cellData.t = TRANSLATE(STRIP(dataLine, 'T'), '01', '.*')
          cellGroup.s.cellData.t.cellLength = LENGTH(cellGroup.s.cellData.t) 
          cellGroup.s.numCellDataLines = t
        END
   dataLine = STRIP(LINEIN(patFile,, 1), 'L')
END /* DO UNTIL  */
numCellGroups = s
/*                                                             */
/* translate offset coordinates to row and column (i,j) format */
/* and find pattern width and height                           */
DO s = 1 TO numCellGroups
   IF minRow >= 0 THEN cellGroup.s.rowOffset = cellGroup.s.rowOffset - minRow + 1
   IF minRow <  0 THEN cellGroup.s.rowOffset = STRIP(minRow, 'L', '-') - STRIP(cellGroup.s.rowOffset, 'L', '-') + 1
   IF minColumn <  0 THEN cellGroup.s.colOffset = cellGroup.s.colOffset + STRIP(minColumn, 'L', '-') + 1
   IF minColumn >= 0 THEN cellGroup.s.colOffset = cellGroup.s.colOffset - minColumn + 1
   DO t = 1 TO cellGroup.s.numCellDataLines
      patWidthInFile = MAX(patWidthInFile, cellGroup.s.colOffset + cellGroup.s.cellData.t.cellLength)
      patHeightInFile = MAX(patHeightInFile, cellGroup.s.rowOffset + cellGroup.s.numCellDataLines)
   END
END
DO i = 1 TO patHeightInfile
   DO j = 1 TO patWidthInFile
      A.i.j = 0
   END
END
/* merge cellGroups into array    */
DO s = 1 TO numCellGroups
   i = cellGroup.s.rowOffset
   j = cellGroup.s.colOffset
   DO t = 1 TO cellGroup.s.numCellDataLines
      DO charPosition = 1 TO cellGroup.s.cellData.t.cellLength       
         A.i.j = SUBSTR(cellGroup.s.cellData.t, charPosition, 1)
         j = j + 1 
      END   
   i = i + 1
   j = cellGroup.s.colOffset
   END
END
/* load patternData.k        */
DO i = 1 TO patHeightInFile
   DO j = 1 TO patWidthInFile
      patternData.k = patternData.k||A.i.j
   END 
   k = k + 1
END
numLines = k - 1
patWidth = MAX(patWidthInFile, patWidth)
patHeight = MAX(patHeightInFile, patHeight) 
RETURN
parseCellData�/* called from 'parseRandom' & 'parseAscii' */
repeatCount = 0
IF POS('*', dataLine) = 0 & POS('.', dataLine) = 0 THEN
   DO charCount = 1 to LENGTH(dataLine)
       aChar = SUBSTR(dataLine, charCount,1)
       SELECT
           /* RLE format: determine repeat count  */
         WHEN aChar >=0 & aChar <= 9 THEN 
           DO
             repeatCount = aChar
             aChar = SUBSTR(dataLine,charCount+1,1)
             IF aChar >=0 & aChar <= 9 THEN 
               DO
                 repeatCount = repeatCount * 10 + aChar
                 charCount = charCount + 1
                 aChar = SUBSTR(dataLine,charCount+1,1)
                 IF aChar >=0 & aChar <= 9 THEN 
                   DO
                    repeatCount = repeatCount * 10 + aChar
                    charCount = charCount + 1
                   END
               END
           END
              /* RLE format: add a zero for a 'b' character (dead cell)    */
         WHEN aChar = 'b' & repeatCount = 0 THEN patternData.k = patternData.k||'0' 
         WHEN aChar = 'b' & repeatCount > 0 THEN
           DO
             patternData.k = patternData.k||COPIES('0',repeatCount) 
             repeatCount = 0
           END
              /* RLE format: add a 1 for a character 'o' (live cell) */
         WHEN aChar = 'o' & repeatCount = 0 THEN patternData.k = patternData.k||'1' 
         WHEN aChar = 'o' & repeatCount > 0 THEN
           DO
             patternData.k = patternData.k||COPIES('1',repeatCount) 
             repeatCount = 0
           END 
              /* RLE format: '$' character is a new line  */
         WHEN aChar = '$' & repeatCount = 0 THEN 
           DO
             k = k +1
             /* handle a second '$' character  */
             aChar = SUBSTR(dataLine,charCount+1,1)
             IF aChar = '$' THEN
               DO
                 patternData.k ='0'
                 charCount = charCount + 1
                 k = k + 1
               END  
           END 
         WHEN aChar = '$' & repeatCount > 0 THEN 
           DO
             k = k + 1
             DO repeatCount - 1 
               patternData.k ='000' /* insert a row of zeros  */
               k = k + 1
             END
             repeatCount = 0
           END
              /* RLE format: '!' character is EOF   */
         WHEN aChar = '!' | aChar = ' ' THEN RETURN   
       OTHERWISE
       END /* select  */
   END /* do for decode RLE format */
ELSE
   /* plain ASCII format   */
  DO
   asciiFormat = 1
   DO charCount = 1 to LENGTH(dataLine)
     aChar = SUBSTR(dataLine, charCount,1)
     SELECT
       WHEN aChar = '.' THEN patternData.k = patternData.k||'0'
       WHEN aChar = '*' THEN patternData.k = patternData.k||'1'
     OTHERWISE
       patternData.k = patternData.k||aChar
     END /* select */
   END /* end DO for decode ascii data  */
  END /* do for ELSE  */
IF asciiFormat = 1 THEN   k = k + 1  
RETURN

setComment�/* called from 'parseLife105' & 'parseMCell' */
IF LENGTH(STRIP(SUBSTR(dataLine, 2),'T')) > 2 THEN 
  DO
    numComments = numComments + 1
    commentData.numcomments = SUBSTR(dataLine, 3)
  END
RETURNrounded�/* called from 'checkLimit' to round up to horiz or vert value */
PROCEDURE
aNum = ARG(1)
SELECT
  WHEN aNum > 900 THEN aNum = 1000
  WHEN aNum > 800 THEN aNum = 900
  WHEN aNum > 700 THEN aNum = 800
  WHEN aNum > 600 THEN aNum = 700
  WHEN aNum > 500 THEN aNum = 600
  WHEN aNum > 400 THEN aNum = 500
  WHEN aNum > 300 THEN aNum = 400
  WHEN aNum > 200 THEN aNum = 300
  WHEN aNum > 100 THEN aNum = 200
  WHEN aNum > 50  THEN aNum = 100
  WHEN aNum > 24  THEN aNum = 50
  WHEN aNum > 0   THEN aNum = 24
OTHERWISE
END
RETURN aNum
randomData�/* called from mainWindow FILE menu */
CALL initialConditions.Disable
parms = modalFor('D900',, 'Random.lif parameters')
IF parms = 1 THEN 
  DO
    /* cancel taken  */
    CALL initialConditions.Enable
    RETURN
  END
PARSE VAR parms cellsHoriz cellsVert decimalState decimalDensity oldRule randFile gameType nbhType nbhTitle
astPosition = ''
DO UNTIL astPosition = 0
  astposition = POS('*', gameType)
  IF astPosition > 0 THEN gameType = OVERLAY(' ', gameType, astPosition) 
END
astPosition = ''
DO UNTIL astPosition = 0
  astposition = POS('*', nbhtitle)
  IF astPosition > 0 THEN nbhTitle = OVERLAY(' ', nbhTitle, astPosition) 
END
IF SUBSTR(oldRule, 1, 1) = 'S' THEN
  DO
    PARSE VAR oldRule sPart '/' bPart '/' .
    rule = sPart||'/'||bPart||'/'||decimalState
  END
ELSE
  rule = oldRule
rc = DOSDEL(randFile)
maxCharacters = cellsVert * cellsHoriz
densityPercent = decimalDensity / 100
step1 = 0; step2 = 0; step3 = 0; step4 = 0; step5 = 0
density = 0
nonZeros = 0
numCycles = 0
baseValue = COPIES(0, maxCharacters)
DO UNTIL density >= densityPercent
  numCycles = numCycles + 1
  IF numcycles // 50 = 0 THEN  CALL SLEEP 1
  randomDecimal = RANDOM(0, decimalState - 1)
  IF decimalState < 11 THEN  newDigit  = randomDecimal
  ELSE
   newDigit = numToChar(randomDecimal)
   IF gameType = 'BINARY' THEN overlayPosition = RANDOM(1, cellsHoriz - 1)
   ELSE
     overlayPosition = RANDOM(1, maxCharacters - 1) 
  oldDigit = SUBSTR(baseValue, overlayPosition, 1)
  IF oldDigit <> 0 THEN ITERATE
  baseValue = OVERLAY(newDigit, baseValue, overlayPosition)
  IF newDigit <> 0 THEN  nonZeros = nonZeros + 1
  IF gameType = 'BINARY' THEN density = nonZeros / cellsHoriz
  ELSE
    density = nonZeros / maxCharacters
  SELECT
      WHEN (density >= densityPercent/ 5) & step1 = 0 THEN
         DO
          CALL setPercentBar 20     
          step1 = 1
         END
      WHEN (density >= 2 * densityPercent/ 5) & step2 = 0 THEN
         DO
          CALL setPercentBar 40     
          step2 = 1
         END
      WHEN (density >= 3 * densityPercent/ 5) & step3 = 0 THEN
         DO
          CALL setPercentBar 60     
          step3 = 1
         END
      WHEN (density >= 4 * densityPercent/ 5) & step4 = 0 THEN
         DO
          CALL setPercentBar 80     
          step4 = 1
         END
      WHEN (density >= densityPercent) & step5 = 0 THEN
         DO
          CALL setPercentBar 100     
          step5 = 1
         END
  OTHERWISE
  END
END
baseValue = TRANSLATE(baseValue, '.*23456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', inputTable) 
rc = STREAM(randfile, 'C', 'OPEN WRITE')
rc = LINEOUT(randFile, '#Random')
rc = LINEOUT(randFile, '#C Pattern generated randomly') 
rc = LINEOUT(randFile, '#C Game: 'gameType)
rc = LINEOUT(randFile, '#C Neighborhood: 'nbhTitle)
rc = LINEOUT(randFile, '#C Rule: 'rule)
rc = LINEOUT(randFile, '#C Density: 'decimalDensity'%')
rc = LINEOUT(randFile, '#Game = 'gameType)
rc = LINEOUT(randFile, '#NbrHood = 'nbhType)
rc = LINEOUT(randFile, 'x = 'cellsHoriz', y = 'cellsVert', rule = 'rule) 
position = 1
dataLength = cellsHoriz
DO i = 1 TO cellsVert 
  data = SUBSTR(baseValue, position, dataLength)
  rc = LINEOUT(randFile, data)
  position = (dataLength * i) + 1
  IF TRANSLATE(gameType) = 'BINARY' THEN LEAVE
END
rc = LINEOUT(randFile)
CALL initialConditions.Enable
CALL setPercentBar 0
DROP baseValue maxLength totalChars nonZeros
RETURNsetPercentBar�/* called from  'randomData', 'loadArray', 'pauseExecution', 'selectPattern' & mainWindow NOTIFY event */
percent=ARG(1)
IF VAL('inCycle') = 1 THEN CALL NOTIFY mainWindow, 'percentDone', percent
ELSE
CALL mainWindow.loadPercent.Text percent||'#'percent||' %' 
RETURNgetWindowColors�/* called from 'configOptions' */
windowColor = IniGet('winColor', 'Window', cfgFile)
startColor = IniGet('startBtnColor', 'Window', cfgFile)
clearColor = IniGet('clearBtnColor', 'Window', cfgFile)
stepColor = IniGet('stepBtnColor', 'Window', cfgFile)
pauseColor = IniGet('pauseBtnColor', 'Window', cfgFile)
stopColor = IniGet('stopBtnColor', 'Window', cfgFile)
checkPointColor = IniGet('chkPointBtnColor', 'Window', cfgFile)
closeRandomColor = IniGet('closeRandomBtnColor', 'Window', cfgFile)
cancelCreateRandomColor = IniGet('cancelCreateRandomBtnColor', 'Window', cfgFile)
colorText = IniGet('textColor', 'Window', cfgFile)
colorBackgnd = IniGet('backGndColor', 'Window', cfgFile)
disabledColor = IniGet('disabledControlColor', 'Window', cfgFile)
patternColor = IniGet('patternListBox', 'Window', cfgFile)
patternTitleColor = IniGet('patternTitle', 'Window', cfgFile)
ruleColor = IniGet('ruleListBox', 'Window', cfgFile)
fontColor = IniGet('fontListBox', 'Window', cfgFile)
percentBar = IniGet('percentBarColor', 'Window', cfgFile)
RETURNviewGraphics�/* called by mainWindow VIEW menu option */
graphicsName = FilePrompt(graphicsDir'\*.*', 'Name of image', 'OK', 'Open')
IF graphicsName = '' THEN RETURN
IF imageView = 'INTERNAL' THEN
 DO 
   CALL D400.Open ,"View Pattern Graphics File"
   CALL D400.gifFile.Text TRANSLATE(graphicsName)
   CALL D400.c401.text graphicsName
 END
ELSE
'START /F /PGM 'imageView """"graphicsName""
RETURNsaveGIF�/* called from mainWindow FILE menu option. */
/* save and convert pattern to GIF format     */
CALL USE 'step1', 1
CALL USE 'step2', 1
CALL stopExecution
CALL USE 'step1', 0
CALL loadingText.text 'Wait'
CALL loadPercent.Color '-', '#255 255 0'
CALL loadPercent.Text '100# '
gifName = FilePrompt(graphicsDir'\*.gif', 'Save Pattern to ?.GIF', 'OK', 'Save')
IF gifName = '' THEN RETURN
rc = CVREAD(cellCVfile, 'A.')
CALL loadGif gifName
CALL USE 'step2', 0
CALL loadingText.text 'Calc %'
CALL loadPercent.Color '-', percentBar
CALL loadPercent.Text '0'||'#'0||' %'
RETURN	loadFonts�/* called from mainWindow init event of Fonts listbox (fonts_Init), and apply Config menu option */
CALL fonts.Delete
numFonts = 0
rc = IniEnumSections(fontSections., cfgFile)
DO i = 1 TO fontSections.0
  IF SUBSTR(fontSections.i,1,4) = 'FONT' THEN
   DO
    numFonts = numFonts + 1
    fontTitle.numFonts = IniGet('TITLE', fontSections.i, cfgFile)
    fontName.numFonts = IniGet('outFont', fontSections.i, cfgFile)
   END
END
DO i = 1 to numFonts
CALL fonts.Add fontTitle.i,"L"
END
RETURN	loadRules�/* called from mainWindow rule listbox (rules_Init) and menu option to apply config */
CALL rules.Delete
numRules = 0
rc = IniEnumSections(ruleSections., rules)
DO i = 1 TO ruleSections.0
  ruleTitle.i = IniGet('TITLE', ruleSections.i, rules)
  ruleValue.i = IniGet('ruleValue', ruleSections.i, rules)
  IF ruleTitle.i <> '' THEN 
   DO
     CALL rules.Add ruleTitle.i,"L", ruleValue.i
     numRules = numRules + 1
   END
END
RETURNloadPatterns�/* called from mainWindow listbox (initialConditions_Init) and from menu to apply config */
CALL initialConditions.Delete
rc = IniEnumSections(patternSections., patterns)
DO i = 1 TO patternSections.0
  patTitle.i = IniGet('TITLE', patternSections.i, patterns)
  IF patTitle.i <> '' THEN CALL initialConditions.Add patTitle.i,"L", patternSections.i
END
RETURN	enterRulep/* called from 'selectPattern' */
parms = modalFor('D320',, 'Enter Rule') 
IF parms = 1 THEN RETURN 1
RETURN setupExecution�/* called from 'selectPattern' */
SELECT
  WHEN patLocation = 'KEYBOARD' THEN
     DO
       commentData.1 = 'Entered from Keyboard'
       numComments = 1
     END
  WHEN patlocation = 'PROMPT' THEN 
    DO 
      IF commentData.1 = '' THEN 
       DO
         commentData.1 = 'no description available'
         numComments = 1
       END
    END
  WHEN patlocation = 'HERE' THEN
     DO
       IF commentData.1 = '' THEN 
         DO
           commentData.1 = mainWindow.initialConditions.Item(patNum)
           numComments = 1
         END
     END
OTHERWISE
/* comment is from a file defined in drlife.pat  */
    DO 
      IF commentData.1 = '' THEN 
         DO
           commentData.1 = mainWindow.initialConditions.Item(patNum)
           numComments = 1
         END 
    END
END /* SELECT   */
CALL D200.patternTitle.Text commentData.1
CALL D200.patternTitle.Delete 
DO i = 1 TO numComments
  CALL D200.patternTitle.Add commentData.i, 'L'
END
CALL VAL 'patternText', commentData.1
IF mainwindow.rules.Select() > 0 THEN CALL D200.ruleUsed.Text mainWindow.rules.Item(mainwindow.rules.Select()) 
ELSE
   CALL D200.ruleUsed.Text ruleType
caType = gameType
CALL getNeighbors
CALL D200.xValue.Text formatNum(cellsHoriz)
CALL D200.yValue.Text formatNum(cellsVert)
IF gameType <> 'BINARY' THEN CALL D200.numCells.Text formatNum(cellsHoriz * cellsVert)
ELSE
  DO
    CALL D200.numCells.Text formatNum(cellsHoriz)
    CALL adjustView.Disable
  END
CALL VAL 'ended', 0
CALL D200.neighborhood.Text nbhTitle
CALL D200.eTimeValue.Text ''
CALL D200.cellsPer.Text ''
CALL D200.genPerSec.Text ''
CALL D200.caType.Text caType
CALL mainWindow.resetPattern.Enable
CALL mainWindow.ovrHoriz.Disable
CALL mainWindow.horizCells.Disable
CALL mainWindow.ovrVert.Disable
CALL mainWindow.vertCells.Disable
CALL mainWindow.ssOverRide.Disable
CALL mainWindow.rules.Disable
CALL mainWindow.initialConditions.Disable
IF syncVars = 1 THEN CALL mainWindow.checkPoint.Disable 
RETURN
saveColors�/* called by mainWindow exit event to save changes to any colors for controls */
currentWinColor = Color('-')
CALL IniSet 'winColor', currentWinColor, 'Window', cfgFile 
currentStartColor = start.Color('-')
CALL IniSet 'startBtnColor', currentStartColor, 'Window', cfgFile 
currentClearColor = resetPattern.Color('-')
CALL IniSet 'clearBtnColor', currentClearColor, 'Window', cfgFile 
currentStepColor = step.Color('-')
CALL IniSet 'stepBtnColor', currentStepColor, 'Window', cfgFile 
currentPauseColor = pause.Color('-')
CALL IniSet 'pauseBtnColor', currentPauseColor, 'Window', cfgFile 
currentStopColor = stop.Color('-')
CALL IniSet 'stopBtnColor', currentStopColor, 'Window', cfgFile 
currentCheckPointColor = checkPoint.Color('-')
CALL IniSet 'chkPointBtnColor', currentCheckPointColor, 'Window', cfgFile 
currentPatColor = D200.patternOutput.Color('-')
CALL IniSet 'backGndColor', currentPatColor, 'Window', cfgFile 
currentPatTextColor = D200.textColor.Color('-')
CALL IniSet 'textColor', currentPatTextColor, 'Window', cfgFile
currentPatListColor = initialConditions.Color('-')
CALL IniSet 'patternListBox', currentPatListColor, 'Window', cfgFile 
currentPatTitleColor = D200.patternTitle.Color('-')
CALL IniSet 'patternTitle', currentPatTitleColor, 'Window', cfgFile
currentRuleListColor = rules.Color('-')
CALL IniSet 'ruleListBox', currentRuleListColor, 'Window', cfgFile 
currentFontListColor = fonts.Color('-')
CALL IniSet 'fontListBox', currentFontListColor, 'Window', cfgFile 
RETURN	resetText�/* called from 'selectPattern', 'snapShot', mainWindow CLEAR button (resetPattern_Click) */
IF VAL('inCycle') = 1 THEN RETURN
CALL D200.patternOutput.Color '+', D200.textColor.Color() 
CALL D200.patternTitle.Text ''
CALL D200.patternTitle.Delete 
CALL D200.ruleUsed.Text ''
CALL D200.caType.Text ''
CALL D200.lambdaValue.text ''
CALL D200.neighborhood.text ''
CALL D200.numStates.text ''
CALL D200.eTimeValue.Text ''
CALL D200.generationCount.Text ''
CALL D200.patternOutput.Text '' 
CALL D200.xValue.Text ''
CALL D200.yValue.Text ''
CALL D200.cellsPer.Text ''
CALL D200.genPerSec.Text ''
CALL D200.numCells.Text ''
CALL D200.population.Text ''
CALL D200.density.text ''
CALL D200.growth.text ''
CALL D200.maxPopulation.Text ''
frameSize = D600.Frame()
IF frameSize = '0 0 0 0' THEN RETURN 
CALL D600.firstLine.Text ''
CALL D600.lastLine.Text ''
CALL D600.numLinesSelected.Text ''
CALL D600.firstColumn.Text ''
CALL D600.lastColumn.Text ''
CALL D600.numcolumnsSelected.Text ''
CALL D600.viewBlock.Text ''
RETURNresetButtons�/* called from 'stopExecution', 'startExecution', 'snapShot', & mainWindow CLEAR button (resetPattern) */
IF VAL('inCycle') = 1 THEN RETURN
CALL mainWindow.loadingText.Text 'Calc %'
CALL mainWindow.initialConditions.Enable
CALL mainWindow.initialConditions.Focus
CALL mainWindow.rules.Enable
CALL mainWindow.multiRules.Disable
CALL mainWindow.leftAlign.Enable
CALL mainWindow.centerAlign.Enable
CALL mainWindow.rightAlign.Enable
CALL mainWindow.topAlign.Enable
CALL mainWindow.vcenterAlign.Enable
CALL mainWindow.bottomAlign.Enable
CALL mainWindow.pause.text 'Pause'
CALL mainWindow.horizCells.Enable
CALL mainWindow.ovrHoriz.Enable
IF mainWindow.ovrHoriz.Select() = 0 THEN CALL mainWindow.horizCells.Select 1
CALL mainWindow.vertCells.Enable
CALL mainWindow.ovrVert.Enable
IF mainWindow.ovrVert.Select() = 0 THEN CALL mainWindow.vertCells.Select 1
CALL mainwindow.rules.Select 0
CALL mainWindow.singleRule.Select 1
CALL mainwindow.initialConditions.Select 0
CALL singleRuleAllowed
CALL VAL 'step', 0
CALL mainWindow.step.Text 'Step'
CALL mainWindow.step.Disable
CALL mainWindow.checkPoint.Enable  
CALL mainWindow.stop.Disable
CALL mainWindow.pause.Disable
CALL mainWindow.start.Disable
CALL mainWindow.adjustView.Disable
CALL mainWindow.resetPattern.Enable
DO WHILE VAL('ended') = 1
CALL SLEEP 50
END
CALL mainWindow.loadPercent.Text 0||'#'||'0 %' 
CALL mainWindow.ssOverRide.Enable 
RETURNinitResources�/* called from 'INIT' */
invalidChar = 0
stepCount = 0
patWidth = 1
patHeight = 1
alignment = 'C'
vertAlignment = 'C'
syncVars = 0
largePattern = 0
startThreadTID = 0
CALL VAL 'cyclicRule', 0
CALL VAL 'wrap', 0
CALL VAL 'delayTime', 0
CALL VAL 'pauseStarted', 0
CALL VAL 'step', 0
CALL VAL 'ended', 0
CALL VAL 'eTimeTID', 0
CALL VAL 'elapsed', 0
CALL VAL 'outStr', 0
RETURNcalcLifeArray�/* Called from 'generate' */
/* calc new values for each cell in A. */
B. = ''
nC = 0
oldAlive = pop
CALL NOTIFY 'mainWindow', 'loadText', 'Calc %' 
DO i = 1 FOR cellsVert
 IF VAL('ended') = 1 THEN RETURN
 DO k = 1 to 5
   IF i = (k/5) * cellsVert THEN CALL NOTIFY 'mainWindow', 'percentDone', k * 20 
 END
 IF wrapEdges = 1 THEN CALL calcTailsI
 ELSE
   CALL calcTailsInoWrap   
 DO j = 1 FOR cellsHoriz
   IF wrapEdges = 1 THEN CALL calcTailsJ
   ELSE
     CALL calcTailsJnoWrap
   IF radius = 1 THEN
     SELECT
       WHEN state = 2 THEN
          nC = A.im1.jm1 * T.1 + A.im1.j * T.2 + A.im1.jp1 * T.3 + ,
               A.i.jm1 * T.4 + A.i.j * T.5 + A.i.jp1 * T.6 + , 
               A.ip1.jm1 * T.7 + A.ip1.j * T.8 + A.ip1.jp1 * T.9
       WHEN state > 2 THEN
          nC = (A.im1.jm1=1) * T.1 + (A.im1.j=1) * T.2 + (A.im1.jp1=1) * T.3 + ,
               (A.i.jm1=1)   * T.4 + (A.i.j=1)   * T.5 + (A.i.jp1=1)   * T.6 + , 
               (A.ip1.jm1=1) * T.7 + (A.ip1.j=1) * T.8 + (A.ip1.jp1=1) * T.9
       OTHERWISE   
     END
   ELSE  /* radius = 2 */
     SELECT
       WHEN state = 2 THEN
          nC = A.im2.jm2 * T.1  + A.im2.jm1 * T.2  + A.im2.j * T.3  + A.im2.jp1 * T.4  + A.im2.jp2 * T.5 + ,
               A.im1.jm2 * T.6  + A.im1.jm1 * T.7  + A.im1.j * T.8  + A.im1.jp1 * T.9  + A.im1.jp2 * T.10 + ,
               A.i.jm2   * T.11 + A.i.jm1   * T.12 + A.i.j   * T.13 + A.i.jp1   * T.14 + A.i.jp2   * T.15 + , 
               A.ip1.jm2 * T.16 + A.ip1.jm1 * T.17 + A.ip1.j * T.18 + A.ip1.jp1 * T.19 + A.ip1.jp2 * T.20 + ,
               A.ip2.jm2 * T.21 + A.ip2.jm1 * T.22 + A.ip2.j * T.23 + A.ip2.jp1 * T.24 + A.ip2.jp2 * T.25 
       WHEN state > 2 THEN
          nC = (A.im2.jm2=1) * T.1  + (A.im2.jm1=1) * T.2  + (A.im2.j=1) * T.3  + (A.im2.jp1=1) * T.4  + (A.im2.jp2=1) * T.5  + ,
               (A.im1.jm2=1) * T.6  + (A.im1.jm1=1) * T.7  + (A.im1.j=1) * T.8  + (A.im1.jp1=1) * T.9  + (A.im1.jp2=1) * T.10 + ,
               (A.i.jm2=1)   * T.11 + (A.i.jm1=1)   * T.12 + (A.i.j=1)   * T.13 + (A.i.jp1=1)   * T.14 + (A.i.jp2=1)   * T.15 + , 
               (A.ip1.jm2=1) * T.16 + (A.ip1.jm1=1) * T.17 + (A.ip1.j=1) * T.18 + (A.ip1.jp1=1) * T.19 + (A.ip1.jp2=1) * T.20 + ,
               (A.ip2.jm2=1) * T.21 + (A.ip2.jm1=1) * T.22 + (A.ip2.j=1) * T.23 + (A.ip2.jp1=1) * T.24 + (A.ip2.jp2=1) * T.25 
       OTHERWISE   
     END
   CALL calcLife
  END /* j */
END  /* i */
maxAlive = MAX(oldAlive, pop, maxAlive)
IF oldAlive > 0 THEN
  gro = FORMAT((pop - oldAlive) / oldAlive * 100,,2)
ELSE
  gro = 0
den = FORMAT(pop / (cellsVert * cellsHoriz) * 100,,2)
DO i = 1 TO cellsVert
  DO j = 1 TO cellsHoriz
    IF B.i.j >= 0 THEN A.i.j = B.i.j
  END
END
RETURNcalcLife�/* Called from 'calcLifeArray'  */
/* general routine for Sxxx/Bxxx/xx type rules   */
/* nC is count of neighbors for A.i.j   */
SELECT
  WHEN A.i.j = 0 THEN 
    /* rule for birth  */
    DO
      /* optimized: A.i.j is zero & no neighbors, and */ 
      /* the Snn/Bnn rule has no zeros in Bnn, so remains zero */
      IF nC = 0 & bCntHasZeros = 0 THEN RETURN 
      ELSE 
        DO k = 0 to nCmax   
          IF nC = bCnt.k THEN 
            DO
              pop = pop + 1
              B.i.j = 1
              RETURN
            END
        END
    END
  WHEN A.i.j = 1 & state = 2 THEN 
    /* rule for survival   */
    DO
      DO k = 0 TO nCmax
        /* optimized: if A.i.j = 1 and neighbors are valid, then remain = 1 */ 
        IF nC = sCnt.k THEN RETURN 
      END
      /* A.i.j dies  */
      pop = pop - 1
      B.i.j = 0
    END
  WHEN A.i.j = 1 & state > 2 THEN     
    DO /* the Generations rule applies   */
      /* rule for survival   */
      DO k = 0 TO nCmax
        /* optimized: if A.i.j = 1 and neighbors are valid, then remain = 1 */ 
        IF nC = sCnt.k THEN RETURN 
      END
      /* A.i.j dies, becomes next generation value */
      B.i.j = 2
    END
  WHEN A.i.j > 1 THEN
      DO
        newValue = (A.i.j + 1) // state       
        IF newValue = 0 THEN
          DO
            pop = pop - 1
            B.i.j = 0
          END
        ELSE
          B.i.j = newValue
      END
OTHERWISE
END
RETURN	formatNum�/* called from 'checkPattern', 'setupExecution', and D200 NOTIFY event  */
PROCEDURE
ARG number
    fmtNum = ""
    DO WHILE LENGTH(number) > 3
        part = RIGHT(number, 3)
        number = LEFT(number, length(number) - 3)
        fmtNum = "," || part || fmtNum
    END
    IF number <> "" THEN fmtNum = number||fmtNum
RETURN fmtNumdecodeLifeRule�/* Called from 'cycle' and 'changeRule' */
PARSE VAR ruleType sCounts '/' bCounts '/' state
IF state = '' THEN state = 2
nCmax = 9 /* default value  */
sCounts = STRIP(sCounts, 'L', 'S')
bCounts = STRIP(bCounts, 'L', 'B')
sCnt. = '99'
DO i = 1 TO LENGTH(sCounts) 
  aNum = charToNum(SUBSTR(sCounts, i,1)) 
  IF aNum > 9 THEN nCmax = 35
  sCnt.aNum = aNum
END
bCnt. = '99'
bCntHasZeros = 0
DO i = 1 TO LENGTH(bCounts) 
  aNum = charToNum(SUBSTR(bCounts, i,1)) 
  IF aNum > 9 THEN nCmax = 35
  bCnt.aNum = aNum
  IF aNum = 0 THEN bCntHasZeros = 1
END
RETURN
selectRule�/* called from 'getPattern', and mainWindow rule listbox (rules_Select) */
PARSE ARG aNum 
ruleType = TRANSLATE(IniGet('ruleValue', RULE.aNum, rules))
IF SUBSTR(ruleType, 1, 1) = 'S' THEN CALL mainWindow.adjustView.Enable
IF ruleType <> 0 THEN nbhType = IniGet('neighborhoodType', RULE.aNum, rules) 
IF ovrRideNeighbor <> '' THEN nbhType = ovrRideNeighbor
ovrRideNeighbor = ''
RETURN
setSliders�/* called from 'selectPattern' */
SELECT
   WHEN cellsHoriz = 1000 THEN CALL mainWindow.horizCells.Select 12
   WHEN cellsHoriz = 900 THEN CALL  mainWindow.horizCells.Select 11
   WHEN cellsHoriz = 800 THEN CALL  mainWindow.horizCells.Select 10
   WHEN cellsHoriz = 700 THEN CALL  mainWindow.horizCells.Select 9
   WHEN cellsHoriz = 600 THEN CALL  mainWindow.horizCells.Select 8
   WHEN cellsHoriz = 500 THEN CALL  mainWindow.horizCells.Select 7
   WHEN cellsHoriz = 400 THEN CALL  mainWindow.horizCells.Select 6
   WHEN cellsHoriz = 300 THEN CALL  mainWindow.horizCells.Select 5
   WHEN cellsHoriz = 200 THEN CALL  mainWindow.horizCells.Select 4
   WHEN cellsHoriz = 100 THEN CALL  mainWindow.horizCells.Select 3
   WHEN cellsHoriz = 50  THEN CALL  mainWindow.horizCells.Select 2
   WHEN cellsHoriz = 24  THEN CALL  mainWindow.horizCells.Select 1
OTHERWISE
   CALL mainWindow.horizCells.Select 13
END   
SELECT
   WHEN cellsVert = 1000 THEN CALL mainWindow.vertCells.Select 12
   WHEN cellsVert = 900 THEN CALL  mainWindow.vertCells.Select 11
   WHEN cellsVert = 800 THEN CALL  mainWindow.vertCells.Select 10
   WHEN cellsVert = 700 THEN CALL  mainWindow.vertCells.Select 9
   WHEN cellsVert = 600 THEN CALL  mainWindow.vertCells.Select 8
   WHEN cellsVert = 500 THEN CALL  mainWindow.vertCells.Select 7
   WHEN cellsVert = 400 THEN CALL  mainWindow.vertCells.Select 6
   WHEN cellsVert = 300 THEN CALL  mainWindow.vertCells.Select 5
   WHEN cellsVert = 200 THEN CALL  mainWindow.vertCells.Select 4
   WHEN cellsVert = 100 THEN CALL  mainWindow.vertCells.Select 3
   WHEN cellsVert = 50  THEN CALL  mainWindow.vertCells.Select 2
   WHEN cellsVert = 24  THEN CALL  mainWindow.vertCells.Select 1
OTHERWISE
   CALL mainWindow.vertCells.Select 13
END
RETURNhorizCellsChanged�/* called from 'selectPattern' */
/* patWidth comes from the x = value in a .lif file, or from Drlife.pat */
IF preventResize = 1 THEN
  DO
    cellsHoriz = patWidth
    RETURN
  END
x2 = MAX(patWidth, widthOverride)
SELECT
  WHEN x2 > 900  THEN cellsHoriz = 1000
  WHEN x2 > 800  THEN cellsHoriz = 900
  WHEN x2 > 700  THEN cellsHoriz = 800
  WHEN x2 > 600  THEN cellsHoriz = 700
  WHEN x2 > 500  THEN cellsHoriz = 600
  WHEN x2 > 400  THEN cellsHoriz = 500
  WHEN x2 > 300  THEN cellsHoriz = 400
  WHEN x2 > 200  THEN cellsHoriz = 300
  WHEN x2 > 100  THEN cellsHoriz = 200
  WHEN x2 > 50   THEN cellsHoriz = 100
  WHEN x2 > 24   THEN cellsHoriz = 50
  WHEN x2 > 0    THEN cellsHoriz = 24
OTHERWISE
END
RETURNvertCellsChanged�/* called from 'selectPattern' */
/* patHeight comes from the y = value in a .lif file */
IF preventResize = 1 THEN
  DO
    cellsVert = patHeight
    RETURN
  END
y2 = MAX(patHeight, heightOverride) 
SELECT
  WHEN y2 > 900  THEN cellsVert = 1000
  WHEN y2 > 800  THEN cellsVert = 900
  WHEN y2 > 700  THEN cellsVert = 800
  WHEN y2 > 600  THEN cellsVert = 700
  WHEN y2 > 500  THEN cellsVert = 600
  WHEN y2 > 400  THEN cellsVert = 500
  WHEN y2 > 300  THEN cellsVert = 400
  WHEN y2 > 200  THEN cellsVert = 300
  WHEN y2 > 100  THEN cellsVert = 200
  WHEN y2 > 50   THEN cellsVert = 100
  WHEN y2 > 24   THEN cellsVert = 50  
  WHEN y2 > 0    THEN cellsVert = 24
OTHERWISE
END
RETURNgetFileData�/* called from 'getPattern' */
ARG aFile
asciiFormat = 0
numComments = 0 
IF aFile = 'PROMPT' THEN
  DO
   patFile = FilePrompt(patternDir'\*.*', 'Select a pattern file')
   IF patFile = '' THEN
     DO
       CALL resetButtons
       RETURN 1
     END
  END
ELSE patFile = aFile
rc = STREAM(patFile, 'C', 'OPEN READ')
IF rc <> 'READY:' THEN
  DO
    errorText = 'File 'aFile' not found.' 
    rc = modalFor('D700',, 'Messages')
    CALL resetButtons
    RETURN 1
  END
rc = STREAM(patFile, 'C', 'SEEK =1 ')
dataLine = STRIP(LINEIN(patFile,, 1), 'L') /* first line of pattern file  */
patternType = SUBSTR(dataLine,1,10)
PARSE VAR patternType patKind ' ' version
patternData. = ''
k = 1    /* count of patternData lines  */
SELECT 
 WHEN patKind = '#Life' & version = '1.05' THEN
  DO
    CALL parseLife105
    rc = STREAM(patFile, 'C', 'CLOSE') 
    CALL checkLimit
    RETURN
  END
 WHEN patKind = '#MCell' | patKind = '#HighOrder' THEN
  DO
    CALL parseMCell
    IF RESULT = 1 THEN 
      DO
        rc = STREAM(patFile, 'C', 'CLOSE')
        RETURN 1
      END 
    rc = STREAM(patFile, 'C', 'CLOSE') 
    CALL checkLimit
    RETURN
  END
 WHEN patKind = '#SRCA' THEN
  DO
    CALL parseSRCA
    rc = STREAM(patFile, 'C', 'CLOSE') 
    CALL checkLimit
    RETURN
  END
 WHEN patKind = '#Random' THEN
  DO
    CALL parseRandom
    rc = STREAM(patFile, 'C', 'CLOSE') 
    CALL checkLimit
    RETURN
  END
 WHEN patKind = '#Life' & version = '1.06' THEN
  DO
    errorText = 'Life 1.06 file format not supported.' 
    rc = modalFor('D700',, 'Messages')
    rc = STREAM(patFile, 'C', 'CLOSE') 
    CALL resetButtons
    RETURN 1
  END
OTHERWISE
  DO
    CALL parseAscii
    rc = STREAM(patFile, 'C', 'CLOSE') 
    CALL checkLimit
  END
END /* select */
RETURN
elapsedTime�/* called from D200 NOTIFY event */
rc = TIME('R')
DO FOREVER
 CALL SLEEP 100
 IF VAL('ended') = 1 THEN 
  DO
   eTime = TRUNC(TIME('E'))
/* one second minimum elapsed time  */
   eTime = MAX(1, eTime)
   CALL VAL 'elapsed', eTime
   tmp = eTime + 0.0000001
   hh = (tmp / 3600) % 1
   mm = ((tmp / 60) - hh * 60) % 1
   ss = (tmp - (mm * 60) - (hh * 3600)) % 1
   formatTime = RIGHT(hh,2,0)||'h:'||RIGHT(mm,2,0)||'m:'||RIGHT(ss,2,0)||'s'
   CALL Notify 'D200', 'elapsedTime', formatTime
   LEAVE
  END
END /* do forever   */
RETURNstepExecution�/* called from mainWindow STEP button (step_Click) & 'startExecution' */
IF VAL('step') = 0 THEN stepCount = 1
ELSE stepCount = stepcount + 1
CALL VAL 'step', stepCount
CALL mainWindow.pause.Text 'Resume'
CALL mainWindow.checkPoint.Enable
CALL mainwindow.step.Text 'Step '||stepCount - 1
CALL D200.Top
IF VAL('pauseStarted') = 0 THEN pauseThreadTID = START('pauseThread')
IF VAL('delayTime') > 0 THEN
  DO
   CALL VAL 'saveDelay', VAL('delayTime')
   CALL VAL 'delayTime', 0
  END 
RETURNpauseExecution�/* called from 'applyView', mainwindow PAUSE button (pause_Click), and 'snapshot' */
IF VAL('pauseStarted') = 0 THEN 
 DO 
  pauseThreadTID = START('pauseThread')
  CALL VAL('step'), 0
  CALL VAL 'saveDelay', VAL('delayTime')
  IF D600.frame() <> '0 0 0 0' THEN CALL D600.pauseProcessing.Disable
  CALL mainWindow.pause.Text 'Resume'
  CALL mainwindow.checkPoint.Enable
  DO UNTIL VAL('pauseStarted') = 1
    CALL SLEEP 100
  END
  CALL setPercentBar 0
  CALL D200.Focus
  RETURN
 END
/* if already in pause mode, then resume execution   */
ELSE  
 DO 
  IF patternChanged = 1 THEN CALL reloadArray
  CALL D200.Focus  
  CALL VAL 'endPause', 1
  CALL VAL 'pauseStarted', 0
  IF D600.frame() <> '0 0 0 0' THEN CALL D600.pauseProcessing.Enable
  CALL mainWindow.pause.Text 'Pause'
  CALL mainwindow.checkPoint.Disable
  CALL setPercentBar 0
  CALL mainWindow.step.Text 'Step'
  stepCount = 0
  CALL D200.Focus
  CALL VAL 'delayTime', VAL('saveDelay')
END
RETURNstartExecution�	/* called by mainwindow START button (start_Click) */
CALL mainWindow.start.Disable
CALL mainWindow.step.Enable
CALL mainWindow.stop.Enable
CALL mainWindow.pause.Enable
CALL VAL 'horiz', cellsHoriz
CALL VAL 'vert', cellsVert
CALL VAL 'inCycle', 0
stopGeneration = mainWindow.stopAtGen.Text()
CALL D200.patternOutput.Color '+', D200.textColor.Color()
IF VAL('patternChanged') = 1 THEN CALL reloadArray
IF VAL('ssMode') = 1 THEN CALL stepExecution 
rc = VARWRITE(cycleVars, 'I', 'cellsVert', 'cellsHoriz', 'cellCVfile', 'ruleType', 'xlateTable', 'nbhType', 'neighbors', 'largePattern', 'pop', 'displayLimit', 'ruleQueue', 'embeds', 'inputTable', 'srcaCVfile', 'T.', 'totalCells', 'activeCells') 
rc = VARWRITE(cycleVars, 'I', 'gameType', 'radius', 'state', 'threshold', 'ghSwitch', 'selectedFont', 'nbhTitle', 'caType', 'numComments', 'commentData.', 'syncVars', 'history', 'colors', 'criteria')
startThreadTID = START('cycle', cycleVars)
CALL D200.Focus
elapsedTimeTID = START('elapsedTime') 
CALL VAL 'eTimeTID', elapsedTimeTID
CALL mainWindow.initialConditions.Disable
CALL mainWindow.rules.Disable
CALL mainWindow.checkPoint.Disable
RETURNstopExecution�/* called by mainWindow STOP button (stop_Click) */
CALL VAL 'ended', 1 
CALL VAL('inCycle'), 0
syncVars = 0
startThreadTID = 0
IF D800.frame() <> '0 0 0 0' THEN CALL queueCyclicRules
IF D600.frame() <> '0 0 0 0' THEN 
DO 
  CALL D600.firstLine.Text ''
  CALL D600.lastLine.Text ''
  CALL D600.numLinesSelected.Text ''
  CALL D600.firstColumn.Text ''
  CALL D600.lastColumn.Text ''
  CALL D600.numcolumnsSelected.Text ''
  CALL D600.viewBlock.Text ''
END
CALL resetButtons
RETURNselectPattern�&/* called by mainWindow PATTERNS listbox (initialConditions_Select) */
/*  get selection and then pattern and display */
patNum = ARG(1)
CALL VAL 'patNumber', patNum
CALL VAL('inCycle'), 0
CALL multiRules.Enable
CALL resetText
preventResize = 0 
largePattern = 0
patternChanged = 0
gameType = ''
nbhType = ''
nbhTitle = ''
ovrRideNeighbor = ''
section = initialConditions.item(patnum, 'Data')
ruleType  = editParm(IniGet('defaultRule', section, patterns))
IF ruletype = 0 THEN CALL enterRule
IF RESULT = 1 THEN
  DO
    CALL resetButtons 
    RETURN
  END 
CALL getRuleData ruleType
IF gameType = '' THEN gameType  = TRANSLATE(IniGet('game', section, patterns))
selectedFont = editParm(IniGet('prefFont', section, patterns))
IF ovrFont.Select() = 0 THEN 
  DO
    CALL fonts.Select(selectedFont) 
    CALL D200.patternOutput.Font fontName.selectedFont 
  END
ELSE
  DO
   overRideFont = Fonts.Select()   
   CALL D200.patternOutput.Font fontName.overRideFont
  END
patHeight  = editParm(IniGet('height', section, patterns))
patWidth   = editParm(IniGet('width', section, patterns))
heightOverride = editParm(IniGet('optimumHeight', section, patterns))
widthOverride =  editParm(IniGet('optimumWidth', section, patterns))
CALL getDefaultNeighbors 
CALL getPattern
IF RESULT = 1 THEN RETURN
IF preventResize = 1 THEN
  DO
    CALL ovrHoriz.Select 0
    CALL ovrVert.Select 0
  END 
/* check for override to horiz cells, and set cellsHoriz from sliders,  */
/* or from patWidth   */
ovrHoriz = ovrHoriz.Select()
IF ovrHoriz = 1 THEN CALL ovrHorizCells
ELSE CALL horizCellsChanged 
/* check for override to vert cells as above   */
ovrVert = ovrVert.Select()
IF ovrVert = 1 THEN CALL ovrVertCells
ELSE CALL vertCellsChanged
IF cellsVert * cellsHoriz > displayLimit THEN largePattern = 1
IF (patWidth > 1000 | patHeight > 1000) THEN 
  DO
    errorText = 'Patterns is too large. Horizontal/Vertical is larger than 1000 cells.'
    rc = modalFor('D700',, 'Error')
    CALL resetButtons 
    RETURN 
  END
IF largePattern = 1 & patLocation = 'KEYBOARD' THEN
  DO
    errorText = 'Large Patterns and keyboard entry are incompatible features.'
    rc = modalFor('D700',, 'Error')
    CALL resetButtons 
    RETURN 
  END 
IF largePattern = 1 THEN
   DO
     errorText = 'Pattern is too large to display fully. It can be displayed in sections.'
     rc = modalFor('D700',, 'Error')
     CALL loadingText.text 'Calc %'
     CALL setPercentBar 0
     CALL Focus
   END
numCols = 0
i = 1
DO UNTIL patternData.i = ''
  numCols = MAX(numCols, LENGTH(patternData.i))
  i = i + 1
END
numLines = i - 1
SELECT
  WHEN alignment = 'L' THEN startAfterCol  = 0
  WHEN alignment = 'C' THEN startAfterCol  = (cellsHoriz - numCols + 1) % 2 
  WHEN alignment = 'R' THEN startAfterCol  = cellsHoriz - numCols 
OTHERWISE
END
IF gameType = 'BINARY' THEN startAfterLine = 0
ELSE
 SELECT
   WHEN vertAlignment = 'T' THEN startAfterLine = 0
   WHEN vertAlignment = 'C' THEN startAfterLine = (cellsVert - numLines + 1) % 2  
   WHEN vertAlignment = 'B' THEN startAfterLine = cellsVert - numLines
 OTHERWISE
 END
leadInLength = startAfterLine * cellsHoriz
leadInString = COPIES('0', leadInLength)
patString = ''
DO i = 1 FOR numLines
  IF startAfterCol > 0 THEN 
    str.i = COPIES('0', startAfterCol) || patternData.i
  ELSE
    str.i = patternData.i
  len.i = LENGTH(str.i)
  trailLength.i = cellsHoriz - len.i  
  str.i = str.i || COPIES('0', trailLength.i)
  patString = patString || str.i
END
tempString = leadInString || patString
trailLength = (cellsHoriz * cellsVert) - LENGTH(tempString)
trailingString =  COPIES('0', trailLength)
startingString = leadInString || patString || trailingString 
CALL loadingText.Text 'Loading'
/* set up display region. Default is whole pattern */
CALL VAL 'strLine', 1
CALL VAL 'enLine', cellsVert
CALL VAL 'strCol', 1
CALL VAL 'enCol', cellsHoriz
CALL loadArray startingString
CALL setPercentBar 0
DROP trailingString
IF patNum = 1 THEN  CALL D200.patternOutput.Focus 
CALL VAL 'partialDisplay', 0
IF gameType <> 'BINARY' THEN CALL displayArray
ELSE
  DO
    outString = ''
    CALL displayBinaryArray 1 
  END
CALL setSliders
rc = DOSDEL(cellCVfile)
rc = CVWRITE(cellCVfile, 'A.')
IF gameType = 'SELF REPLICATING' THEN
  DO
    rc = DOSDEL(srcaCVfile)
    rc = CVWRITE(srcaCVfile, 'srcaRule.')
    DROP srcaRule.
  END
IF gameType = 'LIFE' | gameType = 'GENERATIONS' | gameType = 'WEIGHTED LIFE' THEN CALL adjustView.Enable
CALL start.Enable
CALL ovrHoriz.Disable
CALL horizCells.Disable
CALL ovrVert.Disable
CALL vertCells.Disable
CALL leftAlign.Disable
CALL centerAlign.Disable
CALL rightAlign.Disable
CALL topAlign.Disable
CALL vcenterAlign.Disable
CALL bottomAlign.Disable
IF VAL('cyclicRule') = 1 THEN CALL rules.Select 0
CALL VAL 'rule', ruleType
DROP A.
CALL setupExecution
RETURNgenerate�/* called from 'cycle' */
/* The value of delayTime is set in the "Speed" slider */ 
IF VAL('ended') = 1 THEN RETURN
sleepTime = VAL('delayTime')
wrapEdges = VAL('wrap')
IF gameType = 'BINARY' THEN CALL calcBinaryArray 
ELSE
  DO
    CALL USE 'pauseResource', 1 
    IF VAL('patternChanged') = 1 THEN
      DO
        CALL reloadArray
        CALL VAL 'patternChanged', 0
      END
    SELECT
      WHEN gameType = 'LIFE' THEN CALL calcLifeArray 
      WHEN gameType = 'GENERATIONS' THEN CALL calcLifeArray 
      WHEN gameType = 'WEIGHTED LIFE' THEN CALL calcWeightedLifeArray 
      WHEN gameType = 'MARGOLUS' THEN CALL calcMargolusArray
      WHEN gameType = 'SELF REPLICATING' THEN CALL calcSRCAArray
      WHEN gameType = 'CYCLIC CA' THEN CALL calcCyclicArray
      WHEN gameType = 'SECOND ORDER' THEN CALL calcSecondOrderLifeArray
    OTHERWISE
    END
    bpCyclicRule = VAL('cyclicRule')
    IF bpCyclicRule = 1 THEN 
      DO
       activeCriteria = VAL('criteria')
       PARSE VAR activeCriteria part1 '#' part2 '#' part3
       Select
          WHEN criteriaPart = 1 THEN Interpret part1
          WHEN criteriaPart = 2 THEN Interpret part2
          WHEN criteriaPart = 3 THEN Interpret part3
       OTHERWISE
       END
       IF cycle = 1 THEN CALL changeRule
      END
    IF VAL('ended') = 1 THEN RETURN
    CALL displayArray
    CALL NOTIFY 'D200', 'fromGenerate', gen pop gro den maxAlive
    CALL USE 'pauseResource', 0 
    gen = gen + 1
    IF sleepTime > 0 THEN CALL SLEEP sleepTime
  END
RETURNpauseThread�/* called from 'stepExecution', 'stopExecution', and 'pauseExecution' */
/* wait for pauseResource to be released by generate routine */
CALL USE 'pauseResource', 1
CALL VAL 'pauseStarted' , 1
IF VAL('step') = 0 THEN
    DO FOREVER
     CALL SLEEP 100 
     IF VAL('step') > 0 THEN LEAVE   
     IF VAL('ended') = 1 | VAL('endPause') = 1 THEN
        DO
          CALL USE 'pauseResource', 0
          CALL VAL 'pauseStarted' , 0
          CALL VAL 'endPause', 0
          RETURN
        END
     END 
IF VAL('step') = 1 THEN stepValue = 0
DO FOREVER
   CALL SLEEP 50
   stepCount = VAL('step')
   IF stepCount > stepValue THEN
     DO
      CALL USE 'pauseResource', 0
      CALL USE 'pauseResource', 1
      stepValue = stepCount
     END
   IF VAL('ended') = 1 | VAL('endPause') = 1 THEN
      DO
        CALL USE 'pauseResource', 0
        CALL VAL 'pauseStarted' , 0
        CALL VAL 'endPause', 0
        RETURN
      END
END /* do forever   */
RETURNconfigOptions�/* called from 'INIT' and apply config menu option */
D100xpixel = IniGet('xpixelmain', 'Window', cfgFile)
D100ypixel = IniGet('ypixelmain', 'Window', cfgFile)
D200xpixel = IniGet('xpixelpattern', 'Window', cfgFile)
D200ypixel = IniGet('ypixelpattern', 'Window', cfgFile)
D600xpixel = IniGet('xpixelsection', 'Window', cfgFile)
D600ypixel = IniGet('ypixelsection', 'Window', cfgFile)
D800xpixel = IniGet('xpixelmultiRule', 'Window', cfgFile)
D800ypixel = IniGet('ypixelmultiRule', 'Window', cfgFile)
dTime = IniGet('delayTime', 'General', cfgFile)
CALL VAL 'stringWaitTime', IniGet('waitTime', 'General', cfgFile)
editPgm = IniGet('editor', 'General', cfgFile)
imageView = TRANSLATE(IniGet('imageViewer', 'General', cfgFile))
helpViewer = IniGet('helpView', 'General', cfgFile)
patternDir = IniGet('patDir', 'General', cfgFile)
rc = DOSISDIR(patternDir)
IF rc = 0 THEN 
  DO
    errorText = 'File Drlife.cfg has an incorrect directory for pattern files. '
    rc = ModalFor('D700',,'Messages')
    EXIT
  END 
graphicsDir = IniGet('gifDir', 'General', cfgFile)
rc = DOSISDIR(graphicsDir)
IF rc = 0 THEN 
  DO
    errorText = 'File Drlife.cfg has an incorrect directory for saved gif files. '
    rc = ModalFor('D700',,'Messages')
    EXIT
  END 
cpFilesDir = IniGet('cpDir', 'General', cfgFile)
rc = DOSISDIR(cpFilesDir)
IF rc = 0 THEN 
  DO
    errorText = 'File Drlife.cfg has an incorrect directory for checkpoint files. '
    rc = ModalFor('D700',,'Messages')
    EXIT
  END 
xlateTable = IniGet('xlate', 'General', cfgFile)
inputTable = IniGet('inTable', 'General', cfgFile)
optimizeRows = IniGet('optimizeRowCalc', 'General', cfgFile)
displayLimit = IniGet('maxCells', 'General', cfgFile)
defaultFont = IniGet('font', 'General', cfgFile)
/* get rules   */
rc = IniEnumSections(ruleSections., rules)
DO i = 1 TO ruleSections.0
ruleTitle.i = IniGet('TITLE', ruleSections.i, rules)
ruleValue.i = IniGet('ruleValue', ruleSections.i, rules)
END
numRules = ruleSections.0
/* get patterns      */
rc = IniEnumSections(patternSections., patterns)
DO i = 1 TO patternSections.0
  patTitle.i = IniGet('TITLE', patternSections.i, patterns)
END
numPatterns = patternSections.0
/* get pattern embeds    */
CALL loadEmbeds
/* get Fonts        */
numFonts = 0
rc = IniEnumSections(fontSections., cfgFile)
DO i = 1 TO fontSections.0
  IF SUBSTR(fontSections.i,1,4) = 'FONT' THEN
   DO
    numFonts = numFonts + 1
    fontTitle.numFonts = IniGet('TITLE', fontSections.i, cfgFile)
    fontName.numFonts = IniGet('outFont', fontSections.i, cfgFile)
   END
END
CALL getWindowColors
RETURN	loadArray�/* called from 'selectPattern', 'initializeArray', 'reloadArray' & 'cycle' */
instring = TRANSLATE(ARG(1))
pop = 0
embed. = ''
numEmbeds = 0
/* inString = TRANSLATE(inString) */
inString = TRANSLATE(inString, inputTable, xlateTable)
charsInLine = VAL('enCol') - VAL('strCol') + 1
DO i = VAL('strLine') TO VAL('enLine')
 linesCompleted = i - VAL('strLine')
 DO k = 1 to 10
   IF i = (k/10) * VAL('enLine') THEN CALL setPercentBar k * 10
 END
   DO j = VAL('strCol') TO VAL('enCol')
     arrayPosition = charsInLine * linesCompleted + (j - VAL('strCol') + 1) 
     alphaDigit = SUBSTR(inString, arrayPosition, 1)
    IF alphaDigit <> '#' THEN A.i.j = charToNum(alphaDigit)
    ELSE
      A.i.j = alphaDigit  /*  a # character   */ 
   SELECT
        WHEN A.i.j > 0 & A.i.j <> '#' THEN pop = pop + 1
        WHEN A.i.j = 0 THEN NOP
        WHEN A.i.j = '#' THEN
          /* A.i.j indicates that an embedded pattern character follows  */ 
          DO 
            nextChar = SUBSTR(inString, arrayPosition + 1, 1)
            tag = A.i.j
            tag2 = nextChar
            found = 0
            DO q = 1 to embedSections.0
              IF embedSections.q = 'EMBED.'tag||tag2 THEN
                DO
                  found = 1
                  numEmbeds = numEmbeds + 1
                  embed.numEmbeds = tag','tag2','i','j
                END
              IF found = 1 THEN
                DO
                  /* code to skip some columns  */
                  LEAVE
                END      
            END
            IF found = 0 THEN A.i.j = 0
          END 
     OTHERWISE
     END /* select  */
   END /* j */
END /* i */
IF numEmbeds > 0 THEN CALL embeddedPatterns
IF VAL('inCycle') = 1 THEN 
  DO
   CALL NOTIFY 'D100', 'loadText', 'Calc %' 
   CALL NOTIFY 'D100', 'percentDone', '0'
  END
ELSE
  DO
   CALL loadingText.Text 'Calc %' 
   CALL loadPercent.Text '0#' 
  END 
DROP inString
RETURNdisplayArray�/* called from 'selectPattern', and 'generate' */
outString = ''
CR = '0D'x
LF = '0A'x
restoredFont = VAL('selectedFont')
IF VAL('partialDisplay') = 1 THEN
  DO
    startLine = VAL('strLine')
    endLine = VAL('enLine')
    startColumn = VAL('strCol')
    endColumn = VAL('enCol')
  END
ELSE /* partialDisplay = 0 */
  DO
    startLine = 1
    endLine = cellsVert
    startColumn = 1
    endColumn = cellsHoriz
  END
charCount = 0 
temp. = ''
m = 1
DO i= startLine TO endLine
   DO j= startColumn TO endColumn
     temp.m = temp.m||numToChar(A.i.j)
     charCount = charCount + 1
     if j = endColumn THEN
      DO
        temp.m = temp.m||CR||LF
        charCount = charCount + 2
      END       
      m = (charCount % 240) + 1
   END
END 
DO i = 1 TO m
outString = outString||temp.i
END
DROP temp.
CALL VAL 'outStr', outString
DROP outString
CALL NOTIFY 'D200', 'outputText'
RETURNcycle�/* thread initiated from 'startExecution' */
PARSE ARG cycleVars
rc = VARREAD(cycleVars, 'I')
rc = DOSDEL(cycleVars)
CR = '0D'x
LF = '0A'x
CALL VAL 'inCycle', 1
CALL loadEmbeds
patNum = VAL('patNumber')
patText = VAL('patternText')
CALL RXQUEUE 'set', ruleQueue
rc = CVREAD(cellCVfile, 'A.')
rc = DOSDEL(cellCVfile)
hp1 = cellsHoriz + 1
vp1 = cellsVert + 1
DO j = 0 to hp1
 A.0.j = 0
 A.vp1.j = 0
END  
DO i = 0 TO vp1
 A.i.0 = 0
 A.i.hp1 = 0
END
gen = 1
criteriaPart = 1
IF VAL('cyclicRule') = 1 THEN CALL changeRule /* get first global rule */
SELECT
  WHEN gameType = 'LIFE' THEN CALL decodeLifeRule
  WHEN gameType = 'GENERATIONS' THEN CALL decodeLifeRule
  WHEN gameType = 'WEIGHTED LIFE' THEN CALL decodeLifeRule
  WHEN gameType = 'MARGOLUS' THEN CALL decodeMargolusRule
  WHEN gameType = 'BINARY' THEN CALL decodeBinaryRule
  WHEN gameType = 'CYCLIC CA' THEN CALL decodeCyclicRule
  WHEN gameType = 'SECOND ORDER' THEN
    DO
      CALL decodeLifeRule
      DO i = 1 TO cellsVert
        DO j = 1 TO cellsHoriz
          past.i.j = 0
        END
      END
    END
  WHEN gameType = 'SELF REPLICATING' THEN
    DO
      CALL loadSRCARule
      CALL DOSDEL(srcaCVfile)
      CALL loadGridArray 
    END
OTHERWISE
END
maxAlive = 0
partition = 0
cd = 1
CALL calcLambda
CALL NOTIFY 'D200', 'lambda-state', lambda state
/*  main loop  */
DO FOREVER 
CALL SLEEP 1 
  IF VAL('ended') = 1 THEN LEAVE
  cpRequested = VAL('breakPoint')
  PARSE VAR cpRequested action ',' cpFile
  SELECT
    WHEN action = 'S' THEN /* create a new checkpoint   */
      DO
        CALL VAL 'breakPoint', ''
        IF bpCyclicRule = 1 THEN
          DO
            numQueued = QUEUED()
            DO k = 1 to numQueued
              PULL queueRule.k
              QUEUE queueRule.k
            END
          END
        CALL DOSDEL(cpFile)
        rc = VARWRITE(cpFile)
      END
    WHEN action = 'A' THEN  /* activate a checkpoint    */
      DO
        CALL VAL 'breakPoint', ''
        sCnt. = 99
        bCnt. = 99
        rc = VARREAD(cpFile)
        CALL createSyncVars
      END 
  OTHERWISE
  END
  CALL generate  
  IF VAL('saveArray') = 1 THEN
    DO
      rc = CVWRITE(cellCVfile, 'A.')
      IF gameType = 'SELF REPLICATING' THEN rc = CVWRITE(srcaCVfile, 'srcaRule.')
      CALL VAL 'saveArray', 0
    END
END /* do forever  */
CALL SLEEP 500
CALL VAL 'ended', 0
RETURNINIT�/* Global init. The first routine called on start up. */
CALL RxFuncAdd 'SysloadFuncs', 'REXXUTIL', 'SysLoadFuncs'
CALL SysLoadFuncs
fSpec = SysSearchPath('PATH', 'Drlife.exe')
fpath = FILESPEC('DRIVE', fSpec)||STRIP(FILESPEC('PATH', fSpec), 'T', '\')
rc = DIRECTORY(fPath)
curDir = Directory()
CALL RxFuncAdd 'RexxLibRegister', 'REXXLIB', 'RexxLibRegister'
CALL RexxLibRegister
CALL RxFuncAdd 'IniLoadFuncs', 'REXXINI', 'IniLoadFuncs'
CALL IniLoadFuncs
/* make graphics available */ 
Call RxFuncAdd 'RxgdLoadFuncs', 'RXGDUTIL', 'RxgdLoadFuncs'
Call RxgdLoadFuncs
/* make new controls available  */
rc = RxFuncAdd("DRCtrlRegister", 'drctl017' , "DRCtrlRegister")
CALL DRCtrlRegister
CR = '0D'x
LF = '0A'x
/* filespec for all control files  */
cfgFile = curDir||'\DrLife.cfg'
patterns = curDir||'\DrLife.pat'
rules = curDir||'\DrLife.rul'
switchRules = curDir||'\DrLife.con'
neighbors = curDir||'\DrLife.nbh'
checkPointFile = curDir||'\DrLife.cpt'
embeds = curDir||'\Drlife.emb'
helpFile = curDir||'\DrLife.inf'
notesFile = curDir||'\Drlife.not'
cellCVfile = curDir||'\cellCV.dat' 
srcaCVfile = curDir||'\srcaCV.dat'
cycleVars = curDir||'\cycleCV.dat'
/* window names    */
mainWindowTitle = 'Cellular Automata Animator'
patternWindowTitle = 'C.A. Animator Pattern'
enterRuleWindowTitle = 'Construct a C.A.'
gifDisplayWindowTitle = 'Graphics File'
checkPointsWindow = 'Checkpoint/Restart'
sectionWindowTitle = 'Select Pattern Viewing Section & Sub-Patterns' 
multiRuleWindowtitle = 'Global Control Criteria/Rules'
randomFileParmsWindowTitle = 'Create Random Pattern file'
CALL initResources
ruleQueue = 'DRLIFE'
aQueue = RXQUEUE('create', ruleQueue)
IF aQueue <> ruleQueue THEN CALL RXQUEUE 'Delete', aQueue
oldQueue = RXQUEUE('set', ruleQueue)
CALL configOptions
CALL mainWindow.Open "", mainWindowTitle
CALL mainWindow.Hide
CALL D200.Open "", patternWindowTitle 
CALL mainWindow.Show
CALL checkConfig
IF RESULT = 1 THEN RETURN�� �d 0�  �  �  ��    '      ��  �T ) h� d ���        � � n  	 � ����        � � n  	 � ����        � �5 n  	 � ����        � �U n  	 � ����        � �j m  
 � ����        � � n  	 � ����         � � B � ( l ����        �  �	 l ?  � ����        �  �T l ?  � ����        � �� m 9 
 � ����          �� m D 
 � ����          �� B � ( v ����         �#n  
 � ����         �>n % 
 � ����          �#B ? ( ~ ����        � 6 @ 
 t ����        + �Y 6  
 y ����       
 / �� 6 4 
 u ����        : �6  
 z ����      &   >�
 & �  r ?��      &   ��� & �  s ���        H �N    
 � ����        L ��  < 	 � ����        R  �	     h ����        X  �+     i ����        ^  �M     g ����        c  �o     � ����        i  ��     � ����        o  ��     f ����      &   t��  `  m ����        u �D "  x ����        z �
   	 | ����     �  �   �*  \ 	 } ����        � ��  $ 
 � ����         �  ��    � ����        � ��  d 
 � ����        �  � @ � E � ����        �  �� @ � E � ����       	 �  �!@ D E � ����main window    L C R T C B  Horiz. Align Vert. Align Single Rule Multiple Rules  Ovr Default  Columns x 100 Ovr Rows x 100 Ovr  �      x   6.Helvetica                                                                                                              �      x   10.System Monospaced                                                                                                    Def Speed Start Pause Step CP/RS Clear Stop  Wrap Calc % DRD_PERCENTBAR  Pause at  Pattern Sections & Embeds Pattern Built-In Rules Cell Size � �d 0�  �  �      File \   �      Create a Random Pattern     Save Pattern as .GIF     Apply Edit Changes     Edit �   �     	 Configuration    
 Patterns     Sub-Patterns     Rules     Change Criteria     NeighborHoods     Pattern files     Check Points     View $   �      View Graphics files     Notes 
   �       Help 4   �      ~Contents   @��    ~Product Info ���d 0t   filemenu  randomCALL randomData  	saveImageCALL saveGIF  applyConfig�CALL configOptions
CALL loadPatterns
CALL loadRules
CALL loadExistingRules
CALL loadChangeCriteria
CALL loadFonts
CALL loadCheckPoints
CALL loadEmbeds
CALL getWindowColors	 
editConfig&'START /F /PGM ' editPgm """"cfgFile""
 patternsmenu''START /F /PGM ' editPgm """"patterns"" subpatternsmenu%'START /F /PGM ' editPgm """"embeds"" 	rulesmenu$'START /F /PGM ' editPgm """"rules"" switchrulesmenu*'START /F /PGM ' editPgm """"switchrules"" editneighbor('START /F /PGM ' editPgm """"neighbors"" editPattern�fileName = FilePrompt(patternDir'\*.*', 'Select a Pattern File')
IF fileName <> '' THEN 'START /F /PGM ' editPgm """"fileName"" editbrkPoints/'START /F /PGM ' editPgm """"checkPointFile""
 viewGraphicsCALL viewGraphics 	notesmenu+'START /F /PGM ' editPgm """"notesFile"" 
 helpmenu   :'START /f 'helpViewer """"helpFile""
CALL setPercentBar 0  �errorText = 'Product: 'mainWindowTitle 'v1.1 for classic REXX'||CR||LF||'Author: Stan Pokorney'||CR||LF||'e-mail: pokorney@insightbb.com' 
rc = modalFor('D700',, 'Messages')
���d 0�  �d Key�/* Window description

mainWindow
D200 - Pattern display
D320 - Construct a C.A.
D400 - View graphics files
D500 - Checkpoint/Restart
D600 - Partial pattern and Subpatterns
D700 - Error Messages
D800 - Multiple Rules
D900 - Random file creation
*/
Notify�rc = eventData()
SELECT
  WHEN eventData.1 = 'loadText' THEN CALL loadingtext.Text eventData.2
  WHEN eventData.1 = 'percentDone' THEN CALL loadPercent.Text eventData.2||'#'eventData.2||' %'
  WHEN eventData.1 = 'error' THEN
    DO
     errorText = eventData.2
     CALL stopExecution
     rc = ModalFor('D700',, 'Messages')
     CALL resetText
     CALL resetButtons
    END
OTHERWISE
ENDMove�winSize = mainWindow.Position()
PARSE VAR winSize newXpos newYpos .
CALL IniSet 'xpixelmain', newXpos, 'Window', cfgFile
CALL IniSet 'ypixelmain', newYpos, 'Window', cfgFile
Exit�CALL saveColors
CALL D200.Close
CALL D600.Close
CALL D800.Close
rc = DOSDEL(cellCVfile)
rc = DOSDEL(srcaCVfile)
CALL RxgdUnloadFuncs
CALL RxFuncDrop 'RxgdLoadFuncs'
CALL IniDropFuncsInit^CALL Text mainWindowTitle
CALL Position D100xpixel, D100ypixel
CALL Color '-', windowColor
�� Init.CALL Font defaultFont
CALL adjustView.DisableClick6IF mainWindow.adjustView.Select() THEN CALL selectView�� Changed6CALL VAL 'stopGeneration', mainWindow.stopAtGen.Text()Init�CALL stopAtGen.Color '-', pauseColor
CALL Font defaultFont
CALL stopAtGen.Text 999999
CALL VAL 'stopGeneration', stopAtGen.Text()�� InitCALL Font defaultFont�} InitKCALL loadPercent.Color '-', percentBar
CALL loadPercent.Font defaultFont
�| InitCALL Font defaultFont�x InitBCALL Font defaultFont
CALL wrapEdges.Select 1
CALL VAL 'wrap', 1Click#CALL VAL 'wrap', wrapEdges.Select()�m Changed^CALL VAL 'delayTime', dTime * (sleepTime.Select() - 1)
CALL VAL 'saveDelay', VAL('delayTime')Init�CALL sleepTime.Range 10
CALL sleepTime.Font defaultFont
DO i=1 TO 10
  CALL sleepTime.Item i,'Value', 11 - i
END
CALL sleepTime.Select 1
�f InitmCALL stop.Color '-', stopColor
CALL stop.Color "D-", disabledColor
CALL Font defaultFont
CALL stop.DisableClickCALL stopExecution�� InitmCALL resetPattern.Color '-', clearColor
CALL resetPattern.Color "D-", disabledColor
CALL Font defaultFont
Click"CALL resetButtons 
CALL resetText�� ClickCALL checkPointInitnCALL checkPoint.Color '-', checkPointColor
CALL checkPoint.Color "D-", disabledColor
CALL Font defaultFont
�g ClickCALL stepExecutionInitmCALL step.Color '-', stepColor
CALL step.Color "D-", disabledColor
CALL Font defaultFont
CALL step.Disable�i Init�CALL pause.Color '-', pauseColor
CALL pause.Color "D-", disabledColor
CALL Font defaultFont
CALL pause.Text 'Pause'
CALL pause.Disable
ClickCALL pauseExecution�h InitqCALL start.Color '-', startColor
CALL start.Color "D-", disabledColor
CALL Font defaultFont
CALL start.DisableClickCALL startExecution�� InitCALL Font defaultFont�� Click�/* makes single-step active when START is pressed   */
IF ssOverride.Select() = 1 THEN  CALL VAL 'ssMode', 1
ELSE 
 CALL VAL 'ssMode', 0
InitCALL Font defaultFont�s InitCALL initCellSliders�r InitCALL initCellSliders�z InitCALL Font defaultFont�u InitCALL Font defaultFont�y InitCALL Font defaultFont�t InitCALL Font defaultFont�~ Select�selectedFont = fonts.Select() 
CALL VAL 'fontNum', selectedFont
CALL D200.patternOutput.Font fontName.selectedFont
CALL VAL 'selectedFont', fontName.selectedFont  
InitbCALL fonts.Font defaultFont
CALL loadFonts
CALL fonts.Color '-', fontColor
CALL fonts.Select 1 �� Init0CALL Font defaultFont
CALL defaultFont.Select 1�� InitCALL Font defaultFont
�v SelecttIF syncVars = 0 THEN
  DO
    aNum = rules.Select()
    IF VAL('cyclicRule') = 0 THEN CALL selectRule aNum
  ENDInitrCALL rules.Font defaultFont
CALL rules.Color '-', ruleColor
CALL rules.Color "D-", disabledColor
CALL loadRules�� Init.CALL Font defaultFont
CALL multiRules.DisableClick�errorFound = 0
IF gameType = 'LIFE' THEN
  DO
    PARSE VAR ruleType . '/' . '/' ruleState
    IF ruleState > 2 THEN errorfound = 1
  END
IF gameType <> 'LIFE' THEN
  DO
    errorfound = 1
    ruleState = 'all'
  END
IF errorFound = 1 THEN
 DO
  errorText = 'Multiple Rules are incompatible features with 'gameType' patterns with 'ruleState 'states.'
  CALL stopExecution
  rc = ModalFor('D700',, 'Messages')
  CALL resetText
  CALL resetButtons
  CALL resetVariables
  CALL singleRule.Select 1
 END 
ELSE
IF multiRules.Select() THEN CALL D800.Open ,"Cyclic Rules"�� ClickCALL singleRuleAllowedInit:CALL Font defaultFont
CALL mainWindow.singleRule.Select 1�� InitCALL Font defaultFont�� InitCALL Font defaultFont�l SelectBIF syncVars = 0 THEN CALL selectPattern initialConditions.Select()Init�CALL initialConditions.Font defaultFont
CALL initialConditions.Color '-', patternColor
CALL initialConditions.Color "D-", disabledColor
CAll loadPatterns
�� Click0IF bottomAlign.Select() THEN vertAlignment = 'B'Init0CALL Font defaultFont
CALL bottomAlign.Select 0�� Click1IF VcenterAlign.Select() THEN vertAlignment = 'C'Init1CALL Font defaultFont
CALL VcenterAlign.Select 1�� Click-IF topAlign.Select() THEN vertAlignment = 'T'Init-CALL Font defaultFont
CALL topAlign.Select 0�� Init/CALL Font defaultFont
CALL rightAlign.Select 0Click+IF rightAlign.Select() THEN alignment = 'R'�� Click,IF centerAlign.Select() THEN alignment = 'C'Init0CALL Font defaultFont
CALL centerAlign.Select 1�� Init.CALL Font defaultFont
CALL leftAlign.Select 0Click*IF leftAlign.Select() THEN alignment = 'L'�� �� 0-  -  �  ��    $      d�  ��  �� � ��s        w� � & 	 � ����         �
 �0 � � C � ����        � �3� % 	 � ����         � �Z�  	 � ����        � ���  	 � ����         � ���  	 � ����        � � �  	 � ����         � �1 � �	 � ����        � � � ) 	 � ����         � �2 � Q 	 � ����        � �� � ; 	 � ����         � �� � � 	 � ����         � �     � ����      
  � �   �� � ����        � �  % 	 � ����        � �,  2 	 � ����        � �h   	 � ����        � ��  + 	 � ����        � ��  0 	 � ����         � ��    	 � ����       	 � � ( 	 � ����        � �5  	 � ����       
 � �^ * 	 � ����         � �� 0 	 � ����       
 � �  * 	 � ����         � �-  " 	 � ����        � �`  % 	 � ����          ��  + 	 � ����         ��  ' 	 � ����         ��    	 � ����         � ' 	 � ����         �6  	 � ����         �U 2 	 � ����        ' ��  	 � ����        ) ��  	 � ����        + ��  	 � ����pattern window    Pattern:  Lambda:  States:  Rule:  CA Type:  Neighborhood:     Elapsed:   # Gen:   Population:  Density%:   Cells/Gen:  Cells/Sec:  Gen/Sec:  Max Pop:   Growth%:   Col x Rows:   x   ���� 0g
  �� Move�winSize = D200.Position()
PARSE VAR winSize newXpos newYpos .
CALL IniSet 'xpixelpattern', newXpos, 'Window', cfgFile
CALL IniSet 'ypixelpattern', newYpos, 'Window', cfgFile
OpenCALL mainwindow.FocusNotify�rc = EVENTDATA()
SELECT
 WHEN eventData.1 = 'neighborhood' THEN CALL neighborHood.Text eventData.2
 WHEN eventData.1 = 'lambda-state' THEN
     DO
       PARSE VAR eventData.2 lambda states
       CALL lambdaValue.Text lambda
       CALL numStates.Text states
     END
 WHEN eventData.1 = 'sync' THEN CALL syncVars
 WHEN eventData.1 = 'rule' THEN
      DO i = 1 TO numRules
        IF eventData.2 = ruleValue.i THEN CALL ruleUsed.Text ruleTitle.i
      END
 WHEN eventData.1 = 'outputText' THEN
         CALL patternOutput.Text TRANSLATE(VAL('outStr'), xlateTable, inputTable)
 WHEN eventData.1 = 'getText' THEN 
         CALL VAL 'changedText', D200.patternOutput.Text() 
 WHEN eventData.1 = 'generationCount' THEN
       DO
         generations = eventData.2
         IF generations = VAL('stopGeneration') THEN CALL pauseExecution  
         CALL generationCount.Text formatNum(generations)
         IF gameType <> 'BINARY' THEN
             cellCount = generations * cellsHoriz * cellsVert
         ELSE
              cellCount = generations * cellsHoriz 
       END
 WHEN eventData.1 = 'elapsedTime' THEN
       DO   
        CALL eTimeValue.Text eventData.2
        eSeconds = VAL('elapsed')
        IF cellCount = 'CELLCOUNT' THEN cellcount = 0 
        CALL cellsPer.Text formatNum(cellCount % eSeconds)
        IF generations = 'GENERATIONS' THEN generations = 1
        CALL genPerSec.Text FORMAT(generations / eSeconds,,2)
       END
 WHEN eventData.1 = 'fromGenerate' THEN
  DO
    PARSE VAR eventData.2 gen pop gro den maxAlive
    CALL generationCount.Text formatNum(gen)
    CALL population.Text formatNum(pop)
    CALL growth.Text gro
    CALL density.Text den
    CALL maxPopulation.Text formatNum(maxAlive)
    cellCount = gen * cellsHoriz * cellsVert
    IF gen = VAL('stopGeneration') THEN CALL pauseExecution
  END
OTHERWISE
END
InitaCALL Text patternWindowTitle
CALL Position D200xpixel, D200ypixel
CALL Color '-', windowColor
�� ChangedCALL VAL 'patternChanged', 1Init�CALL patternOutput.Font font.1 
CALL patternOutput.Color '+', colorText
CALL patternOutput.Color '-', colorBackgnd 
CALL textColor.Color '+', colorText
�� Init*CALL D200.textColor.Color '-', colorText
�� Init�CALL patternTitle.Font defaultFont
CALL patternTitle.Color '-', patternTitleColor
CALL patternTitle.Color 'H-', patternTitleColor
CALL patternTitle.Color 'H+', '#0 0 0'�� ��0�   �   �  ��          �   �X  �� ����        
 � � � 0 
 �����         �  �B � � 
 �����    	 �   �    �  �� �����        �   �] % 
 �����d400 display GIF File    File Name:  DRD_IMAGE  Exit ����0�   ��Init<CALL Color '-', windowColor
CALL Text gifDisplayWindowtitle��ClickCALL D400.Close��InitCALL gifFile.Font defaultFont�� ��0�  �  �  ��          v�  �l h Bn ����        �� Z (  �����         � �8 Z �  �����        � � L �  �����        � � A �  ����        � � 4   �����        � �! 4 1  �����         � �  � / �����        �  �* ( 
 �����        �  � ( 
 �����        �  � ( 
 �����        �  � ( 
 �����d500 Checkpoints    Pattern:  Description of new checkpoint:    d     # Description  Activate Save Delete Cancel ����0a  ��Open CALL D500.Text checkPointsWindowInit?CALL Color '-', windowColor
CALL checkPointDescription.Text ''��InitCALL Font defaultFont
Click1CALL D500.Close
CALL stopExecution
RETURN dummy��InitCALL Font defaultFontClick�IF checkPoints.Select() = 0 THEN 
  DO
    errorText = 'Select a checkpoint to delete'
    rc = ModalFor('D700',, 'Messages') 
  END
ELSE
  DO
    index = checkPoints.Select()
    cpNum = SUBSTR(checkPoints.Item(index, 'Value'), 1, 3)
    cpFile = checkPoints.Item(index, 'Data')
    rc = DOSDEL(cpFile)
    CALL checkPoints.Delete index
    CALL IniDel 'bpDescription', 'BREAKPOINT.'cpNum, checkPointfile
    CALL IniDel 'bpFileSpec', 'BREAKPOINT.'cpNum, checkPointfile
  END��InitCALL Font defaultFontClick�/* create a new checkpoint file   */
CALL getCPFileName
CALL VAL 'breakPoint', 'S,'cpFile
bpTextDesc = checkPointDescription.Text()
bpName = cpNum' 'bpTextDesc
CALL checkPoints.Add bpName, 'L', cpFile
CALL IniSet , , 'BREAKPOINT.'cpNum, checkPointfile
CALL IniSet 'bpDescription', bpName, 'BREAKPOINT.'cpNum, checkPointfile
CALL IniSet 'bpFileSpec', cpFile, 'BREAKPOINT.'cpNum, checkPointfile
CALL D500.Close
CALL pauseExecution
RETURN dummy��InitCALL Font defaultFontClick�IF checkPoints.Select() = 0 THEN 
  DO
    errorText = 'Select a checkpoint to restart'
    rc = ModalFor('D700',, 'Messages')
  END
ELSE
  DO
    cpfile = checkPoints.Item(checkPoints.Select(), 'Data')
    CALL VAL 'breakPoint', 'A,'cpFile
    CALL D500.Close
    CALL pauseExecution
  END��Init`CALL checkPoints.Font defaultFont
CALL loadCheckPoints
CALL checkPoints.Color '-', fontColor
��Init^CALL checkPointDescription.Font defaultFont
CALL checkPointDescription.Color '-', fontColor
��Init�SELECT
  WHEN patLocation = 'KEYBOARD' THEN
     CALL currentPattern.Text 'Pattern Entered from Keyboard'
  WHEN patLocation = 'PROMPT' THEN
     CALL currentPattern.Text commentData.1
  WHEN patlocation = 'HERE' THEN
     CALL currentPattern.Text mainWindow.initialConditions.Item(patNum)
  OTHERWISE
     CALL currentPattern.Text 'Pattern from 'patLocation
END�� �X0�  �  �  ��    &      ��  �, ) �� X���    	 �  �  �  � � _����        ���   f����        � ��   g����        � �!�   p����        � �>�   j���        � �>�   k����        � �=�  	 q����        �  �� . 
 c����        ��s�   h����        � �y�   i����         �v�   t����        	 ���   l����         ���   m����         ���  	 r����          �N� . 
 a����          ��� . 
 \����          �� E 1 o����          �n� E 1 s����         ' �2 e G u����        (  � ' 
 �����        .  �= . 
 d����        7��f  
 x����        < ��\  
 y����        A ��g   n��C        K ��]   {��M        U ��D  
 ����        W ��6  
 �����        [ ��D  
 �����        ^ ��6  
 �����        b  �n % 
 �����        h  �� ! 
 e����       	 l  �{X > # z����        v  �{2 > $ }����        ��   	 v����        � �  � 	 w����        �  �� . 
 b����        �  �� � S ~����        �  � � q |����d600 Select Section & Embeds    DRD_IMAGE  Begin: End: Total:             Snapshot Begin: End: Total:       Mark Apply Rows Columns  Pause Selected Row: Col:                 0 180 90 270 Clear Add Insert At Rotation CW Wait   Close Select Pattern Section Sub-Patterns ���X0�  �XNotify�rc = eventData()
IF eventData.1 = 'waiting' THEN CALL waiting.Text eventData.2
IF eventData.1 = 'gifCreated' THEN
  DO
    CALL VAL 'endWait', 1
    gifFile = eventData.2
    CALL D600.c607.Text gifFile
    CALL D600.c607.text "#E 1"
    CALL getData.Enable
    CALL applyView.Enable
    CALL closeView.Enable
    CALL D600.Focus
    CALL waiting.Text ''
  ENDOpenCALL D600.FocusMove�winSize = Position()
PARSE VAR winSize newXpos newYpos .
CALL IniSet 'xpixelsection', newXpos, 'Window', cfgFile
CALL IniSet 'ypixelsection', newYpos, 'Window', cfgFile
D600xpixel = newXpos
D600ypixel = newYpos
Init�CALL Text sectionWindowTitle
CALL Color '-', windowColor
CALL Position D600xpixel, D600ypixel
CALL rotate0.Select 1
CALL processSubpattern.Disable
CALL addSubpattern.Disable
IF VAL('pauseStarted') = 1 THEN CALL pauseProcessing.Disable�bInitCALL Font defaultFontClickkCALL D600.Close
IF VAL('pauseStarted') = 1 THEN CALL pauseExecution
CALL mainWindow.adjustView.Select 0
�wInitCALL Font defaultFont�eClickCALL processSubpatternInitCALL Font defaultFont��Click�CALL subPatterns.Select 0
CALL insertAtRow.Text 0
CALL insertAtCol.Text 0
CALL rotate0.Select 1
CALL processSubpattern.Disable
CALL addSubpattern.DisableInitCALL Font defaultFont�{Init>CALL insertAtCol.Color '-', ruleColor
CALL insertAtCol.Text 0�nInit>CALL insertAtRow.Color '-', ruleColor
CALL insertAtRow.Text 0�dClickCALL getSubpatternInitCALL Font defaultFont��Click�IF VAL('inCycle') = 0 THEN
    DO
      errorText = 'Pattern must be started before Pause is available.'
      rc = ModalFor('D700',, 'Messages') 
      SIGNAL noAction
    END
IF VAL('pauseStarted') = 0 THEN CALL pauseExecution
CALL pauseProcessing.Disable
CALL D600.Focus
noAction:InitCALL Font defaultFont�uSelect�IF mainWindow.initialConditions.Select() = 0 THEN
  DO
    errorText = 'Select pattern to be used.'
    rc = modalFor('D700',, 'Messages')
    CALL subPatterns.Select 0
  END
ELSE
  DO
    CALL addSubpattern.disable
    CALL processSubpattern.Enable
  ENDInit�CALL subPatterns.Font defaultFont
CALL subPatterns.Color '-', ruleColor
IF embedSections.0 > 0 THEN
 DO i = 1 TO embedSections.0
   CALL subPatterns.Add embedTitle.i, 'L', embedSections.i
 END�\InitCALL Font defaultFont
ClickCALL applyView�aInitCALL Font defaultFontClick�/* get selected coordinates  */
retrieved = c607.text()
PARSE VAR retrieved startColumn endLine endColumn startLine
IF retrieved = '0 0 0 0' THEN 
  DO
    errorText = 'No selection, or selection is too near edges'
    rc = ModalFor('D700',, 'Messages')
  END
ELSE
  DO
    startColumn = xlateSection('horiz', startColumn)
    endColumn   = xlateSection('horiz', endColumn)
    startLine   = xlateSection('vert', startLine)
    endLine     = xlateSection('vert', endLine) 
    CALL D600.firstLine.Text startLine
    CALL D600.lastLine.Text endLine
    CALL D600.numLinesSelected.Text endLine - startLine + 1
    CALL D600.firstColumn.Text startColumn
    CALL D600.lastColumn.Text endColumn
    CALL D600.numColumnsSelected.Text endColumn - startColumn + 1
  END�mInit$CALL lastColumn.Color '-', ruleColor�lInit%CALL firstColumn.Color '-', ruleColor�cInitCALL Font defaultFontClickCALL snapshot
CALL D600.Top�kInit"CALL lastLine.Color '-', ruleColor�jInit#CALL firstLine.Color '-', ruleColor�_Init+CALL D600.viewblock.Color '-', colorBackgnd�� ��0�   �   �  ��          h   �� � 6 ���p       
  t  �   �v ��        �   ��  / 
 �����Message                  Exit ����0�   ��OpenCALL soundBeepInitCALL Color '-', windowColor��ClickCALL D700.Close
RETURN nothing��InitCALL errorText.Text errorText�� � 0�  �  �  ��          �  �0 8 ��  ���       1 �	 � � 
 %����         5	 � � o8 ,����        6 � | @ 
 .����         G � r o
 -����        H �
 b V 
 $����         \ �
  � B "����         ] ��  � B #����        ^  �IT $ 
 &����        a  �IF $ 
 '����        f  �I8 $ 
 (����        m  �I+ $ 
 *����        s  �J $ 
 )����        x��  U 
 /����        z  �! Y 
 !����        �  ��  � P +����Control Criteria    Global Control Criteria - Add, Change, or Delete:  Active Criteria:  Existing Rule/Type:   Up Down Delete Clear Load   Stop Global Control Global Control Rules: ��� 0s  � Move�winSize = D800.Position()
PARSE VAR winSize newXpos newYpos .
CALL IniSet 'xpixelmultiRule', newXpos, 'Window', cfgFile
CALL IniSet 'ypixelmultiRule', newYpos, 'Window', cfgFile
Init�CALL Text multiRuleWindowTitle
D800xpixel = IniGet('xpixelmultiRule', 'Window', cfgFile)
D800ypixel = IniGet('ypixelmultiRule', 'Window', cfgFile)
CALL Position D800xpixel, D800ypixel
CALL Color '-', windowColor
CALL VAL 'cyclicRule', 1
ruleCount = 0
CALL numQueued.Text 'Rules Queued = 'rulecount�!InitCALL Font defaultFont
ClickPCALL D800.Close
CALL mainWindow.singleRule.Select 1
CALL VAL 'cyclicRule', 0
�)InitCALL Font defaultFont
ClickFCALL queueCyclicRules
CALL numQueued.Text 'Rules Queued = 'QUEUED()
�*InitCALL Font defaultFont
Click|CALL selectedRules.Delete 
rulecount = 0
DO WHILE QUEUED() > 0
  PULL
END
CALL numQueued.Text 'Rules Queued = 'QUEUED()�(InitCALL Font defaultFont
Click�index = selectedRules.Select()
IF index > 0 THEN
  DO
    CALL selectedRules.Delete index
    ruleCount = ruleCount -1
    CALL reIndex
  END�'InitCALL Font defaultFont
Click�index = selectedRules.Select()
IF index > 0 THEN
 DO
  numItems = selectedRules.Item()
  newIndex = index + 1
  item = selectedRules.Item(index)
  itemData = selectedRules.Item(index, 'Data')
  IF index < numItems THEN
    DO
      CALL selectedRules.Delete index 
      CALL selectedRules.Add item, newIndex, itemData
      CALL reIndex
    END
  CALL selectedRules.Select newIndex
 END�&InitCALL Font defaultFont
Click�index = selectedRules.Select()
IF index > 0 THEN
 DO
  item = selectedRules.Item(index)
  itemData = selectedRules.Item(index, 'Data')
  IF index > 1 THEN
    DO
     CALL selectedRules.Add item, index - 1, itemData
     CALL selectedRules.Select index - 1
     CALL selectedRules.Delete index + 1
     CALL reIndex 
    END
 END�#InitNCALL selectedRules.Font defaultFont
CALL selectedRules.Color '-', ruleColor
�"Select�item = existingRules.Item(existingRules.Select())
queueData = existingRules.Item(existingRules.Select(), "Data")
ruleCount = selectedRules.Item()
rulecount = rulecount + 1 
CALL selectedRules.Add rulecount||'. '||item, "L", queueData
CALL existingRules.Select 0
InitdCALL existingRules.Font defaultFont
CALL existingRules.Color '-', ruleColor
CALL loadExistingRules�-InitRCALL currentCriteria.Font defaultFont
CALL currentCriteria.Color '-', ruleColor
�,ChangedCALL changeCriteria.Select 0Select�anIndex = changeCriteria.Select()
IF anIndex > 0 THEN
  DO
   index = anIndex
   changeOnData = changeCriteria.Item(index) 
   CALL currentCriteria.Focus
   CALL currentCriteria.Text changeOnData
   CALL VAL 'criteria', changeOnData
   CALL changeCriteria.Focus 
  ENDEnterCALL updateCriteriaInitiCALL changeCriteria.Font defaultFont
CALL changeCriteria.Color '-', ruleColor
CALL loadChangeCriteria
�� ��0L  L  �  ��         & f  �H Z �� ����         � � Z O B �����         � �k Y � B �����         � �� Y � B �����        �� B  
 �����        � �H B # 
 �����        � �� B . 
 �����       
 � �[@ +  �����          � � 4  
 ����          � �F 4  
 ����      &   � �� . �  �����      &   � �). �  �����       ( � � " � 
 �����       	  ��  + 
 �����          ��  �  ���        &  �^ (  �����        -  �� (  �����        4  �
 S X Q �����        9  �g S � Q �����        F  �� S � Q �����D900 get parms for random pattern file       States Density Horiz Cells Vert Cells                                      NOTE: Rule is modified by state selected File Name   �     Cancel Create Game Neighborhood Rules ����0g  ��InitmCALL Color '-', windowColor
CALL Text randomFileParmsWindowtitle
CALL closeRandom.Disable 
windowID = ID()��InitECALL closeRandom.Color '-', closeRandomColor
CALL Font defaultFont
Click�	/* called from D900 CLOSE button (closeRandom_Click)  */
SELECT
 WHEN horizCells2.Select() = 1 THEN cellsHoriz = 24 
 WHEN horizCells2.Select() = 2 THEN cellsHoriz = 50
 WHEN horizCells2.Select() = 3 THEN cellsHoriz = 100
 WHEN horizCells2.Select() = 4 THEN cellsHoriz = 200
 WHEN horizCells2.Select() = 5 THEN cellsHoriz = 300
OTHERWISE
END
SELECT
  WHEN vertCells2.Select() = 1 THEN cellsVert = 24
  WHEN vertCells2.Select() = 2 THEN cellsVert = 50
  WHEN vertCells2.Select() = 3 THEN cellsVert = 100
  WHEN vertCells2.Select() = 4 THEN cellsVert = 200
  WHEN vertCells2.Select() = 5 THEN cellsVert = 300
OTHERWISE
END
randFile = randomFile.Text()
state = states.Select()
gameType = game.Item(game.Select())
gameType = SPACE(gameType, ,'*')
nbhType = nbrHood.Item(nbrHood.Select(), "Data")
nbhTitle = nbrHood.Item(nbrHood.Select())
nbhTitle = SPACE(nbhTitle, ,'*')
IF randomizeFactor.Select() = 10 THEN selectedDensity = 95
ELSE
  selectedDensity = 10 * randomizeFactor.Select()
rule = rules2.Item(rules2.Select(), "data")
closeRandomColor = closeRandom.Color('-')
CALL IniSet 'closeRandomBtnColor', closeRandomColor, 'Window', cfgFile
CALL D900.Close
RETURN cellsHoriz cellsVert state selectedDensity rule randFile gameType nbhType nbhTitle��InitMCALL cancelCreate.Color '-', cancelCreateRandomColor
CALL Font defaultFont
ClickCALL D900.Close
RETURN 1��InitxCALL randomFile.Font defaultFont
CALL randomFile.Color '-', ruleColor
CALL randomFile.Text patternDir||'\Random.lif'
��Init�CALL Range 5
CALL Font defaultFont
CALL Item 1,'Value', 24 
CALL Item 2,'Value', 50 
CALL Item 3,'Value', 100 
CALL Item 4,'Value', 200 
CALL Item 5,'Value', 300 
CALL Select 1
cellsVert = 24
��Init�CALL Range 5
CALL Font defaultFont
CALL Item 1,'Value', 24 
CALL Item 2,'Value', 50 
CALL Item 3,'Value', 100 
CALL Item 4,'Value', 200 
CALL Item 5,'Value', 300 
CALL Select 1
cellsHoriz = 24
��GetFocus*CALL randomizeFactor.Color '-', ruleColor Init�value.0 = 10
value.1 = 10
value.2 = 20
value.3 = 30
value.4 = 40
value.5 = 50
value.6 = 60
value.7 = 70
value.8 = 80
value.9 = 90
value.10 = 95
CALL randomizeFactor.Range "VALUE"
CALL randomizeFactor.Color '-', ruleColor  
CALL randomizeFactor.Font defaultFont
��InitVCALL Font defaultFont 
CALL states.Color '-', ruleColor
CALL states.Range 2, 35 

��SelectCALL closeRandom.enableInit�CALL rules2.Font defaultFont
CALL rules2.Color '-', ruleColor
DO i = 1 TO ruleSections.0
ruleValue.i = IniGet('ruleValue', ruleSections.i, rules)
IF SUBSTR(ruleValue.i, 1, 1) = 'D' | SUBSTR(ruleValue.i, 1, 1) = 'X'THEN ITERATE
ruleTitle.i = IniGet('TITLE', ruleSections.i, rules)
IF ruleTitle.i <> '' THEN CALL rules2.Add ruleTitle.i' -- 'ruleValue.i,"L", ruleValue.i
END
��SelectYnbrType = nbrHood.Item(nbrHood.Select(), 'Data')
CALL loadRules2
CALL rules2.Select 1
InitSCALL nbrHood.Font defaultFont
CALL loadGameID
CALL nbrHood.Color '-', fontColor
��SelectgameType = TRANSLATE(game.Item(game.Select(), 'Value'))
CALL loadNbrHoods
IF nbrHood.Item() > 0 THEN CALL nbrHood.Select 1 
Init`CALL game.Font defaultFont
CALL loadGameID
CALL game.Color '-', fontColor
CALL game.Select 1 �����0!   �Selecting state modifies rule�� �@0�  �  �  ��          �  �\ p x� @���         � �
 Z < 9 A����         � �S Z | 9 C����         � �� Z � 9 D����         �	 �  � < E����        �  �& -  J����        � �5& 5 
 H����        �  � -  K����        �  �< -  I����        �  � T D G �����        �  �R T � G �����        �  �� T � G �����        �  �  � G �����CA Development        Lambda   Cancel Continue Game Neighborhood Pattern Rule & State ���@0�  �@InitLCALL Text enterRuleWindowTitle
CALL Color '-', windowColor
windowID = ID()�IClick�ovrRideNeighbor = neighborhoodID.Item(neighborhoodID.Select(), "Data")
section = patterns.Item(patterns.Select(), 'DATA')
CALL D320.Close 
RETURN dummy�KClickCALL D320.close
RETURN 1�JClick�gameType = TRANSLATE(gameID.Item(gameID.Select()))
tempRule = ruleID.Text()
PARSE VAR tempRule ruleType '--' RuleTitle
nbhType =  TRANSLATE(neighborHoodID.Item(neighborhoodID.Select(), 'Data'))
SELECT
  WHEN gameType = 'BINARY' THEN CALL decodeBinaryRule
  WHEN gameType = 'LIFE' THEN CALL decodeLifeRule
  WHEN gameType = 'GENERATIONS' THEN CALL decodeLifeRule
  WHEN gameType = 'CYCLIC CA' THEN CALL decodeLifeRule
  WHEN gameType = 'SECOND ORDER' THEN CALL decodeLifeRule
  WHEN gameType = 'MARGOLUS' THEN CALL decodeMargolusRule
OTHERWISE
END
CALL getNeighbors
CALL calcLambda
CALL D320.dispLambda.Text lambda�EChangedFtempRule = ruleID.Text()
PARSE VAR tempRule ruleType '--' ruleTitle
Init@CALL ruleID.Font defaultFont
CALL ruleID.Color '-', fontColor
�DSelect�section = patterns.Item(patterns.Select(), 'DATA')
i = 1
patternData.i = IniGet(patData.i, section, patterns)
DO UNTIL patternData.i = ''
  i = i + 1
  patternData.i = IniGet(patData.i, section, patterns)
END 
Init�CALL patterns.Font defaultFont
CALL patterns.Color '-', fontColor
CALL patterns.Delete
DO i = 1 TO numPatterns
  patLocation  = TRANSLATE(IniGet('patternFrom', PATTERN.i, patterns))
  IF patLocation <> 'HERE' THEN ITERATE  
  patTitle.i = IniGet('TITLE', patternSections.i, patterns)
  IF patTitle.i <> '' THEN CALL patterns.Add patTitle.i,"L", patternSections.i
END
CALL patterns.Select 1
�CSelectgnbrType = neighborhoodID.Item(neighborhoodID.Select(), 'Data')
CALL loadRuleID
CALL ruleID.Select 1
InitlCALL neighborhoodID.Font defaultFont
CALL neighborhoodID.Color '-', fontColor
CALL neighborhoodID.Select 1�ASelect�gameType = TRANSLATE(gameID.Item(gameID.Select(), 'Value'))
CALL loadNeighborHoods
IF neighborhoodID.Item() > 0 THEN CALL neighborhoodID.Select 1 
InithCALL gameID.Font defaultFont
CALL loadGameID
CALL gameID.Color '-', fontColor
CALL gameID.Select 1 
�