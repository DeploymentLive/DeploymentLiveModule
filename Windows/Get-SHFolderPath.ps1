function Get-SHFolderPath {
    <#
    .SYNOPSIS
        Get a Folder path from the Shell
    .DESCRIPTION
        Some functions here that are not available in [environment]::GetFolderPath() 
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        https://learn.microsoft.com/en-us/windows/win32/shell/knownfolderid
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    [cmdletbinding()]
    param(
        [guid] $FolderGUID
    )

    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class KnownFolders {
        [DllImport("shell32.dll")]
        private static extern int SHGetKnownFolderPath(
                [MarshalAs(UnmanagedType.LPStruct)] 
                Guid rfid,
                uint dwFlags,
                IntPtr hToken,
                out IntPtr pszPath
            );

        public static string GetPath(string knownFolderId) {
            Guid guid = new Guid(knownFolderId);
            IntPtr outPath;
            int hresult = SHGetKnownFolderPath(guid, 0, IntPtr.Zero, out outPath);
            if (hresult >= 0) {
                string path = Marshal.PtrToStringUni(outPath);
                Marshal.FreeCoTaskMem(outPath);
                return path;
            }
            throw new Exception("SHGetKnownFolderPath failed with code " + hresult);
        }
    }
"@

    [KnownFolders]::GetPath( $guid.ToString('B').Toupper()) 

}

