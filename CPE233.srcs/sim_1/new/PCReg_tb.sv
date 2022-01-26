`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 01:26:42 PM
// Design Name: 
// Module Name: PCReg_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PCReg_tb();

    logic [31:0] pc_add, pc_in;
    logic pc_we, pc_rst, clk;
    
    PCReg UUT (.pc_din(pc_in), .pc_write(pc_we),
               .pc_rst(pc_rst), .pc_address(pc_add),
               .clk(clk));
    
    always begin
        #5 clk <= !clk; //10ns clk period 
    end
    
    initial begin
        clk = 1'b0;
        #2.5                    //delay by 3/4 period so changes occur just before rising edge
        pc_rst = 1'b1;          //Test pc_write=1, pc_rst=0 - reset reg
        pc_we = 1'b0;
        pc_in = 'h0000_0000;
        #10
        pc_rst = 1'b0;      
        #10
        pc_in = 'hFFFF_FFFF;   //Test pc_write=0, pc_rst=0 
        #10
        pc_we = 1'b1;           //Test pc_write=1, pc_rst=0
        #10
        pc_rst = 1'b1;          //Test pc_write=1, pc_rst=1
        pc_in = 'h1234_5678;
    end
endmodule
