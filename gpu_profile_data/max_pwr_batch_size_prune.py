import sys
import nltk
import re
import glob
#usage python perf_data_pruning.py inputfile > outputfile
#nltk.download('punkt')
from glob import glob
#words_match = ['***Alexnet','***vgg16','***mlp_l4','***mlp_l5','***nmt_l3','***nmt_l5','***wlm_anotherLSTM','***wlm_bigLSTM','GPU','**batch'];
filearg = sys.argv[1]
filename_list = list()
print "batchsize,util_gpu_pwr,total_gpu_pwr,gpu_util,gpu_memory_size,gpu_used_memory,gpu_free_memory"
for filename in sys.argv[1:]:
#	print filename
        filename_list.append(filename)
	res = re.findall("batchsize_(\d+)_*",filename)
        with open(filename) as fp:
		fp.readline()
                total_gpu_pwr_util=[]
                total_gpu_pwr=[]
                gpu_util=[]
                memory_size=[]
      		gpu_memory_used=[]
                gpu_memory_free=[]
		for line in fp:
			gpu_query = line.split(",")
	                total_gpu_pwr_util.append(int(float(gpu_query[1])))
                        total_gpu_pwr.append(int(float(gpu_query[0])))
                        gpu_util.append(int(gpu_query[2]))
                        memory_size.append(int(gpu_query[4]))
                        gpu_memory_used.append(int(gpu_query[5]))
                        gpu_memory_free.append(int(gpu_query[6]))
                else:
	                #total_gpu_pwr_util_1=sorted(total_gpu_pwr_util,key=float)
		        total_gpu_pwr_util.sort(key=int,reverse=True)
                        total_gpu_pwr.sort(key=int)
                        gpu_util.sort(key=int,reverse=True)
                        memory_size.sort(key=int,reverse=True)
                        gpu_memory_used.sort(key=int,reverse=True)
                        gpu_memory_free.sort(key=int,reverse=True)
                        #print total_gpu_pwr_util
        print "%d,%d,%d,%d,%d,%d,%d" %(int(res[0]),total_gpu_pwr_util[0],total_gpu_pwr[0],gpu_util[0],memory_size[0],gpu_memory_used[0],gpu_memory_free[0])
#filename_list.sort(key=int)
#for list in filename_list:
#	print list
#with open(glob(sys.argv[1])) as fp:
#	for line in fp
		#print line
		#words = nltk.word_tokenize(line)
                #for words_match_t in words_match:
	         #       if words_match_t in words:
		#		print line
