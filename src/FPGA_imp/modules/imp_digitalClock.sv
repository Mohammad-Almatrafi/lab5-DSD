
module imp_digitalClock (
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
    output wire [2:0] LED,
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

  logic [6:0] hsec;
  logic [5:0] sec;
  logic [5:0] min;
  logic minClk,secClk,hsecClk;

  digitalClock implementation (
      .clk(clk),
      .rst_n(reset_n),
      .en(SW[0]),
      .hsec(hsec),
      .sec(sec),
      .min(min),
      .hsecClk(hsecClk),
      .secClk(secClk),
      .minClk(minClk)
  );

  assign LED[0] = hsecClk;
  assign LED[1] = secClk;
  assign LED[2] = minClk;

  // assign digits[0] = 4'b1111;
  //  assign digits[1] = 4'b1111;
  //   assign digits[2] = 4'b1111;
  //   assign digits[3] = 4'b1111;
  //   assign digits[4] = 4'b1111;
  //   assign digits[5] = 4'b1111;
  //   assign digits[6] = 4'b1111;
  //   assign digits[7] = 4'b1111;

  assign digits[0] = hsec[3:0];
  assign digits[1] = {1'b0, hsec[6:4]};
  assign digits[2] = sec[3:0];
  assign digits[3] = {2'b00, sec[5:4]};
  assign digits[4] = min[3:0];
  assign digits[5] = {2'b00, min[5:4]};


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
