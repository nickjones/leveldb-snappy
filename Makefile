all: libsnappy.a_64 libleveldb.a_64 libsnappy.a_32 libleveldb.a_32

libsnappy.a_32:
	CFLAGS=-m32 CXXFLAGS=-m32 LDFLAGS=-m32 make libsnappy.a
	mv libsnappy.a libsnappy.a_32

libsnappy.a_64:
	CFLAGS='-m64 -fPIC' CXXFLAGS='-m64 -fPIC' LDFLAGS=-m64 make libsnappy.a
	mv libsnappy.a libsnappy.a_64

libsnappy.a:
	cd snappy && \
	mkdir -p build && \
	./autogen.sh && \
	./configure --without-gtest --disable-shared --prefix=`pwd`/build/ && \
	$(MAKE) clean && \
	$(MAKE) && \
	$(MAKE) install
	cp snappy/build/lib/libsnappy.a ./

libleveldb.a_32:
	CFLAGS=-m32 CXXFLAGS=-m32 LDFLAGS=-m32 make libleveldb.a
	mv libleveldb.a libleveldb.a_32

libleveldb.a_64:
	CFLAGS='-m64 -fPIC' CXXFLAGS='-m64 -fPIC' LDFLAGS=-m64 make libleveldb.a
	mv libleveldb.a libleveldb.a_64

libleveldb.a:
	cd leveldb && $(MAKE) clean && $(MAKE) libleveldb.a
	cp leveldb/libleveldb.a ./

.PHONY: clean

clean:
	cd snappy && rm -rf build && rm -f libsnappy.a
	rm -f libsnappy.a*
	cd leveldb && make clean
	rm -f libleveldb.a*
