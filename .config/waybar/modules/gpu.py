#!/usr/bin/env python

import json
import subprocess

data = {}
output_usage = subprocess.check_output("./nvidia-gpu/gpu_info.sh -u", shell=True).decode("utf-8").strip('\n')
output_temp = subprocess.check_output("./nvidia-gpu/gpu_info.sh -t", shell=True).decode("utf-8").strip('\n')

data ={}

data['text'] = output_usage + " " + output_temp
