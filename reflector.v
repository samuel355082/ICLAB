module reflector(plugboard_forward_out, reflector_out);
input [6-1:0] plugboard_forward_out;
output reg [6-1:0] reflector_out;

always@(*)begin
    reflector_out = 6'd63 - plugboard_forward_out;
end

endmodule
