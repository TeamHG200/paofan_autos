.PHONY : all clean binary library test summary

AR = ar
CC = g++
CFLAGS = -fPIC -g -std=c++11 -Wreorder -O2
ARFLAGS = r
LDFLAGS = -lpthread -lm
INCLUDE = -Isrc -I.
LIBRARY = -LDEPEND/lib
DEPEND = DEPEND
BUILD = BUILD
INSTALL = INSTALL
GTEST_LIB = -lgtest_main -lgtest
LDFLAGS += -lrt -Wl,-E
SHARED = --shared

libchis.so: chis_board.o pattern_hash.o sillychis.o
	$(CC) -o $@ $^ $(SHARED) $(CFLAGS) $(INCLUDE) $(LIBRARY) $(LDFLAGS)

#main.o: main.cpp 
#	$(CC) -c -o $@ $^  $(CFLAGS) $(INCLUDE)

chis_board.o: chis_board.cpp 
	$(CC) -c -o $@ $^  $(CFLAGS) $(INCLUDE)

pattern_hash.o: pattern_hash.cpp
	$(CC) -c -o $@ $^  $(CFLAGS) $(INCLUDE)

sillychis.o: sillychis.cpp
	$(CC) -c -o $@ $^  $(CFLAGS) $(INCLUDE)
clean:
	rm *.so *.o

