`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 01:45:17 PM
// Design Name: 
// Module Name: CSR
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


module CSR(reset, int_taken, ADDR, WR_EN, CSR_MIE, CSR_MEPC, CSR_MTVEC, RD, PC, WD, clk);
    input logic reset, int_taken, WR_EN, clk; //csr_WE
    input logic [11:0] ADDR; //IR[31:20]
    input logic [31:0] PC, WD; //RS1
    output logic CSR_MIE;
    output logic [31:0] CSR_MEPC, CSR_MTVEC, RD; //to PCMux, RegMux
    
    //Temp wire to GND
    always_ff @(posedge clk) begin
        CSR_MIE <= 1'b0;
        CSR_MEPC <= 32'h0000_0000;
        CSR_MTVEC <= 32'h0000_0000;
        RD <= 32'h0000_0000;
    end
endmodule
