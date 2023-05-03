import csv
import json
import os
import sys

# CONSTANTS
HEADERS = ["Email", "Breach"]
API_URL = "https://api.dehashed.com/search?query=domain:{}&size={}&page={}"
API_USER = os.environ.get("DEHASHED_API")
size = 100
page = 1

print(f"[i] The maximum size of the dataset is {size}. Adjust Accordingly")
# FUNCTIONS
def fetch_data(domain, size, page):
    """
    Fetches data from Dehashed API for a given domain, size and page
    """
    url = API_URL.format(domain, size, page)
    response = os.popen(f'curl -s "{url}" -u {API_USER} -H "Accept: application/json"').read()
    data = json.loads(response)
    return data.get("entries"), data.get("balance")

def write_csv(entries, output_csv):
    """
    Write data to CSV file
    """
    with open(output_csv, "w", encoding="UTF8") as f:
        writer = csv.writer(f)
        writer.writerow(HEADERS)
        unique_emails = set()
        total_unique_emails = 0
        for entry in entries:
            email = entry.get("email")
            database_name = entry.get("database_name")
            writer.writerow([email, database_name])
            if email not in unique_emails:
                unique_emails.add(email)
                total_unique_emails += 1
        if len(entries) >= size:
            print(f"[+] Total results: {len(entries)} |||  Increase sizing for the API!! ||| ")
        else:
            print(f"[+] Total results: {len(entries)}")
            print(f"[+] Unique emails: {total_unique_emails}")

# MAIN
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("[x] ERROR: Please provide a domain")
        sys.exit(1)

    domain = sys.argv[1]
    output_csv = domain + ".csv"

    entries, balance = fetch_data(domain,size,page)

    if entries:
        write_csv(entries, output_csv)
        print(f"[+] Successfully wrote data to {output_csv}")
        print("-----"*10)
        print(f"\t--> Dehashed API balance: {balance}")
    else:
        print("[x] ERROR: Failed to fetch data from Dehashed API")
        sys.exit(1)

