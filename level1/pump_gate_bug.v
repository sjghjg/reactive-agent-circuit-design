// Deliberately incorrect implementation for the failure exercise.
// Compile this file instead of pump_gate.v, never together with it.
module pump_gate (
    input  wire dry,
    input  wire water_ok,
    input  wire fault,
    output wire pump_req
);
    assign pump_req = dry | (water_ok & ~fault);
endmodule
