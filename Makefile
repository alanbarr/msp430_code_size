TOOLS_PATH=/opt/msp430_gcc
TOOLS_PREFIX=msp430-elf-
TOOLS_INC=$(TOOLS_PATH)/include
MCU=msp430g2553 
CC=$(TOOLS_PREFIX)gcc
SIZE=$(TOOLS_PREFIX)size
OD=$(TOOLS_PREFIX)objdump

CFLAGS+=-Wall -Wextra -Wpedantic -mmcu=$(MCU) -std=c99 
CFLAGS+=-ggdb 

ODFLAGS=--disassemble-all --section-headers --source

# Other optimisations to consider
# -ffunction-sections -fdata-sections -Wl,--gc-sections,print-gc-sections

DIR=output
CSRC=main.c 
INC=.
IINC:=$(patsubst %,-I%,$(INC) $(TOOLS_INC))

OUTPUT = $(DIR)/default.dump \
         $(DIR)/space.dump \
         $(DIR)/minrt.dump \
         $(DIR)/space_minrt.dump \

all: $(OUTPUT)

$(DIR)/default.elf: $(CSRC) Makefile | $(DIR)
	@$(CC) $(CFLAGS) \
		$(IINC) $(CSRC) -L$(TOOLS_INC) -o $@
	$(SIZE) $@

$(DIR)/space.elf: $(CSRC) Makefile | $(DIR)
	@$(CC) $(CFLAGS) \
		-Os \
		$(IINC) $(CSRC) -L$(TOOLS_INC) -o $@
	$(SIZE) $@

$(DIR)/minrt.elf: $(CSRC) Makefile | $(DIR)
	@$(CC) $(CFLAGS) \
		-minrt \
		$(IINC) $(CSRC) -L$(TOOLS_INC) -o $@ 
	$(SIZE) $@

$(DIR)/space_minrt.elf: $(CSRC) Makefile | $(DIR)
	@$(CC) $(CFLAGS) \
		-Os \
		-minrt \
		$(IINC) $(CSRC) -L$(TOOLS_INC) -o $@
	$(SIZE) $@


$(OUTPUT): $(DIR)/%.dump : $(DIR)/%.elf
	$(SIZE) --radix=16 $< > $@
	$(OD) $(ODFLAGS) $< >> $@

$(DIR):
	mkdir -p $@

clean:
	rm $(DIR)/*.elf
	rm $(DIR)/*.dump
	rmdir $(DIR)

