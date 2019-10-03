`timescale 1ns / 1ps
`include "bad_ALU.v"
////////////////////////////////////////////////////////////////////////////////
// Tool versions:  
// Description: Simple testbench to test the ALU
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_test;

	// Inputs
   reg [31:0]	A;
   reg [31:0]	B;
   reg [3:0]	Opin;

   // Outputs
   wire [31:0]	result;
   wire			zero;

   // Test clock 
   reg			clk; // in this version we do not really need the clock

   // Expected outputs
   reg [31:0]	exp_result;
   wire			exp_zero;

   // Vector and Error counts
   reg [10:0]	vec_cnt, err_cnt;
   reg [99:0]	testvec[0:12];

   // TO DO:
   // Define an array called 'testvec' that is wide enough to hold the inputs:
   //   Opin, a, b 
  
	//
   // and the expected output
   //   exp_result
	//
   // for each testcase.
   // Note: we will not store 'exp_zero' in this array.

 

	bad_ALU dut(clk, A, B, Opin, result, zero);

   // The test clock generation
    always				// process always triggers
	begin
		clk=1; #50;		// clk is 1 for 50 ns 
		clk=0; #50;		// clk is 0 for 50 ns
	end					// generate a 100 ns clock


   // Initialization
   	initial
	begin 
	$dumpfile("ALU3.vcd");
    $dumpvars(0, ALU_test);
	$readmemh("testvectors_hex.txt", testvec, 0, 11);
		// TO DO:
		// Read the content of the file testvectors_hex.txt into the 
		// array testvec. The file contains values in hexadecimal format

	err_cnt=0; // number of errors
	vec_cnt=0; // number of vectors
   	end
	   
   // TO DO:
   // calculate the value of 'exp_zero' from the 'exp_result'
   // 
   assign exp_zero = (result==0) ? 1'b1 : 1'b0;
   
   // Tests
	always @ (posedge clk)		// trigger with the test clock
	begin
		// Wait 20 ns, so that we can safely apply the inputs
		#20; 
		
		// Assign the signals from the testvec array
		{Opin,A,B,exp_result}= testvec[vec_cnt]; 

		// Wait another 60ns after which we will be at 80ns
		#181; // tiempo minimo para que se sincronizen los valores.
	
		// Check if output is not what we expect to see
		if ((result !== exp_result) | (zero !== exp_zero))
		begin                                         
			// Display message
			$display("Error at %5d ns: Opin %b a=%h b=%h", $time, Opin,A,B);	// %h displays hex
			$display("       %h (%h expected)",result,exp_result);
			$display(" Zero: %b (%b expected)",zero,exp_zero);							// %b displays binary
			err_cnt = err_cnt + 1;																// increment error count
		end

		vec_cnt = vec_cnt + 1;																	// next vector
	
		// We use === so that we can also test for X
		if ((testvec[vec_cnt][99:96] === 4'bxxxx))
		begin
			// End of test, no more entries...
			$display ("%d tests completed with %d errors", vec_cnt, err_cnt);
			
			// Wait so that we can see the last result
			#20; 
			
			// Terminate simulation
			$finish;
		end
	end

   // TO DO:

   // Instantiate the Unit Under Test (UUT)
   
endmodule
