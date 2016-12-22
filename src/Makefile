TOP = ..
BIN = $(TOP)/bin/wye

RAGEL = ragel
BISON = bison
CXX = g++
CXXFLAGS += -Wall -Ofast -std=c++11
RAGELFLAGS += -G2 -C

PREFIX ?= /usr/local

GENERATED_SRC := lexer.cpp parser.tab.cc parser.tab.hh stack.hh
SRCS=$(filter-out $(GENERATED_SRC), $(wildcard *.cpp))
OBJS:=$(SRCS:.cpp=.o) $(GENERATED_SRC:.cpp=.o) $(GENERATED_SRC:.cc=.o)
DEPS:=$(OBJS:.o=.d)

COLOR_MAGENTA:=$(shell tput setaf 5)
COLOR_GREEN:=$(shell tput setaf 2)
COLOR_LIGHTBLUE:=$(shell tput setaf 6)
COLOR_RESET:=$(shell tput sgr0)


.PHONY: all clean test
all: $(BIN)

$(BIN): $(OBJS)
	@echo "$(COLOR_LIGHTBLUE)srcs=$(SRCS), objs=$(SRCS)$(COLOR_RESET)"
	$(CXX) -o $@ $(OBJS) $(LDFLAGS)

%.o: %.cpp
	$(CXX) -c -o $@ $< $(CFLAGS)

.PHONY: lexer.rl parser.yy
lexer.cpp: lexer.rl
	$(RAGEL) $(RAGELFLAGS) -o lexer.cpp lexer.rl

#parser.tab.cc parser.tab.hh: parser.yy
#	$(BISON) parser.yy

clean:
	rm -f *.d *.o $(BIN)
	rm -f $(GENERATED_SRC)

-include $(DEPS)
