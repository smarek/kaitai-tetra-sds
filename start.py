#!/usr/bin/python3

import downlink
import kaitaistruct
import code
from ppretty import ppretty

pdu = downlink.Downlink.from_file('sample2.bin')
print(ppretty(pdu,str_length=100000000,seq_length=10000,depth=1000))

code.interact(local=locals())
