;Assignment 2 

    JMP Start

;Data 


CR =      13D
LF =      10D

temp      DB  ?
conv      DB  ?
num1      DB  ?
num2      DB  ?
Final     DB  ?
msg       DB  'Please enter the temperature value you would like to convert...', CR, LF,'$' 
msg2      DB  'Please enter C for Centigrade -> Farenheit or F for Farenheit -> Centigrade...', CR, LF,'$'
PntStr:   DB  '    '
Carriage  DB  ' ', CR, LF, '$'
Answer    DB  'Answer: ', '$'


Start:     
            MOV AX, 0       ;Clear AX Register
            MOV AL, 3       ;Set Value of AL to 3h
            INT 10H         ;INT 10h with sub-command 3h to create new window

            LEA DX, msg2    ;Load effective address for message
            MOV AH, 9       
            INT 21H         ;Output message to screen
            
            MOV AH, 1
            INT 21H         ;User input
            CMP AL, 0dh     ;Check for carrage return
            JZ Start        ;If return was pressed then check ZF flag and jump back to start 
        
Comp:       

            MOV BL, 'C'
            CMP BL, AL      ;Check if C was entered
            JZ Cent         ;Check ZF flag and jump to sum
    
            MOV BL, 'F'     
            CMP BL, AL      ;Check if F was entered
            JZ Far          ;Check ZF flag and jump to sum
            
            JMP Start
            

Cent:       
            CALL Enttemp    ;Call temp input 
            
            LEA DI, temp    ;Perform calculation
            MOV AL, [DI]
            MOV DL, 9
            MUL DL
            MOV DL, 5
            DIV DL
            MOV AH, 32
            ADD AL, AH
            
            LEA DI, Final
            MOV [DI], AL
            
            JMP Finish
            
Far:            
            CALL Enttemp   ;Call temp input
            

            LEA DI, temp   ;Perform calculation
            MOV AL, [DI]
            SUB AL, 32
            MOV DL, 5
            MUL DL
            MOV DL, 9
            DIV DL
            
            LEA DI, Final
            MOV [DI], AL
            
            JMP Finish


Enttemp:
            MOV AX, 0
            MOV AL, 3
            INT 10H
            
            LEA DX, msg     ;Load msg
            MOV AH, 9       ;Set value of AH to 9h
            INT 21H         ;INT 21h with sub-command 9h to prompt message display
        
            
            LEA DI, num1
            MOV AH, 1   
            INT 21H         ;INT 21h with sub-command 1h to allow for user input
            CMP AL, 0dh     ;Check for carrage return
            JZ Enttemp      ;If return was pressed then check ZF flag and jump return back            
            SUB AL, 30H
            MOV [DI], AL
            
            LEA DI, num2
            MOV AH, 1
            INT 21H
            CMP AL, 0dh
            JZ Enttemp
            SUB AL, 30H
            MOV [DI], AL
            
            MOV AL, num1
            MOV BL, 10
            MUL BL
            ADD AL, num2
            
            LEA DI, temp
            MOV [DI], AL
            
            
RET                         
                     
                                           


Finish:
            
            MOV AX, 0
            MOV DX, 0
            LEA DI, Final
            MOV AL, [DI]
            MOV CL, 10
            DIV CL
            
            ADD AL, 30H
            
            MOV DL, AH
            ADD DL, 30H
             
            
            MOV BP, 1
            MOV BYTE PTR [PntStr+BP], AL
            MOV BP, 2
            MOV BYTE PTR [PntStr+BP], DL
            MOV AL, 24H
            MOV BP, 3
            MOV BYTE PTR [PntStr+BP], AL
            
            MOV AX, 0       
            MOV AL, 3       
            INT 10H         
            LEA DX, Answer
            MOV AH, 9
            INT 21H
            
            MOV DX, PntStr
            MOV AH, 9
            INT 21H               