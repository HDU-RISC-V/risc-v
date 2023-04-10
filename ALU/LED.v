module LED(
    input clk,
	 input[31:0] Data,
    output[3:0] AN,
    output[7:0] seg 
);

    wire clk_500HZ;
    C250HZ user2(clk,clk_500HZ);
    show u4(clk_250HZ,Data,AN,seg);
	 
endmodule





module C250HZ( // 每个数码管选通时间为2ms,即转换信号为500HZ 
  input clk_old,
  output reg clk_new
);
  reg[15:0] counter;
  initial begin
    counter <= 16'd0;
	 clk_new<=1'b0;
  end

  always @(posedge clk_old) begin
      if (counter>=16'd25_000) begin
        clk_new <= ~clk_new;
        counter <= 16'b0;
      end
      else
        counter <= counter + 1'b1;
    end
endmodule





module show(
    	input clk,
    	input [31:0]Data,
    	output reg [3:0]AN,
    	output reg [7:0]seg
        );
    	
		reg [2:0]Bit_Sel;
		reg [3:0]data;
		initial begin 
		Bit_Sel <= 3'd0;
		data <= 4'd0;
		AN <= 4'b1111;
		end
		always@(posedge clk)
			begin
				Bit_Sel<=Bit_Sel+1'b1;
				
				case(Bit_Sel)
					2'b000:begin
							AN<=4'b1111;
							data<=Data[3:0];
							end
					2'b001:begin
							AN<=4'b1110;
							data<=Data[7:4];
							end
					2'b010:begin
							AN<=4'b1101;
							data<=Data[11:8];
							end
					2'b011:
							begin
							AN<=4'b1100;
							data<=Data[15:12];
							end
					2'b100:
							begin
							AN<=4'b1011;
							data<=Data[19:16];
							end
					2'b101:
							begin
							AN<=4'b1010;
							data<=Data[23:20];
							end
					2'b110:
							begin
							AN<=4'b1001;
							data<=Data[27:24];
							end
					2'b111:
							begin
							AN<=4'b1000;
							data<=Data[31:28];
							end
					//default:AN<=2'b1111;
				endcase
			end
		
		always@(*)
			begin
			case(data)
    			4'b0000: seg<=8'b00000011;//0
    			4'b0001: seg<=8'b10011111;//1
    			4'b0010: seg<=8'b00100101;//2
    			4'b0011: seg<=8'b00001101;//3
    			4'b0100: seg<=8'b10011001;//4
    			4'b0101: seg<=8'b01001001;//5
    			4'b0110: seg<=8'b01000001;//6
    			4'b0111: seg<=8'b00011111;//7
    			4'b1000: seg<=8'b00000001;//8
    			4'b1001: seg<=8'b00001001;//9
    			4'b1010: seg<=8'b00010001;//a
    			4'b1011: seg<=8'b11000001;//b
    			4'b1100: seg<=8'b01100011;//c
    			4'b1101: seg<=8'b10000101;//d
    			4'b1110: seg<=8'b01100001;//e
    			4'b1111: seg<=8'b01110001;//f
    		endcase
			end
endmodule