# LinuxMonitoring v2.0

Monitoring and real-time system state research

## Part 1. File Generator

Create a bash script. The script is run with 6 parameters. Example of script execution: `main.sh /opt/test 4 az 5 az.az 3kb`

**Parameter 1** - absolute path. \
**Parameter 2** - number of nested folders. \
**Parameter 3** - list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 4** - number of files in each created folder. \
**Parameter 5** - list of English alphabet letters used in file names and extensions (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 6** - file size (in kilobytes, but no more than 100).

## Part 2. File System Cluttering

Create a bash script. The script is run with 3 parameters. Example of script execution: `main.sh az az.az 3Mb`

**Parameter 1** - list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 2** - list of English alphabet letters used in file names and extensions (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 3** - file size (in Megabytes, but no more than 100).

Folder and file names should consist only of the letters specified in the parameters, and use each of them at least once.  
The length of this part of the name should be at least 5 characters, plus the script execution date in the format DD MM YY, separated by an underscore.

When the script is run, folders with files should be created in various (any, except paths containing **bin** or **sbin**) locations in the file system.  
The number of nested folders is up to 100. The number of files in each folder is a random number (different for each folder).  
The script should stop working when there is 1 GB of free space left in the file system (in the / partition).  
Determine the free space in the file system using the command: `df -h /`.

Write a log file with data on all created folders and files (full path, creation date, size for files).  
At the end of the script, display the start time, end time, and total runtime on the screen. Add this data to the log file.

## Part 3. File System Cleanup

Create a bash script. The script is run with 1 parameter.
The script should be able to clean up the system from the folders and files created in [Part 2](#part-2-file-system-cluttering) in 3 ways:

1. By log file
2. By creation date and time
3. By name pattern (i.e., characters, underscore, and date).

The cleanup method is specified when running the script, as a parameter with a value of 1, 2, or 3.

*When deleting by creation date and time, the user enters the start and end times with minute precision.*

## Part 4. Log Generator

Create a bash script that generates 5 **nginx** log files in *combined* format.
Each log should contain information for 1 day.

For a day, a random number of records from 100 to 1000 should be generated.
For each record, randomly generate:

1. IP (any valid IPs, i.e., there should be no IPs like 999.111.777.777)
2. Response codes (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
3. Methods (GET, POST, PUT, PATCH, DELETE)
4. Dates (within the specified log day, should be in ascending order)
5. Request URLs
6. User agents (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

In the comments in your script/program, indicate what each of the used response codes means.

## Part 5. Monitoring

Create a bash script to parse **nginx** logs from [Part 4](#part-4-log-generator) using **awk**.

The script is run with 1 parameter, which takes a value of 1, 2, 3, or 4.
Depending on the parameter value, display:

1. All records, sorted by response code
2. All unique IPs found in the records
3. All requests with errors (response code - 4xx or 5xx)
4. All unique IPs found among the erroneous requests

## Part 6. **GoAccess**

Using the GoAccess utility, get the same information as in [Part 5](#part-5-monitoring).

Open the web interface of the utility on the local machine.

## Part 8. Pre-made Dashboard

- Install the pre-made dashboard *Node Exporter Quickstart and Dashboard* from the official website of **Grafana Labs**
- Perform tests
- Start another virtual machine located in the same network as the current one
- Run a network load test using the **iperf3** utility
- Check the network interface load

## Part 9. Additional. Custom *node_exporter*

Write a bash script that collects information on basic system metrics. The script should generate an HTML page in the format of **Prometheus**, which will be served by **nginx**. You can update the page inside the bash script in a loop, no more frequently than every 3 seconds.

- Modify the configuration file of **Prometheus** to collect information from the created page.
- Perform tests

---

Date: 21-12-2023
