#include"lavaRapidoHW.h"

static const char valores[]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
long int unsigned contador=0;
unsigned char i,j;
static int cont=0;

void inicializa(){ 
    ADCON1 = 0x06;
    TRISB = 0x01;
    TRISD = 0x00;
    TRISE = 0x00;
    TRISB = 0xF8;
    TRISA=0x00;
    TRISC=0x00;
    //BitSet(PORTC,1); 
    lcd_init();
}
void shift(int t,int op){
    for (i = 0; i < 10; i++) {
        atraso_ms(t);
        lcd_cmd(0x18);
    }
    for (i = 0; i < 20; i++) {
        atraso_ms(t);
        lcd_cmd(0x1C); //lcd desliza pra direita
    }
    if(op==1) return;
    for (i = 0; i < 10; i++) {
        atraso_ms(t);
        lcd_cmd(0x18); //lcd desliza pra esquerda
    }
    atraso_ms(1000);
}
void escolherVeiculo(){
    lcd_cmd(L_CLR);
    for(i=0;i<5;i++){
        lcd_cmd(L_L1);
        lcd_str("Escolha seu veiculo");
        lcd_cmd(L_L2);
        lcd_str("1-Carro 2-Moto 3-Caminhao");
        shift(200,0);
    }
}
void intro(){ //Mensagens de introdução do Lava Rápido Hot Wheels
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str("Lava Rapido Hot");
    lcd_cmd(L_L2);
    lcd_str("     Wheels");
    shift(50,0);

    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str("       _/|''|'!_,");
    lcd_cmd(L_L2);
    lcd_str("       `-O---=O-'");
    shift(50,1);
}
unsigned char leituraTeclado(){ //Lê uma tecla para a escolha do veículo a ser lavado
    unsigned char tmp;
    TRISD = 0x0F; 
    tmp = tc_tecla(0) + 0x30; //lê a tecla e armazena em tmp         
    TRISD = 0x00;
    return tmp;
}
void tempo(int inicio, int fim){ //contador em segundos que recebe o inicio da contagem e o fim dela, com no máximo 1 minuto
    PORTD=0x00;
    contador=inicio*60; //começa a contar do parâmetro enviado, em segundos
    while(1){ //contagem em segundos e milissegundos nos displays de 7 segmentos
        for(i=2;i<6;i++){
            if(i==2) PORTD=valores[(contador/60)/10]; 
            if(i==3) PORTD=valores[(contador/60)%10];
            if(i==4) PORTD=valores[(contador%60)/10];
            if(i==5) PORTD=valores[(contador%60)%10];
            PORTA=0x00;
            BitSet(PORTA,i); //liga um display de cada vez
            atraso_ms(1);
        }
        contador--;
        if(contador==fim*60){ //termina a contagem no parâmetro enviado, em segundos
            PORTA=0x00;
            break;
        }
    }
}
void contagem(int cont){ //Mostra nos leds do PORTB a quantidade de veículos lavados no dia
    TRISB=0x00;
    PORTB=0x00;
    for(i=1;i<=cont;i++) BitSet(PORTB,i); //liga os leds do PORTB até o parâmetro recebido
    atraso_ms(600);
}
void lavando(char veiculo[10]){  //Etapas de lavagem de um carro
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str("   Lavando");
    lcd_cmd(L_L2);
    lcd_str("   ");
    lcd_str(veiculo);
    atraso_ms(1000);
    lcd_cmd(L_CLR);
    lcd_str(" Pre-Lavagem...");
    tempo(60,45);
    lcd_cmd(L_CLR);
    lcd_str("  Ensaboando");
    lcd_cmd(L_L2);
    lcd_str("   ");
    lcd_str(veiculo);
    lcd_str("...");
    atraso_ms(50);
    tempo(45,30);
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str("  Enxaguando");
    lcd_cmd(L_L2);
    lcd_str("   ");
    lcd_str(veiculo);
    lcd_str("...");
    atraso_ms(50);
    tempo(30,15);
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str("   Secando");
    lcd_cmd(L_L2);
    lcd_str("   ");
    lcd_str(veiculo);
    lcd_str("...");
    BitSet(PORTC,2); //liga o cooler
    atraso_ms(50);
    tempo(15,0);
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    BitClr(PORTC,2); //desliga o cooler
    lcd_cmd(L_CLR);
}
int lavandoVeiculo(unsigned char tmp){ //Inicia a lavagem de um veículo de acordo com a tecla pressionada
    PORTC=0x00;
    BitSet(PORTC,1);
    if(tmp=='1'){
        lavando(" o Carro");
    }
    if(tmp=='2'){
        lavando(" a Moto");
    }
    if(tmp=='3'){
        lavando(" o Caminhao");
    }
    cont++; //acrescenta um na variável de veículos lavados
    
    BitClr(PORTC,1); //ativa o buzzer para avisar que terminou a lavagem
    lcd_str("   Por favor");
    lcd_cmd(L_L2);
    lcd_str("retire seu veiculo");
    shift(200,0);
    BitSet(PORTC,1); //desativa o buzzer
    lcd_cmd(L_CLR);
    do{ //garante que a tecla certa seja digitada
        lcd_str(" Pressione 1 para");
        lcd_cmd(L_L2);
        lcd_str("retirar seu veiculo");
        shift(200,0);
        i=leituraTeclado();
        if(i!='1'){
            lcd_cmd(L_CLR);
            lcd_str("Tecla invalida");
            atraso_ms(5000);
        }
        lcd_cmd(L_CLR);
    }while(i!='1');
    
    return cont; //retorna a quantidade de veículos lavados
} 



