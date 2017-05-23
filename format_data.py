#!/usr/bin/env python

# formats data output by netperf and stores it in the specified results folder

import sys
import os

num_tests = int(os.environ["reps"])
results_file = str(os.environ["results_file"])

if not os.path.exists(results_file):
        os.makedirs(results_file)

ogdir = os.getcwd()
resdir = str(ogdir + "/" + results_file)
print resdir
os.chdir(resdir)
print ogdir

if not os.path.exists(os.environ["backend"]):
	os.makedirs(os.environ["backend"])

os.chdir(ogdir)

def grab_var(out_str, output, test):
	global num_tests

	mrkr = 0

	i = 0
	while(i < test):

		mrkr = output.find(("\n" + out_str + "="),(mrkr + 1))
		endmrkr = output.find("\n",(mrkr + 1))
		i += 1

	return float(output[(mrkr + len(out_str) + 2):endmrkr])

def grab_net_data_stream(output):
	runs = 1
	thr_avg = 0
	mnl_avg = 0

	while(runs < (num_tests + 1)):

		msg = grab_var("LOCAL_BYTES_PER_SEND", output, runs)
		thr = grab_var("THROUGHPUT", output, runs)
		mnl = grab_var("MEAN_LATENCY", output, runs)

		runs += 1
		thr_avg += float(thr)
		mnl_avg += float(mnl)

	thr_avg = thr_avg / runs
	mnl_avg = mnl_avg / runs

	file_output = open(results_file + "/" + os.environ["backend"] + "/" + os.environ["test"] + "_" + os.environ["qemu_ver"] +  ".dat", "a")
        file_output.write(str(msg) + "\t" + str("%.2f" % thr_avg) + "\t" + str("%.2f" % mnl_avg) + "\n")
        file_output.close()

def grab_net_data_rr(output):
        runs = 1
        thr_avg = 0
        mnl_avg = 0
        rtl_avg = 0

        while(runs < (num_tests + 1)):

                msg = grab_var("REQUEST_SIZE", output, runs)
                thr = grab_var("THROUGHPUT", output, runs)
                mnl = grab_var("MEAN_LATENCY", output, runs)
                rtl = grab_var("RT_LATENCY", output, runs)

                runs += 1
                thr_avg += float(thr)
                mnl_avg += float(mnl)
                rtl_avg += float(rtl)

        thr_avg = thr_avg / runs
        mnl_avg = mnl_avg / runs
        rtl_avg = rtl_avg / runs

        file_output = open(results_file + "/" + os.environ["backend"] + "/" + os.environ["test"] + "_" + os.environ["qemu_ver"] +  ".dat", "a")
        file_output.write(str(msg) + "\t" + str("%.2f" % thr_avg) + "\t" + str("%.2f" % rtl_avg) + "\n")
        file_output.close()

test_out =  sys.stdin.read()

if os.environ["type"] == "stream":
	grab_net_data_stream(test_out)
else:
	grab_net_data_rr(test_out)


