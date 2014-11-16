10 REM GOBLIN RELOADED
20 REM DANIELE OLMISANI, 2014
30 REM ...
50 REM ### MAIN TITLE
55 REM SET BORDER AND BACKG COLORS
60 POKE 53280,2 : POKE 53281,1
65 PRINT "{CLEAR}"
70 PRINT "{DOWN*5}{RIGHT*4}{GREEN}GOBLIN {RED}{REVERSE ON}RELOADED"
75 PRINT "{DOWN*2}{RIGHT*4}{BLUE}DANIELE.OLMISANI@GMAIL.COM"
80 PRINT "{DOWN*2}{RIGHT*4}USE O,P KEYS TO MOVE"
85 PRINT "{DOWN*2}{RIGHT*4}PLEASE WAIT... DEFINING CHARACTERS"
100 REM ### GAME INITIALIZATION
105 REM RECLAIM MEMORY FOR CUSTOM CHARS
110 POKE 52,48 : POKE 56,48 : CLR
115 REM CUSTOM CHAR MAP, ORIGINAL CHAR MAP, GAME FIELD START ADDRESSES
120 CM = 12288 : OM = 53248 : GF = 54272
125 REM TURN INTERRUPTS OFF
130 POKE 56334,PEEK(56334) AND 254
135 REM SWITCH I/O REGS WITH CHARS ROM
140 POKE 1,PEEK(1) AND 251
145 REM COPY DIGIT CHARS, FROM '0' TO '9'
150 FOR N=384 TO 464
160 : POKE N+CM,PEEK(N+OM)
170 NEXT N
175 REM LOAD CUSTOM CHARS
180 FOR N=0 TO 39
190 : READ A
200 : POKE N+CM,A
210 NEXT N
220 GB=0: SF=1 : CR=2 : HF=3 : BL=4 : SP=32
230 VS=54296 : AD=54277 : SR=54278 : WF=54276 : LB=54272 : HB=54273
235 REM SWITCH CHARS ROM WITH I/O REGS
240 POKE 1,PEEK(1)OR 4
245 REM TURN INTERRUPTS ON
250 POKE 56334,PEEK(56334)OR 1
255 REM SET CUSTOM CHAR AT ADDRESS 12288 
260 POKE 53272,(PEEK(53272) AND 240)+12
400 REM ### GAME START
410 IF S>HS THEN HS=S
420 S=0
500 REM ### GAMEFIELD SETUP
510 Z=1964 : W=0 : G=0 
520 PRINT"{CLEAR}"
530 PRINT"{HOME}{RED}{DOWN*2}{SPACE*17}"HS
540 GOSUB 2400
550 GOSUB 2500
600 REM ### GAME LOOP
610 POKE Z,SP : Z=Z-40 : IF Z<1144 THEN Z=Z+760
620 GET A$ 
625 IF A$="O" THEN Z=Z-1
630 IF A$="P" THEN Z=Z+1
640 IF PEEK(Z)=BL THEN GOSUB 2300 : GOTO 400
650 IF PEEK(Z)=SF THEN GOSUB 2100
660 POKE Z,GB : POKE Z+GF,0 : FOR T=1 TO 220 : NEXT
670 IF W=36-G THEN GOSUB 2200 : GOTO 500
680 GOTO 600
900 REM ### GAME END 
910 POKE 53272,21 : POKE 53280,14 : POKE 53281,6 : POKE 52,50 : POKE 56,50 
920 PRINT"{CLEAR)SEE YA!"
2100 REM ### EATING ROUTINE
2110 W=W+1 : S=S+25
2120 PRINT"{HOME}{BLUE}{DOWN*2}"S
2130 POKE VS,15 : POKE AD,30 : POKE SR,200 : POKE WF,17
2140 POKE HB,71 : POKE LB,12
2150 FOR T=1 TO 90 : NEXT T
2160 POKE VS,0 : POKE HB,0 :POKE LB,0
2170 RETURN
2200 REM ### GAMEFIELD COMPLETE ROUTINE
2210 PRINT"{HOME}{RED}{DOWN*18}{RIGHT*8}{REVERSE OFF}****** ALL RIGHT !******"
2220 FOR I=1 TO 10 : GET C$ : NEXT I : REM COLLECT GARBAGE
2230 POKE VS,15 : POKE AD,30 : POKE SR,200 : POKE WF,17 : FOR I=1 TO 17
2240 H=INT(RND(0)*10)+21 : L=INT(RND(0)*45)+210 : POKE HB,H : POKE LB,L
2250 FOR T=1 TO 80 : NEXT T : NEXT I : POKE VS,0 : POKE HB,0 : POKE LB,0
2260 RETURN
2300 REM ### GAME END ROUTINE
2310 POKE Z,CR : POKE VS,15 : POKE AD,30 : POKE SR,200 : POKE WF,129 : POKE HB,2 : POKE LB,125
2320 FOR I=1 TO 400 : NEXT I : POKE VS,15 : POKE HB,0 : POKE LB,0
2340 FOR X=1144 TO 1823
2350 : IF PEEK(X)=SF THEN POKE X,HF : POKE X+GF,3
2360 NEXT X
2380 FOR I=1 TO 10 : GET C$ : NEXT I
2390 REM POKE 646,14
2395 GET C$ : IF C$="" THEN GOTO 2395
2399 RETURN
2400 REM ### RANDOM BLOCKS ROUTINE
2410 FOR I=1 TO 118
2420 : X=INT(RND(1)*680)+1144
2430 : IF PEEK(X)=BL THEN 2420
2440 : POKE X,BL : POKE X+GF,5
2450 NEXT I
2460 RETURN
2500 REM ### RANDOM FACES ROUTINE
4510 FOR I=1 TO 36
4520 : F=SF
4530 : X=INT(RND(1)*680)+1144
4540 : IF PEEK(X)<>SP THEN 4530
4550 : IF PEEK(X+39)=BL AND PEEK(X+40)=BL AND PEEK(X+41)=BL THEN F=HF : G=G+1
4560 : POKE X,F : POKE X+GF,8
5570 NEXT I
5580 RETURN
9000 REM ### CUSTOM CHARS
9100 DATA 126,219,219,255,165,90,90,165
9200 DATA 60,66,165,129,153,165,66,60
9300 DATA 170,85,170,85,126,219,255,189
9400 DATA 60,66,165,129,165,153,66,60
9500 DATA 170,85,170,85,170,85,170,85