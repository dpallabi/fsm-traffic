`timescale 1ns/1ps

module tb_smart_traffic_controller;

    // Testbench signals
    reg clk;
    reg reset;

    reg car_sensor;
    reg pedestrian_req;
    reg emergency;

    reg car_enter;
    reg car_exit;

    reg low_traffic_mode;

    wire [1:0] traffic_light;
    wire pedestrian_green;
    wire emergency_active;
    wire [3:0] parking_slots;

    // -------------------- DUT Instantiation --------------------
    smart_traffic_controller DUT (
        .clk(clk),
        .reset(reset),
        .car_sensor(car_sensor),
        .pedestrian_req(pedestrian_req),
        .emergency(emergency),
        .car_enter(car_enter),
        .car_exit(car_exit),
        .low_traffic_mode(low_traffic_mode),
        .traffic_light(traffic_light),
        .pedestrian_green(pedestrian_green),
        .emergency_active(emergency_active),
        .parking_slots(parking_slots)
    );

    // -------------------- Clock Generation --------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns clock period
    end

    // -------------------- Stimulus --------------------
    initial begin
        // Initialize inputs
        reset = 1;
        car_sensor = 0;
        pedestrian_req = 0;
        emergency = 0;
        car_enter = 0;
        car_exit = 0;
        low_traffic_mode = 0;

        // Waveform dump
        $dumpfile("smart_traffic.vcd");
        $dumpvars(0, tb_smart_traffic_controller);

        // Reset pulse
        #20 reset = 0;

        // ---------------- NORMAL TRAFFIC ----------------
        #20 car_sensor = 1;        // vehicle detected
        #100 car_sensor = 0;

        // ---------------- PEDESTRIAN REQUEST ----------------
	// Pedestrian request DURING vehicle green
        #30 pedestrian_req = 1;
        #20 pedestrian_req = 0;
	// Pedestrian request AFTER full traffic cycle
	#120 pedestrian_req = 1;
	#20  pedestrian_req = 0;


        // ---------------- PARKING ENTRY ----------------
        #30 car_enter = 1;
        #10 car_enter = 0;

        // ---------------- PARKING EXIT ----------------
        #40 car_exit = 1;
        #10 car_exit = 0;

        // ---------------- EMERGENCY OVERRIDE ----------------
        #50 emergency = 1;
        #40 emergency = 0;

        // ---------------- LOW TRAFFIC MODE (EARLY MORNING) ----------------
        #50 low_traffic_mode = 1;
        #100 low_traffic_mode = 0;

        // End simulation
        #200 $finish;
    end

endmodule
