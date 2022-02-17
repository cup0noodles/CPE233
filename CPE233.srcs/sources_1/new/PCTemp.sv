`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 01:16:32 PM
// Design Name: 
// Module Name: PCTemp
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


module PCTemp(pc_address, jalr,
              branch, jal, 
              mtvec, mepc, 
              pc_source, pc_rst, 
              pc_write, clk, pc4);
    /* All necessary wires for both modules.
    PC_DIN is replaced with PC_DIN_BUS to denote the interconnection */
    output logic [31:0] pc_address, pc4;
    input logic [31:0] jalr, branch, jal, mtvec, mepc;
    input logic [2:0] pc_source;
    input logic clk, pc_rst, pc_write;
    logic [31:0] pc_din_bus;
    
    always_comb begin
        pc4 = pc_address + 'h4; 
    end
    
    //Submodules are simply called with appropriate signals
    PCMux PCMux0(.pc4(pc4), .jalr(jalr), 
          .branch(branch), .jal(jal),
          .mtvec(mtvec), .mepc(mepc),
          .pc_din(pc_din_bus), .pc_source(pc_source));
     
    PCReg PCReg0(.pc_din(pc_din_bus), .pc_address(pc_address),
          .pc_rst(pc_rst), .pc_write(pc_write),
          .clk(clk));
endmodule
