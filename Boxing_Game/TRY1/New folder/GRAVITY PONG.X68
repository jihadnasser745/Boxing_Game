*-----------------------------------------------------------
* Program    : Gravity Pong FINAL
* Written by : Timothy Hooker 
* Date       : 4-24-2013
* Description: Pong style game that has gravity
*-----------------------------------------------------------

		ORG		$1000
START:	       
                BSR             START_SCREEN
                BSR				SET_BALL
* ENABLE BUFFER
                MOVE            #92,D0                  ; Set Drawing mode
                MOVE            #17,D1                  ; Mode 17 enables double buffering
                TRAP            #15                     ; Run task
		
		
* TIMER
                MOVE		    #8,D0                   ; Get time in D1.L
		        TRAP		    #15                     ; Run task
		        MOVE.L          D1,S_TIME               ; Move time to S_TIME

TIMER		    MOVE            #8,D0                   ; Get new time
		        TRAP            #15                     ; Run task
		        MOVE.L          D1,D2                   ; copy new time to 
		        SUB.L           S_TIME,D2               ; Subtract S_TIME from new time
		        CMP.L           DELAY,D2                ; Compare DELAY to elapsed time
		        BGE             LOOP                    
		        BRA             TIMER

LOOP		     
                MOVE.L          D1,S_TIME               ; Set new s_time 
                * If GAME_IS_RUNNING = TRUE
                IF.B GAME_IS_RUNNING <EQ> #1 THEN
                BSR             INCREASE_BALL_SPEED
                BSR             MOVE_BALL  
                BSR             CHECK_BALL
 				ENDI
                BSR             CHECK_KEY_PRESS
                BSR             PAINT                   ; Paint screen
                BRA             TIMER                   ; Branch to timer
                
GAME_OVER
                *CLEAR SCREEN
                MOVE.L          #87,D0                  ; draw rectangle
                MOVE.L          #0,D1                   ; Set left X position to 0          
                MOVE.L          #0,D2                   ; Set top y position to 0
                MOVE.L          #640,D3                 ; Set width to 640
                MOVE.L          #480,D4                 ; Set height to 480
                TRAP            #15 
                
                *CHANGE FONT SIZE
                MOVE            #21,D0					; Task 21 changes font size
                MOVE.L          #$00FFFFFF,D1           ; Color = white
                MOVE.L          #$05180005,D2           ; Lucidia Sans Typewriter size=18
                TRAP            #15						; run task
                
                *DRAW STRING
                MOVE			#95,D0					; Draw string located at A1
                MOVE.W			#200,D1					; Set x position of string
                MOVE.W			#220,D2					; Set y position of string
                TRAP			#15						; Run task
                
		        * DRAW FROM BUFFER
		        MOVE            #94,D0					; Draw from buffer
                TRAP            #15                     ; Run task

                
        	    MOVE.B		    #9,D0                   ; Halt simulator
	            TRAP		    #15                     ; Run task
****************************************************************************************************************		
* Subroutines
****************************************************************************************************************
START_SCREEN
                * DRAW START SCREEN
                MOVE.W			START_X,D1				; Start screen text x position
                MOVE.W			START_Y,D2				; Start screen text y position
                MOVE			#95,D0					; Draw string located at A1
                ADD.W           #120,D1					; Move x position right to center string
                LEA				START_L1,A1				; point to string for line 1
                TRAP			#15						; run task
                MOVE.W          START_X,D1				; move start x to next string x position
                ADD.W           #32,D2					; Move y position down for next string
                LEA				START_L2,A1				; point to string for line 2
                TRAP			#15						; run task
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L3,A1				; point to string for line 3
                TRAP			#15						; run task
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L4,A1				; point to string for line 4
                TRAP			#15						; run task
                ADD.W           #32,D2					; Move y position down for next string
                LEA				START_L5,A1				; point to string for line 5
                TRAP			#15						; run task
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L6,A1				; point to string for line 6
                TRAP			#15						; run task
                ADD.W           #16,D2					; Move y position down for next string
                LEA				START_L7,A1				; point to string for line 7
                TRAP			#15						; run task
                ADD.W           #76,D1					; Move x position right to center string
                ADD.W           #32,D2					; Move y position down for next string
                LEA				START_L8,A1				; point to string for line 8
                TRAP			#15						; run task
                MOVE            #5,D0					; wait for input from keyboard
                TRAP            #15						; run task
                RTS             
****************************************************************************************************************
****************************************************************************************************************               
SET_BALL
				*IF IT'S PLAYER1 SERVE
			IF.B P_SERVE <EQ> #1 THEN
				MOVE.L			P1_X,BALL_X				; ball_x position = P1 paddle x position
				MOVE.L			P_W,D0					; move paddle width to D0
				ADD.L			D0,BALL_X				; add paddle width to ball x position
				MOVE.L			P1_Y,BALL_Y				; ball y position = P1 paddle y position
				ADD.L			#37,BALL_Y				; move ball y position to center of paddle				
				MOVE.L			#200,P2_Y				; move P2 paddle to center of screen
				
				*IF IT'S PLAYER2 SERVE
			ELSE
				MOVE.L			P2_X,BALL_X				; ball_x position = P2 paddle x position
				MOVE.L			BALL_DI,D0				; Move ball diameter to D0
				SUB.L			D0,BALL_X				; move ball to rest on P2 paddle
				MOVE.L			P2_Y,BALL_Y				; ball y position = P2 paddle y position 
				ADD.L			#37,BALL_Y				; move ball y position to center of paddle
				MOVE.L			#200,P1_Y				; move P1 paddle to center of screen
				MOVE.L          BALL_X,BALL_RIGHT		; copy ball x to ball right
				ADD.L           D0,BALL_RIGHT			; add ball diameter to ball right 
			ENDI
			    MOVE.L          #2,BALL_HS				; reset ball hoizontal speed to 2
				MOVE.L          #1,BALL_VS 				; reset ball vertical speed to 1
				MOVE.B			#0,GAME_IS_RUNNING		; stop game loop from running
				RTS               
****************************************************************************************************************
**************************************************************************************************************** 
INCREASE_BALL_SPEED
                MOVE.L          BALL_AC,D2              ; move acceleration rate to D2 for comparison
                ADD.L           #1,COUNT                ; Add 1 to the count
 				*; IF COUNT = BALL ACCELERATION RATE
            IF.L COUNT <EQ> D2 THEN                         
                ADD.L           #1,BALL_VS              ; add 1 to ball vertical speed
                MOVE.L          #0,COUNT                ; reset count to 0
            ENDI
                RTS
****************************************************************************************************************
****************************************************************************************************************
MOVE_BALL       *UPDATE BALL POSITION
                MOVE.L          BALL_Y,D1               ; Move BALL_Y to D1 
                ADD.L           BALL_VS,D1              ; Add BALL_VS TO D1
                MOVE.L          D1,BALL_Y               ; Move D1 to BALL_Y
                ADD.L           BALL_RAD,D1             ; Add BALL_RAD to D1
                MOVE.L          D1,BALL_YCENTER         ; Move D1 to BALL_YCENTER
                ADD.L           BALL_RAD,D1             ; Add BALL_RAD TO D1
                MOVE.L          D1,BALL_B               ; Move D1 to BALL_B
                MOVE.L          BALL_X,D1               ; Move BALL_X to D1
                ADD.L           BALL_HS,D1              ; Add BALL_HS to D1
                MOVE.L          D1,BALL_X               ; Move D1 to BALL_X
                ADD.L           BALL_RAD,D1             ; Add BALL_RAD,D1
                MOVE.L          D1,BALL_XCENTER         ; Move D1 to BALL_XCENTER
                ADD.L           BALL_RAD,D1             ; Add BALL_RAD to D1
                MOVE.L          D1,BALL_RIGHT           ; Move D1 to BALL_RIGHT
                RTS
****************************************************************************************************************
****************************************************************************************************************
CHECK_BALL      
                BSR             COURT_COLLISION
                BSR             PADDLE_COLLISION
                BSR             SCORE
                RTS
****************************************************************************************************************
****************************************************************************************************************
COURT_COLLISION
                MOVE.L          BALL_B,D2               ; Move ball bottom to D2
                * If BALL_B > COURT_Y
        IF.L D2 <GT> COURT_Y THEN                       
                MOVE.L          COURT_X,D0              ; Move COURT_X to D0
                MOVE.L          COURT_RIGHT,D1          ; Copy court x position to D1
      
                * IF COURT_X <= BALL_XCENTER <= COURT RIGHT X
            IF.L BALL_XCENTER <GE> D0 AND.L BALL_XCENTER <LE> D1 THEN            
                NEG.L           BALL_VS                 ; Reverse ball vertical direction
                MOVE.L          COURT_DE,D2             ; Move deceleration of ball caused by court hit to D2
                ADD.L           D2,BALL_VS              ; Decrease speed
                MOVE.L          COURT_Y,D3              ; Move court top to D3
                SUB.L           BALL_DI,D3              ; Get new ball top position
                MOVE.L          D3,BALL_Y               ; Move ball top to new position 
            ENDI
        ENDI
                RTS 
****************************************************************************************************************
****************************************************************************************************************                
PADDLE_COLLISION
                
                *LEFT PADDLE
                MOVE.L          P1_X,D0                 ; Move P1_X,D0
                ADD.L           P_W,D0                  ; Get paddle right in D0 
                * IF BALL_XCENTER > P1_RIGHT AND BALL_X <= P1_RIGHT
        IF.L BALL_XCENTER <GT> D0 AND.L BALL_X <LE> D0 THEN                   
                MOVE.L          P1_Y,D1                 ; move P1_Y to D1
                MOVE.L          P1_Y,D2                 ; Move P1_Y to D2
                ADD.L           P_H,D2                  ; Get paddle bottom in D2
                * IF BALL_YCENTER >= P1_TOP AND BALL_YCENTER <= P1_BOTTOM
            IF.L BALL_YCENTER <GE> D1 AND.L BALL_YCENTER <LE> D2 THEN 
            	MOVE.L			P_BOOST,D3				; Move paddle speed boost to D3
                MOVE.L          D0,BALL_X               ; Move P1_RIGHT to BALL_X
                NEG.L           BALL_HS                 ; Rervers BALL_HS
                ADD.L			D3,BALL_HS				; Add paddle speed boost to Ball horizontal speed
                * IF BALL_VS > 0
                IF.L BALL_VS <GT> #0 THEN
                NEG.L			BALL_VS					; reverse ball vertical speed
                ENDI
            ENDI    
        ENDI
        
                *RIGHT PADDLE
                MOVE.L          P2_X,D0                 ; Move P2_X,D0   
				* IF BALL_XCENTER < P2_X AND BALL_RIGHT >= P2_X       
        IF.L BALL_XCENTER <LT> D0 AND.L BALL_RIGHT <GE> D0 THEN                   
                MOVE.L          P2_Y,D1                 ; move P2_Y to D1
                MOVE.L          P2_Y,D2                 ; Move P2_Y to D2
                ADD.L           P_H,D2                  ; Get paddle bottom in D2
				* IF BALL_YCENTER >= P2_Y AND BALL_YCENTER <= P2_BOTTOM
            IF.L BALL_YCENTER <GE> D1 AND.L BALL_YCENTER <LE> D2 THEN
                MOVE.L			P_BOOST,D3				; Move paddle speed boost to D3
            	ADD.L			D3,BALL_HS				; Add paddle speed boost to Ball horizontal speed
                SUB.L           BALL_DI,D0 				; subtract ball diameter from P2 x position
                MOVE.L          D0,BALL_X				; set new x position for ball
                NEG.L           BALL_HS					; reverse ball HS
                * IF BALL_VS > 0
                IF.L BALL_VS <GT> #0 THEN
                NEG.L			BALL_VS					; reverse ball vertical speed
                ENDI
            ENDI    
        ENDI
****************************************************************************************************************
****************************************************************************************************************        
SCORE
        	IF.L BALL_X <GE> #640 THEN
        		*IF IT'S PLAYER1 SERVER
        		IF.B P_SERVE <EQ> #1 THEN
            	ADD				#$100,P1_SCORE			
            	ENDI
            	MOVE.B			#1,P_SERVE				
            	BSR				SET_BALL		
            	IF P1_SCORE <EQ> #$3300 THEN
            	LEA             P1_WIN,A1
            	BRA             GAME_OVER
            	ENDI
        	ENDI
        		
        	IF.L BALL_RIGHT <LE> #0 THEN
        		*IF IT'S PLAYER2 SERVE
        		IF.B P_SERVE <EQ> #2 THEN
            	ADD				#$100,P2_SCORE
            	ENDI
            	MOVE.B			#2,P_SERVE
            	BSR				SET_BALL
            	IF P2_SCORE <EQ> #$3300 THEN
            	LEA             P2_WIN,A1
            	BRA             GAME_OVER
            	ENDI
         	ENDI
                RTS
****************************************************************************************************************
****************************************************************************************************************               
CHECK_KEY_PRESS
                MOVE.L          P_SPEED,D2
                MOVE.L          #19,D0                  ; return current state of up to 4 specified keys
            IF.B GAME_IS_RUNNING <EQ> #1 THEN
                MOVE.L          #'A'<<24+'Z'<<16+'K'<<8+'M',D1
            ENDI
            IF.B GAME_IS_RUNNING <EQ> #0 THEN
                IF.B P_SERVE <EQ> #1 THEN
                MOVE.L			#'A'<<24+'Z'<<16+$20<<8+$20,D1
                ENDI
                IF.B P_SERVE <EQ> #2 THEN
                MOVE.L			#$20<<24+$20<<16+'K'<<8+'M',D1
                ENDI
            ENDI
                TRAP            #15
                
                BTST.L          #24,D1
            IF <NE> THEN
                MOVE.L			P1_Y,D3
                ADD.L			P_H,D3
                IF.L D3 <GE> #90 THEN
                SUB.L           D2,P1_Y
                IF.B GAME_IS_RUNNING <EQ> #0 AND.B P_SERVE <EQ> #1 THEN
                SUB.L			D2,BALL_Y
                ENDI
                ENDI
            ENDI
            
                BTST.L          #16,D1
            IF <NE> THEN
            	IF.L P1_Y <LE> #382 THEN
                ADD.L           D2,P1_Y
                IF.B GAME_IS_RUNNING <EQ> #0 AND.B P_SERVE <EQ> #1 THEN
                ADD.L			D2,BALL_Y
                ENDI
                ENDI
            ENDI
            
                BTST.L          #8,D1
            IF <NE> THEN
                MOVE.L			P2_Y,D3
                ADD.L			P_H,D3
                IF.L D3 <GE> #90 THEN
                SUB.L           D2,P2_Y
                IF.B GAME_IS_RUNNING <EQ> #0 AND.B P_SERVE <EQ> #2 THEN
                SUB.L			D2,BALL_Y
                ENDI
                ENDI
            ENDI
            
                BTST.L          #0,D1
            IF <NE> THEN
                IF.L P2_Y <LE> #382 THEN
                ADD.L           D2,P2_Y
                IF.B GAME_IS_RUNNING <EQ> #0 AND.B P_SERVE <EQ> #2 THEN
                ADD.L			D2,BALL_Y
                ENDI
                ENDI
            ENDI
            
            
            IF.B GAME_IS_RUNNING <EQ> #0 THEN
                IF.B P_SERVE <EQ> #1 THEN
                BTST.L			#0,D1
                IF <NE> THEN
                MOVE.B			#1,GAME_IS_RUNNING
          	    ENDI
                ENDI
                IF.B P_SERVE <EQ> #2 THEN
                BTST.L			#24,D1
                IF <NE> THEN
                MOVE.B			#1,GAME_IS_RUNNING
          	    ENDI
                ENDI
            ENDI                      	
                RTS
****************************************************************************************************************
****************************************************************************************************************                
PAINT           
                *CLEAR SCREEN
                MOVE.L          #87,D0                  ; draw rectangle
                MOVE.L          #0,D1                   ; Set left X position to 0          
                MOVE.L          #0,D2                   ; Set top y position to 0
                MOVE.L          #640,D3                 ; Set width to 640
                MOVE.L          #480,D4                 ; Set height to 480
                TRAP            #15                     ; Run task
                
                * DRAW SCORES
                MOVE			#95,D0					; draw string at A1
                LEA				P1,A1					; point to string at P1
                MOVE.W			#80,D1					; set string x position
                MOVE.W			#2,D2					; set string y position
                TRAP			#15						; Run task
                LEA				P2,A1					; point to string at p2
                MOVE.W			#400,D1					; set string x position
                TRAP			#15						; Run task
                LEA				P1_SCORE,A1				; point to string at P1_SCORE
                MOVE.W			#140,D1					; set string x position
                TRAP			#15						; Run task
                LEA				P2_SCORE,A1				; point to string at P2_SCORE
                MOVE.W			#460,D1					; set string x position
                TRAP			#15						; Run task
                
                * CHANGE FILL COLOR TO WHITE	
		        MOVE		    #81,D0					; Change fill color
		        MOVE.L		    #$00FFFFFF,D1			; move hex WHITE to D1
		        TRAP		    #15                     ; Run task

            
                   * DRAW BALL
        	    MOVE.L		    #88,D0		
		        MOVE.L		    BALL_X,D1
		        MOVE.L		    BALL_Y,D2
		        MOVE.L		    BALL_X,D3
		        MOVE.L		    BALL_Y,D4
		        ADD.L		    BALL_DI,D3
		        ADD.L		    BALL_DI,D4
		        TRAP		    #15                     ; Run task
              

                * DRAW PLAYER 1 PADDLE
                MOVE.L          #87,D0					; draw rectangle
                MOVE.L          P1_X,D1					; set rectangle x position
                MOVE.L		    P1_Y,D2					; set rectangle y position
                MOVE.L          P1_X,D3
                MOVE.L          P1_Y,D4
                ADD.L           P_W,D3
                ADD.L           P_H,D4
                TRAP            #15                     ; Run task

                
                * DRAW PLAYER 2 PADDLE
                MOVE.L          #87,D0					; draw rectangle
                MOVE.L          P2_X,D1					; set rectangle x position
                MOVE.L		    P2_Y,D2					; set rectangle y position
                MOVE.L          P2_X,D3
                MOVE.L          P2_Y,D4
                ADD.L           P_W,D3
                ADD.L           P_H,D4
                TRAP            #15                     ; Run task

                
                * DRAW COURT
                MOVE.L          #87,D0					; draw rectangle
                MOVE.L          COURT_X,D1				; set rectangle x position
                MOVE.L		    COURT_Y,D2				; set rectangle y position
                MOVE.L          COURT_X,D3				; move court x to rectangle right x position
                MOVE.L          COURT_Y,D4				; move court y to rectangle bottom y position
                ADD.L           COURT_W,D3				; add width to get court right
                ADD.L           COURT_H,D4				; add height to get court bottom
                TRAP            #15                     ; Run task

        
               * CHANGE FILL COLOR TO BLACK	
		        MOVE		    #81,D0					; Change fill color
		        MOVE.L		    #$00000000,D1			; move hex BLACK to D1
		        TRAP		    #15                     ; Run task

               
		        * DRAW FROM BUFFER
		        MOVE            #94,D0					; draw from buffer
                TRAP            #15                     ; Run task
                RTS
****************************************************************************************************************
**************************************************************************************************************** 
* Variables and Strings
        *ball position and movement variables
BALL_X	        DC.L		    320                     ; Ball starting x position
BALL_Y	        DC.L		    100                     ; Ball starting y position
BALL_B          DS.L            1                       ; Ball bottom
BALL_RIGHT      DS.L            1                       ; Ball right side
BALL_DI		    DC.L		    16                      ; Ball diameter
BALL_RAD        DC.L            8                       ; Ball radius
BALL_XCENTER    DS.L            1                       ; Ball X center
BALL_YCENTER    DS.L            1                       ; Ball Y center
BALL_HS         DC.L            2                       ; Ball horizontal speed
BALL_VS         DC.L            1                       ; Ball vertical speed
BALL_AC         DC.L            4                       ; Ball acceleration
COUNT           DC.L            0                       ; Ball acceleration loop counter
        * paddle position and movement variables
P1_X            DC.L            0                       ; P1 paddle starting x position
P1_Y            DC.L            200                     ; P1 paddle starting y position
P2_X            DC.L            624                     ; P2 paddle starting x position
P2_Y            DC.L            200                     ; P2 paddle starting y position
P_W             DC.L            16                      ; Paddle width
P_H             DC.L            90                      ; Paddle height
P_SPEED         DC.L            6                       ; Paddle speed
P_BOOST         DC.L            1                       ; amount that each paddle hit will increase BALL_HS
        * court and net position variables
COURT_X         DC.L            0                       ; Court x postion
COURT_Y         DC.L            472                     ; Court y postion
COURT_RIGHT     DC.L            640                     ; Value of court Right x
COURT_W         DC.L            640                     ; Court width
COURT_H         DC.L            8                       ; Court height
COURT_DE        DC.L            0                       ; Deceleration caused by court hit
        * timer variables
S_TIME          DS.L            1                       ; Saved time
DELAY           DC.L            2                       ; Delay for loop
GAME_IS_RUNNING DC.B            0                       ; 0=False 1= True
		* player variables
P_SERVE			DC.B			1						; 1=PLAYER1 2=PLAYER2   
P1				DC.W			'PLAYER1',0             ; player 1 label
P2				DC.W			'PLAYER2',0             ; player 2 label
P1_SCORE		DC.W			'0',0                   ; player 1 score
P2_SCORE		DC.W			'0',0                   ; player 2 score
		* start screen
START_X         DC.W            152						; start screen text start x position
START_Y		    DC.W            160						; start screen text start y position
START_L1		DC.B	        'GRAVITY PONG',0		; start screen string 1
START_L2		DC.B            'RULES:',0				; start screen string 2
START_L3		DC.B            'PLAYERS CAN ONLY SCORE ON THEIR SERVE',0			; start screen string 3
START_L4		DC.B            'THE FIRST PLAYER TO SCORE THREE TIMES WINS',0		; start screen string 4
START_L5		DC.B            'CONTROLS:',0										; start screen string 5
START_L6		DC.B            'PLAYER 1 SERVE = SPACEBAR, UP = A, DOWN = Z',0		; start screen string 6
START_L7		DC.B            'PLAYER 2 SERVE = SPACEBAR, UP = K, DOWN = M',0		; start screen string 7
START_L8        DC.B            'PRESS ENTER TO CONTINUE',0							; start screen string 8
		* game over
P1_WIN			DC.B			'PLAYER1 WINS!',0		; player 1 wins string
P2_WIN			DC.B			'PLAYER2 WINS!',0		; player 2 wins string

		        END		        START		            ; last line of source






















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
