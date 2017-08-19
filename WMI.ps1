# Computer & Creds
$ComputerName = "Win2016SRV"
if(-NOT (Test-Connection -ComputerName $ComputerName -Quiet -Count 1)){Write-Error "No connection to $ComputerName"; Break;}
$Cred = Get-Credential

try {
    # WMI Option A
    $OSinfo = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName -Credential $Cred -Namespace "root/cimv2" |
    Select-Object Caption, OSArchitecture, BuildNumber, Version, @{LABEL='LastBootUpTime';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}

    # WMI Option B
    $ServicesQuery = "SELECT * FROM win32_Service `
                      WHERE NOT State='Stopped'"
    $Services = Get-WmiObject -Query $ServicesQuery -ComputerName $ComputerName -Credential $Cred -Namespace "root/cimv2" | Select-Object name, StartMode
}
catch {
    $ErrorMSG = "{0}`n{1}" -f $_.Exception.Message,$_.InvocationInfo.PositionMessage
    Write-Error $ErrorMSG
    Break;
}

# Format result
$Hash = [ordered] @{
    ComputerName = $ComputerName
    OS = $OSinfo.Caption
    Build = $OSinfo.BuildNumber
    Version = $OSinfo.Version
    Architecture = $OSinfo.OSArchitecture
    BootTime = $OSinfo.LastBootUpTime
    Started_Services = $Services
}

$ComputerInfo = New-Object PSObject -Property $Hash

<#
    Result:
    $ComputerInfo
    --------------
    ComputerName     : Win2016SRV
    OS               : Microsoft Windows Server 2016 Standard
    Build            : 14393
    Version          : 10.0.14393
    Architecture     : 64-bit
    BootTime         : 19/08/2017 18:36:13
    Started_Services : {@{name=BFE; StartMode=Auto}, @{name=CoreMessagingRegistrar; StartMode=Auto}, @{name=CryptSvc; StartMode=Auto}, @{name=DcomLaunch; StartMode=Auto}...}
    $ComputerInfo.Started_Services
    ------------------------------
    name                   StartMode
    ----                   ---------
    BFE                    Auto
    CoreMessagingRegistrar Auto
    CryptSvc               Auto
    DcomLaunch             Auto
    Dhcp                   Auto
    DiagTrack              Auto
    Dnscache               Auto
    DPS                    Auto
    EventLog               Auto
    EventSystem            Auto
    gpsvc                  Auto
    IKEEXT                 Auto
    iphlpsvc               Auto
    LanmanServer           Auto
    LanmanWorkstation      Auto
    lmhosts                Manual
    LSM                    Auto
    MpsSvc                 Auto
    MSDTC                  Auto
    netprofm               Manual
    NlaSvc                 Auto
    ETC ...
#>
