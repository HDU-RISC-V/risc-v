`include "D_register.v"
`include "ALU.v"
`include "LED.v"
`include "FR.v"

module Top(
	input clk_F,
	input clk_A,
	input clk_B,
	input rst_n,
	input [31:0] SW,
   output [3:0] F,
   output [3:0] AN,
   output [7:0] seg
);
	// D_register
	reg [31:0] A;
	reg [31:0] B;
	reg [31:0] Data;
    reg [3:0] Fs;
	
	// D_register
    D_register u_D_registerA (
        .clk(clk_A),
        .n_rst(n_rst),
        .in(SW[31:0]),
        .out(A)
    );

    D_register u_D_registerB (
        .clk(clk_B),
        .n_rst(n_rst),
        .in(SW[31:0]),
        .out(B)
    );
	
	// ALU
    ALU u_ALU (
        .rst_n(rst_n),
        .a(A),
        .b(B),
        .op(SW[3:0]),
        .out(Data),
		  .ZF(Fs[3]),
		  .CF(Fs[2]),
		  .OF(Fs[1]),
		  .SF(Fs[0])
    );

    // FR
    FR u_FR (
        .clk(clk_F),
        .rst_n(rst_n),
        .flag(Fs)
    );
    
    LED u_LED(
		  .clk(clk),
		  .Data(Data),
		  .AN(AN),
		  .seg(seg)
	 );
    
    always @(posedge clk_F or negedge rst_n) begin
        if (!rst_n) begin
            F <= 4'b0000;
        end else begin
            F <= Fs;
        end
    end
	 
endmodule