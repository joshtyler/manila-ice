
CC=g++
# N.B. stealing source from SPI prog
CXXFLAGS=-c -Wall  -g -I../spi_prog
LDFLAGS=-lserial -lpthread
SOURCES= sdram_test.cpp ../spi_prog/VectorUtility.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=sdram_test


all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS)  $(LDFLAGS) -o $@

.cc.o:
	$(CC) $(CXXFLAGS) $< -o $@

clean:
	/bin/rm -rf $(OBJECTS) $(EXECUTABLE)
