
function Invoke-OpenSSL {
    <#
    .Synopsis
       Call OpenSSL
    .DESCRIPTION
       Invoke SSL command
    .EXAMPLE
       invoke-OpenSSL ( "x509 -in .\myfile.crt -text" -split ' ' )
    .NOTES
        If you pass in  "-passout", "env:keypass" into the command list
        the script will put the SecureString Argument into to the environment for use. 
    #>
    [CmdletBinding()]
    Param (
        # Param1 help description
        [Parameter(Mandatory=$false,ValueFromPipeline=$true,Position=0)]
        [string[]] $Commands,
        [SecureString] $PassIn,
        [SecureString] $PassOut
    )

    #region Find openssl

    $OpenSSL = Find-LocalFile -Name "openssl.exe" -CommonLocation { (Get-ItemProperty -Path HKLM:\SOFTWARE\GitForWindows -ErrorAction SilentlyContinue ).InstallPath + "\usr\bin\openssl.exe" }

    #endregion 

    #region Populate environment with passwords.

    $PassInName = $null 
    $passOutName = $null
    for ( $i = 0; $i -le $commands.Length ; $i++ ) {
        if ( $commands[$i] -eq '-passin' -and $commands[$i+1].StartsWith('env:') ) { 
            write-verbose "PassIn: [$($commands[$i])] and [$($commands[$i+1])]   $($PassIn.GetType())"
            $PassInName = $commands[$i+1].Split(':')[1]
            set-item "env:$($PassInName)" -Value (New-Object PSCredential 0, $PassIn).GetNetworkCredential().Password
        }
        elseif ( $commands[$i] -eq '-passout' -and $commands[$i+1].StartsWith('env:') ) { 
            write-verbose "Passout: [$($commands[$i])] and [$($commands[$i+1])]   $($passOut.GetType())"
            $passOutName = $commands[$i+1].Split(':')[1]
            set-item "env:$($passOutName)" -Value (New-Object PSCredential 0, $passOut).GetNetworkCredential().Password
        }        
    }

    #endregion

    # Invoke OpenSSL.exe
    write-verbose "$OpenSSL $($commands -join ' ')"
    & $OpenSSL $commands | write-verbose
    $Result = $?
    
    if ( $PassInName -ne $null ) {
        remove-item "env:$($PassInName)"
    }
    if ( $passOutName -ne $null ) {
        remove-item "env:$($passOutName)"
    }

    return $Result
}