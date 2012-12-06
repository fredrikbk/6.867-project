import os
import sys
import re
import string


if len(sys.argv) < 3:
    print "Usage: %s <directory> <output prefix> [cutoff] [multiword]\nCompile word frequencies for .txt files \nin each directory under given root" % (sys.argv[0])
    exit(1)

rootdir = sys.argv[1]
outprefix = sys.argv[2]

if len(sys.argv) >= 4:
    cutoff = int(sys.argv[3])
else:
    cutoff = 1

if len(sys.argv) >= 5:
    multiword = int(sys.argv[4])
else:
    multiword = 0


commonwords = ['the', 'be', 'to', 'of', 'and', 'a', 'in', 'that', 'i', 'it', 'for', 'not', 'on', 'with', 'he', 'as', 'you', 'do', 'at', 'this', 'but', 'his', 'by', 'from', 'they', 'we', 'say', 'her', 'she', 'or', 'an', 'will', 'my', 'one', 'all', 'would', 'there', 'their', 'what', 'so', 'up', 'out', 'if', 'about', 'who', 'get', 'which', 'go', 'me', 'when', 'make', 'can', 'like', 'time', 'no', 'just', 'him', 'know', 'take', 'people', 'into', 'year', 'your', 'good', 'some', 'could', 'them', 'see', 'other', 'than', 'then', 'now', 'look', 'only', 'come', 'its', 'over', 'think', 'also', 'back', 'after', 'use', 'two', 'how', 'our', 'work', 'first', 'well', 'way', 'even', 'new', 'want', 'because', 'any', 'these', 'give', 'day', 'most', 'us'] 


allwords = set()
dirtodict = dict()
wordcounts = dict()


def addwordtolist(word, allwords, dirwords, wordcounts):
    allwords.add(word)
    if word in dirwords:
        dirwords[word] += 1
    else:
        dirwords[word] = 1
    if word in wordcounts:
        wordcounts[word] += 1
    else:
        wordcounts[word] = 1




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
                    linelist = line.split(' ')
                    listlen = len(linelist)
                    for i in range(0, listlen):
                        word = filter(str.isalpha, linelist[i])
                        # Filter out any blank words or common words that start a sequence
                        if len(word) == 0 or word in commonwords:
                            continue
                        addwordtolist(word, allwords, dirwords, wordcounts)
                        if not multiword:
                            continue
                        word2 = ''
                        word3 = ''
                        if (i+1) < listlen-1:
                            word2 = filter(str.isalpha, linelist[i+1])
                            if len(word2) == 0:
                                continue
                            # Ignore couples of words where the second is common
                            if word2 not in commonwords:
                                addwordtolist(word + '-' + word2, allwords, dirwords, wordcounts)
                        if (i+2) < listlen:
                            word3 = filter(str.isalpha, linelist[i+2])
                            if len(word3) == 0:
                                continue
                            # Ignore triples of words where the start or end are common
                            if word in commonwords or word3 in commonwords:
                                continue
                            addwordtolist(word + '-' + word2 + '-' + word3, allwords, dirwords, wordcounts)
                        
        dirtodict[name] = dirwords



allwords = filter(lambda x: len(x) > 2 and x not in commonwords, allwords)

days = sorted(dirtodict.iterkeys())

sortedwords = sorted(allwords)

# Filter out words that do not pass cutoff
print "Filtering words"
sortedwords = filter(lambda x: wordcounts[x] >= cutoff, sortedwords)



# Write remaining words to data file
datafile = open(outprefix + '.txt', 'w')
wordfile = open(outprefix + '.counts', 'w')

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
    wordfile.write(word + ' ' + str(wordcounts[word]) + "\n")

wordfile.close()


