# is_even.ps1 bench marking
param (
    $EXPO = 10,
    #
    $PATH2PS1 = "$PSScriptRoot/is_even/is_even.ps1",
    $PATH2GEN = "$PSScriptRoot/v2/Generator.ps1"
)
#
# Run generator
& $PATH2GEN -EXPO $EXPO -ROOTDUMPDIR "$PSScriptRoot/is_even"
#
# benchmark all options
$TotalTimer = [System.Diagnostics.Stopwatch]::StartNew()
#
[array]$BenchmarkLs = @()
#
foreach ($n in 0..([Math]::Pow(2, $EXPO))) {
    #
    $StartTime = $TotalTimer.Elapsed
    #
    $output = (& $PATH2PS1 $n) -eq ($n % 2 -eq 0)
    # 
    $EndTime = $TotalTimer.Elapsed
    $El = $EndTime - $StartTime
    $BenchmarkLs += , @($n, $output, $El)
}
# Make analytics
$TotalTime += $BenchmarkLs | ForEach-Object { return $_[2] }
# write results
#$BenchmarkLs > "$PSScriptRoot/BenchMark_$EXPO.result"
#
$TotalTimer.Stop(); $Runtime = $TotalTimer.Elapsed
Write-Host ("`nBenchmark Runtime: ({0})m ({1})s ({2})ms" -f $Runtime.Minutes, $Runtime.Seconds, $Runtime.Milliseconds)
Write-Host ("Avgerage Runtime: ({0})ms" -f ([math]::Round(($TotalTime.Milliseconds | Measure-Object -Average).Average, 2)))
Write-Host ("Longest Runtime: ({0})ms" -f ([math]::Round(($TotalTime.Milliseconds | Measure-Object -Maximum).Maximum, 2)))
Write-Host ("Shortest Runtime: ({0})ms`n" -f ([math]::Round(($TotalTime.Milliseconds | Measure-Object -Minimum).Minimum, 2)))