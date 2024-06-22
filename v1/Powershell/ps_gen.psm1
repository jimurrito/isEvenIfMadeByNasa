function New-PowershellScript {
    param (
        $ExpoLimit = 8
    )

    # Start timer
    $timer = [Diagnostics.Stopwatch]::StartNew()

    # Generate path
    $Path = "isEven_${ExpoLimit}bit.ps1"

    #  Create the file - overwites existing
    $null = New-Item -Name $Path -Force

    # Add prelude
    $prelude = Get-Content "$PSScriptRoot\prelude"
    Set-Content -Path $Path -Value $prelude

    # 
    foreach ($Num in 1..([bigint]::Pow(2, $ExpoLimit))) {
        # Is even check LOLz
        $isEven = (($Num % 2) -eq 0)

        $out = 'elseif ($In -eq ' + $Num + ') {$' + $isEven + '}'
        Add-Content -Path $Path -Value $out
    }
    
    #
    Add-Content -Path $Path -Value 'else {Write-Error "Number is waay too big!"}'

    # Stop timer
    $timer.stop()

    Write-Host ("Done. Operation took {0} Seconds." -f $timer.Elapsed.TotalSeconds)
    Add-Content -Path $Path -Value ("# Operation took {0} Seconds." -f $timer.Elapsed.TotalSeconds)
}