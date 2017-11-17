from __future__ import print_function
import sys
import nltk
import re
#nltk.download('punkt')
words_match = ['CPU','**batch']
print ("threads,batchsize,time[ms]")
for filename in sys.argv[1:]:
	res = re.findall("threads_(\d+).",filename)
        with open(filename) as fp:
		for line in fp:
                	words = nltk.word_tokenize(line)
                	for words_match_t in words_match:
	                	if words_match_t in words:
					if words_match_t is 'CPU':
						res_time=re.findall("(\d+\.\d+)ms",words[3])
						print(int(float(res_time[0])))
					else:
						res_batch_size=re.findall("batch size (\d+)",line)
                                                print(res[0],end=',')
						print(res_batch_size[0],end=',')
				
