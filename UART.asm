
_main:

;UART.c,25 :: 		void main() {
;UART.c,26 :: 		ANSEL = ANSELH=0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;UART.c,27 :: 		TRISA = 0XFF;
	MOVLW      255
	MOVWF      TRISA+0
;UART.c,28 :: 		TRISD = 0X00;    //All PORTD pins configured as outputs
	CLRF       TRISD+0
;UART.c,29 :: 		TRISB = 0X00;  //All PORTB pins configured as outputs
	CLRF       TRISB+0
;UART.c,30 :: 		PORTB = 0X00; //Turning PORTB off
	CLRF       PORTB+0
;UART.c,31 :: 		TRISC1_bit = 0;     //OUTPUT FOR PWM1
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;UART.c,32 :: 		TRISC2_bit = 0;     //OUTPUT FOR PWM1
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;UART.c,33 :: 		TRISC6_bit = 1;    //Bluetooth module TXD pin
	BSF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;UART.c,34 :: 		TRISA2_bit = 1;   //First Flame sensor input RA2
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
;UART.c,35 :: 		TRISE2_bit = 1;  //Second Flame sensor input RE2
	BSF        TRISE2_bit+0, BitPos(TRISE2_bit+0)
;UART.c,36 :: 		TRISA1_bit = 1; //Smoke Senser input RA1
	BSF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
;UART.c,37 :: 		PORTB.RB0  = 0;     // Motor_1 output
	BCF        PORTB+0, 0
;UART.c,38 :: 		PORTB.RB1  = 0;    // Motor_1 output
	BCF        PORTB+0, 1
;UART.c,39 :: 		PORTB.RB2  = 0;   // Motor_2 output
	BCF        PORTB+0, 2
;UART.c,40 :: 		PORTB.RB3  = 0;  // Motor_2 output
	BCF        PORTB+0, 3
;UART.c,41 :: 		PORTB.RB5  = 0; // Water pump output
	BCF        PORTB+0, 5
;UART.c,42 :: 		TRISE.RE1  = 0;//Led output
	BCF        TRISE+0, 1
;UART.c,44 :: 		CCP1CON = 0b00001100; // Configure CCP1 for PWM mode  RC1
	MOVLW      12
	MOVWF      CCP1CON+0
;UART.c,46 :: 		T2CON = 0b00000111;   // Configure Timer2 with a prescaler of 16
	MOVLW      7
	MOVWF      T2CON+0
;UART.c,48 :: 		UART1_INIT(9600);    // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;UART.c,50 :: 		PWM1_Init(5000);                    // Initialize PWM1 module at 5KHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;UART.c,51 :: 		PWM2_Init(5000);                    // Initialize PWM2 module at 5KHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;UART.c,53 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;UART.c,54 :: 		PWM2_Start();                       // start PWM2
	CALL       _PWM2_Start+0
;UART.c,56 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,57 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,59 :: 		SCS_bit = 1;
	BSF        SCS_bit+0, BitPos(SCS_bit+0)
;UART.c,60 :: 		IRCF2_bit=IRCF1_bit=IRCF0_bit = 1;
	BSF        IRCF0_bit+0, BitPos(IRCF0_bit+0)
	BTFSC      IRCF0_bit+0, BitPos(IRCF0_bit+0)
	GOTO       L__main18
	BCF        IRCF1_bit+0, BitPos(IRCF1_bit+0)
	GOTO       L__main19
L__main18:
	BSF        IRCF1_bit+0, BitPos(IRCF1_bit+0)
L__main19:
	BTFSC      IRCF1_bit+0, BitPos(IRCF1_bit+0)
	GOTO       L__main20
	BCF        IRCF2_bit+0, BitPos(IRCF2_bit+0)
	GOTO       L__main21
L__main20:
	BSF        IRCF2_bit+0, BitPos(IRCF2_bit+0)
L__main21:
;UART.c,62 :: 		UART1_WRITE_TEXT("PRESS A KEY : ");
	MOVLW      ?lstr1_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,64 :: 		while(1)
L_main0:
;UART.c,66 :: 		if(UART1_DATA_READY())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;UART.c,68 :: 		uart_rd=UART1_READ();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;UART.c,69 :: 		UART1_WRITE(uart_rd);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,70 :: 		}
L_main2:
;UART.c,72 :: 		switch(uart_rd)
	GOTO       L_main3
;UART.c,74 :: 		case 'F': // Move forward
L_main5:
;UART.c,75 :: 		PORTB.RB5 = 0;  //water pump off
	BCF        PORTB+0, 5
;UART.c,76 :: 		PORTE.RE1 = 0;  //led off
	BCF        PORTE+0, 1
;UART.c,77 :: 		PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BCF        PORTB+0, 7
;UART.c,78 :: 		PORTB.RB0 = 1;
	BSF        PORTB+0, 0
;UART.c,79 :: 		PORTB.RB1 = 0;
	BCF        PORTB+0, 1
;UART.c,80 :: 		PORTB.RB2 = 1;
	BSF        PORTB+0, 2
;UART.c,81 :: 		PORTB.RB3 = 0;
	BCF        PORTB+0, 3
;UART.c,82 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,83 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,84 :: 		break;
	GOTO       L_main4
;UART.c,85 :: 		case 'B': // Move backward
L_main6:
;UART.c,87 :: 		PORTB.RB5 = 0;  //water pump off
	BCF        PORTB+0, 5
;UART.c,88 :: 		PORTE.RE1 = 0; //led off
	BCF        PORTE+0, 1
;UART.c,89 :: 		PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BCF        PORTB+0, 7
;UART.c,90 :: 		PORTB.RB0 = 0;
	BCF        PORTB+0, 0
;UART.c,91 :: 		PORTB.RB1 = 1;
	BSF        PORTB+0, 1
;UART.c,92 :: 		PORTB.RB2 = 0;
	BCF        PORTB+0, 2
;UART.c,93 :: 		PORTB.RB3 = 1;
	BSF        PORTB+0, 3
;UART.c,94 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,95 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,96 :: 		break;
	GOTO       L_main4
;UART.c,97 :: 		case 'L': // Turn left
L_main7:
;UART.c,99 :: 		PORTB.RB5 = 0;  //water pump off
	BCF        PORTB+0, 5
;UART.c,100 :: 		PORTE.RE1 = 0;  //led off
	BCF        PORTE+0, 1
;UART.c,101 :: 		PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BCF        PORTB+0, 7
;UART.c,102 :: 		PORTB.RB0 = 0;
	BCF        PORTB+0, 0
;UART.c,103 :: 		PORTB.RB1 = 1;
	BSF        PORTB+0, 1
;UART.c,104 :: 		PORTB.RB2 = 1;
	BSF        PORTB+0, 2
;UART.c,105 :: 		PORTB.RB3 = 0;
	BCF        PORTB+0, 3
;UART.c,106 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,107 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,108 :: 		break;
	GOTO       L_main4
;UART.c,109 :: 		case 'R': // Turn right
L_main8:
;UART.c,110 :: 		PORTB.RB5 = 0;  //water pump off
	BCF        PORTB+0, 5
;UART.c,111 :: 		PORTE.RE1 = 0;  //led off
	BCF        PORTE+0, 1
;UART.c,112 :: 		PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BCF        PORTB+0, 7
;UART.c,113 :: 		PORTB.RB0 = 1;
	BSF        PORTB+0, 0
;UART.c,114 :: 		PORTB.RB1 = 0;
	BCF        PORTB+0, 1
;UART.c,115 :: 		PORTB.RB2 = 0;
	BCF        PORTB+0, 2
;UART.c,116 :: 		PORTB.RB3 = 1;
	BSF        PORTB+0, 3
;UART.c,117 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,118 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,119 :: 		break;
	GOTO       L_main4
;UART.c,120 :: 		case 'S': // Stop
L_main9:
;UART.c,121 :: 		PORTB.RB5 = 0;  //water pump off
	BCF        PORTB+0, 5
;UART.c,122 :: 		PORTE.RE1 = 0;  //led off
	BCF        PORTE+0, 1
;UART.c,123 :: 		PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BCF        PORTB+0, 7
;UART.c,124 :: 		PORTB.RB0 = 0;
	BCF        PORTB+0, 0
;UART.c,125 :: 		PORTB.RB1 = 0;
	BCF        PORTB+0, 1
;UART.c,126 :: 		PORTB.RB2 = 0;
	BCF        PORTB+0, 2
;UART.c,127 :: 		PORTB.RB3 = 0;
	BCF        PORTB+0, 3
;UART.c,128 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,129 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,130 :: 		break;
	GOTO       L_main4
;UART.c,131 :: 		case 'W': // Activate water pump
L_main10:
;UART.c,132 :: 		if(PORTE.RE2==1 || PORTA.RA1==1 || PORTA.RA2==1)
	BTFSC      PORTE+0, 2
	GOTO       L__main16
	BTFSC      PORTA+0, 1
	GOTO       L__main16
	BTFSC      PORTA+0, 2
	GOTO       L__main16
	GOTO       L_main13
L__main16:
;UART.c,134 :: 		PORTE.RE1 = 0;   //led off
	BCF        PORTE+0, 1
;UART.c,135 :: 		PORTB.RB5 = 1;  //water pump on
	BSF        PORTB+0, 5
;UART.c,136 :: 		PORTB.RB7 = 1;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BSF        PORTB+0, 7
;UART.c,137 :: 		PORTB.RB0 = 0;
	BCF        PORTB+0, 0
;UART.c,138 :: 		PORTB.RB1 = 0;
	BCF        PORTB+0, 1
;UART.c,139 :: 		PORTB.RB2 = 0;
	BCF        PORTB+0, 2
;UART.c,140 :: 		PORTB.RB3 = 0;
	BCF        PORTB+0, 3
;UART.c,141 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,142 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,143 :: 		}
	GOTO       L_main14
L_main13:
;UART.c,146 :: 		PORTE.RE1 = 0; //led off
	BCF        PORTE+0, 1
;UART.c,147 :: 		PORTB.RB5 = 0;//water pump off
	BCF        PORTB+0, 5
;UART.c,148 :: 		PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BCF        PORTB+0, 7
;UART.c,149 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,150 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,151 :: 		}
L_main14:
;UART.c,152 :: 		break;
	GOTO       L_main4
;UART.c,153 :: 		default:
L_main15:
;UART.c,154 :: 		PORTE.RE1 = 1;  //led on
	BSF        PORTE+0, 1
;UART.c,155 :: 		PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
	BCF        PORTB+0, 7
;UART.c,156 :: 		PORTB.RB0 = 0;
	BCF        PORTB+0, 0
;UART.c,157 :: 		PORTB.RB1 = 0;
	BCF        PORTB+0, 1
;UART.c,158 :: 		PORTB.RB2 = 0;
	BCF        PORTB+0, 2
;UART.c,159 :: 		PORTB.RB3 = 0;
	BCF        PORTB+0, 3
;UART.c,160 :: 		PORTB.RB5 = 0; //water pump off
	BCF        PORTB+0, 5
;UART.c,161 :: 		PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;UART.c,162 :: 		PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;UART.c,163 :: 		break;
	GOTO       L_main4
;UART.c,164 :: 		} //end of switch statement
L_main3:
	MOVF       _uart_rd+0, 0
	XORLW      70
	BTFSC      STATUS+0, 2
	GOTO       L_main5
	MOVF       _uart_rd+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main6
	MOVF       _uart_rd+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVF       _uart_rd+0, 0
	XORLW      82
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _uart_rd+0, 0
	XORLW      83
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _uart_rd+0, 0
	XORLW      87
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	GOTO       L_main15
L_main4:
;UART.c,165 :: 		} //end of while loop
	GOTO       L_main0
;UART.c,166 :: 		} //end of main function
L_end_main:
	GOTO       $+0
; end of _main
