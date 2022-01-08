#!/usr/bin/env python3

import sys

if len(sys.argv) < 3:
    printf("usage: assemblerom.py romfile:addr romfile2:addr ... outfile")
    exit(1)

infiles = []
for a in sys.argv[1:-1]:
    v = a.split(":")
    if len(v) != 2:
        printf("error in argument ["+a+"]")
        exit(1)
    if v[1][0] == '0':
        ar = int(v[1],base=16)
        infiles.append([v[0], ar])
        print("added",v[0],"\tmapped starting at","{0:#0{1}X}".format(ar,8).replace("X","x"))
    else:
        ar = int(v[1])
        infiles.append([v[0], ar])
        print("added",v[0],"\tmapped starting at","{0:#0{1}x}".format(ar,8).replace("X","x"))

outbuf = bytearray(16777216 * 3)
for f in infiles:
    fn = f[0]
    fp = f[1]
    print("processing",fn,end="")
    with open(fn,"rb") as fl:
        fb = fl.read()
        print(" sz =",hex(int(len(fb)/3)))
        fpr = fp*3
        outbuf[fpr:fpr+len(fb)] = fb

with open(sys.argv[-1],"wb") as fl:
    fl.write(outbuf)