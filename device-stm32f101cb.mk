# Some device templates
# Author: Krzysztof Dziuba krzysztof (at) meeqo.net
# License: LGPL-3


INCDIR += $(SKELETON_BASE)/device/STM32F10x/Include
SRCDIR += $(SKELETON_BASE)/device/STM32F10x/Source

ASMSRC += $(SRCDIR)/startup_stm32f10x_md.s
CSRC   += $(SRCDIR)/system_stm32f10x.c

COPT   += -DSTM32F10X_MD -mthumb -mcpu=cortex-m3 $(foreach dir, $(INCDIR), -I$(dir)) 

LIBS   +=

LINKER  = $(SKELETON_BASE)/linker/STM32F101CB.ld
