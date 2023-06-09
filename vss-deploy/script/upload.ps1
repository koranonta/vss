try
{
    # Load WinSCP .NET assembly
    Add-Type -Path "WinSCPnet.dll"
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::FTP
        HostName = "202.129.16.74"
        UserName = "lapatprc"
        Password = "*kkvA9s8"
    }
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        $remotePath = "/app/node/"
 
        $lines = Get-Content "list.txt"
 
        foreach ($line in $lines)
        {
            Write-Host "Uploading $line ..."
            $session.PutFiles($line, $remotePath).Check()
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}