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
 
always_comb begin

    I_TYPE = {{21{INSTRUCT[31]}}, {INSTRUCT[30:20]}};
    S_TYPE = {{21{INSTRUCT[31]}}, {INSTRUCT[30:25]}, {INSTRUCT[11:7]}};
    B_TYPE = {{20{INSTRUCT[31]}}, {INSTRUCT[7]}, 
              {INSTRUCT[30:25]}, {INSTRUCT[11:8]}, 
              {1'b0}};
    U_TYPE = {{20{INSTRUCT[31:12]}}, {12{1'b0}}};
    J_TYPE = {{12{INSTRUCT[31]}}, {INSTRUCT[19:12]},
             {{INSTRUCT[20]}}, INSTRUCT[30:21], 
             {1'b0}};

end
endmodule
