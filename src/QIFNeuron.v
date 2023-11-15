module QIFNeuron (
  input wire clk,          // Clock input
  input wire rst_n,       // Reset input
  input wire [7:0] B,     // Input B (8-bit, signed)
  output reg [7:0] V,     // Output voltage V (8-bit, signed)
      
);

  
  wire [7:0] V_reset = -8'sd20; // Set signed decimal value Vreset to -20
  wire [7:0] Vpeak = 8'd50;  // Vpeak value (Set to 50)
       
 

  // V computation
  reg [7:0] V_reg; // Intermediate register for V
 
 always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
        V_reg <= V_reset;
    end else begin
        if (V_mem >= V_peak) begin
            V_reg <= V_reset;
        end else begin
            // Integrate the synaptic current
            V_reg <= V_reg + ((V_reg / 8) * (V_reg / 8)) * (B / 4);
        end
    end
end


  assign V = V_reg;

endmodule
