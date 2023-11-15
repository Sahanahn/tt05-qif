module QIFNeuron (
  input wire clk,          // Clock input
  input wire rst_n,       // Reset input
  input wire [7:0] B,     // Input B (8-bit, signed)
  output reg [7:0] V    // Output voltage V (8-bit, signed)
      );

  reg [7:0] Z1, Z2;        // Delay flip-flops
  wire [7:0] V_reset = -8'sd20; // Set Vreset to -20
  wire [7:0] Vpeak = 8'd50;  // Vpeak value (Set to 50)
  

        

  // V computation
  reg [7:0] V_reg; // Intermediate register for V
  always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
      V_reg <= V_reset;
      
      Z1 <= 8'b0; // Initialize Z1 on reset
    end else if (V_reg >= Vpeak) begin
      V_reg <= V_reset;
     
      Z1 <= 8'b0;
      Z2 <= 8'b0;
    end else begin
       V_reg <= V_reg + ((V_reg / 8) * (V_reg / 8)) * (B / 4);
        
      Z2 <= V_reg;
    end
  end
 
 
  assign V = Z2;

endmodule
