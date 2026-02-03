param(
    [string]$prefix,
    [string]$dns
)

for ($i = 1; $i -le 255; $i++) {
    $resolved = Resolve-DnsName -DnsOnly "$prefix.$i" -Server $dns -ErrorAction Ignore
    if ($resolved) {
        $namehost = $resolved.NameHost
        if ($namehost) {
            Write-Output "$prefix.$i $namehost"
        }
    }
}