//~ `New testbench
`timescale  1ns / 1ps

module tb_CPUTop;

// CPUTop Parameters
parameter PERIOD  = 400;


// CPUTop Inputs
reg   rst_n                                = 0 ;
reg   clk                                  = 0 ;
reg   clk_LED                              = 0 ;
reg   [2:0]  SW                            = 0 ;

// CPUTop Outputs
wire  [3:0]  FR                            ;
wire  [3:0]  AN                            ;
wire  [7:0]  seg                           ;


// initial
// begin
//     forever #(PERIOD/2)  clk=~clk;
// end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

CPUTop  u_CPUTop (
    .rst_n                   ( rst_n          ),
    .clk                     ( clk            ),
    .clk_LED                 ( clk_LED        ),
    .SW                      ( SW       [2:0] ),

    .FR                      ( FR       [3:0] ),
    .AN                      ( AN       [3:0] ),
    .seg                     ( seg      [7:0] )
);

initial
begin
    $dumpfile("CPUTop.vcd");
    $dumpvars(0, CPUTop);
    integer i,j;
    for (i=0; i<1000; i=i+1) begin
        for (j=0; j<8; j=j+1) begin
            SW = j;
            #PERIOD/8;
        end
        #PERIOD/2;
        clk=~clk;
    end

    $finish;
end

endmodule
