#line 1 "C:/Users/LENOVO/Desktop/Project/UART1/fire Fighting robot/UART.c"
unsigned char uart_rd;
#line 25 "C:/Users/LENOVO/Desktop/Project/UART1/fire Fighting robot/UART.c"
void main() {
ANSEL = ANSELH=0;
TRISA = 0XFF;
TRISD = 0X00;
TRISB = 0X00;
PORTB = 0X00;
TRISC1_bit = 0;
TRISC2_bit = 0;
TRISC6_bit = 1;
TRISA2_bit = 1;
TRISE2_bit = 1;
TRISA1_bit = 1;
PORTB.RB0 = 0;
PORTB.RB1 = 0;
PORTB.RB2 = 0;
PORTB.RB3 = 0;
PORTB.RB5 = 0;
TRISE.RE1 = 0;

CCP1CON = 0b00001100;

T2CON = 0b00000111;

UART1_INIT(9600);

PWM1_Init(5000);
PWM2_Init(5000);

PWM1_Start();
PWM2_Start();

PWM1_SET_DUTY(255);
PWM2_SET_DUTY(255);

SCS_bit = 1;
IRCF2_bit=IRCF1_bit=IRCF0_bit = 1;

UART1_WRITE_TEXT("PRESS A KEY : ");

while(1)
{
 if(UART1_DATA_READY())
 {
 uart_rd=UART1_READ();
 UART1_WRITE(uart_rd);
 }

 switch(uart_rd)
 {
 case 'F':
 PORTB.RB5 = 0;
 PORTE.RE1 = 0;
 PORTB.RB7 = 0;
 PORTB.RB0 = 1;
 PORTB.RB1 = 0;
 PORTB.RB2 = 1;
 PORTB.RB3 = 0;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 break;
 case 'B':

 PORTB.RB5 = 0;
 PORTE.RE1 = 0;
 PORTB.RB7 = 0;
 PORTB.RB0 = 0;
 PORTB.RB1 = 1;
 PORTB.RB2 = 0;
 PORTB.RB3 = 1;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 break;
 case 'L':

 PORTB.RB5 = 0;
 PORTE.RE1 = 0;
 PORTB.RB7 = 0;
 PORTB.RB0 = 0;
 PORTB.RB1 = 1;
 PORTB.RB2 = 1;
 PORTB.RB3 = 0;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 break;
 case 'R':
 PORTB.RB5 = 0;
 PORTE.RE1 = 0;
 PORTB.RB7 = 0;
 PORTB.RB0 = 1;
 PORTB.RB1 = 0;
 PORTB.RB2 = 0;
 PORTB.RB3 = 1;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 break;
 case 'S':
 PORTB.RB5 = 0;
 PORTE.RE1 = 0;
 PORTB.RB7 = 0;
 PORTB.RB0 = 0;
 PORTB.RB1 = 0;
 PORTB.RB2 = 0;
 PORTB.RB3 = 0;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 break;
 case 'W':
 if(PORTE.RE2==1 || PORTA.RA1==1 || PORTA.RA2==1)
 {
 PORTE.RE1 = 0;
 PORTB.RB5 = 1;
 PORTB.RB7 = 1;
 PORTB.RB0 = 0;
 PORTB.RB1 = 0;
 PORTB.RB2 = 0;
 PORTB.RB3 = 0;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 }
 else
 {
 PORTE.RE1 = 0;
 PORTB.RB5 = 0;
 PORTB.RB7 = 0;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 }
 break;
 default:
 PORTE.RE1 = 1;
 PORTB.RB7 = 0;
 PORTB.RB0 = 0;
 PORTB.RB1 = 0;
 PORTB.RB2 = 0;
 PORTB.RB3 = 0;
 PORTB.RB5 = 0;
 PWM1_SET_DUTY(255);
 PWM2_SET_DUTY(255);
 break;
 }
 }
}
