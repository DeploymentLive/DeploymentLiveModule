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

    $builder = New-Object System.Text.StringBuilder $Size
    [ProfileApi]::GetPrivateProfileString($category, $key, "", $builder, $builder.Capacity, $path) | Out-Null
    return $builder.ToString()

}