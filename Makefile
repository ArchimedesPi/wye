BIN = bin/wye

.PHONY: all test clean
all clean:
	$(MAKE) -C src $@
