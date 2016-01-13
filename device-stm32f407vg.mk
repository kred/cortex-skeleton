# Some device templates
# Author: Krzysztof Dziuba krzysztof (at) meeqo.net
# License: LGPL-3


INCDIR += $(SKELETON_BASE)/device/STM32F4xx/Include
SRCDIR += $(SKELETON_BASE)/device/STM32F4xx/Source

ASMSRC += $(SRCDIR)/startup_stm32f4xx.s
CSRC   += $(SRCDIR)/system_stm32f4xx.c

COPT   += -DSTM32F407 -mthumb -mcpu=cortex-m4 $(foreach dir, $(INCDIR), -I$(dir)) 

LIBS   +=

LINKER  = $(SKELETON_BASE)/linker/STM32F407VG.ld
