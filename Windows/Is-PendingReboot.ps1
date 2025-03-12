function Test-PendingReboot {

    <#
    .SYNOPSIS
        Test the pending reboot status on a local and/or remote computer.
    .DESCRIPTION
        Returns $false if nothing is pending...

        This function will query the registry on a local and/or remote computer and determine if the
        system is pending a reboot, from Microsoft/Windows updates, Configuration Manager Client SDK, Pending
        Computer Rename, Domain Join, Pending File Rename Operations and Component Based Servicing.

        ComponentBasedServicing = Component Based Servicing
        WindowsUpdate = Windows Update / Auto Update
        CCMClientSDK = SCCM 2012 Clients only (DetermineifRebootPending method) otherwise $null value
        PendingFileRenameOperations = PendingFileRenameOperations, when this property returns true,
                                    it can be a false positive
        PendingFileRenameOperationsValue = PendingFilerenameOperations registry value; used to filter if need be,
                                        Anti-Virus will leverage this key property for def/dat removal,
                                        giving a false positive

    .LINK
        https://www.powershellgallery.com/packages/PendingReboot/0.9.0.6/Content/pendingreboot.psm1 
        https://gist.github.com/altrive/5329377
        https://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542
    .EXAMPLE
        Test-PendingRebootStep -Verbose
        Test for any pending reboots.
    #>

    [CmdletBinding()]
    param()

    if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { 
        write-verbose "Found RebootPending"
        return $true 
    }

    if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { 
        write-verbose "Found RebootRequired"
        return $true 
    }

    if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) {
        write-verbose "Found PendingFileRenameOperations"
        return $true 
    }

    try { 
        $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
        $status = $util.DetermineIfRebootPending()
        if(($status -ne $null) -and $status.RebootPending){
            Write-Verbose "Found ConfigMgr RebootPending"
            return $true
        }
    }catch{}

    return $false

}
