*-----------------------------------------------------------
* Title      :Maze Runner Level 1
* Written by :Edward Smith
* Date       :June 2015
* Description:easmith@nvcc.edu
*-----------------------------------------------------------
; Move arrow Keys to move to the right maze exit without hitting obstacles or walls. You have 20 seconds.



      ORG    $1000
START:                  ; first instruction of program


initialize
    move #8,d0
    trap #15
    move.l d1,D5        ; get time
    
 
    bsr setup
    
	
    
loop
    
    bsr background                  
     

	bsr shooter1
	bsr bulletcollide 
	bsr shooter2
	bsr bulletcollide
	bsr shooter3
	bsr bulletcollide
	bsr shooter4
	bsr bulletcollide
	bsr shooter5
	bsr bulletcollide
	bsr shooter6
	bsr bulletcollide
	bsr shooter7
	bsr bulletcollide
	bsr shooter8
	bsr bulletcollide
	bsr shooter9 
	bsr bulletcollide

	bsr shooter10
	bsr bulletcollide
	bsr shooter12
	bsr bulletcollide
	bsr shooter13
	bsr bulletcollide
	bsr shooter14
	bsr bulletcollide
	bsr shooter15
	bsr bulletcollide
	bsr shooter16
	bsr bulletcollide
	bsr shooter17
	bsr bulletcollide
	bsr keycheck 
	move.b	#23,d0			delay to reduce cpu workload
    	move.l	#2,d1			delay 1/100 sec
    	trap	#15				execute delay 
	 bsr background	
      bsr checkend  
    bsr checkwall
    bsr checktime
     
    
         
     
    
    bra loop
	  
   
setup
    move.l  #Blue,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Blue,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    move.b  #92,d0
    move.b  #17,d1      enable double buffering
    trap    #15


        
    
	 move.w S1XL, ts1      ; this is establishing the walls and the initial positions of the obstacles
     move.w S1XR ,ts2
     move.w S1YU , ts3
     move.w S1YL, ts4
	lea xL,A0
	lea xR,A1
    lea yU,A2
     lea yB,A3
     move.w S2XL, ts5
     move.w S2XR ,ts6
     move.w S2YU , ts7
     move.w S2YL, ts8
     move.w S3XL, ts9
     move.w S3XR ,ts10
     move.w S3YU , ts11
     move.w S3YL, ts12
     move.w S4XL, ts13
     move.w S4XR ,ts14
     move.w S4YU , ts15
     move.w S4YL, ts16
     move.w S5XL, ts17
     move.w S5XR ,ts18
     move.w S5YU , ts19
     move.w S5YL, ts20
     move.w S6XL, ts21
     move.w S6XR ,ts22
     move.w S6YU , ts23
     move.w S6YL, ts24
      move.w S7XL, ts25
     move.w S7XR ,ts26
     move.w S7YU , ts27
     move.w S7YL, ts28
      move.w S8XL, ts29
     move.w S8XR ,ts30
     move.w S8YU , ts31
     move.w S8YL, ts32
     move.w S9XL, ts33
     move.w S9XR ,ts34
     move.w S9YU , ts35
     move.w S9YL, ts36
      move.w S10XL, ts37
     move.w S10XR ,ts38
     move.w S10YU , ts39
     move.w S10YL, ts40
       move.w S11XL, ts41
     move.w S11XR ,ts42
     move.w S11YU , ts43
     move.w S11YL, ts44
      move.w S12XL, ts45
     move.w S12XR ,ts46
     move.w S12YU , ts47
     move.w S12YL, ts48
    move.w S13XL, ts49
     move.w S13XR ,ts50
     move.w S13YU , ts51
     move.w S13YL, ts52
    move.w S14XL, ts53
     move.w S14XR ,ts54
     move.w S14YU , ts55
     move.w S14YL, ts56
    move.w S15XL, ts57
     move.w S15XR ,ts58
     move.w S15YU , ts59
     move.w S15YL, ts60
     move.w S16XL, ts61
     move.w S16XR ,ts62
     move.w S16YU , ts63
     move.w S16YL, ts64

      move.w S17XL, ts65
     move.w S17XR ,ts66
     move.w S17YU , ts67
     move.w S17YL, ts68


    rts
keycheck	
     move.l  #Blue,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Blue,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	

     
    Move.b #19,D0                                          ; this checks for arrow keys up,down,left,right and then moves player accordingly
	clr.l d1
	move.l #$26<<24+$28<<16+$25<<8+$27,D1
	trap #15
	btst.l #24,D1
     if <NE> THEN
          sub #5,(A2)
    move.w (A2),d2
    
    sub #5,(A3)
    move.w (A3),d4
    move.w (A1),d3
    move.w (A0),d1
    move.b	#87,d0
	trap	#15			draw filled rect
	rts
	endi
	 btst.l #16,D1
     if <NE> THEN
     
     add #5,(A2)
    move.w (A2),d2
    
    add #5,(A3)
    move.w (A3),d4
    move.w (A1),d3
    move.w (A0),d1
     move.b	#87,d0
	trap	#15	
	rts
	endi
	 btst.l #8,D1
     if <NE> THEN
      
    
    move.w (A2),d2
    move.w (A3),d4
    sub #5,(A1)
    move.w (A1),d3
    sub #5,(A0)
    move.w (A0),d1

     move.b	#87,d0
	trap	#15	
	rts
	endi
	
	 btst.l #1,D1
     if <NE> THEN
    
     
    move.w (A2),d2
    
    
    move.w (A3),d4
    add #5,(A1)
    move.w (A1),d3
    add #5,(A0)
    move.w (A0),d1
     move.b	#87,d0
	trap	#15	 
	rts
	endi
	rts
	
checkwall                 ; this starts the process of checking if you hit a wall
	cmpi.w #200,(A0)        ; A0 is left x of player.  So all of the "second " routines are checking the y based on the x.
	 blt second1            ; I did this before I knew about the collision detection method done below for obstacles
	  cmpi.w #250,(A0)
	 blt second2
      cmpi.w #500,(A0)
	 blt second3
      cmpi.w #500,(A0)
      bgt second4
      cmpi.w #260,(A0)
      bgt second5
     cmpi.w #350,(A0)
      bgt second6

	 rts      

	
second1	
     cmpi.w #400,(A2)
     blt term
     rts
second2	
     cmpi.w #100,(A2)
     blt term 
     rts
     
second3
      cmpi.w #50,(A2) 
      blt term 
      cmpi.w #260,(A1)
      bgt second5
      cmpi.w #350,(A0)
      bgt second6
    
      
      rts   
second4 
     cmpi.w #140,(A2)
     blt term
     cmpi.w #300,(A0)
     bgt second6
     rts
second5
     cmpi.w #280,(A3)
     bgt check1
     rts
check1 
     cmpi.w  #350,(A0)
     blt term
     bgt second6
     rts
second6
     cmpi.w #400,(A3)
     bgt term
     rts  
checktime          ; checks if it has been 20 seconds
    
    move #8,d0
    trap #15
    move.l D1,D7
    sub.l  D5,D7
    cmp.l #2000,D7
    bhi timeout
    
    rts

background                                       ; this draws in the walls 
  move.l  #Color2,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color2,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	

 move.w	#0,d2		uY1
	move.w	#400,d4		lY2
    move.w #0, d1       lx
    move.w  #200 , d3       rx
    
	move.b	#87,d0
	trap	#15			draw filled rect

	
  move.w	#0,d2		uY1
	
	move.w	#100,d4		lY2
    
     move.w #200, d1       lx
     move.w  #250 , d3       rx
    
	move.b	#87,d0
	trap	#15			draw filled rect

   
    move.w	#0,d2		uY1
	
	move.w	#50,d4		lY2
    
     move.w #250, d1       lx
     move.w  #640 , d3       rx
    
	move.b	#87,d0
	trap	#15			draw filled rect
  
    move.w	#0,d2		uY1
	
	move.w	#140,d4		lY2
    
     move.w #500, d1       lx
     move.w  #640 , d3       rx
    
	move.b	#87,d0
	trap	#15			draw filled rect


     move.w	#280,d2		uY1
	
	move.w	#480,d4		lY2
    
     move.w #260,d1       lx
     move.w  #350 , d3       rx
    
	move.b	#87,d0
	trap	#15			draw filled rect  
	
	
	
	  move.w	#400,d2		uY1
	
	move.w	#480,d4		lY2
    
     move.w #350,d1       lx
     move.w  #640 , d3       rx
    
	move.b	#87,d0
	trap	#15			draw filled rect 
	    
    move.l  #Blue,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Blue,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color

    move.w	(A2),d2		uY1
	
	move.w	(A3),d4		lY2
    
     move.w (A0),d1       lx
     move.w  (A1) , d3       rx
    
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	move.b  #94,d0      repaint
    trap    #15
    
	rts
term                ; this ends the game and restarts if you collide
    
    

 
	bsr shooter1
	 
	bsr shooter2
	
	bsr shooter3
	
	bsr shooter4
	
	bsr shooter5
	
	bsr shooter6
	
	bsr shooter7
	
	bsr shooter8
	
	bsr shooter9 
	
	bsr shooter10
	
	bsr shooter11
	
	bsr shooter12
	
	bsr shooter13
	
	bsr shooter14
	bsr shooter15
	bsr shooter16
	bsr shooter17
	bsr background
	lea msg4,A1
    move #13,D0
    trap #15
    move.b  #94,d0      repaint
    trap    #15
	
    lea msg,A1
    move #13,D0
    trap #15
	

    move.b  #94,d0      repaint
    trap    #15
    

   move.b	#23,d0			delay to reduce cpu workload
    	move.l	#200,d1			delay 1/100 sec
    	trap	#15				execute delay 
     movea #0,A0
     movea #0, A1
     movea #0,A2
     movea #0, A3
     move  #10, XL
     move  #20, XR
     move #450, YU
     move #460,YB
      
    bra initialize
    
timeout                    ; this ends game and restarts if you run out of time
    
    

 
	bsr shooter1
	 
	bsr shooter2
	
	bsr shooter3
	
	bsr shooter4
	
	bsr shooter5
	
	bsr shooter6
	
	bsr shooter7
	
	bsr shooter8
	
	bsr shooter9 
	
		
	bsr shooter11
	
	bsr shooter12
	
	bsr shooter13
	
	bsr shooter14
	bsr shooter15
	bsr shooter16
	bsr shooter17
	bsr background
	lea msg4,A1
    move #13,D0
    trap #15
    
	
    lea msg3,A1
    move #13,D0
    trap #15
	

    move.b  #94,d0      repaint
    trap    #15
    

     move.b	#23,d0			delay to reduce cpu workload
    	move.l	#200,d1			delay 1/100 sec
    	trap	#15				execute delay 
     movea #0,A0
     movea #0, A1
     movea #0,A2
     movea #0, A3
     move  #10, XL
     move  #20, XR
     move #450, YU
     move #460,YB
      
    bra initialize

shooter1                                        ; "shooterx" routines control the obstacles.  some have some randomness
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts4) <lt> #50 then 
     move.w S1XL, ts1
     move.w S1XR ,ts2
     move.w S1YU , ts3
     move.w S1YL, ts4
   endi
   
     move.w	(ts3),d2		uY1
	
	 move.w	(ts4),d4		lY2
    
     move.w (ts1),d1       lx
     move.w  (ts2) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	

	
	move.b  #94,d0      repaint
    trap    #15
    
     
    
    
      move.b  #11,D0
    move.w  #$FF00,D1
    trap    #15         clear screen                     ; here is the screen clear
    move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1  prevent overflow in divu                          ; this is gettinng random number
    divu    #3,d1       time count / 100
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 3

    
    sub.w   d1,(ts3)                 ; subtracting random number from obstacle top
    sub.w   d1, (ts4)
    move.w (ts1),d1
        rts
shooter2 
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts8) <lt> #40 then 
     move.w S2XL, ts5
     move.w S2XR ,ts6
     move.w S2YU , ts7
     move.w S2YL, ts8
   endi
   
     move.w	(ts7),d2		uY1
	
	 move.w	(ts8),d4		lY2
    
     move.w (ts5),d1       lx
     move.w  (ts6) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	

	 move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #7,d1     time count / 100
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 7


	

    sub.w   d1,(ts7)
    sub.w   d1,(ts8)
    move.w (ts5),d1 
    rts
shooter3 
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts11) <gt> #500 then 
     move.w S3XL, ts9
     move.w S3XR ,ts10
     move.w S3YU , ts11
     move.w S3YL, ts12
   endi
   
     move.w	(ts11),d2		uY1
	
	 move.w	(ts12),d4		lY2
    
     move.w (ts9),d1       lx
     move.w  (ts10) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	

	
   move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #5,d1     time count / 100
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 5

	

    add.w   d1,(ts11)
   
    sub.w   #4,(ts9)
    sub.w   #3,(ts10)
    add.w   d1,(ts12)
     move.w (ts9),d1       
    rts
shooter4 
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts15) <gt> #700 then 
     move.w S4XL, ts13
     move.w S4XR ,ts14
     move.w S4YU , ts15
     move.w S4YL, ts16
   endi
   
     move.w	(ts15),d2		uY1
	
	 move.w	(ts16),d4		lY2
    
     move.w (ts13),d1       lx
     move.w  (ts14) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	 
    move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #6,d1     time count / 100
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 6

	

	

    add.w   d1,(ts15)
    add.w   #4, (ts16)
    move.w (ts13),d1 
    rts
shooter5
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts19) <gt> #450 then 
     move.w S5XL, ts17
     move.w S5XR ,ts18
     move.w S5YU , ts19
     move.w S5YL, ts20
   endi
   
     move.w	(ts19),d2		uY1
	
	 move.w	(ts20),d4		lY2
    
     move.w (ts17),d1       lx
     move.w  (ts18) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #3,d1     time count / 100
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 3

	
    add   #4,(ts19)
    add.w  #6, (ts20)
    add   #3,(ts17)
    add.w  #3, (ts18)
    move.w (ts17),d1

    rts
shooter6
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts23) <gt> #460 then 
     move.w S6XL, ts21
     move.w S6XR ,ts22
     move.w S6YU , ts23
     move.w S6YL, ts24
   endi
   
     move.w	(ts23),d2		uY1
	
	 move.w	(ts24),d4		lY2
    
     move.w (ts21),d1       lx
     move.w  (ts22) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	

	move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #15,d1     time count / 100
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 15

	



	

    add   #4,(ts23)
    add   #4, (ts24)
    add   #3,(ts21)
    add   #3, (ts22)
    move  (ts21),d1
    rts
shooter7
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts26) <lt> #200 then 
     move.w S7XL, ts25
     move.w S7XR ,ts26
     move.w S7YU , ts27
     move.w S7YL, ts28
   endi
   
     move.w	(ts27),d2		uY1
	
	 move.w	(ts28),d4		lY2
    
     move.w (ts25),d1       lx
     move.w  (ts26) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	

	move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #6,d1     time count / 6
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 6

	

    sub   #4,(ts27)
    sub.w  d1, (ts28)
    sub   #3,(ts25)
    sub   #3, (ts26)
   move.w  (ts25),d1
    rts
shooter8
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts30) <gt> #640 then 
     move.w S8XL, ts29
     move.w S8XR ,ts30
     move.w S8YU , ts31
     move.w S8YL, ts32
   endi
   
     move.w	(ts31),d2		uY1
	
	 move.w	(ts32),d4		lY2
    
     move.w (ts29),d1       lx
     move.w  (ts30) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   
	

	

   
    sub   #1,(ts25)
    add   #1, (ts26)
    add   #3 , (ts29)
    add   #3, (ts30)
    add     #1 , (ts31)
    add    #4, (ts32)
    rts
shooter9
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts34) <gt> #600 then 
     move.w S9XL, ts33
     move.w S9XR ,ts34
     move.w S9YU , ts35
     move.w S9YL, ts36
   endi
   
     move.w	(ts35),d2		uY1
	
	 move.w	(ts36),d4		lY2
    
     move.w (ts33),d1       lx
     move.w  (ts34) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #3,d1     time count / 3
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 3

   
    sub   #1,(ts31)
    add   #1, (ts32)
    add.w   d1 , (ts35)
    add.w   d1, (ts36)
    add     #2 , (ts33)
    add    #2, (ts34)
    move.w (ts33),d1
    rts

shooter10
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts37) <lt> #260 then 
     move.w S10XL, ts37
     move.w S10XR ,ts38
     move.w S10YU , ts39
     move.w S10YL, ts40
   endi
   
     move.w	(ts39),d2		uY1
	
	 move.w	(ts40),d4		lY2
    
     move.w (ts37),d1       lx
     move.w  (ts38) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   
	



	


   
        
    sub.w     #2, (ts37)
    sub.w   #1, (ts38)
    add #3 , (ts39)
    add  #3,(ts40)
    
    rts

shooter11
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts41) <lt> #260 then 
     move.w S11XL, ts41
     move.w S11XR ,ts42
     move.w S11YU , ts43
     move.w S11YL, ts44
   endi
   
     move.w	(ts43),d2		uY1
	
	 move.w	(ts44),d4		lY2
    
     move.w (ts41),d1       lx
     move.w  (ts42) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   
	

	

   move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #2,d1     time count / 2
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 2

	


        
    sub     #1 , (ts37)
    
    
    sub.w     d1 , (ts41)
    sub  #1, (ts42)
    
    
    add #4 , (ts43)
    add  #4,(ts44)
    move.w (ts41),d1

    rts

shooter12
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts47) <lt> #50 then 
     move.w S12XL, ts45
     move.w S12XR ,ts46
     move.w S12YU , ts47
     move.w S12YL, ts48
   endi
   
     move.w	(ts47),d2		uY1
	
	 move.w	(ts48),d4		lY2
    
     move.w (ts45),d1       lx
     move.w  (ts46) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   
	

	

   
        
    move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #4,d1     time count / 4
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 4

	


    sub.w d1 ,(ts47)
    sub.w d1,(ts48)
    move.w (ts45),d1

    rts

shooter13
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts51) <lt> #40 then 
     move.w S12XL, ts49
     move.w S12XR ,ts50
     move.w S12YU , ts51
     move.w S12YL, ts52
   endi
   
     move.w	(ts51),d2		uY1
	
	 move.w	(ts52),d4		lY2
    
     move.w (ts49),d1       lx
     move.w  (ts50) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   
	

    move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #4,d1     time count / 4
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 4

	


    sub  #1  , (ts47)
    add #1, (ts46)
    sub   #5 , (ts51)
    sub.w  d1,(ts52)
   move.w (ts49),d1

    rts

shooter14
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts55) <lt> #90 then 
     move.w S14XL, ts53
     move.w S14XR ,ts54
     move.w S14YU , ts55
     move.w S14YL, ts56
   endi
   
     move.w	(ts55),d2		uY1
	
	 move.w	(ts56),d4		lY2
    
     move.w (ts53),d1       lx
     move.w  (ts54) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   sub #2,(ts54)
   sub  #2, (ts56)
	sub #3, (ts55)
	sub #4, (ts53)


    
    rts
shooter15
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts60) <gt> #700 then 
     move.w S15XL, ts57
     move.w S15XR ,ts58
     move.w S15YU , ts59
     move.w S15YL, ts60
   endi
   
     move.w	(ts59),d2		uY1
	
	 move.w	(ts60),d4		lY2
    
     move.w (ts57),d1       lx
     move.w  (ts58) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	
   sub #1,(ts57)
   sub  #1, (ts58)
   add  #1, (ts59)
   add  #2,(ts60)


    
    rts
shooter16
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts62) <gt> #620 then 
     move.w S16XL, ts61
     move.w S16XR ,ts62
     move.w S16YU ,ts63
     move.w S16YL, ts64
   endi
   
     move.w	(ts63),d2		uY1
	
	 move.w	(ts64),d4		lY2
    
     move.w (ts61),d1       lx
     move.w  (ts62) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
	move.b  #8,d0
    trap    #15
    and.l   #$0000FFFF,d1 prevent overflow in divu
    divu    #4,d1     time count / 4
    swap    d1          swap upper and lower words of D1 to put remainder in low word
    addq.w  #1,d1       d1.w contains number from 1 to 4

	


   sub #1,(ts61)
   add  #1, (ts62)
	sub.w d1, (ts63)
	add #1, (ts64)

   move.w  (ts61),d1
    
    rts

shooter17
      move.l  #Color3,D1    set pen color
    move.b  #80,D0
    trap    #15

 
    move.l	#Color3,d1		fill color
	move.b	#81,d0
	trap	#15			set fill color
	
    if (ts65) <lt> #260 then 
     move.w S17XL, ts65
     move.w S17XR ,ts66
     move.w S17YU ,ts67
     move.w S17YL, ts68
   endi
   
     move.w	(ts67),d2		uY1
	
	 move.w	(ts68),d4		lY2
    
     move.w (ts65),d1       lx
     move.w  (ts66) , d3       rx
       
     
     
	move.b	#87,d0
	trap	#15			draw filled rect 
	
		


   sub  #1,(ts65)
   add  #1, (ts66)
   add #2, (ts67)
	add #2, (ts68)
       
    
    rts



checkend                    ; this checks to see if you made it to the end
    cmpi.w #640,(A1)
    bgt finish
    rts
finish                      ; this ends game if you win
    lea msg4,A1
    move #13,D0
    trap #15
    move.b  #94,d0      repaint
    trap    #15
	
    lea msg2,A1
    move #13,D0
    trap #15
    move.b  #94,d0      repaint
    trap    #15
    lea msg5,A1
    move #13,D0
    trap #15
    move.b  #94,d0      repaint
    trap    #15

     
    add #1000,(score)
    
    move.l #1000,D1
    move #3,D0
    trap #15
    move.b  #94,d0      repaint
    trap    #15

    
   move.b	#23,d0			delay to reduce cpu workload
    	move.l	#200,d1			delay 1/100 sec
    	trap	#15				execute delay 
     movea #0,A0
     movea #0, A1
     movea #0,A2
     movea #0, A3
     move  #10, XL
     move  #20, XR
     move #450, YU
     move #460,YB
      
    bra initialize
 
bulletcollide           ; this detects collision between player and obstacles.  players and obstacles are just rectangles
  
   move.w (A0),L             ; no collision if any of these are met
   move.w (L),d6
   sub.w d6,d3                ; d3 is obstacle right
   if d3 <lt> #0 then
   bra nocollision
   endi
   move.w (A1),R
   move.w (R),d6
   sub.w  d6,d1
   if d1 <gt> #0 then           ; d1 is obstacle left
   bra nocollision
   endi
   move.w (A2),T
   move.w (T),D6
   sub.w d6,d4
   if d4 <lt> #0 then 
   bra nocollision
   endi
   move.w  (A3),B
   move.w  (B),D6
   sub.w d6,d2
   if d2 <gt> #0 then 
   bra nocollision
   endi
   bra term
   
nocollision rts   
   
* Put variables and constants here
Blue Equ $00FF0000       
Color2 Equ $000000FF
Color3 Equ $00FFFFFF
xL:   dc.w 10
xR:   dc.w 20
yU:   dc.w   450
yB:   dc.w   460
msg:  dc.b  'GAME OVER-  COLLISION',$0,$d,0
msg2: dc.b 'You Won!',$0,$d,0
msg3: dc.b 'Too much time',0
msg4: dc.b  'Maze Runner by Edward Smith',$0,$d,0
msg5: dc.b  'SCORE',$0,$d,0
S1XL: dc.w  300
S1XR: dc.w   303
S1YU:  dc.w  280
S1YL: dc.w  285
ts1:  ds.w  1
ts2:  ds.w  1
ts3:  ds.w  1
ts4:  ds.w  1
S2XL: dc.w  300
S2XR: dc.w   303
S2YU:  dc.w  320
S2YL: dc.w  325
ts5:  ds.w  1
ts6:  ds.w  1
ts7:  ds.w  1
ts8:  ds.w  1
S3XL: dc.w  140
S3XR: dc.w   143
S3YU:  dc.w  400
S3YL: dc.w  405
ts9:  ds.w  1
ts10:  ds.w  1
ts11:  ds.w  1
ts12:  ds.w  1
S4XL: dc.w  140
S4XR: dc.w   143
S4YU:  dc.w  385
S4YL: dc.w  390
ts13:  ds.w  1
ts14:  ds.w  1
ts15:  ds.w  1
ts16:  ds.w  1
S5XL: dc.w  200
S5XR: dc.w   203
S5YU:  dc.w  320
S5YL: dc.w  325
ts17:  ds.w  1
ts18:  ds.w  1
ts19:  ds.w  1
ts20:  ds.w  1
S6XL: dc.w  176
S6XR: dc.w   179
S6YU:  dc.w  296
S6YL: dc.w  301
ts21:  ds.w  1
ts22:  ds.w  1
ts23:  ds.w  1
ts24:  ds.w  1
S7XL: dc.w  260
S7XR: dc.w   263
S7YU:  dc.w  300
S7YL: dc.w  305
ts25:  ds.w  1
ts26:  ds.w  1
ts27:  ds.w  1
ts28:  ds.w  1
S8XL: dc.w  290
S8XR: dc.w   293
S8YU:  dc.w  47
S8YL: dc.w  52
ts29:  ds.w  1
ts30:  ds.w  1
ts31:  ds.w  1
ts32:  ds.w  1

S9XL: dc.w  270
S9XR: dc.w   285
S9YU:  dc.w  17
S9YL: dc.w  32
ts33:  ds.w  1
ts34:  ds.w  1
ts35:   ds.w  1
ts36:  ds.w  1

S10XL: dc.w  500
S10XR: dc.w   503
S10YU:  dc.w  120
S10YL: dc.w  125
ts37:  ds.w  1
ts38:  ds.w  1
ts39:   ds.w  1
ts40:  ds.w  1

S11XL: dc.w  510
S11XR: dc.w   513
S11YU:  dc.w  100
S11YL: dc.w  105
ts41:  ds.w  1
ts42:  ds.w  1
ts43:   ds.w  1
ts44:  ds.w  1

S12XL: dc.w  440
S12XR: dc.w   443
S12YU:  dc.w  400
S12YL: dc.w  403
ts45:  ds.w  1
ts46:  ds.w  1
ts47:   ds.w  1
ts48:  ds.w  1

S13XL: dc.w  440
S13XR: dc.w   443
S13YU:  dc.w  440
S13YL: dc.w  445
ts49:  ds.w  1
ts50:  ds.w  1
ts51:   ds.w  1
ts52:  ds.w  1

S14XL: dc.w  640
S14XR: dc.w   643
S14YU:  dc.w  390
S14YL: dc.w  395
ts53:  ds.w  1
ts54:  ds.w  1
ts55:   ds.w  1
ts56:  ds.w  1

S15XL: dc.w  637
S15XR: dc.w   640
S15YU:  dc.w  137
S15YL: dc.w  140
ts57:  ds.w  1
ts58:  ds.w  1
ts59:   ds.w  1
ts60:  ds.w  1

S16XL: dc.w  600
S16XR: dc.w   602
S16YU:  dc.w  260
S16YL: dc.w   262
ts61:  ds.w  1
ts62:  ds.w  1
ts63:   ds.w  1
ts64:  ds.w  1

S17XL: dc.w  500
S17XR: dc.w   502
S17YU:  dc.w  140
S17YL: dc.w   142
ts65:  ds.w  1
ts66:  ds.w  1
ts67:   ds.w  1
ts68:  ds.w  1

L:    ds.w  1
R:    ds.w  1
T:    ds.w 1
B:    ds.w 1
score: ds.l 1
    END    START        ; last line of source






















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
