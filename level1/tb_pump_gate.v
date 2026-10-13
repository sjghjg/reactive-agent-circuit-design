`timescale 1ns/1ps

module tb_pump_gate;
    reg dry;
    reg water_ok;
    reg fault;
    wire pump_req;
    reg expected;
    integer case_number;

    pump_gate dut (
        .dry(dry),
        .water_ok(water_ok),
        .fault(fault),
        .pump_req(pump_req)
    );

    initial begin
        // The specification permits ON only for the input pattern 110.
        // Enumerating all eight patterns checks this entire three-bit input space.
        for (case_number = 0; case_number < 8; case_number = case_number + 1) begin
            {dry, water_ok, fault} = case_number[2:0];
            expected = (case_number == 6);
            #1;
            if (pump_req !== expected) begin
                $fatal(1,
                    "FAIL dry=%b water_ok=%b fault=%b: expected=%b actual=%b",
                    dry, water_ok, fault, expected, pump_req);
            end
        end
        $display("PASS: all 8 input combinations");
        $finish;
    end
endmodule
