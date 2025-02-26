`timescale 1ns/1ns

module op1(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R=A+B;
endmodule

module op2(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R=A&B;
endmodule

module op3(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R=A|2;
endmodule

module op4(input [15:0]A, input [15:0]B, output reg [31:0]R);
  assign R=A*B;
endmodule

module op5(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R=A-B;
endmodule

module op6(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R=A<B?1:0;
endmodule

module ALU_BLOQUEO(input [31:0]X, input [31:0]Y, input [2:0]s, input clk, output reg [31:0]r, output reg Zflag);
  wire [31:0]w[5:0];
  op1 ope1(.A(X), .B(Y), .R(w[0]));
  op2 ope2(.A(X), .B(Y), .R(w[1]));
  op3 ope3(.A(X), .R(w[2]));
  op4 ope4(.A(X[15:0]), .B(Y[15:0]), .R(w[3]));
  op5 ope5(.A(X), .B(Y), .R(w[4]));
  op6 ope6(.A(X), .B(Y), .R(w[5]));
  always @(posedge clk) begin
    case (s)
	  3'd0: begin
	    r = w[0];
	  end 
	  3'd1: begin
	    r = w[1];
	  end 
	  3'd2: begin
	    r = w[2];
	  end 
	  3'd3: begin
	    r = w[3];
	  end 
	  3'd4: begin
	    r = w[4];
	  end 
	  3'd5: begin
	    r = w[5];
	  end  
	endcase
	if(r==0) Zflag=1;
	else Zflag=0;
  end
endmodule

module ALU_SIN_BLOQUEO(input [31:0]X, input [31:0]Y, input [2:0]s, input clk, output reg [31:0]r, output reg Zflag);
  wire [31:0]w[5:0];
  op1 ope1(.A(X), .B(Y), .R(w[0]));
  op2 ope2(.A(X), .B(Y), .R(w[1]));
  op3 ope3(.A(X), .R(w[2]));
  op4 ope4(.A(X[15:0]), .B(Y[15:0]), .R(w[3]));
  op5 ope5(.A(X), .B(Y), .R(w[4]));
  op6 ope6(.A(X), .B(Y), .R(w[5]));
  always @(posedge clk) begin
    case (s)
	  3'd0: begin
	    r <= w[0];
	  end 
	  3'd1: begin
	    r <= w[1];
	  end 
	  3'd2: begin
	    r <= w[2];
	  end 
	  3'd3: begin
	    r <= w[3];
	  end 
	  3'd4: begin
	    r <= w[4];
	  end 
	  3'd5: begin
	    r <= w[5];
	  end  
	endcase
	if(r==0) Zflag=1;
	else Zflag=0;
  end
endmodule

module ALU_TB();
  reg  [31:0]X_TB, Y_TB;
  reg  [2:0] s_TB;
  wire [31:0]r_TB_B, r_TB_SB;
  reg  clk_TB;  
  wire Z_TB;  
  ALU_BLOQUEO alu1(.X(X_TB), .Y(Y_TB), .s(s_TB), .clk(clk_TB), .r(r_TB_B), .Zflag(Z_TB));
  ALU_SIN_BLOQUEO alu2(.X(X_TB), .Y(Y_TB), .s(s_TB), .clk(clk_TB), .r(r_TB_SB), .Zflag(Z_TB));
  
  integer i;
  initial begin
    for(i=0;i<6;i=i+1) begin
	  clk_TB = 0;
	  s_TB = i;
	  X_TB = 32'd5;
	  Y_TB = 32'd3;
	  #100
	  clk_TB = ~clk_TB;
	  #100
	  clk_TB = ~clk_TB;
	  X_TB = 32'd3;
	  Y_TB = 32'd5;
	  #100
	  clk_TB = ~clk_TB;
	  #100
	  clk_TB = ~clk_TB;	 
	  X_TB = 32'd5;
	  Y_TB = 32'd3;
	  #100
	  clk_TB = ~clk_TB;
	  #100
	  X_TB = 32'd5;
	  Y_TB = 32'd3;
	  
	end
  end
endmodule




