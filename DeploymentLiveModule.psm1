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
param()

    $ScriptDir = '.'
    if ( $PSScriptRoot -ne $null ) { $ScriptDir = $PSScriptRoot }
    
    $FunctionList = @()

    get-childitem $ScriptDir -directory -exclude *.ignore |
        get-childitem -recurse -exclude *.tests.ps1,*.templates.ps1 | 
        foreach-object { 
            write-host "Import Script: $($_.FullName)"
            if ( -not $_.Name.EndsWith('.private.ps1' ) ) {
                $FunctionList += $_.BaseName
            }
            . $_.FullName | out-null
        }

$FunctionList | Write-host
Export-ModuleMember -Function $FunctionList -Alias *

