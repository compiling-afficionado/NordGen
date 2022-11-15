param([Parameter(Position=0, Mandatory=$true)][string]$hostname, [Parameter(Position=1, Mandatory=$true)][int]$start, [Parameter(Position=2, Mandatory=$true)][int]$end)

for($num=$start; $num -le $end; $num++){
    #$dname = nslookup.exe $hostname$num.nordvpn.com
    try {
        ($dname = nslookup.exe $hostname$num.nordvpn.com) 2> $null | Out-Null
        $dname = ($dname | Select-String Address | Where-Object LineNumber -eq 5).ToString().Split(' ')[-1]
        $output = "$hostname$num.nordvpn.com,$dname"
        $output | Out-File -append $PSScriptRoot/$hostname.csv
    }
    catch {
    }
}