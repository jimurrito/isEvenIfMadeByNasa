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
elseif ($In -eq 3) {$False}
elseif ($In -eq 4) {$True}
elseif ($In -eq 5) {$False}
elseif ($In -eq 6) {$True}
elseif ($In -eq 7) {$False}
elseif ($In -eq 8) {$True}
elseif ($In -eq 9) {$False}
elseif ($In -eq 10) {$True}
elseif ($In -eq 11) {$False}
elseif ($In -eq 12) {$True}
elseif ($In -eq 13) {$False}
elseif ($In -eq 14) {$True}
elseif ($In -eq 15) {$False}
elseif ($In -eq 16) {$True}
else {Write-Error "Number is waay too big!"}
# Operation took 0.2907829 Seconds.
