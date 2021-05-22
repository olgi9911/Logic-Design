VERILOG = iverilog
TARGET = gcd.vcd

$(TARGET) : gcd.vvp
	vvp gcd.vvp

gcd.vvp: gcd_t.v gcd.v
	$(VERILOG) -o gcd.vvp gcd_t.v gcd.v

clean:
	rm $(TARGET)