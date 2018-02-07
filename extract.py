import sys
import os.path

inp = str(sys.argv[1])
out = str(sys.argv[2])
line_n = int(sys.argv[3])
start = int(sys.argv[4])
end = int(sys.argv[5])
file_out = open(out + ".csv",'w')
while start <= end:
	if os.path.isfile("results_4core/mix" + str(start) + '-' + inp + ".txt"):
		file_in = open("results_4core/mix" + str(start) + '-' + inp + ".txt", 'r')


		lines = file_in.readlines()
		print start
		if len(lines) > line_n:
			if lines[line_n].strip() == '':
				IPC = lines[line_n + 1].split(" ")[4]
			else:
				IPC = lines[line_n].split(" ")[4]
		
			file_out.write(str(start) + "," + IPC + "\n")
			file_in.close()
	start += 1

file_out.close()
