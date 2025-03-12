function Get-MSIProperties { 

    <#
    .SYNOPSIS
        Get Properties from a MSI file
    .DESCRIPTION
        Returns a list of properties from an MSI file. 
    .NOTES
    
    .EXAMPLE
    #>

    [cmdletbinding()]
    param(
        $path
    )
    
    write-verbose "Open MSI File: $Path"
    $WindowsInstaller = New-Object -com WindowsInstaller.Installer
    $MSIDatabase = $WindowsInstaller.GetType().InvokeMember("OpenDatabase","InvokeMethod",$Null,$WindowsInstaller,@($Path,0))
    if (-not $MSIDatabase ) { throw "Unable to open MSI file: $Path" }

    $View = $MSIDatabase.GetType().InvokeMember("OpenView","InvokeMethod",$null,$MSIDatabase,"SELECT * FROM Property") 
    $View.GetType().InvokeMember("Execute", "InvokeMethod", $null, $View, $null) | out-null
    while($Record = $View.GetType().InvokeMember("Fetch","InvokeMethod",$null,$View,$null)) 
    {
        @{ $Record.GetType().InvokeMember("StringData","GetProperty",$null,$Record,1) = 
           $Record.GetType().InvokeMember("StringData","GetProperty",$null,$Record,2)} | write-output
    }
    $View.GetType().InvokeMember("Close","InvokeMethod",$null,$View,$null) | out-null

}

