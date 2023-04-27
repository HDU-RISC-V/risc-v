module LED(
    input clk,               // 输入时钟信号
    input [31:0] Data,       // 32位输入数据
    output [3:0] AN,         // 数码管选通信号输出
    output [7:0] seg         // 数码管段选信号输出
);

    wire clk_500HZ;          // 定义一个500Hz的时钟信号
    C500HZ user2(clk, clk_500HZ); // 时钟分频模块，用于生成500Hz的时钟信号
    show u4(clk_500HZ, Data, AN, seg); // 数码管显示模块

endmodule

// 时钟分频模块，用于生成每个数码管选通时间为2ms，即转换信号为500Hz的时钟信号
module C500HZ(
  input clk_old,            // 输入原始时钟信号
  output reg clk_new        // 输出分频后的时钟信号
);
  reg [15:0] counter;       // 定义一个16位计数器
  initial begin
    counter <= 16'd0;
    clk_new <= 1'b0;
  end

  always @(posedge clk_old) begin
      if (counter >= 16'd25_000) begin
        clk_new <= ~clk_new;
        counter <= 16'b0;
      end
      else
        counter <= counter + 1'b1;
    end
endmodule

// 数码管显示模块
module show(
    input clk,               // 输入时钟信号，这里为500Hz
    input [31:0] Data,       // 32位输入数据
    output reg [3:0] AN,     // 数码管选通信号输出
    output reg [7:0] seg     // 数码管段选信号输出
);

    reg [2:0] Bit_Sel;       // 3位位选计数器
    reg [3:0] data;          // 当前显示的4位数码管数据
    initial begin 
        Bit_Sel <= 3'd0;
        data <= 4'd0;
        AN <= 4'b1111;
    end
	
    always @(posedge clk) begin
        Bit_Sel <= Bit_Sel + 1'b1;

        // 根据位选计数器的值选择数码管显示的数据
        case (Bit_Sel)
            3'b000: begin
                AN <= 4'b1111;
                data <= Data[3:0];
            end
            3'b001: begin
                AN <= 4'b1110;
                data <= Data[7:4];
            end
            3'b010: begin
                AN <= 4'b1101;
                data <= Data[11:8];
            end
            3'b011: begin
                AN <= 4'b1100;
                data <= Data[15:12];
            end
            3'b100: begin
                AN <= 4'b1011;
                data <= Data[19:16];
            end
            3'b101: begin
                AN <= 4'b1010;
                data <= Data[23:20];
			end
			3'b110: begin
				AN <= 4'b1001;
				data <= Data[27:24];
			end
			3'b111: begin
				AN <= 4'b1000;
				data <= Data[31:28];
			end
		//default:AN<=2'b1111;
		endcase
	end

	always@(*) begin
		// 根据当前显示的数据，输出对应的数码管段选信号
		case (data)
			4'b0000: seg <= 8'b00000011; // 0
			4'b0001: seg <= 8'b10011111; // 1
			4'b0010: seg <= 8'b00100101; // 2
			4'b0011: seg <= 8'b00001101; // 3
			4'b0100: seg <= 8'b10011001; // 4
			4'b0101: seg <= 8'b01001001; // 5
			4'b0110: seg <= 8'b01000001; // 6
			4'b0111: seg <= 8'b00011111; // 7
			4'b1000: seg <= 8'b00000001; // 8
			4'b1001: seg <= 8'b00001001; // 9
			4'b1010: seg <= 8'b00010001; // A
			4'b1011: seg <= 8'b11000001; // B
			4'b1100: seg <= 8'b01100011; // C
			4'b1101: seg <= 8'b10000101; // D
			4'b1110: seg <= 8'b01100001; // E
			4'b1111: seg <= 8'b01110001; // F
		endcase
	end

endmodule