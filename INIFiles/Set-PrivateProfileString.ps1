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

	[ProfileApi]::WritePrivateProfileString($Section, $key, $Value, $path) | Out-null
}
