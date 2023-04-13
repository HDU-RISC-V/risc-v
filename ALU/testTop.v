`timescale 1ns / 1ps

//.v"//////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:37:54 04/12/2023
// Design Name:   Top
// Module Name:   F:/ISE_DS_14.7/experiment/ALU/testTop.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testTop;

	// Inputs
	reg clk;
	reg clk_F;
	reg clk_A;
	reg clk_B;
	reg rst_n;
	reg [31:0] SW;

	// Outputs
	wire [3:0] F;
	wire [3:0] AN;
	wire [7:0] seg;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.clk_F(clk_F), 
		.clk_A(clk_A), 
		.clk_B(clk_B), 
		.rst_n(rst_n), 
		.SW(SW), 
		.F(F), 
		.AN(AN), 
		.seg(seg)
	);
	always begin #5 clk=~clk;end
	initial begin
		// Initialize Inputs
		clk = 0;
		clk_F = 0;
		clk_A = 0;
		clk_B = 0;
		rst_n = 0;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
          #100 rst_n = 0;
    #100 rst_n = 1;

// add overflow
    #100 SW = 32'hFFFFFFFF;
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'hFFFFFFFF;
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000000;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #500000000;
// add
    #100 rst_n = 0;
    #100 rst_n = 1;

    #100 SW = 32'h00000001;
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000001;
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000000;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #500000000;
// move left
    #100 SW = 32'h00000001;
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000002;
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000001;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #500000000;

// compare < with signal
    #100 SW = 32'hA0000001; // neg
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000001; // pos
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000002;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #500000000;

// compare < with signal
    #100 SW = 32'h00000002; // big
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000001; // small
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000002;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #500000000;


    

		// Add stimulus here

	end
      
endmodule

