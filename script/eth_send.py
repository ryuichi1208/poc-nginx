#!/usr/bin/env python
from socket import *
rawSocket = socket(AF_PACKET, SOCK_RAW)
rawSocket.bind(("eth1", 0))

class ether_flame:
     def __init__(self,src_mac_addr, dst_mac_addr, ethertype):
           self.src_mac_addr = src_mac_addr
           self.dst_mac_addr = dst_mac_addr
           self.ethertype = ethertype

     def string(self):
           return self.dst_mac_addr + self.src_mac_addr + self.ethertype

SRC_MAC_ADDR = "\x11\x11\x11\x11\x11\x11"
DST_MAC_ADDR = "\x22\x22\x22\x22\x22\x22"
ETHER_TYPE = "\x08\x00"

flame = ether_flame(SRC_MAC_ADDR, DST_MAC_ADDR, ETHER_TYPE)

rawSocket.send(flame.string())
