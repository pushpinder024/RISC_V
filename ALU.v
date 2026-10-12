`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2026 07:31:51 PM
// Design Name: 
// Module Name: ALU
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


module ALU(A,B, ALUControl, Result);
//declaring inputs and outputs
input[31:0] A,B;
output[31:0] Result;
input [2:0] ALUControl;

//declaring interim wires
wire [31:0] A_and_B;
wire [31:0] A_or_B;
wire [31:0] not_B;
wire [31:0] ALU_mux;
wire [31:0] sum;
wire [31:0] Result_mux;

//Logic Design

//AND OPERATION
assign A_and_B = A & B;

//OR OPERATION
assign A_or_B = A | B;

//NOT OPERATION ON B
assign not_B = ~B; 

//Ternary Operator
assign ALU_mux = (ALUControl[0] == 1'b0) ? B : not_B;

//Addition/ Subtraction 2's compliment Operation
assign sum = A + ALU_mux + ALUControl[0];

//4 by 1 MUX
assign Result_mux = (ALUControl[1:0] == 2'b00) ? sum :
                    (ALUControl[1:0] == 2'b01) ? sum :
                    (ALUControl[1:0] == 'b10) ? A_and_B : A_or_B
                   ;
                   
assign Result = Result_mux;
endmodule
