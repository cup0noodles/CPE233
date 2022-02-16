`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Matthew Wong
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


module ALU(
    input logic [31:0] A_IN,
    input logic [31:0] B_IN,
    input logic [3:0] ALU_FUN,
    output logic [31:0] RESULT
    );
    
    logic [31:0] SLT_inter;

    always_comb begin
        case (ALU_FUN)
            4'b0000: begin
            //ADD
            RESULT = A_IN + B_IN;
            end
            
            4'b1000: begin
            //SUB
                RESULT = A_IN - B_IN;
            end
            
            4'b0110: begin
            //OR
                RESULT = A_IN | B_IN;
            end
            
            4'b0111: begin
            //AND
                RESULT = A_IN & B_IN;
            end
            
            4'b0100: begin
            //XOR
                RESULT = A_IN ^ B_IN;
            end
            
            4'b0101: begin
            //SRL
                RESULT = A_IN >> B_IN[4:0]; 
            end
            
            4'b0001: begin
            //SLL
                RESULT = A_IN << B_IN[4:0];
            end
            
            4'b1101: begin
            //SRA
                RESULT = $signed(A_IN) >>> B_IN[4:0];
            end
            
            4'b0010: begin
            //SLT
                if ($signed(A_IN) < $signed(B_IN)) RESULT = 1'b1;
                else RESULT = 1'b0;
            end
            
            4'b0011: begin
            //SLTU
                if (A_IN < B_IN) RESULT = 1'b1;
                else RESULT = 1'b0;
            end
            
            4'b1001: begin
            //LUI-COPY
            RESULT = A_IN;
            end
            
            default RESULT = 32'h00000000;
            
         endcase
    end

endmodule
