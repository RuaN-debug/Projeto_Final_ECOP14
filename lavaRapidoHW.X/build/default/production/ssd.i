# 1 "ssd.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "ssd.c" 2
# 21 "ssd.c"
# 1 "./ssd.h" 1
# 22 "./ssd.h"
 void ssdDigit(char val, char pos);
 void ssdUpdate(void);
 void ssdInit(void);
# 21 "ssd.c" 2

# 1 "./pic18f4520.h" 1
# 22 "ssd.c" 2



static const char valor[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

static char display;

static char v0, v1, v2, v3;

void ssdDigit(char val, char pos)
{
 if (pos == 0)
 {
  v0 = val;
 }
 if (pos == 1)
 {
  v1 = val;
 }
 if (pos == 2)
 {
  v2 = val;
 }
 if (pos == 3)
 {
  v3 = val;
 }

}

void ssdUpdate(void)
{

 (*(volatile __near unsigned char*)0xF80) = 0x00;
 (*(volatile __near unsigned char*)0xF84) = 0x00;

 (*(volatile __near unsigned char*)0xF83) = 0x00;

 switch(display)
 {
  case 0:
   (*(volatile __near unsigned char*)0xF83) = valor[v0];
   (((*(volatile __near unsigned char*)0xF80)) |= (1<<5));
   display = 1;
  break;

  case 1:
   (*(volatile __near unsigned char*)0xF83) = valor[v1];
   (((*(volatile __near unsigned char*)0xF80)) |= (1<<2));
   display = 2;
  break;

  case 2:
   (*(volatile __near unsigned char*)0xF83) = valor[v2];
   (((*(volatile __near unsigned char*)0xF84)) |= (1<<0));
   display = 3;
  break;

  case 3:
   (*(volatile __near unsigned char*)0xF83) = valor[v3];
   (((*(volatile __near unsigned char*)0xF84)) |= (1<<2));
   display = 0;
  break;

  default:
   display = 0;
  break;
 }
}


void ssdInit(void)
{

 (((*(volatile __near unsigned char*)0xF92)) &= ~(1<<2));
 (((*(volatile __near unsigned char*)0xF92)) &= ~(1<<5));
 (((*(volatile __near unsigned char*)0xF96)) &= ~(1<<0));
 (((*(volatile __near unsigned char*)0xF96)) &= ~(1<<2));
 (*(volatile __near unsigned char*)0xFC1) = 0x0E;
 (*(volatile __near unsigned char*)0xF95) = 0x00;

}
