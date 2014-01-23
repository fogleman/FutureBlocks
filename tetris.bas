'Future Blocks - By Michael Fogleman
'Start Date : April 20, 2000
'Finish Date: April 24, 2000

Start:
 DECLARE SUB BlueColors ()
 DECLARE SUB RestoreColors ()
 DECLARE SUB Colors (c%, r%, g%, b%)
 DECLARE SUB GetPal ()
 DECLARE SUB CompeteScreen ()
 DECLARE SUB GameOverScreen ()
 DECLARE SUB Menu ()
 DECLARE SUB PreOccupy (height%)
 DECLARE SUB DrawBlock2 (x%, y%, c%)
 DECLARE SUB DrawPiece2 (px%, py%, piece%, col%)
 DECLARE SUB DrawText (x%, y%, txt$, c%, size%, typ%)
 DECLARE SUB TitleScreen ()
 DECLARE SUB ReadText ()
 DECLARE SUB DrawLetter (x%, y%, letter%, c%, size%, typ%)
 DECLARE SUB InfoDisplay ()
 DECLARE SUB CheckFinalMove ()
 DECLARE SUB ComputerPlay (Display%)
 DECLARE SUB CompComplete ()
 DECLARE SUB MoveLeft ()
 DECLARE SUB MoveRight ()
 DECLARE SUB CheckOverlap ()
 DECLARE SUB RotatePiece ()
 DECLARE SUB RefreshField ()
 DECLARE SUB CheckComplete ()
 DECLARE SUB CheckTouch ()
 DECLARE SUB StoreOccupy ()
 DECLARE SUB DebugDisplay ()
 DECLARE SUB MainLoop ()
 DECLARE SUB Delay (dtime!)
 DECLARE SUB NewPiece ()
 DECLARE SUB DrawField ()
 DECLARE SUB DrawBlock (xn%, yn%, c%)
 DECLARE SUB ReadData ()
 DECLARE SUB DrawPiece (xn%, yn%, piece%, r%, col%)
 COMMON SHARED FieldWidth%, FieldHeight%, BlockSize%, XOffset%, YOffset%, Occupied%()
 COMMON SHARED PieceData%(), CurrentColor%(), Text%(), PieceList%(), competen%
 COMMON SHARED CurrentPiece%, PieceX%, PieceY%, PieceR%, PieceC%, Grid%, CMN%
 COMMON SHARED OldPiece%, OldX%, OldY%, OldR%, GameOver%, Overlap%, Debug%
 COMMON SHARED NumComplete%, hint%, CPlay%, DestX%, DestY%, DestR%, usery%, pal%()
 COMMON SHARED LineWeight, GapWeight, HeightWeight, ink$, NextC%, SideWeight
 COMMON SHARED DispWidth%, DispHeight%, DispX%, DispY%, XShift%, messyheight%
 COMMON SHARED Lines%, Score&, GameTime&, StartTime, PieceTime, AirTime, Compete%
 COMMON SHARED gap%, shadow%, Lines2%, Score2&, GameTime2&, NextPiece%, Pieces&, Pieces2&
 COMMON SHARED YourLines%, YourScore&, lastmove%

 DIM PieceData%(17, 3, 6)
 DIM Text%(39, 34)
 DIM PieceList%(999)
 DIM pal%(50)
 ReadData
 ReadText

 CLS
 SCREEN 12

 GetPal
 TitleScreen
 Grid% = 0
 Debug% = 0
 LineWeight = 3
 GapWeight = 4
 HeightWeight = 1
 SideWeight = 1
 FieldWidth% = 12
 FieldHeight% = 24
 BlockSize% = 16
 competen% = 50

DoneComp:
 DO
 Compete% = 0
 Menu
 GameOver% = 0
 CLS
 RANDOMIZE TIMER
 NextPiece% = RND * 6 + 1
 NextC% = RND * 6 + 1
 GameTime2& = -1
 Lines2% = -1
 Pieces2& = -1
 Score2& = -1
 Pieces& = 0
 Lines% = 0
 Score& = 0
 DispHeight% = 440
 DispWidth% = 147
 DispY% = (480 - DispHeight%) / 2
 DispX% = 640 - DispY% - DispWidth%
 XShift% = 320 - (DispX% / 2)
 XOffset% = ((BlockSize% + 2) * FieldWidth%) / 2
 YOffset% = ((BlockSize% + 2) * FieldHeight%) / 2
 IF Compete% = 1 THEN GOTO CompetitionMode
 gap% = 6: shadow% = 2
 DrawField
 DIM CurrentColor%(FieldWidth%, FieldHeight%)
 DIM Occupied%(FieldWidth%, FieldHeight%)
 IF messyheight% > 0 THEN PreOccupy messyheight%
 NewPiece
 StartTime = TIMER
 MainLoop
 GameOverScreen
 ERASE Occupied%, CurrentColor%
 LOOP

CompetitionMode:
 hint% = 0
 CMN% = 0
 n% = 0
 DO
 PieceList%(n%) = RND * 6 + 1
 n% = n% + 1
 LOOP WHILE n% < 1000
 CPlay% = 0
 gap% = 6: shadow% = 2
 DrawField
 DIM CurrentColor%(FieldWidth%, FieldHeight%)
 DIM Occupied%(FieldWidth%, FieldHeight%)
 IF messyheight% > 0 THEN PreOccupy messyheight%
 NewPiece
 StartTime = TIMER
 MainLoop
 GameOverScreen
 YourLines% = Lines%
 YourScore& = Score&
 ERASE Occupied%, CurrentColor%

 CMN% = 0
 GameOver% = 0
 CLS
 RANDOMIZE TIMER
 GameTime2& = -1
 Lines2% = -1
 Pieces2& = -1
 Score2& = -1
 Pieces& = 0
 Lines% = 0
 Score& = 0
 gap% = 6: shadow% = 2
 CPlay% = 1
 DrawField
 DIM CurrentColor%(FieldWidth%, FieldHeight%)
 DIM Occupied%(FieldWidth%, FieldHeight%)
 IF messyheight% > 0 THEN PreOccupy messyheight%
 NewPiece
 StartTime = TIMER
 MainLoop
 GameOverScreen
 ERASE Occupied%, CurrentColor%
 CompeteScreen
 GOTO DoneComp

Piece1:
 DATA 2,3
 DATA 1,0
 DATA 1,1
 DATA 0,1
 DATA 3,2
 DATA 0,1,1
 DATA 1,1,0
 DATA 2,3
 DATA 1,0
 DATA 1,1
 DATA 0,1
 DATA 3,2
 DATA 0,1,1
 DATA 1,1,0
Piece2:
 DATA 2,3
 DATA 0,1
 DATA 1,1
 DATA 1,0
 DATA 3,2
 DATA 1,1,0
 DATA 0,1,1
 DATA 2,3
 DATA 0,1
 DATA 1,1
 DATA 1,0
 DATA 3,2
 DATA 1,1,0
 DATA 0,1,1
Piece3:
 DATA 2,2
 DATA 1,1
 DATA 1,1
 DATA 2,2
 DATA 1,1
 DATA 1,1
 DATA 2,2
 DATA 1,1
 DATA 1,1
 DATA 2,2
 DATA 1,1
 DATA 1,1
Piece4:
 DATA 1,4
 DATA 1
 DATA 1
 DATA 1
 DATA 1
 DATA 4,1
 DATA 1,1,1,1
 DATA 1,4
 DATA 1
 DATA 1
 DATA 1
 DATA 1
 DATA 4,1
 DATA 1,1,1,1
Piece5:
 DATA 2,3
 DATA 1,0
 DATA 1,0
 DATA 1,1
 DATA 3,2
 DATA 1,1,1
 DATA 1,0,0
 DATA 2,3
 DATA 1,1
 DATA 0,1
 DATA 0,1
 DATA 3,2
 DATA 0,0,1
 DATA 1,1,1
Piece6:
 DATA 2,3
 DATA 0,1
 DATA 0,1
 DATA 1,1
 DATA 3,2
 DATA 1,0,0
 DATA 1,1,1
 DATA 2,3
 DATA 1,1
 DATA 1,0
 DATA 1,0
 DATA 3,2
 DATA 1,1,1
 DATA 0,0,1
Piece7:
 DATA 3,2
 DATA 0,1,0
 DATA 1,1,1
 DATA 2,3
 DATA 1,0
 DATA 1,1
 DATA 1,0
 DATA 3,2
 DATA 1,1,1
 DATA 0,1,0
 DATA 2,3
 DATA 0,1
 DATA 1,1
 DATA 0,1

Text:
 DATA 0,0,1,0,0
 DATA 0,1,0,1,0
 DATA 1,0,0,0,1
 DATA 1,1,1,1,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1

 DATA 1,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,1,1,1,0

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 1,1,1,0,0
 DATA 1,0,0,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,1,0
 DATA 1,1,1,0,0

 DATA 1,1,1,1,1
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,1,1,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,1,1,1,1

 DATA 1,1,1,1,1
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,1,1,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,1,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,1,1,1,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1

 DATA 1,1,1,1,1
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 1,1,1,1,1

 DATA 1,1,1,1,1
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 1,1,0,0,0

 DATA 1,0,0,0,1
 DATA 1,0,0,1,0
 DATA 1,0,1,0,0
 DATA 1,1,0,0,0
 DATA 1,0,1,0,0
 DATA 1,0,0,1,0
 DATA 1,0,0,0,1

 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,1,1,1,1

 DATA 1,0,0,0,1
 DATA 1,1,0,1,1
 DATA 1,0,1,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1

 DATA 1,0,0,0,1
 DATA 1,1,0,0,1
 DATA 1,1,0,0,1
 DATA 1,0,1,0,1
 DATA 1,0,1,0,1
 DATA 1,0,0,1,1
 DATA 1,0,0,0,1

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 1,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,1,1,1,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0
 DATA 1,0,0,0,0

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,1,0,1
 DATA 1,0,0,1,1
 DATA 0,1,1,1,0

 DATA 1,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,1,1,1,0
 DATA 1,0,1,0,0
 DATA 1,0,0,1,0
 DATA 1,0,0,0,1

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,0
 DATA 0,1,1,1,0
 DATA 0,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 1,1,1,1,1
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0

 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,0,1,0
 DATA 0,0,1,0,0

 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,1,0,1
 DATA 1,1,0,1,1
 DATA 1,0,0,0,1

 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,0,1,0
 DATA 0,0,1,0,0
 DATA 0,1,0,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1

 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,0,1,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0

 DATA 1,1,1,1,1
 DATA 0,0,0,0,1
 DATA 0,0,0,1,0
 DATA 0,0,1,0,0
 DATA 0,1,0,0,0
 DATA 1,0,0,0,0
 DATA 1,1,1,1,1

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,1,0,0,1
 DATA 1,0,1,0,1
 DATA 1,0,0,1,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 0,0,1,0,0
 DATA 0,1,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,1,1,1,0

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 0,0,0,0,1
 DATA 0,0,0,1,0
 DATA 0,0,1,0,0
 DATA 0,1,0,0,0
 DATA 1,1,1,1,1

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 0,0,0,0,1
 DATA 0,0,1,1,0
 DATA 0,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 0,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 1,1,1,1,1
 DATA 0,0,0,0,1
 DATA 0,0,0,0,1
 DATA 0,0,0,0,1

 DATA 1,1,1,1,1
 DATA 1,0,0,0,0
 DATA 1,1,1,1,0
 DATA 0,0,0,0,1
 DATA 0,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,0
 DATA 1,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 1,1,1,1,1
 DATA 0,0,0,0,1
 DATA 0,0,0,0,1
 DATA 0,0,0,1,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 0,1,1,1,0
 DATA 1,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,1
 DATA 0,0,0,0,1
 DATA 1,0,0,0,1
 DATA 0,1,1,1,0

 DATA 1,0,0,0,0
 DATA 0,1,0,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,1,0,0,0
 DATA 1,0,0,0,0

 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 1,0,0,0,0

 DATA 0,0,0,0,0
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 1,1,1,1,1
 DATA 0,0,1,0,0
 DATA 0,0,1,0,0
 DATA 0,0,0,0,0

 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 1,1,1,1,1
 DATA 0,0,0,0,0
 DATA 0,0,0,0,0
 DATA 0,0,0,0,0

SUB BlueColors
 r% = pal%(3)
 g% = pal%(4)
 b% = pal%(5)
 n% = 0
 DO
 Colors n%, r%, g%, b%
 n% = n% + 1
 LOOP WHILE n% < 16
END SUB

SUB CheckComplete
 DIM c%(FieldHeight%)
 x% = 1: y% = 1: f% = 0
 DO
 o% = Occupied%(x%, y%)
 IF x% = FieldWidth% AND o% > 0 THEN
  IF Debug% = 1 THEN LOCATE f% + 18, 1: PRINT "LINE"; y%; "COMPLETE"
  Lines% = Lines% + 1
  c%(f%) = y%: f% = f% + 1: x% = 0: y% = y% + 1
 END IF
 x% = x% + 1
 IF o% = 0 THEN x% = 1: y% = y% + 1
 LOOP WHILE y% <= FieldHeight%
 IF f% = 0 THEN EXIT SUB

 IF AirTime > 4 THEN AirTime = 4
 Score& = Score& + f% * 100 * (5 - AirTime)
 n% = 0
 DO
 GOSUB Shift
 n% = n% + 1
 LOOP WHILE n% < f%
 EXIT SUB
Shift:
 y% = c%(n%)
 xn% = 1: yn% = y%
 DO WHILE yn% > 1
 Occupied%(xn%, yn%) = Occupied%(xn%, yn% - 1)
 xn% = xn% + 1
 IF xn% > FieldWidth% THEN xn% = 1: yn% = yn% - 1
 LOOP
 RefreshField
 RETURN

END SUB

SUB CheckFinalMove
  ink$ = INKEY$
  IF ink$ = CHR$(0) + "K" THEN
   MoveLeft
   lastmove% = 1
  END IF
  IF ink$ = CHR$(0) + "M" THEN
   MoveRight
   lastmove% = 1
  END IF
  IF ink$ = CHR$(0) + "H" THEN
   RotatePiece
   lastmove% = 1
  END IF
  EXIT SUB
END SUB

SUB CheckOverlap
  DIM xn%(3)
  DIM yn%(3)
  s% = 0
  xn% = PieceX%: yn% = PieceY%
  Xs% = PieceData%(0, PieceR%, CurrentPiece% - 1)
  Ys% = PieceData%(1, PieceR%, CurrentPiece% - 1)
  maxn% = Xs% * Ys%
  n% = 0
  DO
  c% = PieceData%(n% + 2, PieceR%, CurrentPiece% - 1)
  IF c% = 0 THEN
   ELSE
   xn%(s%) = xn%: yn%(s%) = yn%
   s% = s% + 1
  END IF
  xn% = xn% + 1
  IF xn% - PieceX% >= Xs% THEN xn% = PieceX%: yn% = yn% + 1
  n% = n% + 1
  LOOP WHILE n% < maxn%

  'Make Sure Piece Is In Bounds.
  'If not, return -1.
  n% = 0
  Overlap% = 0
  DO
  IF xn%(n%) > FieldWidth% THEN Overlap% = -1: EXIT SUB
  IF yn%(n%) > FieldHeight% THEN Overlap% = -1: EXIT SUB
  IF xn%(n%) < 1 THEN Overlap% = -1: EXIT SUB
  IF yn%(n%) < 1 THEN Overlap% = -1: EXIT SUB
  n% = n% + 1
  LOOP WHILE n% < 4

  'Check If This Location Would Overlap Another Piece.
  n% = 0
  Overlap% = 0
  DO
  IF Occupied%(xn%(n%), yn%(n%)) = 0 THEN
   ELSE
   Overlap% = Overlap% + 1
  END IF
  n% = n% + 1
  LOOP WHILE n% < 4
END SUB

SUB CheckTouch
  'This sub checks if the piece has landed on anything.
  'First, Check if piece has hit the bottom of the field.
  XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
  YSize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
  MaxY% = PieceY% + YSize%
  IF MaxY% = FieldHeight% + 1 THEN GOTO StopPiece
  
  'See if it has hit another piece.
  'Find Base Points
  DIM BaseX%(3), BaseY%(3) '4 is highest poss. number of base points.
  BaseX%(0) = PieceX%
  IF XSize% > 1 THEN BaseX%(1) = PieceX% + 1
  IF XSize% > 2 THEN BaseX%(2) = PieceX% + 2
  IF XSize% > 3 THEN BaseX%(3) = PieceX% + 3

  xn% = PieceX%: yn% = PieceY%
  maxn% = XSize% * YSize%
  n% = 0
  DO
  c% = PieceData%(n% + 2, PieceR%, CurrentPiece% - 1)
  IF c% = 0 THEN
   ELSE
   e% = xn% - PieceX%
   BaseY%(e%) = yn%
  END IF
  xn% = xn% + 1
  IF xn% - PieceX% >= XSize% THEN xn% = PieceX%: yn% = yn% + 1
  n% = n% + 1
  LOOP WHILE n% < maxn%
  
  n% = 0
  DO
  IF BaseX%(n%) = 0 THEN
   ELSE
   IF BaseY%(n%) > 0 THEN
    IF Occupied%(BaseX%(n%), BaseY%(n%) + 1) > 0 THEN
     IF BaseY%(n%) < 2 THEN GameOver% = 1: EXIT SUB
     GOTO StopPiece
    END IF
   END IF
  END IF
  n% = n% + 1
  LOOP WHILE n% < 4

  EXIT SUB
StopPiece:
  IF CPlay% = 0 THEN
   lmtime = TIMER
   DO
   lastmove% = 0
   CheckFinalMove
   LOOP WHILE TIMER - lmtime < .5 AND lastmove% = 0
  END IF
  AirTime = TIMER - PieceTime
  IF AirTime > 7 THEN AirTime = 7
  Score& = Score& + (8 - AirTime) * 5
  StoreOccupy
  RefreshField
  CheckComplete
  NewPiece
END SUB

SUB Colors (c%, r%, g%, b%)
 OUT &H3C8, c%
 OUT &H3C9, r%
 OUT &H3C9, g%
 OUT &H3C9, b%
END SUB

SUB CompComplete
 x% = 1: y% = 1: f% = 0
 DO
 o% = Occupied%(x%, y%)
 IF x% = FieldWidth% AND o% > 0 THEN
  f% = f% + 1: x% = 0: y% = y% + 1
 END IF
 x% = x% + 1
 IF o% = 0 THEN x% = 1: y% = y% + 1
 LOOP WHILE y% <= FieldHeight%
 NumComplete% = f%
END SUB

SUB CompeteScreen
  BlueColors
  LINE (0, 0)-(640, 480), 1, BF
  gap% = 4: shadow% = 2
  DrawText 85, 25, "Competition Mode", 7, 4, 2
  size% = 6
  x% = 40: y% = 80
  sx% = x%: c% = 7
  DO
  LINE (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
  LINE (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
  LINE (x%, y%)-(x% + size%, y%), 15
  LINE (x%, y%)-(x%, y% + size%), 15
  LINE (x% + size%, y%)-(x% + size%, y% + size%), 8
  LINE (x%, y% + size%)-(x% + size%, y% + size%), 8
  x% = x% + size% + 1
  LOOP WHILE x% < 600
  gap% = 2: shadow% = 1
  DrawText 15, 460, "Future Software", 7, 1, 2
  DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
  gap% = 4: shadow% = 1
  DrawText 80, 400, "PRESS ANY KEY TO CONTINUE", 7, 2, 2
  gap% = 4: shadow% = 2
  DrawText 80, 110, "YOU", 7, 4, 2
  DrawText 510, 110, "ME", 7, 4, 2
  DrawText 245, 150, "SCORE", 7, 4, 2
  DrawText 245, 270, "LINES", 7, 4, 2

  DrawText 5, 200, STR$(YourScore&), 7, 4, 2
  DrawText 5, 320, STR$(YourLines%), 7, 4, 2

  sc$ = STR$(Score&)
  DO WHILE LEN(sc$) < 11
  sc$ = " " + sc$
  LOOP
  DrawText 280, 200, sc$, 7, 4, 2

  sc$ = STR$(Lines%)
  DO WHILE LEN(sc$) < 11
  sc$ = " " + sc$
  LOOP
  DrawText 280, 320, sc$, 7, 4, 2
  RestoreColors

  DO
  ink$ = INKEY$
  LOOP WHILE ink$ = ""

END SUB

SUB ComputerPlay (Display%)
 'This is the brain! Computer plays tetris.
 'First, find all possible placement positions.
 stime = TIMER
 XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
 YSize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
 PrevX% = PieceX%
 PrevY% = PieceY%
 PrevR% = PieceR%
 DIM picks%(100)
 DIM BaseX%(3), BaseY%(3)
 DIM PossibleX%(100)
 DIM PossibleY%(100)
 DIM PossibleR%(100)
 DIM Evaluation%(100)
 GOSUB NegEval
 'X and R are the controlled variables, find Y for each combination.
 n% = 0
 xn% = 1
 DO
 r% = 0
 DO
 GOSUB GetY
 PossibleX%(n%) = xn%
 PossibleY%(n%) = PieceY%
 PossibleR%(n%) = r%
 n% = n% + 1
 r% = r% + 1
 LOOP WHILE r% < 4
 xn% = xn% + 1
 LOOP WHILE xn% < FieldWidth% + 2

 'Now, evaluate each position. This is the tough part.
 'Copy the occupied array, so we can see if any moves complete a line.
 DIM TempOccupied%(FieldWidth%, FieldHeight%)
 n1% = 0: n2% = 0
 DO
 TempOccupied%(n1%, n2%) = Occupied%(n1%, n2%)
 n1% = n1% + 1
 IF n1% > FieldWidth% THEN n1% = 0: n2% = n2% + 1
 LOOP WHILE n2% <= FieldHeight%

 'Put each possible position/rotation in. Check for complete line.
 n% = 0
 DO
 PieceX% = PossibleX%(n%)
 PieceY% = PossibleY%(n%)
 PieceR% = PossibleR%(n%)
 IF PieceY% > 0 THEN
  'LOCATE 1, 40: PRINT PieceX%; PieceY%; PieceR%; n%
  Evaluation%(n%) = PieceY% * HeightWeight
  StoreOccupy
  CompComplete
  Evaluation%(n%) = Evaluation%(n%) + NumComplete% * LineWeight
  GOSUB RestoreArray
 END IF
 n% = n% + 1
 LOOP WHILE n% < 101
 
 'Check if next to any pieces.
 n% = 0
 DO
 PieceX% = PossibleX%(n%)
 PieceY% = PossibleY%(n%)
 PieceR% = PossibleR%(n%)
 XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
 YSize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
 DO
 IF PieceX% - 1 > 0 AND PieceX% - 1 <= FieldWidth% AND PieceY% > 0 AND PieceY% <= FieldHeight% THEN
  'DrawBlock PieceX% - 1, PieceY%, -1
  IF Occupied%(PieceX% - 1, PieceY%) > 0 THEN
   Evaluation%(n%) = Evaluation%(n%) + SideWeight
  END IF
 END IF
 IF PieceX% + XSize% > 0 AND PieceX% + XSize% <= FieldWidth% AND PieceY% > 0 AND PieceY% <= FieldHeight% THEN
  'DrawBlock PieceX% - 1, PieceY%, -1
  IF Occupied%(PieceX% + XSize%, PieceY%) > 0 THEN
   Evaluation%(n%) = Evaluation%(n%) + SideWeight
  END IF
 END IF
 PieceY% = PieceY% + 1
 LOOP WHILE PieceY% - PossibleY%(n%) < YSize%
 n% = n% + 1
 LOOP WHILE n% < 101


 'Check For Gaps Under Piece.
 'This is similar to CheckTouch Sub.
 n% = 0
 DO
 PieceX% = PossibleX%(n%)
 PieceY% = PossibleY%(n%)
 PieceR% = PossibleR%(n%)
 IF PieceY% > 0 THEN
  XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
  YSize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
  BaseX%(0) = 0: BaseX%(1) = 0: BaseX%(2) = 0: BaseX%(3) = 0
  BaseY%(0) = 0: BaseY%(1) = 0: BaseY%(2) = 0: BaseY%(3) = 0
  BaseX%(0) = PieceX%
  IF XSize% > 1 THEN BaseX%(1) = PieceX% + 1
  IF XSize% > 2 THEN BaseX%(2) = PieceX% + 2
  IF XSize% > 3 THEN BaseX%(3) = PieceX% + 3
  xn% = PieceX%: yn% = PieceY%
  maxn% = XSize% * YSize%
  bn% = 0
  DO
  c% = PieceData%(bn% + 2, PieceR%, CurrentPiece% - 1)
  IF c% = 0 THEN
   ELSE
   e% = xn% - PieceX%
   BaseY%(e%) = yn%
  END IF
  xn% = xn% + 1
  IF xn% - PieceX% >= XSize% THEN xn% = PieceX%: yn% = yn% + 1
  bn% = bn% + 1
  LOOP WHILE bn% < maxn%

  gaps% = 0
  bn% = 0
  DO
  IF BaseX%(bn%) = 0 THEN
   ELSE
   IF BaseY%(bn%) > 0 AND BaseY%(bn%) < FieldHeight% THEN
    IF Occupied%(BaseX%(bn%), BaseY%(bn%) + 1) = 0 THEN
     gaps% = gaps% + 1
    END IF
   END IF
  END IF
  bn% = bn% + 1
  LOOP WHILE bn% < 4
  Evaluation%(n%) = Evaluation%(n%) - gaps% * GapWeight
 END IF
 n% = n% + 1
 LOOP WHILE n% < 101
 
 'Find Max/Min Evaluation.
 n% = 0
 maxeval% = -1000
 mineval% = 1000
 DO
 IF Evaluation%(n%) < mineval% THEN mineval% = Evaluation%(n%)
 IF Evaluation%(n%) > maxeval% THEN
  maxeval% = Evaluation%(n%)
 END IF
 n% = n% + 1
 LOOP WHILE n% < 101

 DO
 n% = RND * 100
 LOOP WHILE Evaluation%(n%) < maxeval% OR PossibleX%(n%) = 0 OR PossibleY%(n%) = 0
 PieceX% = PossibleX%(n%)
 PieceY% = PossibleY%(n%)
 PieceR% = PossibleR%(n%)
 IF Display% = 1 THEN
  DrawPiece PieceX%, PieceY%, CurrentPiece%, PieceR%, -1
 END IF
 'LOCATE 13, 73: PRINT USING "#####"; Evaluation%(n%)

 'Rid of unnecessary rotation.
 IF CurrentPiece% = 1 OR CurrentPiece% = 2 OR CurrentPiece% = 4 THEN
  IF PieceR% = 3 THEN PieceR% = 1
  IF PieceR% = 2 THEN PieceR% = 0
 END IF
 IF CurrentPiece% = 3 THEN PieceR% = 0

 'n% = 0
 'DO
 PieceX% = PossibleX%(n%)
 PieceY% = PossibleY%(n%)
 PieceR% = PossibleR%(n%)
 XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
 YSize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
 DO
 IF PieceX% - 1 > 0 AND PieceX% - 1 <= FieldWidth% AND PieceY% > 0 AND PieceY% <= FieldHeight% THEN
  'DrawBlock PieceX% - 1, PieceY%, -1
  IF Occupied%(PieceX% - 1, PieceY%) > 0 THEN
   Evaluation%(n%) = Evaluation%(n%) + SideWeight
  END IF
 END IF
 IF PieceX% + XSize% > 0 AND PieceX% + XSize% <= FieldWidth% AND PieceY% > 0 AND PieceY% <= FieldHeight% THEN
  'DrawBlock PieceX% + XSize%, PieceY%, -1
  IF Occupied%(PieceX% + XSize%, PieceY%) > 0 THEN
   Evaluation%(n%) = Evaluation%(n%) + SideWeight
  END IF
 END IF
 PieceY% = PieceY% + 1
 LOOP WHILE PieceY% - PossibleY%(n%) < YSize%
 'n% = n% + 1
 'LOOP WHILE n% < 101


 DestX% = PieceX%
 DestY% = PieceY%
 DestR% = PieceR%

 PieceX% = PrevX%
 PieceY% = PrevY%
 PieceR% = PrevR%
 EXIT SUB

GetY:
 yn% = 1
 PieceX% = xn%
 PieceY% = yn%
 PieceR% = r%
 CheckOverlap
 IF Overlap% = 0 THEN
  ELSE
  PieceY% = 0
  RETURN
 END IF
 DO
 PieceY% = PieceY% + 1
 CheckOverlap
 LOOP WHILE Overlap% = 0
 PieceY% = PieceY% - 1
 RETURN
RestoreArray:
 n1% = 0: n2% = 0
 DO
 Occupied%(n1%, n2%) = TempOccupied%(n1%, n2%)
 n1% = n1% + 1
 IF n1% > FieldWidth% THEN n1% = 0: n2% = n2% + 1
 LOOP WHILE n2% <= FieldHeight%
 RETURN
NegEval:
 en% = 0
 DO
 Evaluation%(en%) = -100
 en% = en% + 1
 LOOP WHILE en% < 101
 RETURN
END SUB

SUB DebugDisplay
  LOCATE 1, 1
  PRINT "Debugging"
  PRINT "   Information"
  PRINT
  PRINT "X       :"; PieceX%
  PRINT "Y       :"; PieceY%
  PRINT "Piece   :"; CurrentPiece%
  PRINT "Rotation:"; PieceR%
  PRINT
  PRINT "Field Width :"; FieldWidth%
  PRINT "Field Height:"; FieldHeight%
  PRINT
  PRINT "Field Coordinates:"
  PRINT " X1:"; 320 - XOffset%
  PRINT " Y1:"; 240 - YOffset%
  PRINT " X2:"; 320 + XOffset%
  PRINT " Y2:"; 240 + YOffset%
END SUB

SUB Delay (dtime!)
 stime = TIMER
 DO
 LOOP WHILE TIMER - stime < dtime!
END SUB

SUB DrawBlock (xn%, yn%, c%)
  IF xn% < 1 OR yn% < 1 THEN EXIT SUB
  IF CurrentColor%(xn%, yn%) = c% THEN EXIT SUB
  CurrentColor%(xn%, yn%) = c%
  IF xn% > FieldWidth% OR yn% > FieldHeight% THEN EXIT SUB
  x% = 320 - XOffset% + 1 + (xn% - 1) * (BlockSize% + 2) - XShift%
  y% = 240 - YOffset% + 1 + (yn% - 1) * (BlockSize% + 2)
  'IF c% > -1 THEN LINE (x%, y%)-(x% + BlockSize%, y% + BlockSize%), c%, BF
  IF c% = 0 THEN LINE (x%, y%)-(x% + BlockSize%, y% + BlockSize%), c%, BF
  IF c% > 0 THEN
   LINE (x% + 1, y% + 1)-(x% + BlockSize% - 1, y% + BlockSize% - 1), c%, BF
   LINE (x%, y%)-(x% + BlockSize%, y%), 15
   LINE (x%, y%)-(x%, y% + BlockSize%), 15
   LINE (x% + BlockSize%, y%)-(x% + BlockSize%, y% + BlockSize%), 8
   LINE (x%, y% + BlockSize%)-(x% + BlockSize%, y% + BlockSize%), 8
  END IF
  IF c% = -1 THEN LINE (x%, y%)-(x% + BlockSize%, y% + BlockSize%), 15, B
END SUB

SUB DrawBlock2 (x%, y%, c%)
  IF c% = 0 THEN LINE (x%, y%)-(x% + 16, y% + 16), c%, BF
  IF c% > 0 THEN
   LINE (x% + 1, y% + 1)-(x% + 16 - 1, y% + 16 - 1), c%, BF
   LINE (x%, y%)-(x% + 16, y%), 15
   LINE (x%, y%)-(x%, y% + 16), 15
   LINE (x% + 16, y%)-(x% + 16, y% + 16), 8
   LINE (x%, y% + 16)-(x% + 16, y% + 16), 8
  END IF
  IF c% = -1 THEN LINE (x%, y%)-(x% + 16, y% + 16), 15, B
END SUB

SUB DrawField
  BlueColors
  size% = 67
  x% = -1 * size% / 2: y% = -1 * size% / 2
  sx% = x%
  c% = RND * 4
  IF c% = 4 THEN c% = 7
  DO
  LINE (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
  LINE (x%, y%)-(x% + size%, y%), 15
  LINE (x%, y%)-(x%, y% + size%), 15
  LINE (x% + size%, y%)-(x% + size%, y% + size%), 8
  LINE (x%, y% + size%)-(x% + size%, y% + size%), 8
  x% = x% + size% + 2
  IF x% > 640 THEN x% = sx%: y% = y% + size% + 2
  LOOP WHILE y% < 480
  
  LINE (320 - XOffset% - XShift% - 4, 240 - YOffset% - 4)-(320 + XOffset% - XShift% + 4, 240 + YOffset% + 4), 0, BF
  LINE (320 - XOffset% - XShift% - 4, 240 - YOffset% - 4)-(320 + XOffset% - XShift% + 4, 240 + YOffset% + 4), 15, B
  LINE (320 - XOffset% - XShift% - 2, 240 - YOffset% - 2)-(320 + XOffset% - XShift% + 2, 240 + YOffset% + 2), 7, B
  LINE (DispX% - 4, DispY% - 4)-(DispX% + DispWidth% + 4, DispY% + DispHeight% + 4), 0, BF
  LINE (DispX% - 2, DispY% - 2)-(DispX% + DispWidth% + 2, DispY% + DispHeight% + 2), 7, B
  LINE (DispX% - 4, DispY% - 4)-(DispX% + DispWidth% + 4, DispY% + DispHeight% + 4), 15, B
  'LOCATE 3, 61: PRINT "Score:"
  'LOCATE 4, 69: PRINT USING "#########"; 0
  'LOCATE 6, 61: PRINT "Lines Cleared:"
  'LOCATE 7, 73: PRINT USING "#####"; 0
  'LOCATE 9, 61: PRINT "Game Time:"
  'LOCATE 10, 73: PRINT USING "#####"; 0
  'LOCATE 12, 61: PRINT "Evaluation:"

  gap% = 2: shadow% = 1
  DrawText DispX% + 7, 25, "SCORE", 7, 1, 2
  DrawText DispX% + 7, 95, "LINES", 7, 1, 2
  DrawText DispX% + 7, 165, "TIME", 7, 1, 2
  DrawText DispX% + 7, 355, "NEXT PIECE", 7, 1, 2
  DrawText DispX% + 7, 237, "PIECES", 7, 1, 2

  IF Grid% = 1 THEN
   x1% = 320 - XOffset%: y1% = 240 - YOffset%
   x2% = 320 + XOffset%: y2% = 240 + YOffset%
   DO
   LINE (x1%, y1%)-(x1%, y2%), 8
   x1% = x1% + BlockSize% + 2
   LOOP WHILE x1% < x2%

   x1% = 320 - XOffset%: y1% = 240 - YOffset%
   x2% = 320 + XOffset%: y2% = 240 + YOffset%
   DO
   LINE (x1%, y1%)-(x2%, y1%), 8
   y1% = y1% + BlockSize% + 2
   LOOP WHILE y1% < y2%
  END IF
  RestoreColors
END SUB

SUB DrawLetter (x%, y%, letter%, c%, size%, typ%)
 sx% = x%: sy% = y%
 xn% = 0: yn% = 0
 n% = 0
 DO
 d% = Text%(letter%, n%)
 IF d% = 1 THEN
  IF typ% = 0 THEN
   LINE (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
   LINE (x%, y%)-(x% + size%, y%), 15
   LINE (x%, y%)-(x%, y% + size%), 15
   LINE (x% + size%, y%)-(x% + size%, y% + size%), 8
   LINE (x%, y% + size%)-(x% + size%, y% + size%), 8
  END IF
  IF typ% = 1 THEN
   LINE (x%, y%)-(x% + size%, y% + size%), c%, BF
  END IF
  IF typ% = 2 THEN
   LINE (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
   LINE (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
   LINE (x%, y%)-(x% + size%, y%), 15
   LINE (x%, y%)-(x%, y% + size%), 15
   LINE (x% + size%, y%)-(x% + size%, y% + size%), 8
   LINE (x%, y% + size%)-(x% + size%, y% + size%), 8
  END IF
 END IF
 n% = n% + 1
 xn% = xn% + 1
 x% = x% + size% + 1
 IF xn% > 4 THEN xn% = 0: x% = sx%: y% = y% + size% + 1
 LOOP WHILE n% < 35
END SUB

SUB DrawPiece (xn%, yn%, piece%, r%, col%)
 x% = xn%: y% = yn%
 Xs% = PieceData%(0, r%, piece% - 1)
 Ys% = PieceData%(1, r%, piece% - 1)
 n% = 0
 DO
 c% = PieceData%(n% + 2, r%, piece% - 1)
 dc% = 0
 IF c% = 0 THEN  ELSE dc% = 1
 IF dc% = 1 THEN DrawBlock xn%, yn%, col%
 xn% = xn% + 1
 IF xn% - x% >= Xs% THEN xn% = x%: yn% = yn% + 1
 n% = n% + 1
 LOOP WHILE yn% < y% + Ys%
END SUB

SUB DrawPiece2 (px%, py%, piece%, col%)
 x% = px%: y% = py%
 xn% = 0: yn% = 0
 Xs% = PieceData%(0, 1, piece% - 1)
 Ys% = PieceData%(1, 1, piece% - 1)
 n% = 0
 DO
 c% = PieceData%(n% + 2, 1, piece% - 1)
 dc% = 0
 IF c% = 0 THEN  ELSE dc% = 1
 IF dc% = 1 THEN DrawBlock2 x%, y%, col%
 x% = x% + 18'BlockSize% + 2
 xn% = xn% + 1
 IF xn% >= Xs% THEN xn% = 0: x% = px%: y% = y% + 18: yn% = yn% + 1
 n% = n% + 1
 LOOP WHILE yn% < Ys%
END SUB

SUB DrawText (x%, y%, txt$, c%, size%, typ%)
 txt$ = UCASE$(txt$)
 sx% = x%: sy% = y%
 n% = 1
 DO
 t$ = MID$(txt$, n%, 1)
 t% = ASC(t$)
 IF t% = 32 THEN GOTO Skip
 IF t% = 41 THEN t% = 36
 IF t% = 46 THEN t% = 37
 IF t% = 43 THEN t% = 38
 IF t% = 45 THEN t% = 39
 IF t% > 64 AND t% < 91 THEN
  t% = t% - 65
 END IF
 IF t% > 47 AND t% < 58 THEN
  t% = t% - 22
 END IF
 DrawLetter x%, y%, t%, c%, size%, typ%
Skip:
 y% = sy%
 x% = x% + (size% + 1) * 5 + gap%
 n% = n% + 1
 LOOP WHILE n% < LEN(txt$) + 1
END SUB

SUB GameOverScreen
  BlueColors
  LINE (0, 0)-(640, 480), 1, BF
  gap% = 6: shadow% = 3
  DrawText 135, 20, "Game Over", 7, 6, 2
  size% = 6
  x% = 40: y% = 80
  sx% = x%: c% = 7
  DO
  LINE (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
  LINE (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
  LINE (x%, y%)-(x% + size%, y%), 15
  LINE (x%, y%)-(x%, y% + size%), 15
  LINE (x% + size%, y%)-(x% + size%, y% + size%), 8
  LINE (x%, y% + size%)-(x% + size%, y% + size%), 8
  x% = x% + size% + 1
  LOOP WHILE x% < 600
  gap% = 2: shadow% = 1
  DrawText 15, 460, "Future Software", 7, 1, 2
  DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
  gap% = 4: shadow% = 1
  DrawText 80, 400, "PRESS ANY KEY TO CONTINUE", 7, 2, 2

  gap% = 4: shadow% = 2
  DrawText 65, 120, "Score", 7, 4, 2
  DrawText 65, 180, "Lines", 7, 4, 2
  DrawText 65, 240, "Time", 7, 4, 2
  DrawText 65, 300, "Pieces", 7, 4, 2

  sc$ = STR$(Score&)
  DO WHILE LEN(sc$) < 11
  sc$ = " " + sc$
  LOOP
  DrawText 265, 120, sc$, 7, 4, 2

  sc$ = STR$(Lines%)
  DO WHILE LEN(sc$) < 11
  sc$ = " " + sc$
  LOOP
  DrawText 265, 180, sc$, 7, 4, 2

  sc$ = STR$(GameTime&)
  DO WHILE LEN(sc$) < 11
  sc$ = " " + sc$
  LOOP
  DrawText 265, 240, sc$, 7, 4, 2

  sc$ = STR$(Pieces&)
  DO WHILE LEN(sc$) < 11
  sc$ = " " + sc$
  LOOP
  DrawText 265, 300, sc$, 7, 4, 2
  RestoreColors

  DO
  ink$ = INKEY$
  LOOP WHILE ink$ = ""

END SUB

SUB GetPal
 n% = 0: c% = 0
 DO
 OUT &H3C6, &HFF
 OUT &H3C7, c%
 rr% = INP(&H3C9)
 gg% = INP(&H3C9)
 bb% = INP(&H3C9)
 pal%(n%) = rr%
 pal%(n% + 1) = gg%
 pal%(n% + 2) = bb%
 n% = n% + 3: c% = c% + 1
 LOOP WHILE c% < 16
END SUB

SUB InfoDisplay
  'LOCATE 4, 69: PRINT USING "#########"; Score&
  'LOCATE 7, 73: PRINT USING "#####"; Lines%
  'LOCATE 10, 73: PRINT USING "#####"; GameTime&
  gap% = 2: shadow% = 1

  IF Score& = Score2& THEN
   ELSE
   LINE (DispX% + 5, 44)-(DispX% + DispWidth% - 2, 62), 0, BF
   sc$ = STR$(Score&)
   DO WHILE LEN(sc$) < 11
   sc$ = " " + sc$
   LOOP
   DrawText DispX% + 9, 45, sc$, 7, 1, 2
   Score2& = Score&
  END IF

  IF Lines% = Lines2% THEN
   ELSE
   LINE (DispX% + 5, 114)-(DispX% + DispWidth% - 2, 132), 0, BF
   sc$ = STR$(Lines%)
   DO WHILE LEN(sc$) < 11
   sc$ = " " + sc$
   LOOP
   DrawText DispX% + 9, 115, sc$, 7, 1, 2
   Lines2% = Lines%
  END IF

  IF GameTime& = GameTime2& THEN
   ELSE
   LINE (DispX% + 5, 184)-(DispX% + DispWidth% - 2, 202), 0, BF
   sc$ = STR$(GameTime&)
   DO WHILE LEN(sc$) < 11
   sc$ = " " + sc$
   LOOP
   DrawText DispX% + 9, 185, sc$, 7, 1, 2
   GameTime2& = GameTime&
  END IF
  
  IF Pieces& = Pieces2& THEN
   ELSE
   LINE (DispX% + 5, 254)-(DispX% + DispWidth% - 2, 272), 0, BF
   sc$ = STR$(Pieces&)
   DO WHILE LEN(sc$) < 11
   sc$ = " " + sc$
   LOOP
   DrawText DispX% + 9, 255, sc$, 7, 1, 2
   Pieces2& = Pieces&
  END IF

END SUB

SUB MainLoop
  OldPiece% = 1
  DO

  IF CPlay% = 0 THEN pausetime = .225 ELSE pausetime = 0
  stime = TIMER
  DO

  x% = OldX%: y% = OldY%: p% = OldPiece%: r% = OldR%
  'Delay .01

  GameTime& = TIMER - StartTime
  InfoDisplay

  WAIT 986, 8
  DrawPiece x%, y%, p%, r%, 0
  x% = PieceX%: y% = PieceY%: p% = CurrentPiece%: r% = PieceR%: c% = PieceC%
  DrawPiece x%, y%, p%, r%, c%
  IF Debug% = 1 THEN DebugDisplay
  CheckTouch
  IF GameOver% = 1 THEN EXIT SUB
  OldX% = PieceX%: OldY% = PieceY%: OldPiece% = CurrentPiece%: OldR% = PieceR%

  DO
  ink$ = INKEY$
  IF ink$ = CHR$(27) THEN GameOver% = 1
  cmove% = 0
  IF CPlay% = 1 THEN
   IF TIMER - ctime > -1 THEN
   IF cmove% = 0 THEN
    IF PieceR% = DestR% THEN
     ELSE
     'RotatePiece
     ink$ = CHR$(0) + "H"
     cmove% = 1
     ctime = TIMER
    END IF
   END IF
   IF PieceX% < DestX% AND cmove% = 0 THEN
    'MoveRight
    ink$ = CHR$(0) + "M"
    cmove% = 1
    ctime = TIMER
   END IF
   IF PieceX% > DestX% AND cmove% = 0 THEN
    'MoveLeft
    ink$ = CHR$(0) + "K"
    cmove% = 1
    ctime = TIMER
   END IF
   END IF
  END IF
  LOOP WHILE TIMER - stime < pausetime AND ink$ = ""

  usery% = 0
  IF ink$ = CHR$(0) + "P" THEN
   PieceY% = PieceY% + 1
   usery% = 1
  END IF
  IF ink$ = CHR$(0) + "K" THEN
   MoveLeft
  END IF
  IF ink$ = CHR$(0) + "M" THEN
   MoveRight
  END IF
  IF ink$ = CHR$(0) + "H" THEN
   RotatePiece
  END IF
  FOR a = 1 TO 15
  a$ = INKEY$
  NEXT
  LOOP WHILE TIMER - stime < pausetime
  IF Compete% = 1 THEN
   IF CMN% > competen% THEN EXIT SUB
  END IF
  IF usery% = 0 THEN PieceY% = PieceY% + 1
  LOOP
END SUB

SUB Menu
Menu:
  BlueColors
  LINE (0, 0)-(640, 480), 1, BF
  gap% = 6: shadow% = 3
  DrawText 55, 20, "Future Blocks", 7, 6, 2
  gap% = 4: shadow% = 2
  DrawText 65, 110, "1.Normal Game Mode", 7, 3, 2
  DrawText 65, 160, "2.Hint Mode", 7, 3, 2
  DrawText 65, 210, "3.Computer Mode", 7, 3, 2
  DrawText 65, 260, "4.Competition Mode", 7, 3, 2
  DrawText 65, 310, "5.Options", 7, 3, 2
  DrawText 65, 360, "6.Exit", 7, 3, 2
  gap% = 2: shadow% = 1
  DrawText 15, 460, "Future Software", 7, 1, 2
  DrawText 395, 460, "By Michael Fogleman", 7, 1, 2

  size% = 6
  x% = 40: y% = 80
  sx% = x%: c% = 7
  DO
  LINE (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
  LINE (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
  LINE (x%, y%)-(x% + size%, y%), 15
  LINE (x%, y%)-(x%, y% + size%), 15
  LINE (x% + size%, y%)-(x% + size%, y% + size%), 8
  LINE (x%, y% + size%)-(x% + size%, y% + size%), 8
  x% = x% + size% + 1
  LOOP WHILE x% < 600
  RestoreColors
BadKey:
  DO
  ink$ = INKEY$
  LOOP WHILE ink$ = ""
  IF ink$ = "1" THEN hint% = 0: CPlay% = 0: EXIT SUB
  IF ink$ = "2" THEN hint% = 1: CPlay% = 0: EXIT SUB
  IF ink$ = "3" THEN hint% = 0: CPlay% = 1: EXIT SUB
  IF ink$ = "4" THEN GOTO Compete
  IF ink$ = "5" THEN GOTO Options
  IF ink$ = "6" THEN CLS : END
  GOTO BadKey

Compete:
  BlueColors
  LINE (0, 0)-(640, 480), 1, BF
  Compete% = 1
  GOSUB Header
  gap% = 4: shadow% = 2
  DrawText 85, 115, "Competition Mode", 7, 4, 2
  DrawText 230, 180, "Play to", 7, 3, 2
  DrawText 265, 220, STR$(competen%), 7, 3, 2
  DrawText 240, 260, "Blocks", 7, 3, 2
  GOSUB InfoHeader
  RestoreColors
  DO
  ink$ = INKEY$
  IF ink$ = "+" THEN
   competen% = competen% + 1
   LINE (260, 218)-(400, 255), 1, BF
   DrawText 265, 220, STR$(competen%), 7, 3, 2
  END IF
  IF ink$ = "-" THEN
   competen% = competen% - 1
   LINE (260, 218)-(400, 255), 1, BF
   DrawText 265, 220, STR$(competen%), 7, 3, 2
  END IF
  LOOP WHILE NOT ink$ = CHR$(27)
  EXIT SUB

Options:
  BlueColors
  GOSUB Header
  gap% = 4: shadow% = 2
  DrawText 65, 100, "1.PreStack", 7, 3, 2
  DrawText 465, 100, STR$(messyheight%), 7, 3, 2
  DrawText 65, 140, "2.Field Width", 7, 3, 2
  DrawText 465, 140, STR$(FieldWidth%), 7, 3, 2
  DrawText 65, 180, "3.Field Height", 7, 3, 2
  DrawText 465, 180, STR$(FieldHeight%), 7, 3, 2
  DrawText 65, 220, "4.Block Size", 7, 3, 2
  DrawText 465, 220, STR$(BlockSize%), 7, 3, 2
  DrawText 65, 260, "5.Line Weight", 7, 3, 2
  DrawText 465, 260, STR$(LineWeight), 7, 3, 2
  DrawText 65, 300, "6.Gap Weight", 7, 3, 2
  DrawText 465, 300, STR$(GapWeight), 7, 3, 2
  DrawText 65, 340, "7.Stack Weight", 7, 3, 2
  DrawText 465, 340, STR$(HeightWeight), 7, 3, 2
  DrawText 65, 380, "8.Side Weight", 7, 3, 2
  DrawText 465, 380, STR$(SideWeight), 7, 3, 2
  DrawText 65, 420, "9.Menu", 7, 3, 2
  gap% = 2: shadow% = 1
  DrawText 15, 460, "Future Software", 7, 1, 2
  DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
  RestoreColors
BadKey2:
  DO
  ink$ = INKEY$
  LOOP WHILE ink$ = ""
  IF ink$ = "9" THEN GOTO Menu
  IF ink$ = "1" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "PreStack", 7, 3, 2
   DrawText 465, 200, STR$(messyheight%), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    messyheight% = messyheight% + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(messyheight%), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    messyheight% = messyheight% - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(messyheight%), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF

  IF ink$ = "2" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "Field Width", 7, 3, 2
   DrawText 465, 200, STR$(FieldWidth%), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    FieldWidth% = FieldWidth% + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(FieldWidth%), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    FieldWidth% = FieldWidth% - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(FieldWidth%), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF

  IF ink$ = "3" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "Field Height", 7, 3, 2
   DrawText 465, 200, STR$(FieldHeight%), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    FieldHeight% = FieldHeight% + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(FieldHeight%), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    FieldHeight% = FieldHeight% - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(FieldHeight%), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF

  IF ink$ = "4" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "Block Size", 7, 3, 2
   DrawText 465, 200, STR$(BlockSize%), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    BlockSize% = BlockSize% + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(BlockSize%), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    BlockSize% = BlockSize% - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(BlockSize%), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF

  IF ink$ = "5" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "Line Weight", 7, 3, 2
   DrawText 465, 200, STR$(LineWeight), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    LineWeight = LineWeight + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(LineWeight), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    LineWeight = LineWeight - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(LineWeight), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF

  IF ink$ = "6" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "Gap Weight", 7, 3, 2
   DrawText 465, 200, STR$(GapWeight), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    GapWeight = GapWeight + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(GapWeight), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    GapWeight = GapWeight - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(GapWeight), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF

  IF ink$ = "7" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "Stack Weight", 7, 3, 2
   DrawText 465, 200, STR$(HeightWeight), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    HeightWeight = HeightWeight + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(HeightWeight), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    HeightWeight = HeightWeight - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(HeightWeight), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF

  IF ink$ = "8" THEN
   BlueColors
   GOSUB Header
   GOSUB InfoHeader
   gap% = 4: shadow% = 2
   DrawText 65, 200, "Side Weight", 7, 3, 2
   DrawText 465, 200, STR$(SideWeight), 7, 3, 2
   RestoreColors
   DO
   ink$ = INKEY$
   IF ink$ = "+" THEN
    SideWeight = SideWeight + 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(SideWeight), 7, 3, 2
   END IF
   IF ink$ = "-" THEN
    SideWeight = SideWeight - 1
    LINE (460, 190)-(639, 230), 1, BF
    DrawText 465, 200, STR$(SideWeight), 7, 3, 2
   END IF
   LOOP WHILE NOT ink$ = CHR$(27)
   GOTO Options
  END IF
  GOTO BadKey2
 
InfoHeader:
  gap% = 4: shadow% = 2
  DrawText 115, 360, "Use + and - To Change", 7, 2, 2
  DrawText 135, 390, "Press ESC When Done", 7, 2, 2
  gap% = 2: shadow% = 1
  DrawText 15, 460, "Future Software", 7, 1, 2
  DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
  RETURN
Header:
  LINE (0, 0)-(640, 480), 1, BF
  gap% = 6: shadow% = 3'2
  DrawText 55, 20, "Future Blocks", 7, 6, 2
  size% = 6
  x% = 40: y% = 80
  sx% = x%: c% = 7
  DO
  LINE (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
  LINE (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
  LINE (x%, y%)-(x% + size%, y%), 15
  LINE (x%, y%)-(x%, y% + size%), 15
  LINE (x% + size%, y%)-(x% + size%, y% + size%), 8
  LINE (x%, y% + size%)-(x% + size%, y% + size%), 8
  x% = x% + size% + 1
  LOOP WHILE x% < 600
  RETURN
END SUB

SUB MoveLeft
  PrevX% = PieceX%
  IF PieceX% > 1 THEN PieceX% = PieceX% - 1
  Overlap% = 0
  CheckOverlap
  IF Overlap% = 0 THEN  ELSE PieceX% = PrevX%
END SUB

SUB MoveRight
  PrevX% = PieceX%
  XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
  IF PieceX% <= FieldWidth% - XSize% THEN PieceX% = PieceX% + 1
  Overlap% = 0
  CheckOverlap
  IF Overlap% = 0 THEN  ELSE PieceX% = PrevX%
END SUB

SUB NewPiece
  Pieces& = Pieces& + 1
  IF Compete% = 0 THEN CurrentPiece% = NextPiece%
  IF Compete% = 1 THEN CurrentPiece% = PieceList%(CMN%): CMN% = CMN% + 1
BadPiece:
  IF Compete% = 0 THEN
   NextPiece% = RND * 100 + 1
   IF NextPiece% > 7 THEN GOTO BadPiece
  END IF
  IF Compete% = 1 THEN
   NextPiece% = PieceList%(CMN%)
  END IF
  PieceX% = FieldWidth% / 2
  PieceR% = 0
  XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
  YSize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
  PieceY% = -1 * YSize%
  PieceC% = NextC%
BadColor:
  NextC% = RND * 13 + 1
  IF NextC% = 8 THEN GOTO BadColor
  ComputerPlay 0
  IF hint% = 1 THEN ComputerPlay 1
  LINE (DispX% + 7, 383)-(DispX% + DispWidth% - 7, 385 + 16 * 4.5), 0, BF
  Xs% = PieceData%(0, 1, NextPiece% - 1) + 1
  DrawPiece2 DispX% + DispWidth% / 2 - BlockSize% * Xs% / 2, 385, NextPiece%, NextC%
  PieceTime = TIMER
END SUB

SUB PreOccupy (height%)
 xn% = 1: yn% = FieldHeight% - height% + 1
 DO
 a% = RND
BCol:
 c% = RND * 13 + 1
 IF c% = 8 THEN GOTO BCol
 IF a% = 1 THEN Occupied%(xn%, yn%) = c%
 xn% = xn% + 1
 IF xn% > FieldWidth% THEN xn% = 1: yn% = yn% + 1
 LOOP WHILE yn% <= FieldHeight%
 RefreshField
END SUB

SUB ReadData
 RESTORE Piece1
 piece% = 0
 DO
 r% = 0
 DO
 READ Xs%, Ys%
 PieceData%(0, r%, piece%) = Xs%
 PieceData%(1, r%, piece%) = Ys%
 b% = Xs% * Ys%
 n% = 0
 DO
 READ PieceData%(n% + 2, r%, piece%)
 n% = n% + 1
 LOOP WHILE n% < b%
 r% = r% + 1
 LOOP WHILE r% < 4
 piece% = piece% + 1
 LOOP WHILE piece% < 7
END SUB

SUB ReadText
 RESTORE Text
 letter% = 0
 DO
 n% = 0
 DO
 READ Text%(letter%, n%)
 n% = n% + 1
 LOOP WHILE n% < 35
 letter% = letter% + 1
 LOOP WHILE letter% < 40
END SUB

SUB RefreshField
 xn% = 1: yn% = 1
 DO
 DrawBlock xn%, yn%, Occupied%(xn%, yn%)
 xn% = xn% + 1
 IF xn% > FieldWidth% THEN xn% = 1: yn% = yn% + 1
 LOOP WHILE yn% < FieldHeight% + 1
END SUB

SUB RestoreColors
 n% = 0: c% = 0
 DO
 r% = pal%(n%)
 g% = pal%(n% + 1)
 b% = pal%(n% + 2)
 Colors c%, r%, g%, b%
 n% = n% + 3
 c% = c% + 1
 LOOP WHILE c% < 16
END SUB

SUB RotatePiece
 PrevR% = PieceR%
 PrevX% = PieceX%
 PrevY% = PieceY%

 usery% = 1
 PieceR% = PieceR% + 1
 IF PieceR% > 3 THEN PieceR% = 0
 Overlap% = 0
 CheckOverlap
 IF Overlap% = 0 THEN EXIT SUB

 PieceX% = PieceX% - 1
 Overlap% = 0
 CheckOverlap
 IF Overlap% = 0 THEN EXIT SUB
 PieceX% = PieceX% - 1
 Overlap% = 0
 CheckOverlap
 IF Overlap% = 0 THEN EXIT SUB
 usery% = 0
 PieceR% = PrevR%
 PieceX% = PrevX%
END SUB

SUB StoreOccupy
 xn% = PieceX%: yn% = PieceY%
 Xs% = PieceData%(0, PieceR%, CurrentPiece% - 1)
 Ys% = PieceData%(1, PieceR%, CurrentPiece% - 1)
 maxn% = Xs% * Ys%
 n% = 0
 DO
 c% = PieceData%(n% + 2, PieceR%, CurrentPiece% - 1)
 IF c% = 0 THEN
  ELSE
  IF xn% > 0 AND yn% > 0 AND xn% <= FieldWidth% AND yn% <= FieldHeight% THEN
   Occupied%(xn%, yn%) = PieceC%
  END IF
 END IF
 xn% = xn% + 1
 IF xn% - PieceX% >= Xs% THEN xn% = PieceX%: yn% = yn% + 1
 n% = n% + 1
 LOOP WHILE n% < maxn%
END SUB

SUB TitleScreen
 BlueColors
 LINE (0, 0)-(640, 480), 1, BF
 gap% = 10: shadow% = 3
 DrawText 50, 50, "FUTURE", 2, 14, 2
 DrawText 100, 200, "BLOCKS", 2, 14, 2
 gap% = 4: shadow% = 2
 DrawText 45, 340, "BY MICHAEL FOGLEMAN", 9, 4, 2
 RestoreColors
 Delay 2
 gap% = 4: shadow% = 1
 DrawText 80, 440, "PRESS ANY KEY TO CONTINUE", 7, 2, 2
 FOR a = 1 TO 15
 a$ = INKEY$
 NEXT
 DO
 LOOP WHILE INKEY$ = ""
END SUB

