# Use Probabilistic Latent Semantic Analysis to model topics of each document
# and then give counts of different topic articles per day rather than word counts


import sys
import os
from math import log

commonwords = ['the', 'be', 'to', 'of', 'and', 'a', 'in', 'that', 'i', 'it', 'for', 'not', 'on', 'with', 'he', 'as', 'you', 'do', 'at', 'this', 'but', 'his', 'by', 'from', 'they', 'we', 'say', 'her', 'she', 'or', 'an', 'will', 'my', 'one', 'all', 'would', 'there', 'their', 'what', 'so', 'up', 'out', 'if', 'about', 'who', 'get', 'which', 'go', 'me', 'when', 'make', 'can', 'like', 'time', 'no', 'just', 'him', 'know', 'take', 'people', 'into', 'year', 'your', 'good', 'some', 'could', 'them', 'see', 'other', 'than', 'then', 'now', 'look', 'only', 'come', 'its', 'over', 'think', 'also', 'back', 'after', 'use', 'two', 'how', 'our', 'work', 'first', 'well', 'way', 'even', 'new', 'want', 'because', 'any', 'these', 'give', 'day', 'most', 'us'] 



if len(sys.argv) < 3:
    print "Usage: %s <directory> <# topics>" % sys.argv[0]
    exit(1)

rootdir = sys.argv[1]
topiccount = int(sys.argv[2])

daytoarticles = dict()

allwords = set()
alldocs = set()

doccount = 0

cutoff = 10


allarticlestowords = dict()

for name in os.listdir(rootdir):
    sdir = os.path.join(rootdir, name)
    # Find all directories under top root
    cutoff -= 1
    if cutoff < 0:
        break
    if os.path.isdir(sdir):
        articlestowords = dict()
        # Iterate over all files in the directory
        print "Processing", sdir
        for sname in os.listdir(sdir):
            _, ext = os.path.splitext(sname)
            if ext == '.txt':
                doccount += 1
                uniqdocname = os.path.join(sdir, sname)
                alldocs.add(uniqdocname)
                articledict = dict()
                for line in [line.strip() for line in open(os.path.join(sdir, sname))]:
                    linelist = line.split(' ')
                    listlen = len(linelist)
                    for i in range(0, listlen):
                        word = filter(str.isalpha, linelist[i])
                        # Filter out any blank words or common words that start a sequence
                        if len(word) == 0 or word in commonwords:
                            continue
                        if word in articledict:
                            articledict[word] += 1
                        else:
                            articledict[word] = 1
                        allwords.add(word)
                articlestowords[uniqdocname] = articledict
                allarticlestowords[uniqdocname] = articledict
        daytoarticles[name] = articlestowords

                        


# Do EM training
sortedwords = sorted(allwords)
sorteddocs = sorted(alldocs)


def e_step(z, doci, wordi):
    global sorteddocs
    global documentpriors
    global docgivenz
    global wordgivenz

    result = documentpriors[doci] * wordgivenz[z][wordi] * docgivenz[z][sorteddocs[doci]]
    return result / joint_dw(doci, wordi)




def joint_dw(doci, wordi):
    global sorteddocs
    global documentpriors
    global docgivenz
    global wordgivenz

    result = 0
    for i in range(topiccount):
        result += documentpriors[doci] * wordgivenz[i][wordi] * docgivenz[i][sorteddocs[doci]]

    return result

def count_dw(doci, wordi):
    global allarticlestowords
    global sorteddocs
    global sortedwords
    worddict = allarticlestowords[sorteddocs[doci]]
    if sortedwords[wordi] in worddict:
        return worddict[sortedwords[wordi]]
    else:
        return 0



def loglikelihood():
    global sortedwords
    global sorteddocs
    global documentpriors
    global docgivenz
    global wordgivenz

    result = 0

    for doci in range(len(sorteddocs)):
        for wordi in range(len(sortedwords)):
            cdw = count_dw(doci, wordi)
            if cdw:
                result += cdw * log(joint_dw(doci, wordi))

    return result

            

# init prior p(d)
documentpriors = [1.0/len(sorteddocs)] * len(sorteddocs)

# init p(w | z)
def init_wgz():
    global topiccount
    global sortedwords
    wordgivenz = dict()
    for i in range(topiccount):
        wordgivenz[i] = [1.0/len(sortedwords)] * len(sortedwords)
    return wordgivenz

wordgivenz = init_wgz()

# init p(d | z)
def init_dgz():
    global topiccount
    global daytoarticles
    global doccount
    docgivenz = dict()
    for i in range(topiccount):
        if i not in docgivenz:
            docgivenz[i] = dict()

        for amap in daytoarticles.itervalues():
            for key in amap.iterkeys():
                docgivenz[i][key] = 1.0/doccount
    return docgivenz

docgivenz = init_dgz()


step = 1
while True:
    print "Computing LL for step",step
    oldll = loglikelihood()
    print "Step", step, ", LL", oldll

    print "Calculating new vals"
    newdocumentpriors = [1.0/len(sorteddocs)] * len(sorteddocs)
    newwgz = init_wgz()
    newdgz = init_dgz()

    for z in range(topiccount):
        denom = 0
        for doci in range(len(sorteddocs)):
            print doci/float(len(sorteddocs)), "              \r",
            for wordi in range(len(sortedwords)):
                denom += count_dw(doci, wordi) * e_step(z, doci, wordi)

        for wordi in range(len(sortedwords)):
            print wordi/float(len(sortedwords)), "                 \r",
            newwgz[z][wordi] = 0
            for doci in range(len(sorteddocs)):
                newwgz[z][wordi] += count_dw(doci, wordi) * e_step(z, doci, wordi)
            newwgz[z][wordi] /= denom

    print "Done p(w|z)"



    wordgivenz = newwgz




