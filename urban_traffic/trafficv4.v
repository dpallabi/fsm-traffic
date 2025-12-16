module smart_traffic_controller (
    input wire clk,
    input wire reset,

    // Traffic inputs
    input wire car_sensor,
    input wire pedestrian_req,
    input wire emergency,

    // Parking system
    input wire car_enter,
    input wire car_exit,

    // Time-based mode (early morning)
    input wire low_traffic_mode,

    // Outputs
    output reg [1:0] traffic_light,     // 00=RED, 01=YELLOW, 10=GREEN
    output reg pedestrian_green,
    output reg emergency_active,
    output reg [3:0] parking_slots
);

    // -------------------- State Encoding --------------------
    localparam s0_IDLE          = 3'b000;
    localparam s1_GREEN         = 3'b001;
    localparam s2_YELLOW        = 3'b010;
    localparam s3_RED           = 3'b011;
    localparam s4_EMERGENCY     = 3'b100;
    localparam s5_PEDESTRIAN    = 3'b101;
    localparam s6_YELLOW_BLINK  = 3'b110;

    reg [2:0] state, next_state;
    reg [3:0] timer;
    reg [3:0] green_limit;

    // -------------------- State Register --------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= s0_IDLE;
            timer <= 0;
            parking_slots <= 4'd10;
        end else begin
            state <= next_state;

            if (state != next_state)
                timer <= 0;
            else
                timer <= timer + 1;
        end
    end

    // -------------------- Parking Slot Management --------------------
    always @(posedge clk) begin
        if (!reset) begin
            if (car_enter && parking_slots > 0)
                parking_slots <= parking_slots - 1;
            else if (car_exit && parking_slots < 10)
                parking_slots <= parking_slots + 1;
        end
    end

    // -------------------- Adaptive Green Timing --------------------
    always @(*) begin
        if (!car_sensor)
            green_limit = 3;   // low traffic → short green
        else
            green_limit = 6;   // normal traffic
    end

    // -------------------- Next State Logic --------------------
    always @(*) begin
        next_state = state;

        case (state)

            s0_IDLE:
                if (emergency)
                    next_state = s4_EMERGENCY;
                else if (low_traffic_mode)
                    next_state = s6_YELLOW_BLINK;
                else if (pedestrian_req)
                    next_state = s5_PEDESTRIAN;
                else if (car_sensor)
                    next_state = s1_GREEN;

            s1_GREEN:
                if (emergency)
                    next_state = s4_EMERGENCY;
                else if (timer >= green_limit)
                    next_state = s2_YELLOW;

            s2_YELLOW:
                if (timer == 2)
                    next_state = s3_RED;

            s3_RED:
                if (timer == 3)
                    next_state = s0_IDLE;

            s5_PEDESTRIAN:
                if (timer == 3)
                    next_state = s0_IDLE;

            s4_EMERGENCY:
                if (!emergency)
                    next_state = s0_IDLE;

            s6_YELLOW_BLINK:
                if (!low_traffic_mode)
                    next_state = s0_IDLE;

            default:
                next_state = s0_IDLE;
        endcase
    end

    // -------------------- Output Logic --------------------
    always @(*) begin
        traffic_light = 2'b00;
        pedestrian_green = 0;
        emergency_active = 0;

        case (state)

            s1_GREEN:
                traffic_light = 2'b10;

            s2_YELLOW:
                traffic_light = 2'b01;

            s3_RED:
                traffic_light = 2'b00;

            s5_PEDESTRIAN: begin
                traffic_light = 2'b00;
                pedestrian_green = 1;
            end

            s4_EMERGENCY: begin
                traffic_light = 2'b10;  // force GREEN
                emergency_active = 1;
            end

            s6_YELLOW_BLINK:
                traffic_light = (timer[0]) ? 2'b01 : 2'b00;

        endcase
    end

endmodule
