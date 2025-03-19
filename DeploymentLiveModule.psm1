<#
.SYNOPSIS
    Deployment Live PowerShell Module
.DESCRIPTION
    Script to import Deployment Live Common modules into PowerShell.
.NOTES
    This is the test/dev version. Is not signed.
    Use ".\Build.ps1" to create version that is ready for signing.
    Copyright Deployment Live LLC, All Rights Reserved.
.LINK
    https://github.com/DeploymentLive/DeploymentLiveModule
#>

[CmdletBinding()]
param(
    [string[]] $Exclude = @('*.ignore','DeploymentLive','.vscode')
)

    $ScriptDir = '.'
    if ( $PSScriptRoot -ne $null ) { $ScriptDir = $PSScriptRoot }
    
    $FunctionList = @()

    foreach ( $Directory in get-childitem $ScriptDir -directory -exclude $Exclude ) {
        foreach ( $File in get-childitem -path "$Directory\*.ps1" -recurse -exclude *.tests.ps1,*.templates.ps1) {
            write-verbose "Import Script: $($File.FullName)"
            if ( -not $File.Name.EndsWith('.private.ps1' ) ) {
                $FunctionList += $File.BaseName
            }
            . $File.FullName | out-null
        }
    }    

$FunctionList -join " " | Write-Verbose
Export-ModuleMember -Function $FunctionList -Alias *

