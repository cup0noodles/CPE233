`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2022 11:13:15 AM
// Design Name: 
// Module Name: CuDcdr_tb
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


module CuDcdr_tb();
    
    //Inputs
    logic [6:0] opcode;
    logic [2:0]funct3;
    logic funct30, int_taken, br_eq, br_ltu, br_lt;
    // Outputs
    logic [3:0] alu_fun;
    logic [2:0] pcSource;
    logic [1:0] alu_srcB, rf_wr_sel;
    logic alu_srcA;
    
    CuDcdr UUT(.opcode(opcode), .funct3(funct3), .funct30(funct30), 
               .int_taken(int_taken), .br_eq(br_eq), .br_ltu(br_ltu),
               .br_lt(br_lt), .alu_fun(alu_fun), .alu_srcA(alu_srcA),
               .alu_srcB(alu_srcB), .pcSource(pcSource), .rf_wr_sel(rf_wr_sel));
    
    
    initial begin
        
    end
endmodule
