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


module ALU(A,B, ALUControl, Result, Z, N ,V ,C);
//declaring inputs and outputs
input[31:0] A,B;
output[31:0] Result;
input [2:0] ALUControl;
output Z,N,V,C;

//declaring interim wires
wire [31:0] A_and_B;
wire [31:0] A_or_B;
wire [31:0] not_B;
wire [31:0] ALU_mux;
wire [31:0] sum;
wire [31:0] Result_mux;
wire cout;
wire [31:0] slt;
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
assign {cout,sum} = A + ALU_mux + ALUControl[0]; // concatenated the cout & sum

//ZERO EXTENSION
assign slt = {31'b0000000000000000000000000000000,sum[31]};

//4 by 1 MUX
assign Result_mux = (ALUControl[2:0] == 3'b000) ? sum :
                    (ALUControl[2:0] == 3'b001) ? sum :
                    (ALUControl[2:0] == 3'b010) ? A_and_B :
                    (ALUControl[2:0] == 3'b011) ? A_or_B :
                    (ALUControl[2:0] == 3'b101) ? slt : 32'h00000000; //else statement
                   
assign Result = Result_mux;

// flags assignment
assign Z = &(~Result);//ZERO FLAG
assign N = Result[31];// NEGATIVE FLAG
assign C = cout & (~ALUControl[1]); // CARRY FLAG
assign V = (~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALUControl[31])); //OVERFLOW FLAG
endmodule
