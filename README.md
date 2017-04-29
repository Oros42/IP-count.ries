# IP count.ries
Count IP and sort countries from log

Setup
-----

```bash
sudo apt install geoip-bin
wget https://raw.githubusercontent.com/Oros42/IP-count.ries/master/IP-count.ries.sh -O IP-count.ries.sh
chmod +x IP-count.ries.sh
```

Run
---

```bash
./IP-count.ries.sh <INPUT_LOG_FILE> <OUPUT_DIR>
```
  
Output :  
<OUPUT_DIR>/ipv4.csv # list of unique IP  
<OUPUT_DIR>/countries.csv # list of countries and count unique IP  
  
Example
-------
```bash
$ ./IP-count.ries.sh /var/log/apache2/access.log.1 ./out_exemple.net/
```
```bash
$ cat ./out_exemple.net/ipv4.csv
31.199.169.45
66.249.76.45
66.249.76.46
66.249.76.47
79.108.248.111
89.163.146.102
89.163.146.112
91.196.50.33
91.45.255.225
104.236.219.177
139.162.113.204
139.162.78.135
169.54.244.89
180.97.106.37
183.56.168.163
185.2.83.33
191.96.249.97
192.186.3.75
193.63.58.83
196.52.43.62
208.43.225.85
220.135.159.86
```
```bash
$ cat ./out_exemple.net/countries.csv
10,US, United States
3,DE, Germany
2,CN, China
1,TW, Taiwan
1,PL, Poland
1,NL, Netherlands
1,IT, Italy
1,GB, United Kingdom
1,ES, Spain
1,CL, Chile
```
```bash
$ wc -l ./out_exemple.net/countries.csv
10 out_exemple.net/countries.csv
```
  
TIP
---
Put this script in cron.  
Example :  
```bash
$ contrable -e
10 8 * * * /home/me/IP-count.ries/IP-count.ries.sh /var/log/apache2/my_website.log.1 /home/me/IP-count.ries/my_website/
```
Now your goal is to have all countries in the world ^_^  

Interface
---------
See https://github.com/Oros42/IP-count.ries_interface
