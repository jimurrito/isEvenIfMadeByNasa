#
param(
    [int64]$EXPO = 10,
    [int64]$CHARLIMIT = 30000,
    #
    [string]$ROOTDUMPDIR = "$PSScriptRoot/is_even",
    [string]$ROOTFILEPATH = "$ROOTDUMPDIR/is_even.ps1",
    [array]$ROOTFILE_CONTENT = @('param([int64]$int)', 'if($int-eq0){return $true}')
    
)
#
import-module "$PSScriptRoot/NumMapper/NumMapper.psd1"
#
$TimerObj = [System.Diagnostics.Stopwatch]::StartNew()
#
# Builders
if ($EXPO -gt 63) { throw "Value provided for -EXPO is too high. Input should be '<=63'" }
[int64]$EXPO_TOTAL = ([bigint]::Pow(2, $EXPO)) - 1
#
# Used in iters
$ITER = 1
$FIRST_ITER = $ITER
$FUNCLIST = @()
$FUNCNAMELIST = @()
[string]$CURR_GUID = New-Guid
#
# Remove the old instance
Remove-Item $ROOTDUMPDIR -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
# create folder
new-item $ROOTDUMPDIR -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
# create file
new-item $ROOTFILEPATH -ItemType File -Force -ErrorAction SilentlyContinue | Out-Null
#
#
Write-Progress -Activity "Generating..." -Status "0 of $EXPO_TOTAL completed" -PercentComplete 0
#
# Iter all numbers
[int64]$ITER = 0
#foreach ($ITER in $HIGHLIMIT) {
while ($true) {
    #
    if ($ITER -eq $EXPO_TOTAL) { break }
    #
    # Handle progress bar rounding
    Write-Progress -Activity "Generating..." -Status "$ITER of $EXPO_TOTAL completed" -PercentComplete ([math]::Round([long](($ITER / $EXPO_TOTAL) * 100)))
    # State for potential unfinished blocks
    $RUNNING = $true
    # Make name for number
    $NumName = Set-Number2Name $ITER
    # function name
    $fncName = "test-$NumName"
    # Add to list
    $FUNCNAMELIST += , @($fncName, $ITER)
    # Generate named function - checks if number matches name, then checks if its true or false.
    $FUNCLIST += ('function {0}([int64]$int){{if({1}-eq$int){{return ${2}}}}}' -f $fncName, "$ITER", ($ITER % 2 -eq 0))
    # Check char length - if this eval true, save functions to file(s)
    if ( (($FUNCLIST -join "`n").Length) -ge $CHARLIMIT) {
        #
        # create folder for guid files
        new-item "$ROOTDUMPDIR/$CURR_GUID" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
        # create files (.psm1, ps1)
        new-item "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.psm1" -ItemType File -ErrorAction SilentlyContinue | Out-Null
        new-item "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.ps1" -ItemType File -ErrorAction SilentlyContinue | Out-Null
        # Write functions to module file (.psm1)
        Set-Content "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.psm1" -Value ($FUNCLIST -join "`n")
        #
        # Write to script file
        $scriptP = "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.ps1"
        # params
        $ScriptContent = @('param([int64]$int)')
        # Import statment
        $ScriptContent += ('import-module "$PSScriptRoot/{0}.psm1"' -f $CURR_GUID)
        #
        # Add initial if statment.
        $ScriptContent += ('if({0}-eq$int){{{1}($int)}}' -f $FUNCNAMELIST[0][1], $FUNCNAMELIST[0][0])
        # adds rest of the statements to the script file.
        foreach ($i in $FUNCNAMELIST[1..($FUNCNAMELIST.Length - 1)]) {
            $ScriptContent += ('elseif({0}-eq$int){{{1}($int)}}' -f $i[1], $i[0])
        }
        #
        # Add final statment
        $ScriptContent += 'else{return $false}'
        #
        Add-Content $scriptP -Value ($ScriptContent -join "`n")
        #
        # Add script call to root function list
        $ROOTFILE_CONTENT += ('elseif({0} -contains $int){{return & "$PSScriptRoot/{1}" $int}}' -f "$FIRST_ITER..$ITER", "$CURR_GUID/$CURR_GUID.ps1")
        #
        # clear fnc list(s)
        $FUNCLIST = @()
        $FUNCNAMELIST = @()
        $FIRST_ITER = $ITER + 1
        # generate new guid
        [string]$CURR_GUID = New-Guid
        # Sets this to false so we can know if we exited the loop prior to saving again
        $RUNNING = $false
    }
    #
    # Iter since we are returning to loop
    $ITER ++
    #
}
# Unwritten catch
if ($RUNNING) {
    #
    # create folder for guid files
    new-item "$ROOTDUMPDIR/$CURR_GUID" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    # create files (.psm1, ps1)
    new-item "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.psm1" -ItemType File -ErrorAction SilentlyContinue | Out-Null
    new-item "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.ps1" -ItemType File -ErrorAction SilentlyContinue | Out-Null
    # Write functions to module file (.psm1)
    Set-Content "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.psm1" -Value ($FUNCLIST -join "`n")
    #
    # Write to script file
    $scriptP = "$ROOTDUMPDIR/$CURR_GUID/$CURR_GUID.ps1"
    # params
    $ScriptContent = @('param([int64]$int)')
    # Import statment
    $ScriptContent += ('import-module "$PSScriptRoot/{0}.psm1"' -f $CURR_GUID)
    #
    # Add initial if statment.
    $ScriptContent += ('if({0}-eq$int){{{1}($int)}}' -f $FUNCNAMELIST[0][1], $FUNCNAMELIST[0][0])
    # adds rest of the statements to the script file.
    foreach ($i in $FUNCNAMELIST[1..($FUNCNAMELIST.Length - 1)]) {
        $ScriptContent += ('elseif({0}-eq$int){{{1}($int)}}' -f $i[1], $i[0])
    }
    #
    # Add final statment
    $ScriptContent += 'else{return $false}'
    #
    Add-Content $scriptP -Value ($ScriptContent -join "`n")
    #
    # Add script call to root function list
    $ROOTFILE_CONTENT += ('elseif({0} -contains $int){{return & "$PSScriptRoot/{1}" $int}}' -f "$FIRST_ITER..$ITER", "$CURR_GUID/$CURR_GUID.ps1")
    #
}
#
#
Write-Progress -Activity "Generating..." -Completed
#
#
$ROOTFILE_CONTENT += 'else{return $false}'
#
# write to root file
Add-Content $ROOTFILEPATH -Value ($ROOTFILE_CONTENT -join "`n")
#
# Stop Per
$TimerObj.Stop(); 
$Runtime = $TimerObj.Elapsed;
Write-Host ("`nGeneration Runtime: ({0})m ({1})s ({2})ms" -f $Runtime.Minutes, $Runtime.Seconds, $Runtime.Milliseconds) 
#
$allfiles = Get-ChildItem -path $ROOTDUMPDIR -Recurse -File
write-host ("({0}) Files created. ({1}) Lines Written" -f $allfiles.count, ($allfiles | ForEach-Object { $_ | Get-Content }).Count)
#