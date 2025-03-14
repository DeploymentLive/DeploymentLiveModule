<#
.SYNOPSIS
    Support Routines for INI files
.DESCRIPTION
    C# class and Pinvoke classes to make Win32 API calls.
.NOTES
    WritePrivateProfileSection Not Implemented yet. 
    Need wrapper for String[] to Zero Terminated String Array.
    Instead, use multiple calls to WritePrivateProfileString() 
#>

Add-Type @'
using System; 
using System.Collections.Generic; 
using System.Text; 
using System.Runtime.InteropServices; 

public class ProfileAPI { 

    // WritePrivateProfileSection too hard. Need wrapper for String[] to Zero Terminated String Array.
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] 
    private static extern bool WritePrivateProfileSection( 
        string lpAppName, 
        string lpString,
        string lpFileName
    ); 

    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] 
    [return: MarshalAs(UnmanagedType.Bool)] 
    public static extern bool WritePrivateProfileString( 
        string lpAppName, 
        string lpKeyName, 
        string lpString, 
        string lpFileName);
     
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] 
    private static extern uint GetPrivateProfileSectionNames(
        IntPtr lpReturnedString, 
        uint nSize, 
        string lpFileName); 
     
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] 
    private static extern uint GetPrivateProfileSection(
        string lpAppName, 
        IntPtr lpReturnedString, 
        uint nSize, 
        string lpFileName); 
     
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] 
    public static extern uint GetPrivateProfileString( 
        string lpAppName, 
        string lpKeyName, 
        string lpDefault, 
        StringBuilder lpReturnedString, 
        uint nSize, 
        string lpFileName); 

    private static string[] ConvertBufferToStringArray( IntPtr pReturnedString, uint bytesReturned ) {
        if (bytesReturned == 0) { 
            Marshal.FreeCoTaskMem(pReturnedString); 
            return null; 
        } 
        string text = Marshal.PtrToStringAuto(pReturnedString, (int)bytesReturned).ToString(); 
        Marshal.FreeCoTaskMem(pReturnedString); 
		char[] separator = new char[1] { '\x0' };
		return text.Split(separator, System.StringSplitOptions.RemoveEmptyEntries);
    }
    
    public static string[] GetSectionNames(string iniFile) { 
        uint MAX_BUFFER = 32767; 
        IntPtr pReturnedString = Marshal.AllocCoTaskMem((int)MAX_BUFFER); 
        uint bytesReturned = GetPrivateProfileSectionNames(pReturnedString, MAX_BUFFER, iniFile); 
        return ConvertBufferToStringArray ( pReturnedString, bytesReturned );
    } 
     
    public static string[] GetSection(string iniFilePath, string sectionName) { 
        uint MAX_BUFFER = 32767; 
        IntPtr pReturnedString = Marshal.AllocCoTaskMem((int)MAX_BUFFER); 
        uint bytesReturned = GetPrivateProfileSection(sectionName, pReturnedString, MAX_BUFFER, iniFilePath); 
        return ConvertBufferToStringArray ( pReturnedString, bytesReturned );
    } 
     
} 
'@