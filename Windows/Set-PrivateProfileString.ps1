function Set-PrivateProfileString {
    <#
    .SYNOPSIS
        Set a string in an INI file
    .DESCRIPTION
        Set a string using the SetPrivateProfile() windows API.
    .NOTES
        Useful in parsing INI files using Standard API's
    #>
    [cmdletbinding()]
    param(
        $Path,
        $Section,
        $Key,
        $Value
    )

    $signature = @'
	[DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
	public static extern bool WritePrivateProfileString(
	   string lpAppName,
	   string lpKeyName,
	   string lpString,
	   string lpFileName);
'@

    ## Create a new type that lets us access the Windows API function
    $Win32 = Add-Type -MemberDefinition $signature -Name Win32Utils -Namespace WritePrivateProfileString -PassThru

	$Win32::WritePrivateProfileString($Section, $key, $Value, $path) | Out-null
}
