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
    
    initial begin
        //ADD
        ALU_FUN = 4'b0000;
        A = 'hA50F96C3;
        B = 'h5AF0693C;
        #10;
        A = 'h84105F21;
        B = 'h7B105FDE;
        #10;
        A = 'hFFFFFFFF;
        B = 'h00000001;
        #10;
        
        //Sub
        ALU_FUN = 4'b1000;
        A = 'h00000000;
        B = 'h00000001;
        #10;
        A = 'hAA806355;
        B = 'h550162AA;
        #10;
        A = 'h550162AA;
        B = 'hAA806355;
        #10;
        
        //AND
        ALU_FUN = 4'b0111;
        A = 'hA55A00FF;
        B = 'h5A5AFFFF;
        #10;
        A = 'hC3C3F966;
        B = 'hFF669F5A;
        #10;
        
        //OR
        ALU_FUN = 4'b0110;
        A = 'h9A9AC300;
        B = 'h65A3CC0F;
        #10;
        A = 'hC3C3F966;
        B = 'hFF669F5A;
        #10;
        
        //XOR
        ALU_FUN = 4'b0100;
        A = 'hAA5500FF;
        B = 'h5AA50FF0;
        #10;
        A = 'hA5A56C6C;
        B = 'hFF00C6FF;
        #10;
        
        //SRL
        ALU_FUN = 4'b0101;
        A = 'h805A6CF3;
        B = 'h00000010;
        #10;
        A = 'h705A6CF3;
        B = 'h00000005;
        #10;
        A = 'h805A6CF3;
        B = 'h00000000;
        #10;
        A = 'h805A6CF3;
        B = 'h00000100;
        #10;
        
        //SLL
        ALU_FUN = 4'b0001;
        A = 'h805A6CF3;
        B = 'h00000010;
        #10;
        A = 'h805A6CF3;
        B = 'h00000005;
        #10;
        A = 'h805A6CF3;
        B = 'h00000100;
        #10;
        
        //SRA
        ALU_FUN = 4'b1101;
        A = 'h805A6CF3;
        B = 'h00000010;
        #10;
        A = 'h705A6CF3;
        B = 'h00000005;
        #10;
        A = 'h805A6CF3;
        B = 'h00000000;
        #10;
        A = 'h805A6CF3;
        B = 'h00000100;
        #10;
        
        //SLT
        ALU_FUN = 4'b0010;
        A = 'h7FFFFFFF;
        B = 'h80000000;
        #10;
        A = 'h80000000;
        B = 'h00000001;
        #10;
        A = 'h00000000;
        B = 'h00000000;
        #10;
        A = 'h55555555;
        B = 'h55555555;
        #10;
        
        //SLTU
        ALU_FUN = 4'b0011;
        A = 'h7FFFFFFF;
        B = 'h80000000;
        #10;
        A = 'h80000000;
        B = 'h00000001;
        #10;
        A = 'h00000000;
        B = 'h00000000;
        #10;
        A = 'h55AA55AA;
        B = 'h55AA55AA;
        #10;
        
        //LUI_COPY
        ALU_FUN = 4'b1001;
        A = 'h01234567;
        B = 'h76543210;
        #10;
        A = 'hFEDCBA98;
        B = 'h89ABCDEF;
        #10;
    end

endmodule
