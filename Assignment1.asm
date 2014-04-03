;Assignment 1 

    JMP Start

;Data 


CR =    13D
LF =    10D
store:  DW  2 DUP (0)
msg     DB  'Enter your guess between 1 and 5...', CR, LF, '$'
msg2    DB  'Your guess is incorrect. Press any key to try again!...', CR, LF, '$'
msg3    DB  'Well done, Your guess was correct! Press any key to quit!...', CR, LF, '$'


Clear:
            MOV AX, 0   ;Clear AX Register
            MOV AL, 3   ;Set Vale of AL to 3h
            INT 10H     ;INT 10h with sub-command 3h to create new window   


Start:
            LEA DX, msg     ;Load msg
            MOV AH, 9       ;Set value of AH to 9h
            INT 21H         ;INT 21h with sub-command 9h to prompt message display
        
            LEA DI, store
        
            MOV AH, 1   
            INT 21H         ;INT 21h with sub-command 1h to allow for user input
            CMP AL, 0dh     ;Check for carrage return
            JZ Finish       ;If return was pressed then check ZF flag and jump to end program
            
            SUB AL, 30H
            MOV [DI], AL    ;Store guessed number 


Number:     
            MOV AH, 2CH     ;Generate random number
            INT 21H
            MOV AL, DL
            MOV AH, 0
            MOV CL, 20
            DIV CL
            MOV BL, AL
            INC BL
        
Comp:       
            MOV AL, [DI]
            CMP BL, AL     ;Compare random number and stored 'guess' number
            JZ Win         ;If ZF flag is set then jump to 'Win'
            
            JMP Lose       ;Else, jump to 'Lose'
            
Win:        
            MOV AX, 0
            MOV AL, 3
            INT 10H 
            LEA DX, msg3
            MOV AH, 9
            INT 21H
            MOV AH, 1
            INT 21H
            
            JMP Finish
            
Lose:       
            MOV AX, 0
            MOV AL, 3
            INT 10H 
            LEA DX, msg2
            MOV AH, 9
            INT 21H
            MOV AH, 1
            INT 21H
            JMP Clear                        
            
                               
Finish:
            MOV AH, 4Ch
            INT 21H               