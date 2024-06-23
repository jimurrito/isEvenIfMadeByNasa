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
$MAX = ([Math]::Pow(2, $EXPO))
[int]$old_round = 0
#
Write-Progress -Activity "Benchmarking" -Status "0 of $Max completed" -PercentComplete 0
#
foreach ($n in 0..$MAX) {
    #
    # Handle progress bar rounding
    Write-Progress -Activity "Benchmarking" -Status "$n of $Max completed" -PercentComplete ([math]::Round(($n / $MAX) * 100))
    $old_round = $round
    #
    $StartTime = $TotalTimer.Elapsed
    #
    $output = (& $PATH2PS1 $n) -eq ($n % 2 -eq 0)
    # 
    $EndTime = $TotalTimer.Elapsed
    $El = $EndTime - $StartTime
    $BenchmarkLs += , @($n, $output, $El)
}
#
Write-Progress -Activity "Benchmarking" -Completed
# Make analytics
$TotalTime += $BenchmarkLs | ForEach-Object { return $_[2] }
#
$TotalTimer.Stop(); $Runtime = $TotalTimer.Elapsed
Write-Host ("`nBenchmark Runtime: ({0})m ({1})s ({2})ms" -f $Runtime.Minutes, $Runtime.Seconds, $Runtime.Milliseconds)
Write-Host ("Average Runtime: ({0})ms" -f ([math]::Round(($TotalTime.Milliseconds | Measure-Object -Average).Average, 2)))
Write-Host ("Longest Runtime: ({0})ms" -f ([math]::Round(($TotalTime.Milliseconds | Measure-Object -Maximum).Maximum, 2)))
Write-Host ("Shortest Runtime: ({0})ms`n" -f ([math]::Round(($TotalTime.Milliseconds | Measure-Object -Minimum).Minimum, 2)))