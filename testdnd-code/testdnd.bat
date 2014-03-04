@echo off
echo PctSign-1 received:
echo %1
perl %~dp0testdnd.pl %1
PAUSE
