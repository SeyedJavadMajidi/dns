@echo off

call :colorEcho 09 "Seyed Javad Majidi - softjam[dot]ir"
call echo .
if "%1"=="on" call :on "%2"
if "%1"=="off" call :off
if "%1"=="list" call  :colorEcho 0e "ghand"
if "%1"=="list" call  :colorEcho 0a "(GhandShekan)"
if "%1"=="list" call  echo .
if "%1"=="list" call  :colorEcho 0e "403"
if "%1"=="list" call  :colorEcho 0a "(403)"
if "%1"=="list" call  echo .
if "%1"=="list" call  :colorEcho 0e "elect"
if "%1"=="list" call  :colorEcho 0a "(electrotm)"
if "%1"=="list" call  echo .
if "%1"=="list" call  :colorEcho 0e "beg"
if "%1"=="list" call  :colorEcho 0a "(Begzar)"
if "%1"=="list" call  echo .
if "%1"=="list" call  :colorEcho 0e "iran"
if "%1"=="list" call  :colorEcho 0a "(hostiran)"
if "%1"=="list" call  echo .


:: Help
if "%1"=="help" call :colorEcho 0e "dns on dns_name"
if "%1"=="help" call :colorEcho 0a " (Enable DNS)"
if "%1"=="help" call echo .
if "%1"=="help" call :colorEcho 0e "dns off"
if "%1"=="help" call :colorEcho 0c " (Disable DNS)"
if "%1"=="help" call echo .
if "%1"=="help" call :colorEcho 0e "dns list"
if "%1"=="help" call :colorEcho 0f " (DNS Name List)"
if "%1"=="help" call echo .





goto :eof

:on
	SET _DHCP=Maybe
	For /f "tokens=2 delims=:" %%a in ('netsh interface ip show addresses ^|FIND "DHCP Enabled"') DO SET _DHCP=%%a
	IF "%_DHCP%"=="No" Then

	:: GhandShekan
	set dnsserver=178.22.122.100
	set dnsserver2=185.51.200.2
	
	:: 403
	if %1=="403" set dnsserver=10.202.10.202
	if %1=="403" set dnsserver2=10.202.10.102
	
	:: electrotm
	if %1=="elect" set dnsserver=78.157.42.100
	if %1=="elect" set dnsserver2=78.157.42.101

	:: Beghzar
	if %1=="beg" set dnsserver=185.55.226.26
	if %1=="beg" set dnsserver2=185.55.225.25
	
	:: hostiran
	if %1=="iran" set dnsserver=172.29.0.100
	if %1=="iran" set dnsserver2=172.29.2.100
	
	for /f "tokens=1,2,3*" %%i in ('netsh interface show interface') do (
		if %%i EQU Enabled (
			netsh interface ipv4 set dnsserver name="%%l" static %dnsserver% both >log.txt
			netsh interface ipv4 add dnsserver name="%%l" %dnsserver2% index=2 >log.txt
		)
	)


	call :colorEcho 0a "%1 DNS is activated"

  goto:eof

:off
	SET _DHCP=Maybe
	For /f "tokens=2 delims=:" %%a in ('netsh interface ip show addresses ^|FIND "DHCP Enabled"') DO SET _DHCP=%%a
	IF "%_DHCP%"=="No" Then

	set dnsserver=178.22.122.100
	set dnsserver2=185.51.200.2
	for /f "tokens=1,2,3*" %%i in ('netsh interface show interface') do (
		if %%i EQU Enabled (
			netsh interface ipv4 set dnsserver name="%%l" dhcp >log.txt
		)
	)

	call :colorEcho 0c "DNS is disabled"
	
	
  goto:eof
  
:colorEcho
echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto:eof
