Function Test-Elevated {
    <#
    .SYNOPSIS
        Tests to see if current process is elevated
    .DESCRIPTION
        Tests to see if current process is elevated
    .EXAMPLE
        Test-Elevated
    #>

    $wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp=new-object System.Security.Principal.WindowsPrincipal($wid)
    $prp.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}
