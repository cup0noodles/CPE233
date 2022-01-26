`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2022 10:08:28 AM
// Design Name: 
// Module Name: RegFile_tb
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


module RegFile_tb();

    logic [4:0] ADR1, ADR2, WADR;
    logic [31:0] WD, RD1, RD2;
    logic WR_EN, clk;
    logic [5:0] i;
    
    RegFile UUT(.RF_ADR1(ADR1), .RF_ADR2(ADR2),
                .RF_WA(WADR), .RF_WD(WD),
                .RF_RS1(RD1), .RF_RS2(RD2),
                .RF_EN(WR_EN), .clk(clk));
    
    always begin
        #5 clk <= !clk;
    end
    
    initial begin
        // Initialize inputs to 0
        ADR1 = 0;
        ADR2 = 0;
        WADR = 0;
        WR_EN = 0;
        clk = 0;
        #2.5;
        
        //Test Write Enable
        ADR1 = 5'b00001; //Observe x1
        WADR = 5'b00001;
        WD = 'h00FF00FF; //Data on bus, RD_EN = 0
        #10;
        WR_EN = 1; // Data should show up in RF_RS1
        #10;
        WR_EN = 0;
        #10
        
        //Test x0
        ADR1 = 5'b00000; //Observe x0
        WADR = 5'b00000;
        WD = 'h00FF00FF; //Data on bus, RD_EN = 0
        WR_EN = 1; // Data should show up in RS_RD1, should be 0
        #10;
        WR_EN = 0;
        #10;
        
        //Test read from same register
        //Assign Value
        WR_EN = 1;
        WADR = 5'b10000;
        WD = 'hC9E23309;
        
        ADR1 = 5'b10000;
        ADR2 = 5'b10000;
        #10;
        
        // Test writing to open register
        WD = 'h2345ABCD;
        #10;
    
    end

endmodule
