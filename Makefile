LIBDIR := lib
allall: vcon_includes all

include $(LIBDIR)/main.mk

EXAMPLES=simple-vcon.vcon
INCLUDES=$(EXAMPLES:.vcon=.pp)

%.pp: %.vcon
	echo "building $@ from $^"
	cat $^ | ./trunc_lines.sh > $@

vcon_includes: $(INCLUDES)
	echo "Making $(INCLUDES)"
	echo "from: $(EXAMPLES)"

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

.PHONY: vcon_includes

