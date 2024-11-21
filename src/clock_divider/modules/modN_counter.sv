module modN_counter #(
    parameter n = 100
) (
    clk,
    rst_n,
    en,
    q
);

  localparam N = n;
  localparam width = $clog2(N);
  input clk, rst_n, en;

  output logic [width-1:0] q;

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) q <= 0;
    else begin
      if (q == N) q <= 0;
      else if (en) q <= q + 1;
    end
  end
endmodule
