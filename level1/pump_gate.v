module pump_gate (
    input  wire dry,
    input  wire water_ok,
    input  wire fault,
    output wire pump_req
);
    // Request the pump only when the soil is dry, water is available,
    // and the sensor has no reported fault.
    assign pump_req = dry & water_ok & ~fault;
endmodule
