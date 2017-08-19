@echo off
echo Example A
SnmpGet.exe -v:1 -c:public -r:demo.snmplabs.com -o:.1.3.6.1.2.1.1.1.0

echo Example B
SnmpGet.exe -c:public -v:2  -r:demo.snmplabs.com -o:.1.3.6.1.2.1.6.13.1.1.127.0.0.1.53.0.0.0.0.0

echo Example C
snmpwalk.exe -v:2c -c:public -r:demo.snmplabs.com -os:.1.3.6.1.2.1.4.16.0 | more

pause
exit


