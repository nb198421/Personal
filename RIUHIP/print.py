cname = AdminConfig.showAttribute(cell, 'name')
nname = AdminConfig.showAttribute(node, 'name')
servs = AdminControl.queryNames('type=Server,cell=' + cname + ',node=' + nname + ',*').split()
print "Number of running servers on node " + nname + ": %s \n" %(len(servs))