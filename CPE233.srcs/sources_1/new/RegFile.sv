`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Matthew Wong
// 
// Create Date: 01/20/2022 05:53:59 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile(RF_ADR1, RF_ADR2, RF_WA, RF_WD, RF_RS1, RF_RS2, RF_EN, clk);

    input logic [4:0] RF_ADR1, RF_ADR2, RF_WA;
    input logic [31:0] RF_WD;
    input logic RF_EN, clk;
    output logic [31:0] RF_RS1, RF_RS2;
    
    // Create register block, 32x32
    logic [31:0] register [31:0];
    
    //Initialize all addresses to be 0
    initial begin
        int i;
        for (i=0; i<32; i=i+1) begin
            register[i] = 0;
        end
    end
    
    always_comb begin
        // Read function
        if (RF_ADR1 != 0) begin
            // Normal Read Op
            RF_RS1 = register[RF_ADR1];
        end
        else begin
            // Read from x0
            RF_RS1 = 0;
        end
        if (RF_ADR2 != 0) begin
            RF_RS2 = register[RF_ADR2];
        end
        else begin
            RF_RS2 = 0;
        end
    end
    
    always_ff @(posedge clk) begin
        if (RF_EN == 1) begin
            register[RF_WA] <= RF_WD;
        end
    end

endmodule
