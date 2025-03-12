function Get-PrivateProfileString {
    <#
    .SYNOPSIS
        Get a string from an INI file
    .DESCRIPTION
        Get a string using the GetPrivateProfile() windows API.
    .NOTES
        Useful in parsing INI files using Standard API's
    #>
    [cmdletbinding()]
    param(
        $Path,
        $Section,
        $Key,
        $Size = (1024 * 10)
    )

    $signature = @'
    [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
    public static extern uint GetPrivateProfileString(
        string lpAppName,
        string lpKeyName,
        string lpDefault,
        StringBuilder lpReturnedString,
        uint nSize,
        string lpFileName);
'@

    ## Create a new type that lets us access the Windows API function
    $Win32 = Add-Type -MemberDefinition $signature -Name Win32Utils -Namespace GetPrivateProfileString -Using System.Text  -PassThru

    $builder = New-Object System.Text.StringBuilder $Size
    $Win32::GetPrivateProfileString($category, $key, "", $builder, $builder.Capacity, $path) | Out-Null
    return $builder.ToString()

}