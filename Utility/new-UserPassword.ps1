function New-UserPassword {
    <#
    .SYNOPSIS
        Create a new User Password
    .DESCRIPTION
        Create a Password that meets arbitrary complexity requirements.
    .NOTES
        The Complexity requirements fall into four classes:
        * Lowercase letters
        * Uppercase letters
        * Numbers
        * Non-Alphanumeric Characters
    .LINK
        http://technet.microsoft.com/en-us/library/hh994562(v=ws.10).aspx
    .EXAMPLE
        new-UserPassword -length 20 -complexity 4
        Create a new password that is 20 characters long, and has characters in all four classes.
    #>
    [cmdletbinding()]
    param(
        [ValidateRange(8,128)] [uint32] $Length = 10,
        $Complexity = 3
    )

    [Reflection.Assembly]::LoadWithPartialName("System.Web") | out-null
    do
    {
        $Pass = [System.Web.Security.Membership]::GeneratePassword($Length,2)
        $ComplexityCount = 0
        if ( $Pass -cmatch "\d") {$ComplexityCount++}
        if ( $Pass -cmatch "\W") {$ComplexityCount++}
        if ( $Pass -cmatch "[A-Z]") {$ComplexityCount++}
        if ( $Pass -cmatch "[a-z]") {$ComplexityCount++}
    }
    while ( $ComplexityCount -lt $Complexity )
    $Pass | Write-Output
}
