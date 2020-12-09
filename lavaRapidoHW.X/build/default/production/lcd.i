# 1 "lcd.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "lcd.c" 2
# 1 "./pic18f4520.h" 1
# 2 "lcd.c" 2
# 1 "./lcd.h" 1
# 14 "./lcd.h"
void lcd_init(void);
void lcd_cmd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(const char* str);
# 3 "lcd.c" 2
# 1 "./delay.h" 1



void atraso_ms(unsigned long int t);
# 4 "lcd.c" 2

void lcd_wr(unsigned char val) {
    (*(volatile __near unsigned char*)0xF83) = val;
}

void lcd_cmd(unsigned char val) {
    (((*(volatile __near unsigned char*)0xF84)) |= (1<<1));
    lcd_wr(val);
    (((*(volatile __near unsigned char*)0xF84)) &= ~(1<<2));
    atraso_ms(3);
    (((*(volatile __near unsigned char*)0xF84)) &= ~(1<<1));
    atraso_ms(3);
    (((*(volatile __near unsigned char*)0xF84)) |= (1<<1));
}

void lcd_dat(unsigned char val) {
    (((*(volatile __near unsigned char*)0xF84)) |= (1<<1));
    lcd_wr(val);
    (((*(volatile __near unsigned char*)0xF84)) |= (1<<2));
    atraso_ms(3);
    (((*(volatile __near unsigned char*)0xF84)) &= ~(1<<1));
    atraso_ms(3);
    (((*(volatile __near unsigned char*)0xF84)) |= (1<<1));
}

void lcd_init(void) {
    (((*(volatile __near unsigned char*)0xF84)) &= ~(1<<1));
    (((*(volatile __near unsigned char*)0xF84)) &= ~(1<<2));
    atraso_ms(20);
    (((*(volatile __near unsigned char*)0xF84)) |= (1<<1));

    lcd_cmd(0x38);
    atraso_ms(5);
    lcd_cmd(0x38);
    atraso_ms(1);
    lcd_cmd(0x38);
    lcd_cmd(0x08);
    lcd_cmd(0x0F);
    lcd_cmd(0x01);
    lcd_cmd(0x38);
    lcd_cmd(0x80);
}

void lcd_str(const char* str) {
    unsigned char i = 0;

    while (str[i] != 0) {
        lcd_dat(str[i]);
        i++;
    }
}
