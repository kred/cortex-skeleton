# Some device templates
# Author: Krzysztof Dziuba krzysztof (at) meeqo.net
# License: LGPL-3


INCDIR += $(SKELETON_BASE)/device/STM32F0xx/Include
SRCDIR += $(SKELETON_BASE)/device/STM32F0xx/Source

ASMSRC += $(SRCDIR)/startup_stm32f030.s
CSRC   += $(SRCDIR)/system_stm32f0xx.c

COPT   += -DSTM32F030 -mthumb -mcpu=cortex-m0 $(foreach dir, $(INCDIR), -I$(dir)) 

LIBS   +=

LINKER  = $(SKELETON_BASE)/linker/STM32F030F4.ld
