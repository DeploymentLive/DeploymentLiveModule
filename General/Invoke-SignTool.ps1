function Invoke-SignTool {
    <#
    .SYNOPSIS
        Run SignTool.exe
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    [cmdletbinding()]
    param(
                 $Cert,
        [string] $Path,
        [string] $Dest
    )

    #region Find openssl

    $SignTool = Find-LocalFile -Name "signtool.exe" -CommonLocation { "${env:ProgramFiles(x86)}\Windows Kits\10\bin\x64\signtool.exe" }

    #endregion

    #region Find Signing Key

    if ( $Cert -isnot [System.Security.Cryptography.X509Certificates.X509Certificate2] ) {
        # Just return the Cert object from the Cert: Store.
        $Cert = get-childitem cert:\* -CodeSigningCert -recurse | Select-object -first 1
    }

    #endregion

    if ( [string]::IsNullOrEmpty($Dest) ) {
        $newFiles = get-item $Path | Foreach-object FullName
    }
    else {
        $NewFiles = Copy-Item -path $path -dest $dest -force -PassThru | Foreach-object FullName
    }
    write-verbose "SignToolexe Sign /v /td sha256 /fd sha256 /sha1 $($Cert.Thumbprint) /t http://timestamp.digicert.com $($NewFiles -join ' ')"
    & $SignTool Sign /v /td sha256 /fd sha256 /sha1 $Cert.Thumbprint /tr http://timestamp.digicert.com $NewFiles

}
