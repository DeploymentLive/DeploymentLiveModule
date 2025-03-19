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
    Check the .\Version.clixml for the right version information
        <MajorVersionNumber>.<Year><Month>.<Date><Hour>.<BuildNumber>
#>

[cmdletbinding()]
param(
    [string[]] $Exclude = @('_notes','_release','.vscode'),
    [string] $ReleaseNotes,
    [string[]] $Tags
)

$ScriptDir = '.'
if ( $PSScriptRoot -ne $null ) { $ScriptDir = $PSScriptRoot }
$sb = New-Object System.Text.StringBuilder

import-module $Scriptdir\DeploymentLiveModule.psm1 -force

#Region Update Version Number

$Oldversion = import-clixml "$ScriptDir\Version.clixml"
$YearMonth = ([datetime]::now.year -2000) * 100 + [datetime]::now.month
$DayHour = ([datetime]::now.day) * 100 + [datetime]::now.hour
$NewVersion = [version]::new($OldVersion.Major,$YearMonth,$DayHour,$OldVersion.revision + 1)
$NewVersion | Export-Clixml "$ScriptDir\Version.clixml"
$NewVersion | write-verbose

#endregion

#region Create Header

$Description = @"
    Common routines required by various Deployment Live scripts.
.SYNOPSIS
    Deployment Live Common PowerShell Module.
.NOTES
    Although this module is avaiable with each function split into seperate *.ps1 files, 
    this Module is compiled here into a single *.psm1 file for the following reasons:
    * Makes Loading much quicker.
    * Standardized Versioning.
    * Makes signing easier.
.LINK
    https://github.com/DeploymentLive/DeploymentLiveModule
.EXAMPLE
    Import-Module DeploymentLive.psm1 -force
"@

$ModuleArguments = @{
    Author = "Keith Garner (KeithGa@DeploymentLive.com)"
    CompanyName  = "Deployment Live LLC" 
    Copyright = "Copyright Deployment Live LLC, all Rights Reserved."
    GUID = [GUID]'7a98a3d7-8132-4442-bc3e-ed3e731848d1'
    projectURI = 'https://github.com/DeploymentLive/DeploymentLiveModule'
    LicenseURI = 'https://opensource.org/license/mit'
}

$SB.AppendLine( (new-ScriptFileInfo @ModuleArguments -Description $Description -version $NewVersion -force -PassThru) ) | write-verbose

#endregion 

#region Enumerate through all functions
$FunctionList = @()

foreach ( $Directory in get-childitem $ScriptDir -directory -exclude $Exclude ) {

    $Sb.AppendLine("`r`n#Region $($Directory.BaseName)`r`n") | write-verbose

    foreach ( $File in get-childitem -path "$Directory\*.ps1" -recurse -exclude *.tests.ps1,*.templates.ps1,*.future.ps1) {
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

$TargetPath = "$ScriptDir\_Release"
if ( -not ( test-path $TargetPath ) ) {
    new-item -ItemType Directory -Path $TargetPath -force -ErrorAction SilentlyContinue | write-verbose
}

$sb.ToString() | out-file -Encoding ascii -FilePath "$TargetPath\DeploymentLive.psm1"
#endregion

#region Create Module Manifest

$ManifestArguments  = @{
    ModuleVersion = $NewVersion
    Path = "$TargetPath\DeploymentLive.psd1"
    FunctionsToExport = '*' # $FunctionList
    RootModule = 'DeploymentLive.psm1'
    Description = "Deployment Live Common PowerShell Module"
}

New-ModuleManifest @ModuleArguments @ManifestArguments

#endregion 

#region Full Sign

$cert = get-childitem cert:\* -CodeSigningCert -recurse | where-object Issuer -match '(DigiCert)' 

if ( $cert -ne $null ) {
    write-verbose "Version $NewVersion is ready to sign for production use."
    write-verbose "$TargetPath\DeploymentLive.psm1"
    Invoke-SignTool -Path "$TargetPath\DeploymentLive.psm1" -Cert $Cert
}

#endregion
