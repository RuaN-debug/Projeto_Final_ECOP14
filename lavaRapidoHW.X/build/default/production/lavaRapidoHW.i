# 1 "lavaRapidoHW.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "lavaRapidoHW.c" 2
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
# 1 "lavaRapidoHW.c" 2


static const char valores[]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
long int unsigned contador=0;
unsigned char i,j;
static int cont=0;

void inicializa(){
    (*(volatile __near unsigned char*)0xFC1) = 0x06;
    (*(volatile __near unsigned char*)0xF93) = 0x01;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    (*(volatile __near unsigned char*)0xF96) = 0x00;
    (*(volatile __near unsigned char*)0xF93) = 0xF8;
    (*(volatile __near unsigned char*)0xF92)=0x00;
    (*(volatile __near unsigned char*)0xF94)=0x00;
    (((*(volatile __near unsigned char*)0xF82)) |= (1<<1));
    lcd_init();
}
void shift(int t,int op){
    for (i = 0; i < 10; i++) {
        atraso_ms(t);
        lcd_cmd(0x18);
    }
    for (i = 0; i < 20; i++) {
        atraso_ms(t);
        lcd_cmd(0x1C);
    }
    if(op==1) return;
    for (i = 0; i < 10; i++) {
        atraso_ms(t);
        lcd_cmd(0x18);
    }
    atraso_ms(1000);
}
void escolherVeiculo(){
    lcd_cmd(0x01);
    for(i=0;i<5;i++){
        lcd_cmd(0x80);
        lcd_str("Escolha seu veiculo");
        lcd_cmd(0xC0);
        lcd_str("1-Carro 2-Moto 3-Caminhao");
        shift(200,0);
    }
}
void intro(){
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str("Lava Rapido Hot");
    lcd_cmd(0xC0);
    lcd_str("     Wheels");
    shift(50,0);

    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str("       _/|''|'!_,");
    lcd_cmd(0xC0);
    lcd_str("       `-O---=O-'");
    shift(50,1);
}
unsigned char leituraTeclado(){
    unsigned char tmp;
    (*(volatile __near unsigned char*)0xF95) = 0x0F;
    tmp = tc_tecla(0) + 0x30;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    return tmp;
}
void tempo(int inicio, int fim){
    (*(volatile __near unsigned char*)0xF83)=0x00;
    contador=inicio*60;
    while(1){
        for(i=2;i<6;i++){
            if(i==2) (*(volatile __near unsigned char*)0xF83)=valores[(contador/60)/10];
            if(i==3) (*(volatile __near unsigned char*)0xF83)=valores[(contador/60)%10];
            if(i==4) (*(volatile __near unsigned char*)0xF83)=valores[(contador%60)/10];
            if(i==5) (*(volatile __near unsigned char*)0xF83)=valores[(contador%60)%10];
            (*(volatile __near unsigned char*)0xF80)=0x00;
            (((*(volatile __near unsigned char*)0xF80)) |= (1<<i));
            atraso_ms(1);
        }
        contador--;
        if(contador==fim*60){
            (*(volatile __near unsigned char*)0xF80)=0x00;
            break;
        }
    }
}
void contagem(int cont){
    (*(volatile __near unsigned char*)0xF93)=0x00;
    (*(volatile __near unsigned char*)0xF81)=0x00;
    for(i=1;i<=cont;i++) (((*(volatile __near unsigned char*)0xF81)) |= (1<<i));
    atraso_ms(600);
}
void lavando(char veiculo[10]){
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str("   Lavando");
    lcd_cmd(0xC0);
    lcd_str("   ");
    lcd_str(veiculo);
    atraso_ms(1000);
    lcd_cmd(0x01);
    lcd_str(" Pre-Lavagem...");
    tempo(60,45);
    lcd_cmd(0x01);
    lcd_str("  Ensaboando");
    lcd_cmd(0xC0);
    lcd_str("   ");
    lcd_str(veiculo);
    lcd_str("...");
    atraso_ms(50);
    tempo(45,30);
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str("  Enxaguando");
    lcd_cmd(0xC0);
    lcd_str("   ");
    lcd_str(veiculo);
    lcd_str("...");
    atraso_ms(50);
    tempo(30,15);
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str("   Secando");
    lcd_cmd(0xC0);
    lcd_str("   ");
    lcd_str(veiculo);
    lcd_str("...");
    (((*(volatile __near unsigned char*)0xF82)) |= (1<<2));
    atraso_ms(50);
    tempo(15,0);
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    (((*(volatile __near unsigned char*)0xF82)) &= ~(1<<2));
    lcd_cmd(0x01);
}
int lavandoVeiculo(unsigned char tmp){
    (*(volatile __near unsigned char*)0xF82)=0x00;
    (((*(volatile __near unsigned char*)0xF82)) |= (1<<1));
    if(tmp=='1'){
        lavando(" o Carro");
    }
    if(tmp=='2'){
        lavando(" a Moto");
    }
    if(tmp=='3'){
        lavando(" o Caminhao");
    }
    cont++;

    (((*(volatile __near unsigned char*)0xF82)) &= ~(1<<1));
    lcd_str("   Por favor");
    lcd_cmd(0xC0);
    lcd_str("retire seu veiculo");
    shift(200,0);
    (((*(volatile __near unsigned char*)0xF82)) |= (1<<1));
    lcd_cmd(0x01);
    do{
        lcd_str(" Pressione 1 para");
        lcd_cmd(0xC0);
        lcd_str("retirar seu veiculo");
        shift(200,0);
        i=leituraTeclado();
        if(i!='1'){
            lcd_cmd(0x01);
            lcd_str("Tecla invalida");
            atraso_ms(5000);
        }
        lcd_cmd(0x01);
    }while(i!='1');

    return cont;
}
