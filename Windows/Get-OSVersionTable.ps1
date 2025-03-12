function Get-OSVersionTable {
<#
.SYNOPSIS
    Get a list of all Windows Versions
.DESCRIPTION
    Simple table of all builds since Windows 7
.NOTES
    Can be edited in Excel and updated as text below.
.LINK
    https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
.EXAMPLE
    get-osversiontable  | Where-Object Name -like '*server*' | where-object { [datetime]$_.'End of Support' -gt [DateTime]::now } | ft 
    Show all Server builds that are still supported. 
#>

@"
Name	Codename	Release date	Version	Editions Old	Build number	Architecture	End of support
Windows 7	Windows 7	22-Oct-09	NT 6.1	Windows 7 Starter,Windows 7 Home Basic,Windows 7 Home Premium,Windows 7 Professional,Windows 7 Enterprise,Windows 7 Ultimate	7601	IA-32,x86-64	14-Jan-20
Windows 8	Windows 8	26-Oct-12	NT 6.2	Windows 8,Windows 8 Pro,Windows 8 Enterprise	9200	IA-32,x86-64	12-Jan-16
Windows 8.1	Blue	17-Oct-13	NT 6.3	Windows 8.1,Windows 8.1 Pro,Windows 8.1 Enterprise	9600	IA-32,x86-64	10-Jan-23
Windows 10	Threshold	29-Jul-15	1507	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	10240	IA-32,x86-64	9-May-17
Windows 10 version 1511	Threshold 2	10-Nov-15	1511	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	10586	IA-32,x86-64	10-Oct-17
Windows 10 version 1607	Redstone 1	2-Aug-16	1607	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	14393	IA-32,x86-64	10-Apr-18
Windows 10 version 1703	Redstone 2	5-Apr-17	1703	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	15063	IA-32,x86-64	9-Oct-18
Windows 10 version 1709	Redstone 3	17-Oct-17	1709	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	16299	IA-32,x86-64	9-Apr-19
Windows 10 version 1803	Redstone 4	30-Apr-18	1803	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	17134	IA-32,x86-64	12-Nov-19
Windows 10 version 1809	Redstone 5	13-Nov-18	1809	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	17763	IA-32,x86-64	10-Nov-20
Windows 10 version 1903	19H1	21-May-19	1903	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	18362	IA-32,x86-64	8-Dec-20
Windows 10 version 1909	Vanadium	12-Nov-19	1909	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	18363	IA-32,x86-64	11-May-21
Windows 10 version 2004	Vibranium	27-May-20	2004	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	19041	IA-32,x86-64	14-Dec-21
Windows 10 version 20H2		20-Oct-20	20H2	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	19042	IA-32,x86-64	9-Aug-22
Windows 10 version 21H1		18-May-21	21H1	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	19043	IA-32,x86-64	13-Dec-22
Windows 10 version 21H2		16-Nov-21	21H2	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	19044	IA-32,x86-64	13-Jun-23
Windows 10 version 22H2		18-Oct-22	22H2	Windows 10 Home,Windows 10 Pro,Windows 10 Education,Windows 10 Enterprise,Windows 10 Pro for Workstations,Windows 10 Pro Education,Windows 10 S,Windows 10 Enterprise LTSC	19045	IA-32,x86-64,ARM64	14-Oct-25
Windows 11	Cobalt	4-Oct-21	21H2	Windows 11 Home,Windows 11 Pro,Windows 11 Pro for Workstations,Windows 11 Pro Education,Windows 11 Education,Windows 11 Enterprise,Windows 11 SE	22000	x86-64,ARM64	10-Oct-23
Windows 11 version 22H2	Nickel	20-Sep-22	22H2	Windows 11 Home,Windows 11 Pro,Windows 11 Pro for Workstations,Windows 11 Pro Education,Windows 11 Education,Windows 11 Enterprise,Windows 11 SE	22621	x86-64,ARM64	8-Oct-24
Windows 11 version 23H2		31-Oct-23	23H2	Windows 11 Home,Windows 11 Pro,Windows 11 Pro for Workstations,Windows 11 Pro Education,Windows 11 Education,Windows 11 Enterprise,Windows 11 SE	22631	x86-64,ARM64	11-Nov-25
Windows 11 version 24H2	Germanium	1-Oct-24	24H2	Windows 11 Home,Windows 11 Pro,Windows 11 Pro for Workstations,Windows 11 Pro Education,Windows 11 Education,Windows 11 Enterprise,Windows 11 SE	26100	x86-64,ARM64	13-Oct-26
Windows Server 2008 R2	Windows Server 7	22-Oct-09	NT 6.1	Windows Server Foundation,Windows Server Standard,Windows Server Enterprise,Windows Server Datacenter,Windows Server for Itanium-based Systems,Windows Storage Server,Windows Web Server	7601	x86-64,Itanium	14-Jan-20
Windows Server 2012	Windows Server 8	4-Sep-12	NT 6.2	Windows Server Foundation,Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	9200	x86-64	10-Oct-23
Windows Server 2012 R2	Windows Server Blue	17-Oct-13	NT 6.3	Windows Server Foundation,Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	9600	x86-64	10-Oct-23
Windows Server 2016	Redstone	12-Oct-16	1607	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	14393	x86-64	12-Jan-27
Windows Server,version 1709	Redstone 3	17-Oct-17	1709	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	16299	x86-64	9-Apr-19
Windows Server,version 1803	Redstone 4	30-Apr-18	1803	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	17134	x86-64	12-Nov-19
Windows Server,version 1809	Redstone 5	13-Nov-18	1809	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	17763	x86-64	10-Nov-20
Windows Server 2019	Redstone 5	13-Nov-18	1809	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	17763	x86-64	9-Jan-29
Windows Server,version 1903	Redstone 5	21-May-19	1903	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	18362	x86-64	8-Dec-20
Windows Server,version 1909	Vanadium	12-Nov-19	1909	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	18363	x86-64	11-May-21
Windows Server,version 2004	Vibranium	26-Jun-20	2004	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	19041	x86-64	14-Dec-21
Windows Server,version 24H2	Iron	20-Oct-20	20H2	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	19042	x86-64	9-Aug-22
Windows Server 2022	Vibranium	18-Aug-21	21H2	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	20348	x86-64	14-Oct-31
Windows Server,version 23H2	Zinc	14-Oct-23	23H2	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	25398	x86-64	24-Oct-25
Windows Server 2025	Germanium	1-Nov-24	24H2	Windows Server Essentials,Windows Server Standard,Windows Server Datacenter	26100	x86-64,ARM64	10-Oct-34
"@ | ConvertFrom-Csv -Delimiter "`t" | Write-Output

}