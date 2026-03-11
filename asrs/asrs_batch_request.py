## Requirements to run this script:
##
## 1. Create a separate .txt file called "apikey.txt" containing your Alma API key and nothing else. 
## The key needs Bibs production read/write and Users production read/write API access.
## The file should be in the same directory as this script (if not, change the path in the code below).
##
## 2. Create a tab-delimited text file called "asrs_batch_request.txt"
## The file needs four columns with these headers: mms_id, holding_id, pid, description
## Each row will contain the data for the items you would like to request. All columns are required.
## You can obtain the MMS ID, Holdings ID, Physical Item ID, and Physical Item Description for each item using Alma Analytics.
## The file should contain request data for no more than 1000 items, due to daily Alma API limitations.
## An example file can be found in this repository at fixtures/asrs_batch_request.txt
## The file should be in the same directory as this script (if not, change the path in the code below).
##
## 3. Set the Alma user ID of the requester below
## 4. Set the Alma pickup location library code below

import csv
import requests
import json

# Load API key from external file
with open('apikey.txt', 'r') as f: # Replace with your filename/path if different
    api_key = f.read().strip()

# Set the appropriate Alma user ID of the requester
user_id = "" 

# Set the apropriate pickup location library code, e.g., AMBLER or MAIN
pickup_location_library = ""

# Input file
input_file = 'asrs_batch_request.txt'  # Replace with your filename/path if different

# Headers for the API request
headers = {
    'Content-Type': 'application/json',
    'cache-control': 'no-cache'
}

# Read the tab-delimited file and send API requests
with open(input_file, newline='', encoding='utf-8') as tsvfile:
    reader = csv.DictReader(tsvfile, delimiter='\t')
    for row in reader:
        mms_id = row['mms_id']
        holding_id = row['holding_id']
        pid = row['pid']
        description = row['description']

        url = f'https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/{mms_id}/holdings/{holding_id}/items/{pid}/requests'
        params = {
            'apikey': api_key,
            'user_id': user_id,
            'format': 'json'
        }

        data = {
            "pickup_location_type": "LIBRARY",
            "request_type": "HOLD",
            "pickup_location_library": pickup_location_library,
            "description": description
        }

        response = requests.post(url, headers=headers, params=params, data=json.dumps(data))

        # Handle response
        if response.status_code == 200 or response.status_code == 201:
            print(f"Success: Item {pid}")
        else:
            print(f"Failed for Item {pid}: {response.status_code} - {response.text}")
