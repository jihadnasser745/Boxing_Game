*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
                MOVE.L #10,B1_X
                MOVE.L #200,B1_Y
                MOVE.L #600,B2_X
                MOVE.L #200,B2_Y
                MOVE.L #30,B_W
                MOVE.L #150,B_H
                
                
                MOVE.L #45,RH1_X
                MOVE.L #170,RH1_Y
                MOVE.L #535,RH2_X
                MOVE.L #17,RH2_Y
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
                
                MOVE.L #298,H1_X
                MOVE.L #342,H2_X
                
                
                MOVE.L #10,BHL1_X
                MOVE.L #345,BHL1_Y
                MOVE.L #595,BHL2_X
                MOVE.L #345,BHL2_Y
                
                
                MOVE.L #0,IS_INVERSED
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
