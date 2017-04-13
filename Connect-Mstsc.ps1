

function Connect-Mstsc {

    param (
        [Parameter(Mandatory=$true,Position=0)]
        [Alias("CN")]
            [string[]]$ComputerName,
        [Parameter(Mandatory=$true,Position=1)]
        [Alias("U")] 
            [string]$User,
        [Parameter(Mandatory=$true,Position=2)]
        [Alias("P")] 
            [string]$Password
    )

    process {
        foreach ($Computer in $ComputerName) {
            $ProcessInfo = New-Object System.Diagnostics.ProcessStartInfo
            $Process = New-Object System.Diagnostics.Process

            $ProcessInfo.FileName = "$($env:SystemRoot)\system32\cmdkey.exe"
            $ProcessInfo.Arguments = "/generic:TERMSRV/$Computer /user:$User /pass:$Password"
            $Process.StartInfo = $ProcessInfo
            $Process.Start()

            $ProcessInfo.FileName = "$($env:SystemRoot)\system32\mstsc.exe"
            $ProcessInfo.Arguments = "/v $Computer"
            $Process.StartInfo = $ProcessInfo
            $Process.Start()
        }
    }
}