/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module boolean_14 (
    input [15:0] a,
    input [15:0] b,
    input [5:0] alufn,
    output reg [15:0] out,
    output reg [2:0] error
  );
  
  
  
  always @* begin
    out = 1'h0;
    error = 1'h0;
    
    case (alufn[0+3-:4])
      4'h8: begin
        out = a & b;
      end
      4'he: begin
        out = a | b;
      end
      4'h6: begin
        out = a ^ b;
      end
      4'ha: begin
        out = a;
      end
      default: begin
        error = 3'h4;
      end
    endcase
  end
endmodule