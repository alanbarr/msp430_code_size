# About 

Example code and generated output for investigating MSP430 code size.
Observations on the output can be read [here](http://www.theunterminatedstring.com/the-greedy-c-runtime).

# Structure

* `.` -  Source files

* `output` - Generated objdump output. These were generated with msp430-gcc
5.3.0.224, obtained pre-built from the Texas Instruments website.

 * `gcc_and_newlib` - Various GCC/Newlib source files used to try and
 decipher some of the magic numbers contained within the objdump'd files. These
 were obtained from the sources of msp430-gcc-6.2.1.16_source-full and
 additionally from a pre-build and installed msp430-gcc 5.3.0.224.
 
# Other

 * [TI GCC Page](http://www.ti.com/tool/msp430-gcc-opensource)
