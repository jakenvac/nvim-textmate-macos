PYTHON := ${shell command -v python3 || command -v python}

all: prebuild build install

.PHONY: prebuild build install

prebuild:

	cd libs/jsoncpp && $(PYTHON) ./amalgamate.py
	cd libs/Onigmo && ./autogen.sh && ./configure

build:
	mkdir -p build
	cd build && cmake ../ && make
	cp build/textmate.dylib ./lua/nvim-textmate-macos/

clean:
	rm -rf build

