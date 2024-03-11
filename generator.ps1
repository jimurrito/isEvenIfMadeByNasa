param (
    $ExpoLimit = 8
)

Import-Module -Name "$PSScriptRoot\Powershell\ps_gen.psm1"


# Generate Powershell version
New-PowershellScript -ExpoLimit $ExpoLimit