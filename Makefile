
CC = gcc

DEBUG_FLAGS = -Wall -g

OPTIMIZE_FLAG = -O1

CUSTOM_FLAGS = 

FLAGS = $(DEBUG_FLAGS) $(OPTIMIZE_FLAG) $(CUSTOM_FLAGS)

LIBS = 

SRC = $(wildcard *.c)

OBJ = $(SRC:.c=.o)

%.o:%.c
	$(CC) -c $(FLAGS) $< -o  $@ $(LIBS) 

ALL = makefile_test

all: $(OBJ)
	gcc -o $(ALL) $(OBJ) 

clean:
	rm -f $(ALL) $(OBJ)

