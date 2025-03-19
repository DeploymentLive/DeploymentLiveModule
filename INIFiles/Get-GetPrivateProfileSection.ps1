function Get-GetPrivateProfileSection {
    <#
    .SYNOPSIS
        Get an array of Section values from INI file
    .DESCRIPTION
        Get section values using the GetPrivateProfileSection() windows API.
    .NOTES
        Useful in parsing INI files using Standard API's
    #>
    [cmdletbinding()]
    param(
        $Path,
        $Section
    )

    return [ProfileApi]::GetSection( $path, $Section) 

}