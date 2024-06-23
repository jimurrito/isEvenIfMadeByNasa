param([int]$int)
if($int-eq0){return $true}
elseif(1..256 -contains $int){return & "$PSScriptRoot/86753c43-3a17-4617-818d-787146a77c1c/86753c43-3a17-4617-818d-787146a77c1c.ps1" $int}
