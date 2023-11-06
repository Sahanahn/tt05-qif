`default_nettype none

module tt_um_QIFNeuron (
  input wire clk,          // Clock input
  input wire rst,          // Reset input
  input wire [7:0] B,      // Input B (8-bit, signed)
  output reg [7:0] V,     // Output voltage V (8-bit, signed)
  output reg spike_out    // Spike output
);
  inout wire ena;
  reg [7:0] Z1, Z2;        // Delay flip-flops
  wire [7:0] V_reset = -8'sd20; // Set Vreset to -20
  wire [7:0] Vpeak = 8'd50;  // Vpeak value (Set to 50)
  wire [7:0] A = 8'd32;      // Gain A (Set to 0.25)
 reg spike_out_reg;        // Spike output register

  // V computation
  reg [7:0] V_reg; // Intermediate register for V
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      V_reg <= V_reset;
    end else if (V_reg >= Vpeak) begin
      V_reg <= V_reset;
      spike_out_reg <= 1'b1;  // Set spike_out_reg to 1 when V >= Vpeak
      Z1 <= 8'b0;
      Z2 <= 8'b0;
    end else begin
      V_reg <= V_reg + B / 4 + (V_reg * V_reg / 16);  // Include the square term here
      spike_out_reg <= 1'b0;  // Set spike_out_reg to 0 when V < Vpeak
    end
  end

  // Z flip-flops
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      Z1 <= 8'b0;
      Z2 <= B;
    end else begin
      Z1 <= B + Z2;
      Z2 <= Z1;
    end
  end
// Spike output and reset logic
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      spike_out_reg <= 1'b0;
    end else if (V_reg >= Vpeak) begin
      spike_out_reg <= 1'b1;
      V_reg <= V_reset; 
      Z1 <= 8'b0;
      Z2 <= 8'b0;
    end else begin
      spike_out_reg <= 1'b0;
    end
  end

  // Assign spike_out_reg to spike_out (output wire)
  assign spike_out = spike_out_reg;
  assign V = Z2;
  
endmodule
