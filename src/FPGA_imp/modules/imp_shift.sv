// `include "FlipFlopLabs.srcs/sources_1/new/register_beh.sv"
// `include "FlipFlopLabs.srcs/sources_1/new/Register.sv"
// `include "seven_seg_controller.sv"
module imp_shift (
    input wire CLK100MHZ,  // using the same name as pin names
    input wire CPU_RESETN,
    output wire CA,
    CB,
    CC,
    CD,
    CE,
    CF,
    CG,
    DP,
    output wire [7:0] AN,
    input wire [15:0] SW,
    output wire [7:0] LED,
    input wire BTNC
);


  logic reset_n;
  logic clk;
  assign reset_n = CPU_RESETN;
  assign clk = CLK100MHZ;


  // Seven segments Controller
  wire [ 6:0] Seg;
  wire [ 3:0] digits [0:7];
  wire [7:0] q;
  shift_reg DUT (
      .clk(BTNC),
      .rst_n(reset_n),
      .Control_bit(SW[0]),
      .Serial_in(SW[1]),
      .q(q)
  );


  assign digits[0] = 4'b1111;
  assign digits[1] = 4'b1111;
  assign digits[2] = 4'b1111;
  assign digits[3] = 4'b1111;
  assign digits[4] = 4'b1111;
  assign digits[5] = 4'b1111;
  assign digits[6] = 4'b1111;
  assign digits[7] = 4'b1111;
    assign LED = q;
//   assign digits[0] = SW[3:0];
//   assign digits[1] = SW[7:4];
//   assign digits[2] = SW[11:8];
//   assign digits[3] = SW[15:12];
//   assign digits[4] = result[3:0];
//   assign digits[5] = result[7:4];
//   assign digits[6] = result[11:8];
//   assign digits[7] = result[15:12];


  sev_seg_controller ssc (
      .clk(clk),
      .resetn(reset_n),
      .digits(digits),
      .Seg(Seg),
      .AN(AN)
  );


  assign {CG, CF, CE, CD, CC, CB, CA} = Seg;
  assign DP = 1'b1;  // turn off the dot point on seven segs


endmodule
