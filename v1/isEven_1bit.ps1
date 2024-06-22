<#
.Description
IsEven, but in the worst possible way.
#>

param (
    $In = $1
)

if ($In -eq 0) {$true}
elseif ($In -eq 1) {$False}
elseif ($In -eq 2) {$True}
else {Write-Error "Number is waay too big!"}
# Operation took 0.0087087 Seconds.
