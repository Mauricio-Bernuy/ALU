`timescale 1s/1ns
`include "ALU.v"

module ALU_tb;
    reg clk;
    reg reset;
    reg[31:0] A;
    reg[31:0] B;
    reg[3:0] Opin;

    wire[31:0] result;
    wire zero;
ALU dut(clk, reset, A, B, Opin, result, zero);

initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0, ALU_tb);
    clk = 0;
    forever #0.5 clk=~clk;
end
initial begin
    A = 32'b00000000000000000000000000011011;
    B = 32'b00000000000000000000000000101110;
end
initial begin
    Opin = 4'b0000; #2
    Opin = 4'b0101; #2
    Opin = 4'b0111; #2
    Opin = 4'b1010; #2
    #4
    $finish;
end

endmodule