import os
import sys
import re
import string


if len(sys.argv) < 3:
    print "Usage: %s <directory> <output prefix>\nCompile word frequencies for .txt files \nin each directory under given root" % (sys.argv[0])
    exit(1)

rootdir = sys.argv[1]
outprefix = sys.argv[2]

commonwords = ['the', 'be', 'to', 'of', 'and', 'a', 'in', 'that', 'i', 'it', 'for', 'not', 'on', 'with', 'he', 'as', 'you', 'do', 'at', 'this', 'but', 'his', 'by', 'from', 'they', 'we', 'say', 'her', 'she', 'or', 'an', 'will', 'my', 'one', 'all', 'would', 'there', 'their', 'what', 'so', 'up', 'out', 'if', 'about', 'who', 'get', 'which', 'go', 'me', 'when', 'make', 'can', 'like', 'time', 'no', 'just', 'him', 'know', 'take', 'people', 'into', 'year', 'your', 'good', 'some', 'could', 'them', 'see', 'other', 'than', 'then', 'now', 'look', 'only', 'come', 'its', 'over', 'think', 'also', 'back', 'after', 'use', 'two', 'how', 'our', 'work', 'first', 'well', 'way', 'even', 'new', 'want', 'because', 'any', 'these', 'give', 'day', 'most', 'us'] 


allwords = set()
dirtodict = dict()



for name in os.listdir(rootdir):
    sdir = os.path.join(rootdir, name)
    # Find all directories under top root
    if os.path.isdir(sdir):
        dirwords = dict()
        # Iterate over all files in the directory
        print "Processing", sdir
        for sname in os.listdir(sdir):
            _, ext = os.path.splitext(sname)
            if ext == '.txt':
                for line in [line.strip() for line in open(os.path.join(sdir, sname))]:
                    for word in line.split(' '):
                        word = filter(str.isalpha, word)
                        # Iterate over all words in each file under the directory
                        allwords.add(word)
                        if word in dirwords:
                            dirwords[word] = dirwords[word] + 1
                        else:
                            dirwords[word] = 1
        dirtodict[name] = dirwords



allwords = filter(lambda x: len(x) > 2 and x not in commonwords, allwords)

days = sorted(dirtodict.iterkeys())

sortedwords = sorted(allwords)

allwordmap = dict()

datafile = open(outprefix + '.txt', 'w')
wordfile = open(outprefix + '.counts', 'w')


print "Compiling word frequencies"

# Compile overall frequencies for all words
for day in days:
    daymap = dirtodict[day]
    for word in sortedwords:
        val = 0
        if word in daymap:
            val = daymap[word]
        if word in allwordmap:
            allwordmap[word] = allwordmap[word] + val
        else:
            allwordmap[word] = val


print "Filtering words"

# Filter out words that do not pass cutoff
cutoff = 10
sortedwords = filter(lambda x: allwordmap[x] >= cutoff, sortedwords)

# Write remaining words to data file
print "Writing data file"
count = 0
for day in days:
    daymap = dirtodict[day]
    daystr = str(int(day[4:6])) + '/' + str(int(day[6:8])) + '/' + day[0:4]
    outlist = [daystr]
    if count % (len(days)/50) == 0:
        print "%.2f%% done" % (float(count)/len(days) * 100)
    count += 1
    for word in sortedwords:
        val = 0
        if word in daymap:
            val = daymap[word]
        outlist.append(str(val))

    outstring = ' '.join(outlist) + "\n"
    datafile.write(outstring)

datafile.close()

print "Writing word counts"

for word in sortedwords:
    wordfile.write(word + ' ' + str(allwordmap[word]) + "\n")

wordfile.close()


