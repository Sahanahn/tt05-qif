`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

// testbench is controlled by test.py
module tt_um_tb ();

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
 input reg clk;               // Clock signal
 input reg rst_n;               // Reset signal
 input reg [7:0] B;     // Input B 
 output wire [7:0] V;              // Output voltage
 output wire spike_out;            // Spike output


    tt_um_QIFNeuron qif_neuron (
    .clk(clk),
        .rst_n(rst_n),
    .B(B),
    .V(V),
    .spike_out(spike_out)
  );

endmodule
