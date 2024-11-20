module digitalClock (
    input clk,
    input rst_n,
    input en,
    output [6:0] hsec,
    output [5:0] sec,
    output [5:0] min,
    output hsecClk,
    output secClk,
    output minClk
);

logic clk1,clk2;
  counter_nhz #(
      .divider(500_000),
      .count  (60)
  ) hsec_counter (
      .clk(clk),
      .rst_n(rst_n),
      .en(en),
      .q(hsec),
      .clkOut(clk1)
  );
  counter_nhz #(
      .divider(50),
      .count  (60)
  ) sec_counter (
      .clk(hsecClk),
      .rst_n(rst_n),
      .en(en),
      .q(sec),
      .clkOut(clk2)
  );
  counter_nhz #(
      .divider(30),
      .count  (60)
  ) min_counter (
      .clk(secClk),
      .rst_n(rst_n),
      .en(en),
      .q(min),
      .clkOut(minClk)
  );

assign hsecClk = clk1;
assign secClk = clk2;


endmodule
