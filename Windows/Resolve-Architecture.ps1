function Resolve-Architecture {
    <#
    .SYNOPSIS
        Resolves Architecture String into a normalized value
    .DESCRIPTION
        Converts most common architecture types into standard values. for x86,x64,arm32, and arm64 only.
    .NOTES
        You can output any table you want using the $Table paramater
    .LINK
        https://github.com/aaronparker/evergreen/blob/main/Evergreen/Private/Get-Architecture.ps1
    #>
    [cmdletbinding()]
    param (
        [string[]] $Table = @("x86","x64","arm32","arm64"),
        [Parameter(Mandatory = $True, Position = 0)]
        [String] $String
    )
    enum ArchState { x86; x64; arm32; arm64 }
    
    switch -regex ( $String.ToLower()) {
        "arm32"     { $architecture = $Table[[ArchState]::arm32]; break }
        "arm"       { $architecture = $Table[[ArchState]::arm32]; break }
        "aarch64"   { $architecture = $Table[[ArchState]::arm64]; break }
        "arm64"     { $architecture = $Table[[ArchState]::arm64]; break }
        "win-arm64" { $architecture = $Table[[ArchState]::arm64]; break }
        "amd64"     { $architecture = $Table[[ArchState]::x64]; break }
        "nt64"      { $architecture = $Table[[ArchState]::x64]; break }
        "nt32"      { $architecture = $Table[[ArchState]::x86]; break }
        "win64"     { $architecture = $Table[[ArchState]::x64]; break }
        "win32"     { $architecture = $Table[[ArchState]::x86]; break }
        "win-x64"   { $architecture = $Table[[ArchState]::x64]; break }
        "win-x86"   { $architecture = $Table[[ArchState]::x86]; break }
        "x86_64"    { $architecture = $Table[[ArchState]::x64]; break }
        "x64"       { $architecture = $Table[[ArchState]::x64]; break }
        "w64"       { $architecture = $Table[[ArchState]::x64]; break }
        "-64"       { $architecture = $Table[[ArchState]::x64]; break }
        "64-bit"    { $architecture = $Table[[ArchState]::x64]; break }
        "64bit"     { $architecture = $Table[[ArchState]::x64]; break }
        "32-bit"    { $architecture = $Table[[ArchState]::x86]; break }
        "32bit"     { $architecture = $Table[[ArchState]::x86]; break }
        "i386"      { $architecture = $Table[[ArchState]::x86]; break }
        "x32"       { $architecture = $Table[[ArchState]::x86]; break }
        "w32"       { $architecture = $Table[[ArchState]::x86]; break }
        "-32"       { $architecture = $Table[[ArchState]::x86]; break }
        "-x86"      { $architecture = $Table[[ArchState]::x86]; break }
        "x86"       { $architecture = $Table[[ArchState]::x86]; break }
        "e64\."     { $architecture = $Table[[ArchState]::x64]; break }

        default {
            Write-Verbose -Message "$($MyInvocation.MyCommand): Architecture not found in $String, defaulting to x86."
            $architecture = "x86"
        }
    }
    $architecture | write-output 
    
}