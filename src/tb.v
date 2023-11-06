`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

// testbench is controlled by test.py
module tb ();

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
  reg clk;               // Clock signal
  reg rst;               // Reset signal
  reg [7:0] B;     // Input B set to -20
  wire [7:0] V;              // Output voltage
  wire spike_out;            // Spike output


    QIFNeuron qif_neuron (
    .clk(clk),
    .rst(rst),
    .B(B),
    .V(V),
    .spike_out(spike_out)
  );

endmodule
