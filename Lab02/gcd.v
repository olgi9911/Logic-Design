//`timescale 1ns / 1ps
module GCD (
  input wire CLK,
  input wire RST_N,
  input wire [7:0] A,
  input wire [7:0] B,
  input wire START,
  output reg [7:0] Y,
  output reg DONE,
  output reg ERROR
);

wire found;
reg [7:0] reg_a, reg_b, next_a, next_b, Y_next;
reg [7:0] big_one;
reg error_next;
reg [1:0] state, state_next;

parameter [1:0] IDLE = 2'b00;
parameter [1:0] CALC = 2'b01;
parameter [1:0] FINISH = 2'b10;
/// Implementation below ///
/// update ERROR ///
always@(posedge CLK) begin
  if (RST_N == 1'b0)  ERROR <= 0;
  else  ERROR <= error_next;
end

/// reset actions ///
always@(posedge CLK) begin
  if (RST_N == 1'b0) begin
    state <= IDLE;
    Y <= 1'b0;
  end
  else
    state <= state_next;
end

/// wire found -> use assign ///
assign found = (next_a == 0 || next_b == 0) ? 1 : 0;

/// FSM ///
always@* begin
  case(state)
    IDLE: begin
      DONE = 0;
      ERROR = 0;
      if (START) begin
        state_next = CALC;
        error_next = (A == 0 || B == 0);
        reg_a = A;
        reg_b = B;
      end
      else begin
        state_next = IDLE;
        error_next = 0;
      end
    end
    CALC: begin
      /// big_one initialization ///
      if (big_one)  big_one = big_one;
      else  big_one = 0;
      ///
      if (!found && !ERROR) begin
        state_next = CALC;
        error_next = ERROR;
      end
      else begin
        state_next = FINISH;
        error_next = ERROR;
      end
    end
    FINISH: begin
      state_next = IDLE;
      error_next = 0;
      DONE = 1;
    end
    default:
      state_next = state_next;
  endcase
end

/// update reg_a, reg_b ///
always@(posedge CLK) begin
  if (state == CALC) begin
    reg_a <= next_a;
    reg_b <= next_b;
  end
end

/// perform SUB ///
always@* begin
  if (state == CALC) begin 
    if (reg_a > reg_b) begin
      next_a = reg_a - reg_b;
      next_b = reg_b;
    end
    else begin
      next_b = reg_b - reg_a;
      next_a = reg_a;
    end
  end  
end

/// chosing big_one ///
always@* begin
  if(state == CALC) begin
    if (next_a == 8'd0) begin
      big_one = next_b;
    end
    else if (next_b == 8'd0) begin
      big_one = next_a;
    end
    else begin
      big_one = big_one;
    end
  end
  else begin
    big_one = big_one;
  end
end

/// update Y_next ///
always@* begin
  if(state == CALC) begin
    Y_next = big_one;
  end
  else if (state == FINISH) begin
    Y_next = Y;
  end
  else begin
    Y_next = Y_next;
  end
end

/// update Y ///
always@(posedge CLK) begin
  if (RST_N == 1'b0) begin
    Y_next <= 8'b0;
    Y <= Y_next;
  end
  else
    Y <= Y_next;
end
///
endmodule