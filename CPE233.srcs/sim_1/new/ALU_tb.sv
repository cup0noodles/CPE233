`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2022 01:48:34 PM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb();

logic [31:0] A, B, RESULT;
logic [3:0] ALU_FUN;

ALU UUT(.A_IN(A), .B_IN(B), .ALU_FUN(ALU_FUN), .RESULT(RESULT));




endmodule
