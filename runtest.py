import os
import sys

if len(sys.argv) == 1:
    print("Error: need to specify test list")
    print("Usage: python3 runtest.py testlist")
    sys.exit(-1)

listfilename = sys.argv[1]

listfile = open(listfilename,'r')
raw = listfile.read()
testlist = raw.split(sep="\n")
listfile.close()

suite2casespath = "./suite2cases"
suitelist = os.listdir(suite2casespath)

for i in range(len(suitelist)):
    suitelist[i] = suitelist[i].replace(".json","")

print("total test targets num = ",len(testlist))
print("available test suites num = ",len(suitelist))

unavalnum = 0
unavaltest = []
for i in range(len(testlist)):
    if(testlist[i] not in suitelist):
        print("test tartget ",testlist[i]," is not available, please check typo or write the test script and suite2cases")
        unavalnum += 1
        unavaltest.append(testlist[i])

for i in range(unavalnum):
    testlist.remove(unavaltest[i])

print("available test targets num = ",len(testlist))
# print("clear logs and results")

# try:
#     os.removedirs("logs/*")
# except:
#     print("no logs")
# else:
#     print("logs cleared")

# try:
#     os.removedirs("results/*")
# except:
#     print("no results")
# else:
#     print("results cleared")

# print("start to run tests")

# for i in range(len(testlist)):
#     os.system("sudo bash mugen.sh -f "+testlist[i])

failedtestnum = []
successtestnum = []

temp = []

os.mkdir("logs_failed")

for i in range(len(testlist)):
    try:
        temp = os.listdir("results/"+testlist[i]+"failed")
    except:
        failedtestnum.append(0)
    else:
        failedtestnum.append(len(temp))
        os.mkdir("logs_failed/"+testlist[i])
        for j in range(len(temp)):
            os.system("cp logs/"+testlist[i]+"/"+temp[j]+"/*.log logs_failed/"+testlist[i]+"/"+temp[j]+"/")

    try:
        temp = os.listdir("results/"+testlist[i]+"succeed")
    except:
        successtestnum.append(0)
    else:
        successtestnum.append(len(temp))

    if(failedtestnum[i] != 0):
        print("Target "+testlist[i]+" tested "+str(successtestnum[i]+failedtestnum[i])+" cases, failed "+str(failedtestnum[i])+" cases")

