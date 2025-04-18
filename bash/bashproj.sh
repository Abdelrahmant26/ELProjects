#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
[ -f $1 ] || { echo "no such file" && exit 1; }
pcap_file="$1" # capture input from terminal.


declare output=$(tshark -r "${pcap_file}") 
#save the output to avoid redundant opening
declare total=$(echo "${output}" | wc -l)
declare top_5_dst=$(tshark -T fields -e ip.dst -r "${pcap_file}" | sort | grep -v "^$" | uniq -c | sort -nr)

declare top_5_src=$(tshark -T fields -e ip.src -r "${pcap_file}" | sort | grep -v "^$" | uniq -c | sort -nr)
declare protocols=$(echo -n "${output}" |  tr -s ' ' | cut -d ' ' -f 7 | sort | grep -v "^$" | uniq -c | sort -nr)

# Function to extract information from the pcap file
analyze_traffic() {
    # Use tshark or similar commands for packet analysis.
    # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
    # extract IP addresses, and generate summary statistics.

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    # Provide summary information based on your analysis
    # Hints: Total packets, protocols, top source, and destination IP addresses.
    echo "1. Total Packets: "${total}" packets"
    echo "2. Protocols:"
    #echo "   - HTTP: [your_http_packets] packets"
    #echo "   - HTTPS/TLS: [your_https_packets] packets"
    echo "${protocols}"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    echo "${top_5_src}"
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresses
    echo "${top_5_dst}"
    echo ""
    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic

