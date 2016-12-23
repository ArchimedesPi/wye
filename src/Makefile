TOP = ..
BIN = $(TOP)/bin/wye

RAGEL = ragel
YACC = byacc
CXX = g++
CXXFLAGS += -Wall -Ofast -std=c++11
RAGELFLAGS += -G2 -C

PREFIX ?= /usr/local

GENERATED_FILES := lexer.cpp parser.tab.cpp parser.tab.h
GEN_SRCS:=$(filter-out %.h, $(GENERATED_FILES))
SRCS=$(filter-out $(GEN_SRCS), $(wildcard *.cpp))
OBJS:=$(filter %.o, $(SRCS:.cpp=.o) $(SRCS:.c=.o)) $(filter %.o, $(GEN_SRCS:.cpp=.o) $(GEN_SRCS:.c=.o))
DEPS:=$(SRCS:.cpp=.d)

COLOR_MAGENTA:=$(shell tput setaf 5)
COLOR_GREEN:=$(shell tput setaf 2)
COLOR_LIGHTBLUE:=$(shell tput setaf 6)
COLOR_RESET:=$(shell tput sgr0)


.PHONY: all clean test
all: $(BIN)

$(BIN): $(OBJS)
	@echo "$(COLOR_LIGHTBLUE)srcs=$(SRCS), objs=$(OBJS), deps=$(DEPS)$(COLOR_RESET)"
	$(CXX) -o $@ $(OBJS) $(LDFLAGS)

%.o: %.cpp 
	$(CXX) -c -o $@ $< $(CFLAGS)

parser.o: parser.tab.cpp
lexer.o: parser.o
wye.o: lexer.o

#.PHONY: lexer.rl parser.yy
%.cpp: %.rl
	$(RAGEL) $(RAGELFLAGS) -o $@ $<

%.tab.cpp %.tab.h: %.yy
	$(YACC) -d -t -o $(@:.cpp=.c) $<
	mv $(@:.cpp=.c) $@

clean:
	rm -f *.d *.o $(BIN)
	rm -f $(GENERATED_FILES)

-include $(DEPS)
