// `include "modN_counter.sv"
module modN_clk #(
    parameter n = 100
) (
    input clk,
    input en,
    input rst_n,
    output logic clk_out
);
  localparam N = n;
  localparam width = $clog2(N);
  logic [width-1:0] count;
  modN_counter #(
      .n(N)
  ) q (
      .clk(clk),
      .rst_n(rst_n),
      .en(en),
      .q(count)
  );

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      clk_out <= 1'b0;
    end else begin
      if (count == 0) begin
        clk_out = ~clk_out;
      end
    end

  end


endmodule
