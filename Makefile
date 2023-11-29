all: prebuild build install

.PHONY: prebuild build install

prebuild:
	cd libs/jsoncpp && python ./amalgamate.py
	cd libs/Onigmo && ./autogen.sh && ./configure

build:
	mkdir -p build
	cd build && cmake ../ && make
	cp build/textmate.dylib ./lua/nvim-textmate/

clean:
	rm -rf build

