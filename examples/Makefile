
EXAMPLES=simple-vcon.vcon
INCLUDES=$(EXAMPLES:.vcon=.pp)

vcon_includes: $(INCLUDES)
	echo "Making $(INCLUDES)"
	echo "from: $(EXAMPLES)"

%.pp: %.vcon
	echo "building $@ from $^"
	cat $^ | ./trunc_lines.sh > $@



