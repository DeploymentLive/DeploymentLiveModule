<#
.SYNOPSIS
    Compile the DeploymentLive Module into a single library file.
.DESCRIPTION
    Will combine the DeploymentLive Module into a single library file:
    * A single file allows for faster loading.
    * With Module Manifest.
    * Script Info.
    * Within a single file for easy signing.
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
    [string[]] $Exclude = @('*.ignore','DeploymentLive','.vscode')
)

$ScriptDir = '.'
if ( $PSScriptRoot -ne $null ) { $ScriptDir = $PSScriptRoot }
$sb = New-Object System.Text.StringBuilder

#region Create Header

$ModuleVersion = '1.2.3.4'

$ModuleArguments = @{
    Author = "Keith Garner (KeithGa@DeploymentLive.com)"
    CompanyName  = "Deployment Live LLC" 
    Copyright = "Copyright Deployment Live LLC, all Rights Reserved."
    GUID = [GUID]'7a98a3d7-8132-4442-bc3e-ed3e731848d1'
    Description = "DeploymentLive Common PowerShell Library"
    projectURI = 'https://github.com/DeploymentLive/DeploymentLiveModule'
    LicenseURI = 'https://opensource.org/license/mit'
}

$SB.AppendLine( (new-ScriptFileInfo @ModuleArguments  -version $ModuleVersion -force -PassThru) ) | write-verbose

#endregion 

#region Enumerate through all functions
$FunctionList = @()

foreach ( $Directory in get-childitem $ScriptDir -directory -exclude $Exclude ) {

    $Sb.AppendLine("`r`n#Region $($Directory.BaseName)`r`n") | write-verbose

    foreach ( $File in get-childitem -path "$Directory\*.ps1" -recurse -exclude *.tests.ps1,*.templates.ps1) {
        write-verbose "Import Script: $($File.FullName)"
        if ( -not $File.Name.EndsWith('.private.ps1' ) ) {
            $FunctionList += $File.BaseName
        }
        $sb.appendLine( (get-content -raw $File.FullName) ) | write-verbose
    }

    $Sb.AppendLine("`r`n#endregion") | Write-verbose

}

$Sb.AppendLine("`r`n`$FunctionList = @('$( $FunctionList -join ''',''')')")  | write-verbose
$Sb.AppendLine('Export-ModuleMember -Function $FunctionList -Alias *') | write-verbose 
#endregion 

#region Start Creating Files

$TargetPath = "$ScriptDir\DeploymentLive"
if ( -not ( test-path $TargetPath ) ) {
    new-item -ItemType Directory -Path $TargetPath -force -ErrorAction SilentlyContinue | write-verbose
}

$sb.ToString() | out-file -Encoding ascii -FilePath "$TargetPath\DeploymentLive.psm1"
#endregion

#region Create Module Manifest

$ManifestArguments  = @{
    ModuleVersion = $ModuleVersion
    Path = "$TargetPath\DeploymentLive.psd1"
    FunctionsToExport = '*' # $FunctionList
     RootModule = 'DeploymentLive.psm1'
}

New-ModuleManifest @ModuleArguments @ManifestArguments

#endregion 

#region Sign



#endregion
