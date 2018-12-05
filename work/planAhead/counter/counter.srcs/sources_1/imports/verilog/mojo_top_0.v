/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input cclk,
    output reg spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output reg [3:0] spi_channel,
    input avr_tx,
    output reg avr_rx,
    input avr_rx_busy,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip,
    input button,
    output reg greenled,
    output reg redled
  );
  
  
  
  reg rst;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  wire [1-1:0] M_edge_detector_out;
  reg [1-1:0] M_edge_detector_in;
  edge_detector_2 edge_detector (
    .clk(clk),
    .in(M_edge_detector_in),
    .out(M_edge_detector_out)
  );
  wire [7-1:0] M_seg_seg;
  wire [4-1:0] M_seg_sel;
  reg [16-1:0] M_seg_values;
  multi_seven_seg_3 seg (
    .clk(clk),
    .rst(rst),
    .values(M_seg_values),
    .seg(M_seg_seg),
    .sel(M_seg_sel)
  );
  wire [16-1:0] M_dec_ctr_digits;
  reg [1-1:0] M_dec_ctr_inc;
  reg [16-1:0] M_dec_ctr_digitsOverride;
  reg [1-1:0] M_dec_ctr_resetSignal;
  multi_dec_ctr_4 dec_ctr (
    .clk(clk),
    .rst(rst),
    .inc(M_dec_ctr_inc),
    .digitsOverride(M_dec_ctr_digitsOverride),
    .resetSignal(M_dec_ctr_resetSignal),
    .digits(M_dec_ctr_digits)
  );
  wire [1-1:0] M_ctr_value;
  counter_5 ctr (
    .clk(clk),
    .rst(rst),
    .value(M_ctr_value)
  );
  reg [1:0] M_seven_check_d, M_seven_check_q = 1'h0;
  reg M_activation_d, M_activation_q = 1'h0;
  reg M_button_pressed_d, M_button_pressed_q = 1'h0;
  reg M_button_activate_d, M_button_activate_q = 1'h0;
  reg M_button_state_d, M_button_state_q = 1'h0;
  reg M_lose_d, M_lose_q = 1'h0;
  reg M_resetSignal_d, M_resetSignal_q = 1'h0;
  reg M_doilose_d, M_doilose_q = 1'h0;
  reg M_redcount_d, M_redcount_q = 1'h0;
  reg M_greencount_d, M_greencount_q = 1'h0;
  
  always @* begin
    M_lose_d = M_lose_q;
    M_doilose_d = M_doilose_q;
    M_seven_check_d = M_seven_check_q;
    M_redcount_d = M_redcount_q;
    M_button_state_d = M_button_state_q;
    M_greencount_d = M_greencount_q;
    M_activation_d = M_activation_q;
    
    M_activation_d = M_edge_detector_out;
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    led = 8'h00;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    M_edge_detector_in = M_ctr_value;
    M_dec_ctr_inc = M_activation_q;
    M_seg_values = M_dec_ctr_digits;
    io_seg = ~M_seg_seg;
    io_sel = ~M_seg_sel;
    io_led = io_dip;
    M_dec_ctr_resetSignal = 1'h0;
    M_dec_ctr_digitsOverride[0+3-:4] = 1'h0;
    M_dec_ctr_digitsOverride[4+3-:4] = 1'h0;
    M_dec_ctr_digitsOverride[8+3-:4] = 1'h0;
    M_dec_ctr_digitsOverride[12+3-:4] = 1'h0;
    
    case (M_redcount_q)
      1'h1: begin
        redled = 1'h1;
      end
      default: begin
        redled = 1'h0;
      end
    endcase
    
    case (M_greencount_q)
      1'h1: begin
        greenled = 1'h1;
      end
      default: begin
        greenled = 1'h0;
      end
    endcase
    if (M_lose_q) begin
      M_dec_ctr_resetSignal = 1'h1;
      M_dec_ctr_digitsOverride[12+3-:4] = 1'h0;
      M_dec_ctr_digitsOverride[8+3-:4] = 1'h0;
      M_dec_ctr_digitsOverride[4+3-:4] = 1'h0;
      M_dec_ctr_digitsOverride[0+3-:4] = 1'h0;
    end
    M_lose_d = 1'h0;
    io_led[0+7-:8] = 8'h00;
    io_led[8+7-:8] = 8'h00;
    io_led[16+7-:8] = 8'h00;
    M_seven_check_d[0+0-:1] = M_dec_ctr_digits[0+3-:4] == 3'h7 || M_dec_ctr_digits[4+3-:4] == 3'h7 || M_dec_ctr_digits[8+3-:4] == 3'h7 || M_dec_ctr_digits[12+3-:4] == 3'h7;
    
    case (M_dec_ctr_digits[0+3-:4] + M_dec_ctr_digits[4+3-:4] * 4'ha + M_dec_ctr_digits[8+3-:4] * 7'h64 + M_dec_ctr_digits[12+3-:4] * 10'h3e8)
      1'h1: begin
        M_doilose_d = 1'h1;
      end
      2'h2: begin
        M_doilose_d = 1'h1;
      end
      2'h3: begin
        M_doilose_d = 1'h1;
      end
      3'h4: begin
        M_doilose_d = 1'h1;
      end
      3'h5: begin
        M_doilose_d = 1'h1;
      end
      4'h9: begin
        M_doilose_d = 1'h1;
      end
      4'ha: begin
        M_doilose_d = 1'h1;
      end
      4'hb: begin
        M_doilose_d = 1'h1;
      end
      4'hc: begin
        M_doilose_d = 1'h1;
      end
      5'h13: begin
        M_doilose_d = 1'h1;
      end
      5'h17: begin
        M_doilose_d = 1'h1;
      end
      5'h18: begin
        M_doilose_d = 1'h1;
      end
      5'h19: begin
        M_doilose_d = 1'h1;
      end
      5'h1e: begin
        M_doilose_d = 1'h1;
      end
      5'h1f: begin
        M_doilose_d = 1'h1;
      end
      6'h20: begin
        M_doilose_d = 1'h1;
      end
      6'h21: begin
        M_doilose_d = 1'h1;
      end
      6'h27: begin
        M_doilose_d = 1'h1;
      end
      6'h28: begin
        M_doilose_d = 1'h1;
      end
      6'h2c: begin
        M_doilose_d = 1'h1;
      end
      6'h2d: begin
        M_doilose_d = 1'h1;
      end
      6'h33: begin
        M_doilose_d = 1'h1;
      end
      6'h34: begin
        M_doilose_d = 1'h1;
      end
      6'h35: begin
        M_doilose_d = 1'h1;
      end
      6'h36: begin
        M_doilose_d = 1'h1;
      end
      6'h3b: begin
        M_doilose_d = 1'h1;
      end
      6'h3c: begin
        M_doilose_d = 1'h1;
      end
      6'h3d: begin
        M_doilose_d = 1'h1;
      end
      7'h41: begin
        M_doilose_d = 1'h1;
      end
      7'h51: begin
        M_doilose_d = 1'h1;
      end
      7'h52: begin
        M_doilose_d = 1'h1;
      end
      7'h59: begin
        M_doilose_d = 1'h1;
      end
      7'h5d: begin
        M_doilose_d = 1'h1;
      end
      7'h5e: begin
        M_doilose_d = 1'h1;
      end
      7'h5f: begin
        M_doilose_d = 1'h1;
      end
      default: begin
        M_doilose_d = 1'h0;
      end
    endcase
    
    case (M_dec_ctr_digits[0+3-:4] + M_dec_ctr_digits[4+3-:4] * 4'ha + M_dec_ctr_digits[8+3-:4] * 7'h64 + M_dec_ctr_digits[12+3-:4] * 10'h3e8)
      3'h7: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      4'he: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      5'h15: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      5'h1c: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      6'h23: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      6'h2a: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      6'h31: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      6'h38: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      6'h3f: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      7'h46: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      7'h4d: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      7'h54: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      7'h5b: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      7'h62: begin
        M_seven_check_d[1+0-:1] = 1'h1;
      end
      7'h64: begin
        M_greencount_d = 1'h1;
        M_dec_ctr_resetSignal = 1'h1;
        M_dec_ctr_digitsOverride[12+3-:4] = 1'h0;
        M_dec_ctr_digitsOverride[8+3-:4] = 1'h0;
        M_dec_ctr_digitsOverride[4+3-:4] = 1'h0;
        M_dec_ctr_digitsOverride[0+3-:4] = 1'h0;
      end
      default: begin
        M_seven_check_d[1+0-:1] = 1'h0;
      end
    endcase
    
    case (button)
      1'h0: begin
        M_button_state_d = 1'h1;
      end
      default: begin
        M_button_state_d = 1'h0;
      end
    endcase
    
    case (M_dec_ctr_digits[0+3-:4] + M_dec_ctr_digits[4+3-:4] * 4'ha + M_dec_ctr_digits[8+3-:4] * 7'h64 + M_dec_ctr_digits[12+3-:4] * 10'h3e8)
      2'h3: begin
        M_redcount_d = 1'h0;
        M_greencount_d = 1'h0;
      end
      3'h6: begin
        M_redcount_d = 1'h0;
      end
      4'h9: begin
        M_redcount_d = 1'h0;
      end
      4'hc: begin
        M_redcount_d = 1'h0;
      end
      4'hf: begin
        M_redcount_d = 1'h0;
      end
      5'h12: begin
        M_redcount_d = 1'h0;
      end
      5'h15: begin
        M_redcount_d = 1'h0;
      end
      5'h18: begin
        M_redcount_d = 1'h0;
      end
      5'h1b: begin
        M_redcount_d = 1'h0;
      end
      5'h1e: begin
        M_redcount_d = 1'h0;
      end
      6'h21: begin
        M_redcount_d = 1'h0;
      end
      6'h24: begin
        M_redcount_d = 1'h0;
      end
      6'h27: begin
        M_redcount_d = 1'h0;
      end
      6'h2a: begin
        M_redcount_d = 1'h0;
      end
      6'h2d: begin
        M_redcount_d = 1'h0;
      end
      6'h30: begin
        M_redcount_d = 1'h0;
      end
      6'h33: begin
        M_redcount_d = 1'h0;
      end
      6'h36: begin
        M_redcount_d = 1'h0;
      end
      6'h39: begin
        M_redcount_d = 1'h0;
      end
      6'h3c: begin
        M_redcount_d = 1'h0;
      end
      6'h3f: begin
        M_redcount_d = 1'h0;
      end
      7'h42: begin
        M_redcount_d = 1'h0;
      end
      7'h45: begin
        M_redcount_d = 1'h0;
      end
      7'h48: begin
        M_redcount_d = 1'h0;
      end
      7'h4b: begin
        M_redcount_d = 1'h0;
      end
      7'h4e: begin
        M_redcount_d = 1'h0;
      end
      7'h51: begin
        M_redcount_d = 1'h0;
      end
      7'h54: begin
        M_redcount_d = 1'h0;
      end
      7'h57: begin
        M_redcount_d = 1'h0;
      end
      7'h5a: begin
        M_redcount_d = 1'h0;
      end
      7'h5d: begin
        M_redcount_d = 1'h0;
      end
      7'h60: begin
        M_redcount_d = 1'h0;
      end
      7'h63: begin
        M_redcount_d = 1'h0;
      end
    endcase
    if ((M_button_state_q == 1'h0 && M_seven_check_q[0+0-:1] == 1'h1) || (M_button_state_q == 1'h0 && M_seven_check_q[1+0-:1] == 1'h1)) begin
      M_lose_d = 1'h1;
      M_redcount_d = 1'h1;
    end
    if (M_button_state_q == 1'h1 && M_doilose_q == 1'h1) begin
      M_lose_d = 1'h1;
      M_redcount_d = 1'h1;
    end
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_seven_check_q <= 1'h0;
      M_activation_q <= 1'h0;
      M_button_pressed_q <= 1'h0;
      M_button_activate_q <= 1'h0;
      M_button_state_q <= 1'h0;
      M_lose_q <= 1'h0;
      M_resetSignal_q <= 1'h0;
      M_doilose_q <= 1'h0;
      M_redcount_q <= 1'h0;
      M_greencount_q <= 1'h0;
    end else begin
      M_seven_check_q <= M_seven_check_d;
      M_activation_q <= M_activation_d;
      M_button_pressed_q <= M_button_pressed_d;
      M_button_activate_q <= M_button_activate_d;
      M_button_state_q <= M_button_state_d;
      M_lose_q <= M_lose_d;
      M_resetSignal_q <= M_resetSignal_d;
      M_doilose_q <= M_doilose_d;
      M_redcount_q <= M_redcount_d;
      M_greencount_q <= M_greencount_d;
    end
  end
  
endmodule
