`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 09:45:59 PM
// Design Name: 
// Module Name: PCTemp_tb
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


module PCTemp_tb();
    
    logic pc_we, pc_rst, clk;
    logic [31:0]pc_add, jalr, branch, jal, mtvec, mepc;
    logic [3:0] pc_source;
    
    PCTemp UUT(.pc_address(pc_add), .jalr(jalr),
               .branch(branch), .jal(jal), 
               .mtvec(mtvec), .mepc(mepc), 
               .pc_source(pc_source), .pc_rst(pc_rst), 
               .pc_write(pc_we), .clk(clk));
    
    always begin
        #5 clk <= !clk; //10ns clk period 
    end
    
    initial begin
        clk = 1'b0;
        pc_source   = 3'b000;
        jalr        = 'h10000001;
        branch      = 'h20000002;
        jal         = 'h30000003;
        mtvec       = 'h40000004;
        mepc        = 'h50000005;
        #2.5                    //delay by 3/4 period so changes occur just before rising edge
        pc_rst = 1'b1;          //Test pc_write=1, pc_rst=0 - reset reg
        pc_we = 1'b0;
        #10
        pc_rst = 1'b0;      
        #10
        pc_we = 1'b1;           //write enable delay test
        #10
        pc_rst = 1'b1;
        #10;
        pc_rst = 1'b0;          //Test Muxing
        #10 pc_source = 3'b001;
        #10 pc_source = 3'b010;
        #10 pc_source = 3'b011;
        #10 pc_source = 3'b100;
        #10 pc_source = 3'b101;
        #10 pc_source = 3'b110;
        #10 pc_source = 3'b111;
    end
endmodule
