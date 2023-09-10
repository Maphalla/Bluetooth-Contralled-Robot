unsigned char uart_rd;
#define FLAME_THRESHOLD  500
#define MOTOR_1_PIN1     RB0
#define MOTOR_1_PIN      RB1
#define MOTOR_2_PIN1     RB2
#define MOTOR_2_PIN      RB3
#define WATER_PUMP_PIN   RB5    //Water pump   output
#define Flame sensor     RA2   // Flame sensor 1 input
#define Flame sensor     RE2  // Flame sensor 2  input
#define Gas sensor       RA1 //Gas/Smoke sensor  input
#define MOTOR_SPEED      127

//void PWM1_Init() {
   // PR2 = 249;          // Set PWM period (1 / frequency)
    //T2CON = 0b00000111; // Configure Timer2 with a prescaler of 16
    //CCP1CON = 0b00001100; // Configure CCP1 for PWM mode
    //CCP2CON = 0b00001100; // Configure CCP1 for PWM mode
//}

//void PWM1_SET_DUTY(unsigned int dutyCycle) {
    //CCPR1L = dutyCycle; // Set PWM duty cycle for Motor 1
    //CCPR2L = dutyCycle; // Set PWM duty cycle for Motor 1
//}

void main() {
ANSEL = ANSELH=0;
TRISA = 0XFF;
TRISD = 0X00;    //All PORTD pins configured as outputs
TRISB = 0X00;  //All PORTB pins configured as outputs
PORTB = 0X00; //Turning PORTB off
TRISC1_bit = 0;     //OUTPUT FOR PWM1
TRISC2_bit = 0;     //OUTPUT FOR PWM1
TRISC6_bit = 1;    //Bluetooth module TXD pin
TRISA2_bit = 1;   //First Flame sensor input RA2
TRISE2_bit = 1;  //Second Flame sensor input RE2
TRISA1_bit = 1; //Smoke Senser input RA1
PORTB.RB0  = 0;     // Motor_1 output
PORTB.RB1  = 0;    // Motor_1 output
PORTB.RB2  = 0;   // Motor_2 output
PORTB.RB3  = 0;  // Motor_2 output
PORTB.RB5  = 0; // Water pump output
TRISE.RE1  = 0;//Led output

CCP1CON = 0b00001100; // Configure CCP1 for PWM mode  RC1
//CCP2CON = 0b00001100; // Configure CCP2 for PWM mode  RC2
T2CON = 0b00000111;   // Configure Timer2 with a prescaler of 16

UART1_INIT(9600);    // Initialize UART module at 9600 bps
//delay_ms(100);      //  Wait for UART module to stabilize
PWM1_Init(5000);                    // Initialize PWM1 module at 5KHz
PWM2_Init(5000);                    // Initialize PWM2 module at 5KHz

PWM1_Start();                       // start PWM1
PWM2_Start();                       // start PWM2

PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%

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
      case 'F': // Move forward
        PORTB.RB5 = 0;  //water pump off
        PORTE.RE1 = 0;  //led off
        PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
        PORTB.RB0 = 1;
        PORTB.RB1 = 0;
        PORTB.RB2 = 1;
        PORTB.RB3 = 0;
     PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
     PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
        break;
      case 'B': // Move backward

        PORTB.RB5 = 0;  //water pump off
        PORTE.RE1 = 0; //led off
        PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
        PORTB.RB0 = 0;
        PORTB.RB1 = 1;
        PORTB.RB2 = 0;
        PORTB.RB3 = 1;
      PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
      PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
        break;
      case 'L': // Turn left

        PORTB.RB5 = 0;  //water pump off
        PORTE.RE1 = 0;  //led off
        PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
        PORTB.RB0 = 0;
        PORTB.RB1 = 1;
        PORTB.RB2 = 1;
        PORTB.RB3 = 0;
      PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
      PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
        break;
      case 'R': // Turn right
        PORTB.RB5 = 0;  //water pump off
        PORTE.RE1 = 0;  //led off
        PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
        PORTB.RB0 = 1;
        PORTB.RB1 = 0;
        PORTB.RB2 = 0;
        PORTB.RB3 = 1;
      PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
      PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
        break;
      case 'S': // Stop
        PORTB.RB5 = 0;  //water pump off
        PORTE.RE1 = 0;  //led off
        PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
        PORTB.RB0 = 0;
        PORTB.RB1 = 0;
        PORTB.RB2 = 0;
        PORTB.RB3 = 0;
      PWM1_SET_DUTY(0); // Set PWM1 duty_cycle of 25%
      PWM2_SET_DUTY(0); // Set PWM1 duty_cycle of 25%
        break;
      case 'W': // Activate water pump
          if(PORTE.RE2==1 || PORTA.RA1==1 || PORTA.RA2==1)
         {
            PORTE.RE1 = 0;   //led off
            PORTB.RB5 = 1;  //water pump on
            PORTB.RB7 = 1;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
            PORTB.RB0 = 0;
            PORTB.RB1 = 0;
            PORTB.RB2 = 0;
            PORTB.RB3 = 0;
      PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
      PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
         }
          else
          {
            PORTE.RE1 = 0; //led off
            PORTB.RB5 = 0;//water pump off
            PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
      PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
      PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
          }
        break;
        default:
          PORTE.RE1 = 1;  //led on
          PORTB.RB7 = 0;  //LED TO SHOW IF FIRE IS DETECTED OR NOT
          PORTB.RB0 = 0;
          PORTB.RB1 = 0;
          PORTB.RB2 = 0;
          PORTB.RB3 = 0;
          PORTB.RB5 = 0; //water pump off
      PWM1_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
      PWM2_SET_DUTY(255); // Set PWM1 duty_cycle of 25%
          break;
      } //end of switch statement
   } //end of while loop
} //end of main function