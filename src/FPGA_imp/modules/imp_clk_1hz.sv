module imp_clk_1hz (
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
    output wire [1:0] LED,
    input wire [15:0] SW,
    input wire BTNC
);


  logic reset_n;
  logic clk;
  assign reset_n = CPU_RESETN;
  assign clk = CLK100MHZ;


  // Seven segments Controller
  logic [6:0] Seg;
  logic [3:0] digits[0:7];
  logic [7:0] q1;
  logic result;

  counter_1hz  c1(
      .clk(clk),
      .rst_n(reset_n),
      .en(SW[0]),
      .q(q1)
      ,.clkOut(LED[0])
  );

    

  // assign digits[0] = 4'b1111;
//  assign digits[1] = 4'b1111;
  assign digits[2] = 4'b1111;
  assign digits[3] = 4'b1111;
  assign digits[4] = 4'b1111;
  assign digits[5] = 4'b1111;
  assign digits[6] = 4'b1111;
  assign digits[7] = 4'b1111;
assign LED[1] = SW[0];
  assign digits[0] = q1[3:0];
  assign digits[1] = q1[7:4];
//       assign digits[1] = SW[7:4];
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
