# 1 "main.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "main.c" 2
# 1 "./lavaRapidoHW.h" 1


# 1 "./config.h" 1
# 38 "./config.h"
#pragma config OSC=HS
#pragma config WDT=OFF
#pragma config LVP=OFF
#pragma config DEBUG = OFF
#pragma config WDTPS = 1
# 3 "./lavaRapidoHW.h" 2

# 1 "./pic18f4520.h" 1
# 4 "./lavaRapidoHW.h" 2

# 1 "./delay.h" 1



void atraso_ms(unsigned long int t);
# 5 "./lavaRapidoHW.h" 2

# 1 "./lcd.h" 1
# 14 "./lcd.h"
void lcd_init(void);
void lcd_cmd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(const char* str);
# 6 "./lavaRapidoHW.h" 2

# 1 "./teclado.h" 1







    unsigned char tc_tecla(unsigned int timeout);
# 7 "./lavaRapidoHW.h" 2


void inicializa();
void shift(int,int);
void escolherVeiculo();
void intro();
unsigned char leituraTeclado();
void lavando(char[10]);
int lavandoVeiculo(unsigned char);
void contagem(int);
void tempo();
# 1 "main.c" 2


void main(){
    unsigned char tmp;
    int cont,i;
    inicializa();
    intro();
    while(1){
        (((*(volatile __near unsigned char*)0xF82)) |= (1<<1));
        lcd_cmd(0x01);
        if(cont>0){
            do{
                lcd_str("1-Escolher outro veiculo");
                lcd_cmd(0xC0);
                lcd_str("2-Sair do lava jato");
                shift(200,0);
                tmp=leituraTeclado();
                if(tmp!='1' && tmp!='2'){
                    lcd_cmd(0x01);
                    lcd_str("Tecla invalida");
                    atraso_ms(5000);
                    lcd_cmd(0x01);
                }
                if(tmp=='2') goto sair;
            }while(tmp!='1' && tmp!='2');
        }
        do{
            escolherVeiculo();
            tmp=leituraTeclado();
            if(tmp!='1' && tmp!='2' && tmp!='3'){
                lcd_cmd(0x01);
                lcd_str("Tecla invalida");
                atraso_ms(5000);
                lcd_cmd(0x01);
            }
        }while(tmp!='1' && tmp!='2' && tmp!='3');
        if(cont==0) {
            (*(volatile __near unsigned char*)0xF93)=0x00;
            (*(volatile __near unsigned char*)0xF81)=0x00;
        }
        cont=lavandoVeiculo(tmp);
        contagem(cont);
        if(cont>=7){
            break;
        }
        (((*(volatile __near unsigned char*)0xF82)) |= (1<<1));
    }
    sair:
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str("Expediente encerrado");
    lcd_cmd(0xC0);
    lcd_str("Tenha um bom dia!");
    shift(120,0);
    atraso_ms(1000);
    lcd_cmd(0x01);
    while(1);
}
