//#include "../defs.h"
#include "../defs_mpw-two-mfix.h"
#include "../print_io.h"

//#include "spi_io.h"



#define IO_8_MASK  0b100000000
#define IO_9_MASK  0b1000000000
#define IO_10_MASK 0b10000000000
#define IO_11_MASK 0b100000000000
#define IO_12_MASK 0b1000000000000
#define IO_13_MASK 0b10000000000000

 
//#define TEST_PIN_MASK 0b1000000000000000000000000000 //mask for timeout ext (known good pin)
#define TEST_PIN_MASK IO_13_MASK

#define IO_CONFIG_WORD 0b0010000000010



#define TEST_CYCLES 20
#define PIN_DELAY 10

// --------------------------------------------------------
// Firmware routines
// --------------------------------------------------------

void set_gpio(int pin)
{
    (volatile uint32_t) ((reg_mprj_datal) |= pin);
}

void clear_gpio(int pin)
{
    (volatile uint32_t) ((reg_mprj_datal) &= ~(pin));
}

void main()
{
    int i, j, k, config_val, index2, pin_valid, valid_combinations, bit_slip, lower_word;

    i = 1;
    for (j = 0; j < 1000; j++);




    //reg_mprj_io_37 = GPIO_MODE_MGMT_STD_INPUT_NOPULL; //for debug
    //reg_mprj_io_37 = 0b0010000000010; //test with 000 analog mode
    //reg_mprj_io_37 = 0b0110000000010;

    //reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_36 = GPIO_MODE_MGMT_STD_INPUT_NOPULL; //test driving pin
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_ANALOG; //bias pins
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_ANALOG;

    //analog signals
    reg_mprj_io_31 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_30 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_29 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_28 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_27 = GPIO_MODE_MGMT_STD_INPUT_NOPULL; 
    reg_mprj_io_26 = GPIO_MODE_MGMT_STD_INPUT_NOPULL; 
    reg_mprj_io_25 = GPIO_MODE_MGMT_STD_INPUT_NOPULL; 


    //my previous calculated good values
    //8 fully tested
    //9 fully tested
    //0000000000001,1111010111110 works for pin 10
    /*
    reg_mprj_io_13 = 0;
    reg_mprj_io_12 = IO_CONFIG_WORD;
    reg_mprj_io_11 = (IO_CONFIG_WORD<<1) | (IO_CONFIG_WORD>>11);
    reg_mprj_io_10 = (IO_CONFIG_WORD<<2) | (IO_CONFIG_WORD>>10);
    reg_mprj_io_9 = (IO_CONFIG_WORD<<3) | (IO_CONFIG_WORD>>9);
    reg_mprj_io_8 = (IO_CONFIG_WORD<<4) | (IO_CONFIG_WORD>>8);
    reg_mprj_io_7 = (IO_CONFIG_WORD<<5) | 0b000000;
    //reg_mprj_io_6 = 0b0001011100000;
    reg_mprj_io_5 = 0x0;
    reg_mprj_io_6 = 0x7ff; //to enable serial
    */
    reg_mprj_io_13 = 0;
    reg_mprj_io_12 = 0b0010000000010;
    reg_mprj_io_11 = 0b0100000000100;
    reg_mprj_io_10 = 0b1000000001001;
    reg_mprj_io_9  = 0b0000000010010;
    reg_mprj_io_8  = 0b0000000100100;
    reg_mprj_io_7  = 0b0000001000000;
    reg_mprj_io_5 = 0x0;
    //reg_mprj_io_6 = 0x7ff; //to enable serial
    reg_mprj_io_6 = 0x00;
    

    reg_mprj_datal = 0;

    reg_uart_clkdiv = 1042;
    reg_uart_enable = 1;

    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    // Enable GPIO (all output, ena = 0)
    reg_gpio_ena = 0x0;
    reg_gpio_pu = 0x0;
    reg_gpio_pd = 0x0;
    reg_gpio_data = 0x1;



    while(1){
        /*
        reg_gpio_data = 0x0;
        
        for (j = 0; j < 3000; j++);

        reg_gpio_data = 0x1;
        
        for (j = 0; j < 3000; j++);
        */

    }
}