import sys
import nltk
import re
#usage python perf_data_pruning.py inputfile > outputfile
#nltk.download('punkt')
words_match = ['***Alexnet','***vgg16','***mlp_l4','***mlp_l5','***nmt_l3','***nmt_l5','***wlm_anotherLSTM','***wlm_bigLSTM','****GPU','**batch'];
count = -1
sum = 0
with open(sys.argv[1]) as fp:
	for line in fp:
		#print line
		words = nltk.word_tokenize(line)
                for words_match_t in words_match:
	        	if words_match_t in words:
				print line
                                count = 0
				break
                if (count!=-1):
			count = count + 1
			if (count>=120 and count<150):
				sum=sum+float(words[1])
                        if count==150:
				print sum/30
                                print ' '
				count=-1
				sum=0

			

