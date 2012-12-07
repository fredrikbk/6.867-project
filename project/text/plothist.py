import numpy
import matplotlib.pyplot as plt
import sys

def usage():
    print "Usage: %s <filename> <title> <axisx> <axisy>" % sys.argv[0]

if len(sys.argv) < 5:
    usage()
    exit(1)



nums = []

for line in sys.stdin.readlines():
    nums.append(float(line))


plt.hist(nums)
plt.title(sys.argv[2])
plt.xlabel(sys.argv[3])
plt.ylabel(sys.argv[4])

plt.savefig(sys.argv[1])
