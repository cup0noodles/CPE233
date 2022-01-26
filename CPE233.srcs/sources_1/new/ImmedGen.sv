`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Matthew Wong
// 
// Create Date: 01/25/2022 01:46:19 PM
// Design Name: 
// Module Name: ImmedGen
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


module ImmedGen(
    input logic [31:0] INSTRUCT,
    output logic [31:0] U_TYPE,
    output logic [31:0] I_TYPE,
    output logic [31:0] S_TYPE,
    output logic [31:0] J_TYPE,
    output logic [31:0] B_TYPE
    );
    
    logic [6:0] opcode;
    
    always_comb begin
        opcode = INSTRUCT[6:0]; //Load opcode type from ins
        case (opcode)
            7'b0010011: begin
            //I_TYPE
                I_TYPE = {{21{INSTRUCT[31]}}, {INSTRUCT[30:20]}};
            end
            
            7'b0100011: begin
            //S_TYPE
                S_TYPE = {{21{INSTRUCT[31]}}, {INSTRUCT[30:25]}, {INSTRUCT[11:7]}};
            end
            
            7'b1100011: begin
            //B_TYPE
                B_TYPE = {{20{INSTRUCT[31]}}, {INSTRUCT[7]}, 
                          {INSTRUCT[30:25]}, {INSTRUCT[11:8]}, 
                          1'b0};
            end
            
            7'b0110111: begin
            //U_TYPE
                U_TYPE = {{20{INSTRUCT[31:12]}}, {12{1'b0}}};
            end
            
            7'b1101111: begin
            //J_TYPE
                J_TYPE = {{12{INSTRUCT[31]}}, {INSTRUCT[19:12]},
                          {2{INSTRUCT[20]}}, INSTRUCT[30:21], 
                          1'b0};
            end
            
            default: begin
            //Error Condition
                U_TYPE = 0;
                I_TYPE = 0;
                J_TYPE = 0;
                S_TYPE = 0;
                B_TYPE = 0;
            end
        endcase
    end
    
endmodule
