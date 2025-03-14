function Get-ProfileProfileSectionNames {
    <#
    .SYNOPSIS
        Get an array of Section Names from INI file
    .DESCRIPTION
        Get section names using the ProfileProfileSectionNames() windows API.
    .NOTES
        Useful in parsing INI files using Standard API's
    #>
    [cmdletbinding()]
    param(
        $Path
    )

    return [ProfileApi]::GetSectionNames( $path) 

}