# What this script does:
# 1. Take a text file of oclc numbers as input
# 2. Check each OCN in the text file to see if TEU holdings are set
# 3. Return a .tsv report which includes the requested OCN, current OCN, institution symbol, and whether or not holdings are set
#
# To use this script:
# Install bookops_worldcat - see https://bookops-cat.github.io
# In the same directory as this script, create a config file called bookops_worldcat_config_teu.py
# The config file should contain the WorldCat Metadata API credentials for TEU as follows:
#
# key='key'
# secret='secret'
#
# additional config files can be created for other WorldCat symbols if needed

import bookops_worldcat_config_teu
from bookops_worldcat import WorldcatAccessToken, MetadataSession
import csv

# Get Access Token
token = WorldcatAccessToken(
    key=bookops_worldcat_config_teu.key,
    secret=bookops_worldcat_config_teu.secret,
    scopes="WorldCatMetadataAPI",
)

# Read OCLC numbers from file (no more than 1000)
input_file = "oclc_numbers.txt"  # Update with your file path
output_file = "oclc_report.tsv"

with open(input_file, "r") as f:
    oclc_numbers = [line.strip() for line in f if line.strip().isdigit()]  # Ensure valid numbers

# Process OCLC numbers
results = []

with MetadataSession(authorization=token) as session:
    for oclc_number in oclc_numbers:
        response = session.holdings_get_current(oclcNumbers=int(oclc_number))
        data = response.json().get("holdings", [{}])[0]

        results.append([
            data.get("requestedControlNumber", ""),
            data.get("currentControlNumber", ""),
            data.get("institutionSymbol", ""),
            data.get("holdingSet", "")
        ])

# Write to TSV file
with open(output_file, "w", newline="") as f:
    writer = csv.writer(f, delimiter="\t")
    writer.writerow(["requestedControlNumber", "currentControlNumber", "institutionSymbol", "holdingSet"])
    writer.writerows(results)

print(f"Report saved to {output_file}")
