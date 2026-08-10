`timescale 1ns/1ps

module ram_16x8_tb;

    reg        clk;
    reg        we;
    reg  [3:0] addr;
    reg  [7:0] din;
    wire [7:0] dout;

    // Instantiate RAM
    ram_16x8 uut (
        .clk  (clk),
        .we   (we),
        .addr (addr),
        .din  (din),
        .dout (dout)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Create waveform file
        $dumpfile("ram_16x8.vcd");
        $dumpvars(0, ram_16x8_tb);

        // Initial values
        we   = 1'b0;
        addr = 4'b0000;
        din  = 8'b0;

        #10;

        // -------------------------
        // Write data to RAM
        // -------------------------

        we   = 1'b1;
        addr = 4'd0;
        din  = 8'hA5;
        #10;

        addr = 4'd1;
        din  = 8'h3C;
        #10;

        addr = 4'd2;
        din  = 8'hF0;
        #10;

        addr = 4'd3;
        din  = 8'h55;
        #10;

        // Stop writing
        we = 1'b0;

        // -------------------------
        // Read data from RAM
        // -------------------------

        addr = 4'd0;
        #10;
        $display("Address = %d, Data = %h", addr, dout);

        addr = 4'd1;
        #10;
        $display("Address = %d, Data = %h", addr, dout);

        addr = 4'd2;
        #10;
        $display("Address = %d, Data = %h", addr, dout);

        addr = 4'd3;
        #10;
        $display("Address = %d, Data = %h", addr, dout);

        // -------------------------
        // Test another location
        // -------------------------

        addr = 4'd10;
        #10;
        $display("Address = %d, Data = %h", addr, dout);

        $finish;
    end

endmodule