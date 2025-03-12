
function Get-WindowOwner {
<#
.SYNOPSIS
    Get the handle of the window Owner
.DESCRIPTION
    Retrns a pointer to the window powershell is currently running from.
.NOTES
    Useful in MessageBox()
.EXAMPLE
    Get-WindowOwner
#>

    [cmdletbinding()]
    param()

    (get-process -id $Pid).MainWindowHandle

}
