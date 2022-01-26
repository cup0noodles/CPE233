`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 01:24:12 PM
// Design Name: 
// Module Name: PCMux_tb
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


module PCMux_tb();

    logic [31:0] pc_address, jalr, branch, jal, mtvec, mepc, pc_din;
    logic [3:0] pc_source;

    PCMux UUT (.pc_address(pc_address), .jalr(jalr),
               .branch(branch), .jal(jal),
               .mtvec(mtvec), .mepc(mepc),
               .pc_din(pc_din), .pc_source(pc_source));
               
    initial begin
        //Set test values for all mux sources
        pc_address  = 'h00000000;
        jalr        = 'h10000001;
        branch      = 'h20000002;
        jal         = 'h30000003;
        mtvec       = 'h40000004;
        mepc        = 'h50000005;
        
        //Increment through all pc_source values
        pc_source   = 3'b000;
        #10 pc_source = 3'b001;
        #10 pc_source = 3'b010;
        #10 pc_source = 3'b011;
        #10 pc_source = 3'b100;
        #10 pc_source = 3'b101;
        #10 pc_source = 3'b110;
        #10 pc_source = 3'b111;
    end
endmodule
