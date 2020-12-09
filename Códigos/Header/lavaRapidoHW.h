#ifndef LAVARAPIDOHW_H
#define	LAVARAPIDOHW_H
#include "config.h"
#include "pic18f4520.h"
#include "delay.h"
#include "lcd.h"
#include "teclado.h"

void inicializa();                       //inicializa todos os ports e o lcd
void shift(int,int);                    //desliza a mensagem do lcd
void escolherVeiculo();                //menu para escolha do veículo
void intro();                         //breve introdução do projeto
unsigned char leituraTeclado();      //lê e retorna uma tecla 
void lavando(char[10]);             //mostra as mensagens das etapas de lavagem no lcd
int lavandoVeiculo(unsigned char); //funciona em conjunto com a função lavando
void contagem(int);               //contabiliza quantos veículos foram lavados nos leds
void tempo();                    //conta o tempo de cada lavagem nos displays de 7 segmentos

#endif	

