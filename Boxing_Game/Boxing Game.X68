*------------------------------------------------------------------------------------------------------------------
* Title      : ATARI BOXING GAME
* Written by : OMAR OMAR 1733 - JIHAD NASSER 1513
* Date       : 2-1-2021
*------------------------------------------------------------------------------------------------------------------
    ORG    $1000                  ; first instruction of program

* Put program code here
                
START:
                BSR             START_SCREEN             ;START SCREEN
                LEA             ROUND1,A1                ;LOAD SOUND ROUND 1
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0                  ;PLAY SOUND ROUND 1
                MOVE.L          #0,D1
                TRAP            #15

                                 * ENABLE BUFFER
                MOVE            #92,D0                  ; Set Drawing mode
                MOVE            #17,D1                  ; Mode 17 enables double buffering
                TRAP            #15                                               
                BSR             PAINT
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #200,D1			        ;delay 2 sec
    	        TRAP	        #15				        ;execute delay
                BSR             GAME
                
GAME:           BSR             KEY_CHECKP1             ;GO TO SUBROUTINE
                BSR             KEY_CHECKP2
                BSR             KEY_CHECKPUNCH1
                BSR             KEY_CHECKPUNCH2
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #1,D1			        ;delay 1/100 sec
    	        TRAP	        #15				        ;execute delay
    	        BSR             PAINT
                BSR             SCORE
                BRA             GAME                    ;BRANCHEMENT INFINIE




*******************************************************************************************************************
*******************************************************************************************************************


                    * DRAW START SCREEN
START_SCREEN:   MOVE.W			START_X,D1				; Start screen text x position
                MOVE.W			START_Y,D2				; Start screen text y position
                MOVE			#95,D0					; Draw string located at A1
                ADD.W           #120,D1					; Move x position right to center string
                LEA				START_L1,A1				;  line 1
                TRAP			#15						
                MOVE.W          START_X,D1				; move start x to next string x position
                ADD.W           #32,D2					; Move y position down for next string
                LEA				START_L2,A1				;  line 2
                TRAP			#15						
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L3,A1				;  line 3
                TRAP			#15						
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L4,A1				;  line 4
                TRAP			#15						
                ADD.W           #32,D2					; Move y position down for next string
                LEA				START_L5,A1				; line 5
                TRAP			#15						
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L6,A1				; line 6
                TRAP			#15						
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L7,A1				;  line 7
                TRAP			#15						
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L8,A1				;  line 8
                TRAP			#15
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L9,A1				;  line 9
                TRAP			#15
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L10,A1		    ;  line 10
                TRAP			#15
                
                
                ADD.W           #76,D1					; Move x position right to center string
                ADD.W           #32,D2					; Move y position down for next string
                LEA				START_L11,A1			;  line 11
                TRAP			#15
                MOVE            #5,D0					; wait input from keyboard
                TRAP            #15
                                
                
                RTS
                
                
PAINT:
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00008080,D1			; color
		        TRAP		    #15                     
                
                MOVE.L          #87,D0                  ; draw rectangle 
                MOVE.L          #0,D1                             
                MOVE.L          #0,D2                  
                MOVE.L          #640,D3                 
                MOVE.L          #480,D4                 
                TRAP            #15
                
                MOVE.B		    #93,D0					; Change pen width
		        MOVE.L		    #4,D1			        ; width
		        TRAP		    #15
		        
		        MOVE.B		    #80,D0					; Change pen color
		        MOVE.L		    #$001DACE2,D1			; color (orange)
		        TRAP		    #15
		        
		        MOVE.L          #90,D0                  ; draw rectangle (border)
                MOVE.L          #2,D1                             
                MOVE.L          #2,D2                  
                MOVE.L          #638,D3                 
                MOVE.L          #478,D4                 
                TRAP            #15
		        
		        
		        MOVE.B		    #93,D0					; Change PEN width
		        MOVE.L		    #1,D1			        ; width
		        TRAP		    #15
		        
		        MOVE.B		    #80,D0					; Change PEN color
		        MOVE.L		    #$00FFFFFF,D1			; color white
		        TRAP		    #15


                MOVE.L          #81,D0                  ; Change fill color
                MOVE.L          #$000000FF,D1           ; color red
                TRAP            #15
                
                

                MOVE.L          #87,D0					; draw p1 body
                MOVE.L          B1_X,D1					; set rectangle x position
                MOVE.L		    B1_Y,D2					; set rectangle y position
                MOVE.L          B1_X,D3
                MOVE.L          B1_Y,D4
                ADD.L           B_W,D3                  ; set width
                ADD.L           B_H,D4                  ; set height
                TRAP            #15
                
		        
		        MOVE.L		    #88,D0		            ;draw p1 head
		        MOVE.L		    HEAD1_X,D1
		        MOVE.L		    HEAD1_Y,D2
		        MOVE.L		    HEAD1_X,D3
		        MOVE.L		    HEAD1_Y,D4
		        ADD.L		    HAND_DI,D3
		        ADD.L		    HAND_DI,D4
		        TRAP		    #15


                IF.L IS_INVERSED <EQ> #0 THEN           ;normal distribution
                
                
                MOVE.L		    #88,D0		            ;draw p1 right box
		        MOVE.L		    RH1_X,D1
		        MOVE.L		    RH1_Y,D2
		        MOVE.L		    RH1_X,D3
		        MOVE.L		    RH1_Y,D4
		        ADD.L		    HAND_DI,D3
		        ADD.L		    HAND_DI,D4
		        TRAP		    #15
                
                
                MOVE.L		    #88,D0		            ;draw p1 left box
		        MOVE.L		    LH1_X,D1
		        MOVE.L		    LH1_Y,D2
		        MOVE.L		    LH1_X,D3
		        MOVE.L		    LH1_Y,D4
		        ADD.L		    HAND_DI,D3
		        ADD.L		    HAND_DI,D4
		        TRAP		    #15


                MOVE.L          #87,D0					;draw p1 right hand
                MOVE.L          BHR1_X,D1					; set rectangle x position
                MOVE.L		    BHR1_Y,D2					; set rectangle y position
                MOVE.L          BHR1_X,D3
                MOVE.L          BHR1_Y,D4
                ADD.L           BHR1_W,D3
                ADD.L           BH_H,D4
                TRAP            #15
                
                
                MOVE.L          #87,D0					;draw p1 left hand
                MOVE.L          BHL1_X,D1					; set rectangle x position
                MOVE.L		    BHL1_Y,D2					; set rectangle y position
                MOVE.L          BHL1_X,D3
                MOVE.L          BHL1_Y,D4
                ADD.L           BHL1_W,D3
                ADD.L           BH_H,D4
                TRAP            #15
                
                ELSE                                    ; inversed distribution
                
                
                MOVE.L          #87,D0					;draw p1 right hand
                MOVE.L          BHR1_X,D1					; set rectangle x position
                MOVE.L		    BHR1_Y,D2					; set rectangle y position
                MOVE.L          BHR1_Y,D4
                ADD.L           B_W,D1
                SUB.L           #35,D1
                MOVE.L          D1,D3
                ADD.L           BHR1_W,D3
                ADD.L           BH_H,D4
                TRAP            #15
                
                
                MOVE.L          #87,D0					;draw p1 left hand
                MOVE.L          BHL1_X,D1					; set rectangle x position
                MOVE.L		    BHL1_Y,D2					; set rectangle y position
                MOVE.L          BHL1_Y,D4
                ADD.L           B_W,D1
                SUB.L           #35,D1
                MOVE.L          D1,D3
                ADD.L           BHL1_W,D3

                ADD.L           BH_H,D4
                TRAP            #15
                
                
                MOVE.L		    #88,D0		            ;draw p1 right box
		        MOVE.L		    RH1_X,D1
		        MOVE.L		    RH1_Y,D2
		        MOVE.L		    RH1_Y,D4
		        ADD.L		    HAND_DI,D4
		        SUB.L           BHR1_W,D1
		        SUB.L           BHR1_W,D1
		        SUB.L           B_W,D1
		        MOVE.L          D1,D3
		        ADD.L           HAND_DI,D3
		        TRAP		    #15
                
                
                MOVE.L		    #88,D0		            ;draw p1 left box
		        MOVE.L		    LH1_X,D1
		        MOVE.L		    LH1_Y,D2
		        MOVE.L		    LH1_Y,D4
		        ADD.L		    HAND_DI,D4
		        SUB.L           BHL1_W,D1
		        SUB.L           BHL1_W,D1
		        SUB.L           B_W,D1
		        MOVE.L          D1,D3
		        ADD.L           HAND_DI,D3
		        TRAP		    #15
                
                ENDI


                MOVE.L          #81,D0
                MOVE.L          #$00FF0000,D1
                TRAP            #15
                
                
                MOVE.L          #87,D0					; draw p2 body
                MOVE.L          B2_X,D1					; set rectangle x position
                MOVE.L		    B2_Y,D2					; set rectangle y position
                MOVE.L          B2_X,D3
                MOVE.L          B2_Y,D4
                ADD.L           B_W,D3
                ADD.L           B_H,D4
                TRAP            #15

		        MOVE.L		    #88,D0		            ;draw p2 head
		        MOVE.L		    HEAD2_X,D1
		        MOVE.L		    HEAD2_Y,D2
		        MOVE.L		    HEAD2_X,D3
		        MOVE.L		    HEAD2_Y,D4
		        ADD.L		    HAND_DI,D3
		        ADD.L		    HAND_DI,D4
		        TRAP		    #15
                
                
                IF.L IS_INVERSED <EQ> #0 THEN           ; normal distribution

                
                
                MOVE.L		    #88,D0		            ;draw p2 right box
		        MOVE.L		    RH2_X,D1
		        MOVE.L		    RH2_Y,D2
		        MOVE.L		    RH2_X,D3
		        MOVE.L		    RH2_Y,D4
		        ADD.L		    HAND_DI,D3
		        ADD.L		    HAND_DI,D4
		        TRAP		    #15
                


                MOVE.L		    #88,D0		            ;draw p2 left box
		        MOVE.L		    LH2_X,D1
		        MOVE.L		    LH2_Y,D2
		        MOVE.L		    LH2_X,D3
		        MOVE.L		    LH2_Y,D4
		        ADD.L		    HAND_DI,D3
		        ADD.L		    HAND_DI,D4
		        TRAP		    #15


                MOVE.L          #87,D0					; draw p2 right hand
                MOVE.L          BHR2_X,D1					; set rectangle x position
                MOVE.L		    BHR2_Y,D2					; set rectangle y position
                MOVE.L          BHR2_X,D3
                MOVE.L          BHR2_Y,D4
                ADD.L           BHR2_W,D3
                ADD.L           BH_H,D4
                TRAP            #15
                
                
                MOVE.L          #87,D0					; draw p2 left hand
                MOVE.L          BHL2_X,D1					; set rectangle x position
                MOVE.L		    BHL2_Y,D2					; set rectangle y position
                MOVE.L          BHL2_X,D3
                MOVE.L          BHL2_Y,D4
                ADD.L           BHL2_W,D3
                ADD.L           BH_H,D4
                TRAP            #15
                
                
                ELSE                                    ; inversed distribution
                
                
                
                MOVE.L          #87,D0					; draw p2 right hand
                MOVE.L          BHR2_X,D1					; set rectangle x position
                MOVE.L		    BHR2_Y,D2					; set rectangle y position
                MOVE.L          BHR2_X,D3
                MOVE.L          BHR2_Y,D4
                ADD.L           BHR2_W,D3
                ADD.L           BH_H,D4
                ADD.L           BHR2_W,D1
                ADD.L           BHR2_W,D3
                SUB.L           B_W,D1
                TRAP            #15



                
                
                MOVE.L          #87,D0					; draw p2 left hand
                MOVE.L          BHL2_X,D1					; set rectangle x position
                MOVE.L		    BHL2_Y,D2					; set rectangle y position
                MOVE.L          BHL2_X,D3
                MOVE.L          BHL2_Y,D4
                ADD.L           BHL2_W,D3
                ADD.L           BH_H,D4
                ADD.L           BHL2_W,D1
                ADD.L           BHL2_W,D3
                SUB.L           B_W,D1
                TRAP            #15


                
                
                MOVE.L		    #88,D0		            ;draw p2 right box
		        MOVE.L		    RH2_X,D1
		        MOVE.L		    RH2_Y,D2
		        MOVE.L		    RH2_Y,D4
		        ADD.L		    HAND_DI,D4
		        ADD.L           BHR2_W,D1
		        ADD.L           BHR2_W,D1
		        ADD.L           B_W,D1
		        MOVE.L          D1,D3
		        ADD.L           HAND_DI,D3
		        TRAP		    #15
                
                
                MOVE.L		    #88,D0		            ;draw p2 left box
		        MOVE.L		    LH2_X,D1
		        MOVE.L		    LH2_Y,D2
		        MOVE.L		    LH2_Y,D4
		        ADD.L		    HAND_DI,D4
		        ADD.L           BHL2_W,D1
		        ADD.L           BHL2_W,D1
		        ADD.L           B_W,D1
		        MOVE.L          D1,D3
		        ADD.L           HAND_DI,D3
		        TRAP		    #15

                
                ENDI

		        *HEALTH
		        
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$000000FF,D1			; color RED
		        TRAP		    #15                     
                
                MOVE.L          #87,D0                  ; draw rectangle backgound of health
                MOVE.L          #18,D1                             
                MOVE.L          #18,D2                  
                MOVE.L          #302,D3                 
                MOVE.L          #37,D4                 
                TRAP            #15
                
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$0000FF00,D1			; color GREEN
		        TRAP		    #15                     
                
                MOVE.L          #87,D0                  ; draw rectangle of health
                MOVE.L          #20,D1
                MOVE.L          #20,D2
                MOVE.L          H1_X,D3
                MOVE.L          #35,D4
                TRAP            #15
                
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00FF0000,D1			; color BLUE
		        TRAP		    #15                     
                
                MOVE.L          #87,D0                  ; draw rectangle backgound of health
                MOVE.L          #338,D1                             
                MOVE.L          #18,D2                  
                MOVE.L          #622,D3                 
                MOVE.L          #37,D4                 
                TRAP            #15


                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$0000FF00,D1			; color GREEN
		        TRAP		    #15                     
                
                MOVE.L          #87,D0                  ; draw rectangle of health
                MOVE.L          H2_X,D1
                MOVE.L          #20,D2
                MOVE.L          #620,D3
                MOVE.L          #35,D4
                TRAP            #15
                
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00008080,D1			; color olive
		        TRAP		    #15                
                
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$00FFFFFF,D1           ; WHITE color
                MOVE.L          #$00080000,D2           ; Lucidia Sans Typewriter size=18
                TRAP            #15	
                
                LEA             P1,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#20,D1					;  x position of string
                MOVE.L			#40,D2					;  y position of string
                TRAP			#15
                
                LEA             P2,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#560,D1					;  x position of string
                MOVE.L			#40,D2					;  y position of string
                TRAP			#15

                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$0000FF00,D1			; color
		        TRAP		    #15                

                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$000000FF,D1           ; RED color
                MOVE.L          #$00060000,D2           ; size=6
                TRAP            #15

                MOVE.L			#95,D0					; health p1 pourcentage 
                IF.L P2_SCORE <EQ> #0 THEN
                LEA             N100,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #1 THEN
                LEA             N95,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #2 THEN
                LEA             N90,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #3 THEN
                LEA             N85,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #4 THEN
                LEA             N80,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #5 THEN
                LEA             N75,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #6 THEN
                LEA             N70,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #7 THEN
                LEA             N65,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #8 THEN
                LEA             N60,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #9 THEN
                LEA             N55,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #10 THEN
                LEA             N50,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #11 THEN
                LEA             N45,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #12 THEN
                LEA             N40,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #13 THEN
                LEA             N35,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #14 THEN
                LEA             N30,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #15 THEN
                LEA             N25,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #16 THEN
                LEA             N20,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #17 THEN
                LEA             N15,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #18 THEN
                LEA             N10,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P2_SCORE <EQ> #19 THEN
                LEA             N5,A1
                MOVE.L			#25,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$00FF0000,D1           ; BLUE color
                MOVE.L          #$00060000,D2           ; Lucidia Sans Typewriter size=18
                TRAP            #15	
                
                MOVE.L			#95,D0					; Draw p2 health pourcentage

                IF.L P1_SCORE <EQ> #0 THEN
                LEA             N100,A1
                MOVE.L			#590,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #1 THEN
                LEA             N95,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #2 THEN
                LEA             N90,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #3 THEN
                LEA             N85,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #4 THEN
                LEA             N80,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #5 THEN
                LEA             N75,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #6 THEN
                LEA             N70,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #7 THEN
                LEA             N65,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #8 THEN
                LEA             N60,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #9 THEN
                LEA             N55,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #10 THEN
                LEA             N50,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #11 THEN
                LEA             N45,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #12 THEN
                LEA             N40,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #13 THEN
                LEA             N35,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #14 THEN
                LEA             N30,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #15 THEN
                LEA             N25,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #16 THEN
                LEA             N20,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #17 THEN
                LEA             N15,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #18 THEN
                LEA             N10,A1
                MOVE.L			#600,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                IF.L P1_SCORE <EQ> #19 THEN
                LEA             N5,A1
                MOVE.L			#610,D1					;  x position of string
                MOVE.L			#21,D2					;  y position of string
                TRAP			#15
                ENDI
                

                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00008080,D1			; color olive
		        TRAP		    #15  
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$00FFFFFF,D1           ; WHITE color
                MOVE.L          #$00080000,D2           ; size=8
                TRAP            #15
                MOVE.L			#95,D0					; Draw round number
                IF.L P1_ROUND <EQ> #1 AND.L P2_ROUND <EQ> #1 THEN
                LEA             ROUND3S,A1              ; round 3
                MOVE.L			#297,D1					;  x position of string
                MOVE.L			#40,D2					;  y position of string
                TRAP			#15
                ELSE
                IF.L P1_ROUND <EQ> #1 OR.L P2_ROUND <EQ> #1 THEN 
                LEA             ROUND2S,A1              ; round 2
                MOVE.L			#297,D1					;  x position of string
                MOVE.L			#40,D2					;  y position of string
                TRAP			#15
                ELSE
                LEA             ROUND1S,A1              ; round 1
                MOVE.L			#297,D1					;  x position of string
                MOVE.L			#42,D2					;  y position of string
                TRAP			#15
                ENDI
                ENDI



                
		        MOVE            #94,D0					;draw from buffer
                TRAP            #15                    

                RTS
                
                
*******************************************************************************************************************
*******************************************************************************************************************
                
KEY_CHECKP1:
                MOVE.L          #19,D0                  ; return current state of up to 4 specified keys
                MOVE.L          #'A'<<24+'D'<<16+'W'<<8+'S',D1      ;   p1 mouvment

                TRAP            #15
                
                MOVE.L          RH1_X,D5                            ;    p1 mouvment limits
                ADD.L           HAND_DI,D5
                MOVE.L          LH1_Y,D6
                ADD.L           HAND_DI,D6
                MOVE.L          LH2_Y,D7
                ADD.L           HAND_DI,D7
                IF.L IS_INVERSED <EQ> #1 THEN
                SUB.L           B_W,D5
                SUB.L           HAND_DI,D5
                SUB.L           B_W,D5
                SUB.L           HAND_DI,D5
                SUB.L           B_W,D5
                SUB.L           HAND_DI,D5
                ADD.L           #10,D5
                SUB.L           HAND_DI,D5
                ENDI               
                
                
                BTST.L            #24,D1                            ;   p1 mouvment left 
                IF <NE> THEN
                 IF.L RH2_X <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #1 THEN
                  IF.L D6 <GT> RH2_Y AND.L D7 <GT> RH1_Y THEN       ;   left limit
                   RTS
                  ENDI
                  ENDI
                 ENDI
                IF.L HEAD1_X <GE> #0 THEN
                SUB.L           #1,B1_X
                SUB.L           #1,RH1_X
                SUB.L           #1,HEAD1_X
                SUB.L           #1,LH1_X
                SUB.L           #1,BHR1_X
                SUB.L           #1,BHL1_X
                MOVE.L          B2_X,D5
                IF.L B1_X <LO> D5 THEN
                MOVE.L          #0,IS_INVERSED                      ;   inversed to normal
                ENDI
                ENDI
                ENDI
                
                BTST.L            #16,D1                            ;   p1 mouvment right
                IF <NE> THEN
                 IF.L RH2_X <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #0 THEN
                  IF.L D6 <GT> RH2_Y AND.L D7 <GT> RH1_Y THEN       ;   right limit
                   RTS
                  ENDI
                  ENDI
                 ENDI
                IF.L IS_INVERSED <EQ> #1 THEN
                IF.L RH1_X <LE> #640 THEN
                ADDI.L           #1,B1_X
                ADDI.L           #1,RH1_X
                ADDI.L           #1,HEAD1_X
                ADDI.L           #1,LH1_X
                ADDI.L           #1,BHR1_X
                ADDI.L           #1,BHL1_X
                MOVE.L           B2_X,D5
                IF.L B1_X <GT> D5 THEN
                MOVE.L           #1,IS_INVERSED                     ;   normal to inversed
                ENDI
                ENDI
                ELSE
                IF.L RH1_X <LE> #590 THEN
                ADDI.L           #1,B1_X
                ADDI.L           #1,RH1_X
                ADDI.L           #1,HEAD1_X
                ADDI.L           #1,LH1_X
                ADDI.L           #1,BHR1_X
                ADDI.L           #1,BHL1_X
                MOVE.L           B2_X,D5
                IF.L B1_X <GT> D5 THEN
                MOVE.L           #1,IS_INVERSED
                ENDI
                ENDI
                ENDI
                ENDI
                
                MOVE.L          LH2_Y,D5
                ADD.L           HAND_DI,D5
                MOVE.L          B2_X,D7
                ADD.L           B_W,D7
                MOVE.L          LH1_X,D6
                ADD.L           HAND_DI,D6

                

                BTST.L            #8,D1                             ;   p1 mouvment up
                IF <NE> THEN
                IF.L RH1_Y <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #0 THEN
                  IF.L D6 <GT> RH2_X AND.L D7 <GT> B1_X THEN        ;   up limit
                   RTS
                  ENDI
                  ENDI
                  IF.L IS_INVERSED <EQ> #1 THEN
                  MOVE.L          LH2_X,D5
                  ADD.L           HAND_DI,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           B_W,D5
                  MOVE.L          B1_X,D7
                  ADD.L           B_W,D7
                  MOVE.L          RH1_X,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           B_W,D6
                  IF.L D5 <GT> D6 AND.L D7 <GT> B2_X THEN
                  RTS
                  ENDI
                  ENDI
                ENDI
                IF.L RH1_Y <GE> #0 THEN
                SUB.L           #1,B1_Y
                SUB.L           #1,RH1_Y
                SUB.L           #1,HEAD1_Y
                SUB.L           #1,LH1_Y
                SUB.L           #1,BHR1_Y
                SUB.L           #1,BHL1_Y
                ENDI
                ENDI
                
                MOVE.L          LH1_Y,D5
                ADD.L           HAND_DI,D5
                
                

                BTST.L            #0,D1                                 ;   p1 mouvment down
                IF <NE> THEN
                IF.L RH2_Y <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #0 THEN
                  IF.L D6 <GT> RH2_X AND.L D7 <GT> B1_X THEN            ;   down limit
                   RTS
                  ENDI
                  ENDI
                  IF.L IS_INVERSED <EQ> #1 THEN
                  MOVE.L          LH2_X,D5
                  ADD.L           HAND_DI,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           B_W,D5
                  MOVE.L          B1_X,D7
                  ADD.L           B_W,D7
                  MOVE.L          RH1_X,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           B_W,D6
                  IF.L D5 <GT> D6 AND.L D7 <GT> B2_X THEN
                  RTS
                  ENDI
                  ENDI
                  ENDI
                IF.L LH1_Y <LE> #420 THEN
                ADDI.L           #1,B1_Y
                ADDI.L           #1,RH1_Y
                ADDI.L           #1,HEAD1_Y
                ADDI.L           #1,LH1_Y
                ADDI.L           #1,BHR1_Y
                ADDI.L           #1,BHL1_Y
                ENDI
                ENDI
                
                RTS

*******************************************************************************************************************
*******************************************************************************************************************

KEY_CHECKP2:
                MOVE.L          #19,D0                  ; return current state of up to 4 specified keys
                MOVE.L          #$25<<24+$27<<16+$26<<8+$28,D1          ;   p2 mouvment

                TRAP            #15
                
                MOVE.L          RH1_X,D5                                ;   mouvment limits
                ADD.L           HAND_DI,D5
                MOVE.L          LH1_Y,D6
                ADD.L           HAND_DI,D6
                MOVE.L          LH2_Y,D7
                ADD.L           HAND_DI,D7
                IF.L IS_INVERSED <EQ> #1 THEN
                SUB.L           B_W,D5
                SUB.L           HAND_DI,D5
                SUB.L           B_W,D5
                SUB.L           HAND_DI,D5
                SUB.L           B_W,D5
                SUB.L           HAND_DI,D5
                ADD.L           #10,D5
                SUB.L           HAND_DI,D5
                ENDI
                
                
                BTST.L            #24,D1                                 ;  mouvment left
                IF <NE> THEN
                 IF.L RH2_X <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #0 THEN
                  IF.L D6 <GT> RH2_Y AND.L D7 <GT> RH1_Y THEN            ;  left limit
                   RTS
                  ENDI
                  ENDI
                 ENDI
                IF.L RH2_X <GE> #0 THEN
                SUB.L           #1,B2_X
                SUB.L           #1,RH2_X
                SUB.L           #1,HEAD2_X
                SUB.L           #1,LH2_X
                SUB.L           #1,BHR2_X
                SUB.L           #1,BHL2_X
                MOVE.L           B2_X,D5
                IF.L B1_X <GT> D5 THEN
                MOVE.L           #1,IS_INVERSED
                ENDI
                ENDI
                ENDI
                
                BTST.L            #16,D1                                  ; mouvment right
                IF <NE> THEN
                 IF.L RH2_X <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #1 THEN
                  IF.L D6 <GT> RH2_Y AND.L D7 <GT> RH1_Y THEN             ; right limit
                   RTS
                  ENDI
                  ENDI
                 ENDI
                IF.L HEAD2_X <LE> #580 THEN
                ADDI.L           #1,B2_X
                ADDI.L           #1,RH2_X
                ADDI.L           #1,HEAD2_X
                ADDI.L           #1,LH2_X
                ADDI.L           #1,BHR2_X
                ADDI.L           #1,BHL2_X
                MOVE.L          B2_X,D5
                IF.L B1_X <LO> D5 THEN
                MOVE.L          #0,IS_INVERSED
                ENDI
                ENDI
                ENDI
                
                
                MOVE.L          LH1_Y,D5
                ADD.L           HAND_DI,D5
                MOVE.L          B2_X,D7
                ADD.L           B_W,D7
                MOVE.L          LH1_X,D6
                ADD.L           HAND_DI,D6
                

                BTST.L            #8,D1                                 ;mouvment up
                IF <NE> THEN
                IF.L RH2_Y <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #0 THEN
                  IF.L D6 <GT> RH2_X AND.L D7 <GT> B1_X THEN            ;up limit
                   RTS
                  ENDI
                  ENDI
                  IF.L IS_INVERSED <EQ> #1 THEN
                  MOVE.L          LH2_X,D5
                  ADD.L           HAND_DI,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           B_W,D5
                  MOVE.L          B1_X,D7
                  ADD.L           B_W,D7
                  MOVE.L          RH1_X,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           B_W,D6
                  IF.L D5 <GT> D6 AND.L D7 <GT> B2_X THEN
                  RTS
                  ENDI
                  ENDI
                ENDI
                IF.L RH2_Y <GE> #0 THEN
                SUB.L           #1,B2_Y
                SUB.L           #1,RH2_Y
                SUB.L           #1,HEAD2_Y
                SUB.L           #1,LH2_Y
                SUB.L           #1,BHR2_Y
                SUB.L           #1,BHL2_Y
                ENDI
                ENDI
                
                
                MOVE.L          LH2_Y,D5
                ADD.L           HAND_DI,D5
                

                BTST.L            #0,D1                                     ;mouvment down
                IF <NE> THEN
                IF.L RH1_Y <EQ> D5 THEN
                  IF.L IS_INVERSED <EQ> #0 THEN
                  IF.L D6 <GT> RH2_X AND.L D7 <GT> B1_X THEN                ;down limit
                   RTS
                  ENDI
                  ENDI
                  IF.L IS_INVERSED <EQ> #1 THEN
                  MOVE.L          LH2_X,D5
                  ADD.L           HAND_DI,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           BHL2_W,D5
                  ADD.L           B_W,D5
                  MOVE.L          B1_X,D7
                  ADD.L           B_W,D7
                  MOVE.L          RH1_X,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           BHR1_W,D6
                  SUB.L           B_W,D6
                  IF.L D5 <GT> D6 AND.L D7 <GT> B2_X THEN
                  RTS
                  ENDI
                  ENDI
                ENDI
                IF.L LH2_Y <LE> #420 THEN
                ADDI.L           #1,B2_Y
                ADDI.L           #1,RH2_Y
                ADDI.L           #1,HEAD2_Y
                ADDI.L           #1,LH2_Y
                ADDI.L           #1,BHR2_Y
                ADDI.L           #1,BHL2_Y
                ENDI
                ENDI

                
                RTS


*******************************************************************************************************************
*******************************************************************************************************************


KEY_CHECKPUNCH1:
                MOVE.L          #19,D0                  ; return current state of 2 specified keys
                MOVE.L          #'G'<<24+'H'<<16,D1     ; p1 punch
                TRAP            #15
                MOVE.L          #0,A3
                
                
                BTST            #24,D1
                IF <NE> THEN                            ;FOR BOXING WITH RIGHT HAND
                IF.L P1RL <EQ> #1 THEN                  ;for not punching with same hand two times
PUNCHGR1
                IF.L IS_INVERSED <EQ> #1 THEN           ;punching
                SUB.L           #1,BHR1_X
                ENDI
                ADD.L           #1,BHR1_W
                ADD.L           #1,RH1_X
                ADD.L           #1,A3
                BSR             PAINT
                CMP.L           #60,A3
                BNE             PUNCHGR1
                
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #13,D1			        ;delay 13/100 sec
    	        TRAP	        #15				        ;execute delay
    	        LEA             WOOSH,A1                ;sound of punching
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                
                SUB.L           #1,P1RL                 ; for left hand
                
                MOVE.L          RH1_X,D2                ;SCORE statments
                ADD.L           HAND_DI,D2
                MOVE.L          RH2_Y,D3
                ADD.L           HAND_DI,D3
                MOVE.L          LH2_Y,D4
                SUB.L           HAND_DI,D4
                MOVE.L          RH1_X,D1
                SUB.L           BHR1_W,D1
		        SUB.L           BHR1_W,D1
		        SUB.L           B_W,D1
		        SUB.L           #60,D1
                
                IF.L RH1_Y <GT> D3 AND.L RH1_Y <LO> D4 THEN         ; for score
                IF.L IS_INVERSED <EQ> #1 THEN
                IF.L D1 <LO> HEAD2_X THEN
                ADD.L           #1,P1_SCORE
                ADD.L           #14,H2_X
                LEA             punch,A1                ;sound of score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B2_X <GT> #60 THEN                              ; for other player throw in inversed
                SUB.L           #50,B2_X
                SUB.L           #50,RH2_X
                SUB.L           #50,HEAD2_X
                SUB.L           #50,LH2_X
                SUB.L           #50,BHR2_X
                SUB.L           #50,BHL2_X
                ENDI
                ADD.L           #50,RH2_Y
                ADD.L           #50,HEAD2_Y
                ADD.L           #50,LH2_Y
                ADD.L           #50,BHR2_Y
                ADD.L           #50,BHL2_Y
                ADD.L           #50,B2_Y

                ENDI
                ENDI
                IF.L IS_INVERSED <EQ> #0 THEN                           ; for score
                IF.L D2 <GT> HEAD2_X AND.L D2 <GT> RH2_X THEN
                ADD.L           #1,P1_SCORE
                ADD.L           #14,H2_X
                LEA             punch,A1                ;sound for score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B2_X <LO> #550 THEN                                ; for other player throw in normal
                ADD.L           #50,B2_X
                ADD.L           #50,RH2_X
                ADD.L           #50,HEAD2_X
                ADD.L           #50,LH2_X
                ADD.L           #50,BHR2_X
                ADD.L           #50,BHL2_X
                ELSE
                MOVE.L          #600,B2_X
                MOVE.L          #535,RH2_X
                MOVE.L          #580,HEAD2_X
                MOVE.L          #535,LH2_X
                MOVE.L          #595,BHR2_X
                MOVE.L          #595,BHL2_X
                ENDI
                ADD.L           #50,RH2_Y
                ADD.L           #50,HEAD2_Y
                ADD.L           #50,LH2_Y
                ADD.L           #50,BHR2_Y
                ADD.L           #50,BHL2_Y
                ADD.L           #50,B2_Y

                ENDI
                ENDI
                ENDI
                
                

PUNCHRR1                                                    ; box return
                SUB.L           #1,BHR1_W
                SUB.L           #1,RH1_X
                SUB.L           #1,A3
                IF.L IS_INVERSED <EQ> #1 THEN              
                ADD.L           #1,BHR1_X
                ENDI
                BSR             PAINT
                CMP.L           #0,A3
                BNE             PUNCHRR1
                ENDI
                ENDI
                
                
                BTST            #16,D1                  ;   left hand boxing
                IF <NE> THEN
                IF.L P1RL <EQ> #0 THEN
PUNCHGL1
                IF.L IS_INVERSED <EQ> #1 THEN             ;FOR BOXING WITH left HAND    
                SUB.L           #1,BHL1_X
                ENDI
                ADD.L           #1,BHL1_W
                ADD.L           #1,LH1_X
                ADD.L           #1,A4
                BSR             PAINT
                CMP.L           #60,A4
                BNE             PUNCHGL1
                
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #13,D1			        ;delay 13/100 sec
    	        TRAP	        #15				        ;execute delay
    	        LEA             WOOSH,A1                ;sound of punching
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
    	        MOVE.L          LH1_X,D2                ;FOR SCORE
                ADD.L           HAND_DI,D2
                MOVE.L          RH2_Y,D3
                ADD.L           HAND_DI,D3
                MOVE.L          LH2_Y,D4
                SUB.L           HAND_DI,D4
                MOVE.L          LH1_X,D1
                SUB.L           BHL1_W,D1
		        SUB.L           BHL1_W,D1
		        SUB.L           B_W,D1
		        SUB.L           #60,D1
		        ADD.L           #1,P1RL

                
                IF.L LH1_Y <GT> D3 AND.L LH1_Y <LO> D4 THEN     ;score in inversed
                IF.L IS_INVERSED <EQ> #1 THEN
                IF.L D1 <LO> HEAD2_X THEN
                ADD.L           #1,P1_SCORE
                ADD.L           #14,H2_X
                LEA             punch,A1                ;sound of score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B2_X <GT> #60 THEN                          ; for other player throw in inversed
                SUB.L           #50,B2_X
                SUB.L           #50,RH2_X
                SUB.L           #50,HEAD2_X
                SUB.L           #50,LH2_X
                SUB.L           #50,BHR2_X
                SUB.L           #50,BHL2_X
                ENDI
                SUB.L           #50,RH2_Y
                SUB.L           #50,HEAD2_Y
                SUB.L           #50,LH2_Y
                SUB.L           #50,BHR2_Y
                SUB.L           #50,BHL2_Y
                SUB.L           #50,B2_Y

                ENDI
                ENDI
                IF.L IS_INVERSED <EQ> #0 THEN
                IF.L D2 <GT> HEAD2_X AND.L D2 <GT> RH2_X THEN       ; for score
                ADD.L           #1,P1_SCORE
                ADD.L           #14,H2_X
                LEA             punch,A1                ;sound of score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B2_X <LO> #550 THEN                         ; for other player throw in normal
                ADD.L           #50,B2_X
                ADD.L           #50,RH2_X
                ADD.L           #50,HEAD2_X
                ADD.L           #50,LH2_X
                ADD.L           #50,BHR2_X
                ADD.L           #50,BHL2_X
                ELSE
                MOVE.L          #600,B2_X
                MOVE.L          #535,RH2_X
                MOVE.L          #580,HEAD2_X
                MOVE.L          #535,LH2_X
                MOVE.L          #595,BHR2_X
                MOVE.L          #595,BHL2_X
                ENDI
                SUB.L           #50,RH2_Y
                SUB.L           #50,HEAD2_Y
                SUB.L           #50,LH2_Y
                SUB.L           #50,BHR2_Y
                SUB.L           #50,BHL2_Y
                SUB.L           #50,B2_Y

                ENDI
                ENDI
                ENDI
                
PUNCHRL1                                                            ;left hand returning
                SUB.L           #1,BHL1_W
                SUB.L           #1,LH1_X
                SUB.L           #1,A4
                IF.L IS_INVERSED <EQ> #1 THEN              
                ADD.L           #1,BHL1_X
                ENDI
                BSR             PAINT
                CMP.L           #0,A4
                BNE             PUNCHRL1
                ENDI
                ENDI
                
                
                RTS
                
                
                
*******************************************************************************************************************
*******************************************************************************************************************

                
KEY_CHECKPUNCH2:


                MOVE.L          #19,D0                  ; return current state of 2 specified keys
                MOVE.L          #'K'<<24+'L'<<16,D1     ; p2 punch
                TRAP            #15
                MOVE.L          #0,A3
                
       
                BTST            #24,D1
                IF <NE> THEN                            ;FOR BOXING WITH RIGHT HAND
                IF.L P2RL <EQ> #0 THEN                  ;for not boxing with same hand two times
PUNCHGR2                                                ;box going
                ADD.L           #1,BHL2_W
                SUB.L           #1,BHL2_X
                SUB.L           #1,LH2_X
                
                ADD.L           #1,A3
                BSR             PAINT
                CMP.L           #60,A3
                BNE             PUNCHGR2
                
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #13,D1			        ;delay 13/100 sec
    	        TRAP	        #15				        ;execute delay
    	        LEA             WOOSH,A1                ;sound of punching
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                
                MOVE.L          LH2_X,D2                ;FOR SCORE
                SUB.L           HAND_DI,D2
                MOVE.L          RH1_Y,D3
                ADD.L           HAND_DI,D3
                MOVE.L          LH1_Y,D4
                SUB.L           HAND_DI,D4
                MOVE.L          LH2_X,D1
                ADD.L           BHL2_W,D1
		        ADD.L           BHL2_W,D1
		        ADD.L           B_W,D1
		        ADD.L           #60,D1
		        ADD.L           #1,P2RL
                
                IF.L LH2_Y <GT> D3 AND.L LH2_Y <LO> D4 THEN         ;score
                IF.L IS_INVERSED <EQ> #1 THEN
                IF.L D1 <GT> HEAD1_X THEN
                ADD.L           #1,P2_SCORE
                SUB.L           #14,H1_X
                LEA             punch,A1                ;sound of score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B1_X <LO> #535 THEN                ; throw the other player in inversed
                ADD.L           #50,B1_X
                ADD.L           #50,RH1_X
                ADD.L           #50,HEAD1_X
                ADD.L           #50,LH1_X
                ADD.L           #50,BHR1_X
                ADD.L           #50,BHL1_X
                ENDI
                SUB.L           #50,RH1_Y
                SUB.L           #50,HEAD1_Y
                SUB.L           #50,LH1_Y
                SUB.L           #50,BHR1_Y
                SUB.L           #50,BHL1_Y
                SUB.L           #50,B1_Y
                

                ENDI
                ENDI
                TST             D2
                IF.L IS_INVERSED <EQ> #0 THEN
                IF.L D2 <LO> HEAD1_X THEN
                ADD.L           #1,P2_SCORE
                SUB.L           #14,H1_X
                LEA             punch,A1                ;sound of score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B1_X <GT> #60 THEN                 ; throw other player in normal
                SUB.L           #50,B1_X
                SUB.L           #50,RH1_X
                SUB.L           #50,HEAD1_X
                SUB.L           #50,LH1_X
                SUB.L           #50,BHR1_X
                SUB.L           #50,BHL1_X
                ELSE
                MOVE.L          #25,B1_X
                MOVE.L          #60,RH1_X
                MOVE.L          #15,HEAD1_X
                MOVE.L          #60,LH1_X
                MOVE.L          #25,BHR1_X
                MOVE.L          #25,BHL1_X
                ENDI
                SUB.L           #50,RH1_Y
                SUB.L           #50,HEAD1_Y
                SUB.L           #50,LH1_Y
                SUB.L           #50,BHR1_Y
                SUB.L           #50,BHL1_Y
                SUB.L           #50,B1_Y


                ENDI
                ENDI
                ENDI

PUNCHRR2                                    ;box return to original
                SUB.L           #1,BHL2_W
                ADD.L           #1,BHL2_X
                ADD.L           #1,LH2_X
                SUB.L           #1,A3
                BSR             PAINT
                CMP.L           #0,A3
                BNE             PUNCHRR2
                
                ENDI
                ENDI
                
                
                BTST            #16,D1
                IF <NE> THEN                ;FOR BOXING WITH LEFT HAND
                IF.L P2RL <EQ> #1 THEN      ;for not punch with same hand two times
PUNCHGL2
                ADD.L           #1,BHR2_W
                SUB.L           #1,BHR2_X
                SUB.L           #1,RH2_X
                ADD.L           #1,A3
                BSR             PAINT
                CMP.L           #60,A3
                BNE             PUNCHGL2
                
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #13,D1			        ;delay 13/100 sec
    	        TRAP	        #15				        ;execute delay
    	        LEA             WOOSH,A1                ;sound of punching
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                
                MOVE.L          RH2_X,D2                ;FOR SCORE
                SUB.L           HAND_DI,D2
                MOVE.L          RH1_Y,D3
                ADD.L           HAND_DI,D3
                MOVE.L          LH1_Y,D4
                SUB.L           HAND_DI,D4
                MOVE.L          RH2_X,D1
                ADD.L           BHR2_W,D1
		        ADD.L           BHR2_W,D1
		        ADD.L           B_W,D1
		        ADD.L           #60,D1
		        SUB.L           #1,P2RL
               
                IF.L RH2_Y <GT> D3 AND.L RH2_Y <LO> D4 THEN
                IF.L IS_INVERSED <EQ> #1 THEN
                IF.L D1 <GT> HEAD1_X THEN
                ADD.L           #1,P2_SCORE
                SUB.L           #14,H1_X
                LEA             punch,A1                ;sound of score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B1_X <LO> #535 THEN                ;other player throw in inversed
                ADD.L           #50,B1_X
                ADD.L           #50,RH1_X
                ADD.L           #50,HEAD1_X
                ADD.L           #50,LH1_X
                ADD.L           #50,BHR1_X
                ADD.L           #50,BHL1_X
                ENDI
                ADD.L           #50,RH1_Y
                ADD.L           #50,HEAD1_Y
                ADD.L           #50,LH1_Y
                ADD.L           #50,BHR1_Y
                ADD.L           #50,BHL1_Y
                ADD.L           #50,B1_Y

                ENDI
                ENDI
                IF.L IS_INVERSED <EQ> #0 THEN
                IF.L D2 <LO> HEAD1_X THEN
                ADD.L           #1,P2_SCORE
                SUB.L           #14,H1_X
                LEA             punch,A1                ;sound of score
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                IF.L B1_X <GT> #60 THEN                 ;other player throw in normal
                SUB.L           #50,B1_X
                SUB.L           #50,RH1_X
                SUB.L           #50,HEAD1_X
                SUB.L           #50,LH1_X
                SUB.L           #50,BHR1_X
                SUB.L           #50,BHL1_X
                ELSE
                MOVE.L          #25,B1_X
                MOVE.L          #60,RH1_X
                MOVE.L          #15,HEAD1_X
                MOVE.L          #60,LH1_X
                MOVE.L          #25,BHR1_X
                MOVE.L          #25,BHL1_X
                ENDI
                ADD.L           #50,RH1_Y
                ADD.L           #50,HEAD1_Y
                ADD.L           #50,LH1_Y
                ADD.L           #50,BHR1_Y
                ADD.L           #50,BHL1_Y
                ADD.L           #50,B1_Y

                

                ENDI
                ENDI
                ENDI
                

PUNCHRL2                                        ;left box returns to original
                SUB.L           #1,BHR2_W
                ADD.L           #1,BHR2_X
                ADD.L           #1,RH2_X
                SUB.L           #1,A3
                BSR             PAINT
                CMP.L           #0,A3
                BNE             PUNCHRL2
                ENDI
                ENDI

                
                RTS
                
                
*******************************************************************************************************************
*******************************************************************************************************************

SCORE:                                                  ;calculating score to win round and game
                IF.L P1_SCORE <EQ> #20 THEN             p1 win a round
                ADD.L           #1,P1_ROUND
                IF.L P1_ROUND <EQ> #2 THEN              ;p1 win the game
                BSR             GAME_OVER
                ENDI
                
                                                        *;congratulation screen

*CLEAR SCREEN
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00D9992F,D1			; color
		        TRAP		    #15  
                MOVE.L          #87,D0                 ;  rectangle
                MOVE.L          #0,D1                   ;  left X position to 0          
                MOVE.L          #0,D2                  ;  top y position to 0
                MOVE.L          #640,D3                 ;  width to 640
                MOVE.L          #480,D4                ;  height to 480
                TRAP            #15 
                
                *CHANGE FONT SIZE
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$0000FF00,D1           ; red color
                MOVE.L          #$05140005,D2           ; Lucidia Sans Typewriter size=18
                TRAP            #15					
                
                *DRAW STRING
                LEA             P1_WIN,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#100,D1					;  x position of string
                MOVE.L			#150,D2					;  y position of string
                TRAP			#15	
                LEA             CONGRA,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#170,D1					;  x position of string
                MOVE.L			#200,D2					;  y position of string
                TRAP			#15						
                
		        * DRAW FROM BUFFER
		        MOVE            #94,D0					; Draw from buffer
                TRAP            #15                     
                
                
*        	    MOVE.B		    #9,D0                   ; Halt simulator
*	            TRAP		    #15
	            
	            MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #300,D1			        ;delay 3 sec
    	        TRAP	        #15				        ;execute delay
    	        
    	                                                ;return everything to original place
                
                MOVE.L #10,B1_X
                MOVE.L #200,B1_Y
                MOVE.L #600,B2_X
                MOVE.L #200,B2_Y
                MOVE.L #30,B_W
                MOVE.L #150,B_H
                
                
                MOVE.L #45,RH1_X
                MOVE.L #170,RH1_Y
                MOVE.L #535,RH2_X
                MOVE.L #170,RH2_Y
                MOVE.L #60,HAND_DI
                
                
                MOVE.L #0,HEAD1_X
                MOVE.L #245,HEAD1_Y
                MOVE.L #580,HEAD2_X
                MOVE.L #245,HEAD2_Y
                
                
                MOVE.L #45,LH1_X
                MOVE.L #320,LH1_Y
                MOVE.L #535,LH2_X
                MOVE.L #320,LH2_Y
                
                
                MOVE.L #10,BHR1_X
                MOVE.L #195,BHR1_Y
                MOVE.L #595,BHR2_X
                MOVE.L #195,BHR2_Y
                MOVE.L #35,BHR1_W
                MOVE.L #35,BHL1_W
                MOVE.L #35,BHR2_W
                MOVE.L #35,BHL2_W
                
                
                MOVE.L #10,BH_H
                
                MOVE.L #300,H1_X
                MOVE.L #340,H2_X
                
                
                MOVE.L #10,BHL1_X
                MOVE.L #345,BHL1_Y
                MOVE.L #595,BHL2_X
                MOVE.L #345,BHL2_Y
                
                
                MOVE.L #0,IS_INVERSED
                MOVE.L          #0,P1_SCORE
                MOVE.L          #0,P2_SCORE
                
                IF.L P1_ROUND <EQ> #1 AND.L P2_ROUND <EQ> #1 THEN
                LEA             ROUND3,A1                ;sound
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                ELSE
                IF.L P1_ROUND <EQ> #1 OR.L P2_ROUND <EQ> #1 THEN
                LEA             ROUND2,A1                ;sound
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                ENDI
                ENDI

                
	            ENDI
	            
	            IF.L P2_SCORE <EQ> #20 THEN             ;p2 win a round
	            ADD.L           #1,P2_ROUND
                IF.L P2_ROUND <EQ> #2 THEN              ;p2 win the game
                BSR             GAME_OVER
                ENDI
                *CLEAR SCREEN                           ; congratulation screen
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00D9992F,D1			; color
		        TRAP		    #15  
                MOVE.L          #87,D0                 ;  rectangle
                MOVE.L          #0,D1                   ;  left X position to 0
                MOVE.L          #0,D2                  ;  top y position to 0
                MOVE.L          #640,D3                 ;  width to 640
                MOVE.L          #480,D4                ;  height to 480
                TRAP            #15 
                
                *CHANGE FONT SIZE
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$0000FF00,D1           ; red color
                MOVE.L          #$05140005,D2           ; Lucidia Sans Typewriter size=18
                TRAP            #15					
                
                *DRAW STRING
                LEA             P2_WIN,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#100,D1					;  x position of string
                MOVE.L			#150,D2					;  y position of string
                TRAP			#15	
                LEA             CONGRA,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#170,D1					;  x position of string
                MOVE.L			#200,D2					;  y position of string
                TRAP			#15						
                
                
		        * DRAW FROM BUFFER
		         MOVE            #94,D0					; Draw from buffer
                 TRAP            #15                     

                
        	    MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #500,D1			        ;delay 1/100 sec
    	        TRAP	        #15				        ;execute delay
    	            
                                                        ;return everything to original place
                MOVE.L #10,B1_X
                MOVE.L #200,B1_Y
                MOVE.L #600,B2_X
                MOVE.L #200,B2_Y
                MOVE.L #30,B_W
                MOVE.L #150,B_H
                
                
                MOVE.L #45,RH1_X
                MOVE.L #170,RH1_Y
                MOVE.L #535,RH2_X
                MOVE.L #170,RH2_Y
                MOVE.L #60,HAND_DI
                
                
                MOVE.L #0,HEAD1_X
                MOVE.L #245,HEAD1_Y
                MOVE.L #580,HEAD2_X
                MOVE.L #245,HEAD2_Y
                
                
                MOVE.L #45,LH1_X
                MOVE.L #320,LH1_Y
                MOVE.L #535,LH2_X
                MOVE.L #320,LH2_Y
                
                
                MOVE.L #10,BHR1_X
                MOVE.L #195,BHR1_Y
                MOVE.L #595,BHR2_X
                MOVE.L #195,BHR2_Y
                MOVE.L #35,BHR1_W
                MOVE.L #35,BHL1_W
                MOVE.L #35,BHR2_W
                MOVE.L #35,BHL2_W
                
                
                MOVE.L #10,BH_H
                
                MOVE.L #300,H1_X
                MOVE.L #340,H2_X
                
                
                MOVE.L #10,BHL1_X
                MOVE.L #345,BHL1_Y
                MOVE.L #595,BHL2_X
                MOVE.L #345,BHL2_Y
                
                
                MOVE.L #0,IS_INVERSED
                MOVE.L          #0,P1_SCORE
                MOVE.L          #0,P2_SCORE
                
                IF.L P1_ROUND <EQ> #1 AND.L P2_ROUND <EQ> #1 THEN           ;round 3 sound
                LEA             ROUND3,A1                ;sound
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #200,D1			        ;delay 1/100 sec
    	        TRAP	        #15				        ;execute delay
                ELSE
                IF.L P1_ROUND <EQ> #1 OR.L P2_ROUND <EQ> #1 THEN            ;round 3 sound
                LEA             ROUND2,A1                ;sound
                MOVE.L          #0,D1
                MOVE.L          #74,D0
                TRAP            #15
                MOVE.L          #75,D0
                MOVE.L          #0,D1
                TRAP            #15
                MOVE.B	        #23,D0			        ;delay to reduce cpu workload
    	        MOVE.L	        #200,D1			        ;delay 1/100 sec
    	        TRAP	        #15				        ;execute delay
                ENDI
                ENDI
	            ENDI

	            
s	            RTS




*******************************************************************************************************************
*******************************************************************************************************************

GAME_OVER:                                              ;game over screen

                IF.L P1_ROUND <EQ> #2 THEN              ;p1 win
                *CLEAR SCREEN
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00D9992F,D1			; color
		        TRAP		    #15  
                MOVE.L          #87,D0                 ;  rectangle
                MOVE.L          #0,D1                   ;  left X position to 0
                MOVE.L          #0,D2                  ;  top y position to 0
                MOVE.L          #640,D3                 ;  width to 640
                MOVE.L          #480,D4                ;  height to 480
                TRAP            #15 
                
                *CHANGE FONT SIZE
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$0000FF00,D1           ; red color
                MOVE.L          #$05140005,D2           ; Lucidia Sans Typewriter size=18
                TRAP            #15					
                
                *DRAW STRING
                LEA             P1_WINGAME,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#100,D1					;  x position of string
                MOVE.L			#150,D2					;  y position of string
                TRAP			#15	
                LEA             CONGRA,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#170,D1					;  x position of string
                MOVE.L			#200,D2					;  y position of string
                TRAP			#15						
                
                
		        * DRAW FROM BUFFER
		         MOVE            #94,D0					; Draw from buffer
                 TRAP            #15                     
                 
                MOVE.B		    #9,D0                   ; Halt simulator
	            TRAP		    #15
                ENDI
                
                IF.L P2_ROUND <EQ> #2 THEN              ;p2 win
                *CLEAR SCREEN
                MOVE.B		    #81,D0					; Change fill color
		        MOVE.L		    #$00D9992F,D1			; color
		        TRAP		    #15  
                MOVE.L          #87,D0                 ;  rectangle
                MOVE.L          #0,D1                   ;  left X position to 0
                MOVE.L          #0,D2                  ;  top y position to 0
                MOVE.L          #640,D3                 ;  width to 640
                MOVE.L          #480,D4                ;  height to 480
                TRAP            #15 
                
                *CHANGE FONT SIZE
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$0000FF00,D1           ; red color
                MOVE.L          #$05140005,D2           ; Lucidia Sans Typewriter size=18
                TRAP            #15					
                
                *DRAW STRING
                LEA             P2_WINGAME,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#100,D1					;  x position of string
                MOVE.L			#150,D2					;  y position of string
                TRAP			#15	
                LEA             CONGRA,A1
                MOVE.L			#95,D0					; Draw string located at A1
                MOVE.L			#170,D1					;  x position of string
                MOVE.L			#200,D2					;  y position of string
                TRAP			#15						
                
                
		        * DRAW FROM BUFFER
		        MOVE            #94,D0					; Draw from buffer
                TRAP            #15
                
                MOVE.B		    #9,D0                   ; Halt simulator
	            TRAP		    #15
                ENDI





*******************************************************************************************************************
*******************************************************************************************************************

                

* Put variables and constants here

B1_X            DC.L            10                      ; p1 body starting x position
B1_Y            DC.L            200                     ; p1 body starting y position
B2_X            DC.L            600                     ; p2 body starting x position
B2_Y            DC.L            200                     ; p2 body starting y position
B_W             DC.L            30                      ; body width
B_H             DC.L            150                     ; body height



RH1_X	        DC.L		    45                      ; p1 right box starting x position
RH1_Y	        DC.L		    170                     ; p1 right box starting y position
RH2_X	        DC.L		    535                     ; p2 right box starting x position
RH2_Y	        DC.L		    170                     ; p2 right box starting y position
HAND_DI		    DC.L		    60                      ; box diameter



HEAD1_X	        DC.L		    0                       ; p1 head starting x position
HEAD1_Y	        DC.L		    245                     ; p1 head starting y position
HEAD2_X	        DC.L		    580                     ; p2 head starting x position
HEAD2_Y	        DC.L		    245                     ; p2 head starting y position



LH1_X	        DC.L		    45                      ; p1 left box starting x position
LH1_Y	        DC.L		    320                     ; p1 left box starting y position
LH2_X	        DC.L		    535                     ; p2 left box starting x position
LH2_Y	        DC.L		    320                     ; p2 left box starting y position


BHR1_X          DC.L            10                      ; p1 right hand starting x position
BHR1_Y          DC.L            195                     ; p1 right hand starting y position
BHR2_X          DC.L            595                     ; p2 right hand starting x position
BHR2_Y          DC.L            195                     ; p2 right hand starting y position
BHR1_W          DC.L            35                      ; p1 right hand width1
BHL1_W          DC.L            35                      ; p1 left hand width1
BHR2_W          DC.L            35                      ; p2 right hand width1
BHL2_W          DC.L            35                      ; p2 left hand width1

BH_H            DC.L            10                      ; Hand height


P1_WIN          DC.W            'PLAYER 1 HAS WIN THE ROUND!',0        ; p1 win round phrase
P2_WIN          DC.W            'PLAYER 2 HAS WIN THE ROUND!',0        ; p2 win round phrase
P1_WINGAME      DC.W            'PLAYER 1 HAS WIN THE GAME!',0         ; p1 win game phrase
P2_WINGAME      DC.W            'PLAYER 2 HAS WIN THE GAME!',0         ; p2 win game phrase
P1_SCORE        DC.L            0                       ;PLAYER 1 SCORE
P2_SCORE        DC.L            0                       ;PLAYER 2 SCORE
P1_ROUND        DC.L            0                       ;PLAYER 1 ROUNDS WIN
P2_ROUND        DC.L            0                       ;PLAYER 2 ROUNDS WIN
CONGRA          DC.W            'CONGRATULATIONS',0                    ; congratulation phrase

P1              DC.W            'PLAYER 1',0            ;PLAYER 1 PHRASE
P2              DC.W            'PLAYER 2',0            ;PLAYER 1 PHRASE

H1_X            DC.L            300                     ;STATING X_POSITION P1 HEALTH
H2_X            DC.L            340                     ;STATING X_POSITION P2 HEALTH


BHL1_X          DC.L            10                      ; p1 left hand starting x position
BHL1_Y          DC.L            345                     ; p1 left hand starting y position
BHL2_X          DC.L            595                     ; p1 left hand starting x position
BHL2_Y          DC.L            345                     ; p1 left hand starting y position

P1RL            DC.L            0                       ;p1 right left box distribution
P2RL            DC.L            0                       ;p1 right left box distribution

IS_INVERSED     DC.L            0                       ; INVERSED DISTRIBUTION

punch           DC.B            'punch.wav',0           ;punch score sound
WOOSH           DC.B            'WOOSH.wav',0           ;punch in air sound
ROUND1          DC.B            'ROUND1.wav',0          ;round 1 sound
ROUND2          DC.B            'ROUND2.wav',0          ;round 2 sound
ROUND3          DC.B            'ROUND3.wav',0          ;round 3 sound
ROUND1S         DC.B            'ROUND1',0              ;round 1 phrase
ROUND2S         DC.B            'ROUND2',0              ;round 2 phrase
ROUND3S         DC.B            'ROUND3',0              ;round 3 phrase

N100             DC.B            '100',0                ;number 100
N95              DC.B            '95',0                 ;number 95
N90              DC.B            '90',0                 ;number 90
N85              DC.B            '85',0                 ;number 85
N80              DC.B            '80',0                 ;number 80
N75              DC.B            '75',0                 ;number 75
N70              DC.B            '70',0                 ;number 70
N65              DC.B            '65',0                 ;number 65
N60              DC.B            '60',0                 ;number 60
N55              DC.B            '55',0                 ;number 55
N50              DC.B            '50',0                 ;number 50
N45              DC.B            '45',0                 ;number 45
N40              DC.B            '40',0                 ;number 40
N35              DC.B            '35',0                 ;number 35
N30              DC.B            '30',0                 ;number 30
N25              DC.B            '25',0                 ;number 25
N20              DC.B            '20',0                 ;number 20
N15              DC.B            '15',0                 ;number 15
N10              DC.B            '10',0                 ;number 10
N5               DC.B            '5',0                  ;number 5


START_X         DC.W            130						                                                ;text start x position
START_Y		    DC.W            130						                                                ;text start y position
START_L1		DC.B	        'BOXING',0		                                                        ;string 1
START_L2		DC.B            'RULES:',0				                                                ;string 2
START_L3		DC.B            'PLAYERS CAN ONLY SCORE BY HITTING HIS ENEMY HEAD',0			  ;string 3
START_L4		DC.B            'THE FIRST PLAYER TO SCORE TEN TIMES WINS',0		                    ;string 4
START_L5		DC.B            'CONTROLS:',0										                    ;string 5
START_L6		DC.B            '-PLAYER 1: RIGHT HAND = G, LEFT HAND = H',0		                    ;string 6
START_L7		DC.B            'UP = W, LEFT = A, DOWN = S, RIGHT = D',0		                        ;string 7
START_L8		DC.B            '-PLAYER 2: RIGHT HAND = NUM 4, LEFT HAND = NUM 5',0		        ;string 8
START_L9		DC.B            'UP = UP ARROW, LEFT = LEFT ARROW',0		                            ;string 9
START_L10		DC.B            'DOWN = DOWN ARROW, RIGHT = RIGHT ARROW',0		                        ;string 10
START_L11       DC.B            'PRESS ENTER TO CONTINUE',0							                    ;string 11
    END    START                                                                                        ;last line of source
		        


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
