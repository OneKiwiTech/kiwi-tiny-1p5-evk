module led#(
    parameter led_number = 35
)
(
    input sys_clk,
    output [ led_number-1 :0] leds
);

reg count_1s_flag;
reg [23:0] count_1s = 'd0;

always @(posedge sys_clk ) begin
    if( count_1s < 12000000 ) begin
        count_1s <= count_1s + 'd1;
        count_1s_flag <= 'd0;
    end
    else begin
        count_1s <= 'd0;
        count_1s_flag <= 'd1;
    end
end


reg [led_number-1:0] leds_value = 'd0;

always @(posedge sys_clk ) begin
    if( count_1s_flag ) begin
    leds_value[ led_number-1 :0] <= ~ leds_value[ led_number-1 :0];
    end
end

assign leds = ~leds_value;

endmodule