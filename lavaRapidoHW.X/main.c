#include"lavaRapidoHW.h"

void main(){
    unsigned char tmp;
    int cont,i;
    inicializa();
    intro();
    while(1){  
        BitSet(PORTC,1); 
        lcd_cmd(L_CLR);
        if(cont>0){ //da segunda lavagem em diante pode-se escolher sair
            do{ //looping para garantir a escolha da tecla certa
                lcd_str("1-Escolher outro veiculo");
                lcd_cmd(L_L2);
                lcd_str("2-Sair do lava jato");
                shift(200,0);
                tmp=leituraTeclado();
                if(tmp!='1' && tmp!='2'){
                    lcd_cmd(L_CLR);
                    lcd_str("Tecla invalida");
                    atraso_ms(5000);
                    lcd_cmd(L_CLR);
                }
                if(tmp=='2') goto sair;   //caso a tecla seja 2, vai para o final do programa
            }while(tmp!='1' && tmp!='2');
        }
        do{ //looping para garantir a escolha da tecla certa
            escolherVeiculo();
            tmp=leituraTeclado();
            if(tmp!='1' && tmp!='2' && tmp!='3'){
                lcd_cmd(L_CLR);
                lcd_str("Tecla invalida");
                atraso_ms(5000);
                lcd_cmd(L_CLR);
            }
        }while(tmp!='1' && tmp!='2' && tmp!='3');
        if(cont==0) { //desliga os leds do PORTB na primeira lavagem
            TRISB=0x00;
            PORTB=0x00;
        }
        cont=lavandoVeiculo(tmp);
        contagem(cont);
        if(cont>=7){ //ao final de 7 lavagens o expediente é encerrado
            break;
        }
        BitSet(PORTC,1); 
    }
    sair:
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str("Expediente encerrado");
    lcd_cmd(L_L2);
    lcd_str("Tenha um bom dia!");
    shift(120,0);
    atraso_ms(1000);
    lcd_cmd(L_CLR);
    while(1);
}