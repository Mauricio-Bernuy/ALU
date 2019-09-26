/////////////////////////////////////////
// 7 Op ALU Simulation
/////////////////////////////////////////

module ALU (clk, reset, A, B, result);

// var declaration 

input clk;
input reset;

input[31:0] A;
input[31:0] B;

output[31:0] result;

reg[31:0] result;