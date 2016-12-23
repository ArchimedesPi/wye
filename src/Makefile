TOP = ..
BIN = $(TOP)/bin/wye

RAGEL = ragel
YACC = byacc
CXX = g++
CXXFLAGS += -Wall -Ofast -std=c++11
RAGELFLAGS += -G2 -C

PREFIX ?= /usr/local

GENERATED_FILES := lexer.cpp parser.tab.cpp parser.tab.h
GENERATED_SRCS := $(filter-out %.h %.hh, $(GENERATED_FILES))
SRCS=$(filter-out $(GENERATED_SRC), $(wildcard *.cpp))
OBJS:=$(filter %.o, $(SRCS:.cpp=.o) $(GENERATED_SRCS:.cpp=.o) $(GENERATED_SRCS:.c=.o))
DEPS:=$(OBJS:.o=.d)

COLOR_MAGENTA:=$(shell tput setaf 5)
COLOR_GREEN:=$(shell tput setaf 2)
COLOR_LIGHTBLUE:=$(shell tput setaf 6)
COLOR_RESET:=$(shell tput sgr0)


.PHONY: all clean test
all: $(BIN)

$(BIN): $(OBJS)
	@echo "$(COLOR_LIGHTBLUE)srcs=$(SRCS), objs=$(OBJS)$(COLOR_RESET)"
	$(CXX) -o $@ $(OBJS) $(LDFLAGS)

%.o: %.cpp 
	$(CXX) -c -o $@ $< $(CFLAGS)

lexer.o: parser.tab.cpp
wye.o: lexer.o

#.PHONY: lexer.rl parser.yy
%.cpp: %.rl
	$(RAGEL) $(RAGELFLAGS) -o $@ $<

%.tab.cpp %.tab.h: %.yy
	$(YACC) -d -t -o $(@:.cpp=.c) $<
	mv $(@:.cpp=.c) $@

clean:
	@echo "$(COLOR_LIGHTBLUE)srcs=$(SRCS), objs=$(OBJS)$(COLOR_RESET)"

	rm -f *.d *.o $(BIN)
	rm -f $(GENERATED_FILES)

-include $(DEPS)
