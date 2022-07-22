
#$ipOrigem = (@(Invoke-WebRequest -Uri "checkip.amazonaws.com").RawContent -split "\n")[6];

while ($true) {
    $data = Get-Date -Format "yyyyMMdd";
    $hora = Get-Date -Format "HH:mm:ss";
    $tempoResp = 0;
    $perda = $false;
    $delay = 15; # aproximadamente 4
    $destinos = @(
        "aws.amazon.com", 
        "www.google.com", 
        "www.oracle.com", 
        "azure.microsoft.com", 
        "1.1.1.1", 
        "8.8.8.8", 
        "9.9.9.9",
        "208.67.222.222",
        "www.nytimes.com",
        "www.globo.com",
        "edition.cnn.com",
        "www.bbc.com",
        "elpais.com",
        "www.iana.org",
        "www.lacnic.net"
    );
    # $destinos = @(        
    #     "1.1.1.1", 
    #     "8.8.8.8", 
    #     "9.9.9.9",
    #     "208.67.222.222",
    #     "www.nytimes.com",
    #     "www.globo.com"
    # );
    $qtdSites = $destinos.Length;

    foreach ($destino in $destinos) {
        Start-Sleep ($delay / $qtdSites);

        try {
            $ping = Test-Connection -ComputerName $destino -Count 1 -ErrorAction stop;
            $tempoResp += $ping.ResponseTime;
        }
        catch {
            $perda = $true;
        }
    }
    
    if ($perda) {
        $tempoResp = 0;
    }
    else {
        $tempoResp = [int]($tempoResp / $qtdSites);
    }
       
    $retorno = Select-Object `
    @{ Name = "Hora"; Expression = { $hora } }, 
    @{ Name = "Media_ms"; Expression = { $tempoResp } } `
        -InputObject '';

    $retorno | Export-Csv -Append -Path ("C:\TI\Qualidade\qualidade_" + $data + ".csv") -NoTypeInformation
    #$retorno
}
