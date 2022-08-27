import sys,os

dc=sys.argv[1]
env=sys.argv[2]
dir="syncController/files/%s/%s/.tmp"%(dc, env)
possibleFiles = [dir+'/.INSTALL', dir+'/.UNINSTALL']
file=""
for f in possibleFiles:
   if os.path.isfile(f):
      file = f
      break

if os.path.isfile(file):
   fp=open(file, "r")
   data=fp.read().strip()
   fp.close()
   print data,
else:
   print "NONE"
