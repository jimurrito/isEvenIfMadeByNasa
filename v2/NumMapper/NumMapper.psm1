#
#
#
<#
.DESCRIPTION
maps a number to a name.
[0] - hundreds
[1] - tens
[2] - ones
#>
function Set-OctetChar2Name {
    param (
        [char]$NumberChar,
        [int]$Place
    )
    # Ones
    if ($Place -eq 2) {
        switch ($NumberChar) {
            '1' { return "one" }
            '2' { return "two" }
            '3' { return "three" }
            '4' { return "four" }
            '5' { return "five" }
            '6' { return "six" }
            '7' { return "seven" }
            '8' { return "eight" }
            '9' { return "nine" }
            Default { return "" }
        }
    }
    # Tens
    elseif ($Place -eq 1) {
        switch ($NumberChar) {
            '1' { throw "Teen Num alert!" }
            '2' { return "twenty" }
            '3' { return "thirty" }
            '4' { return "forty" }
            '5' { return "fifty" }
            '6' { return "sixty" }
            '7' { return "seventy" }
            '8' { return "eighty" }
            '9' { return "ninety" }
            Default { "and" }
        }    
    }
    # Hundreds
    elseif ($Place -eq 0) {
        return "{0}-hundred" -f (Set-OctetChar2Name $NumberChar 2)
    }
    # throw
    else {
        throw "-Place overflow [$Place]"
    }
}
#
#
<#
.DESCRIPTION
Checks if an octet of characters contains a 2 char length number between 10 and 19
#>
function Find-TeenRangeNumbers {
    [OutputType([string])]
    param(
        [string]$octet
    )
    #
    $out = switch ($octet) {
        "10" { return "ten" }
        "11" { return "eleven" }
        "12" { return "twelve" }
        "13" { return "thirteen" }
        "14" { return "fourteen" }
        "15" { return "fifteen" }
        "16" { return "sixteen" }
        "17" { return "seventeen" }
        "18" { return "eighteen" }
        "19" { return "nineteen" }
        Default { throw "Bad Teen Num [$octet]" }
    }
    return $out
}
#
#
<#
.DESCRIPTION
Breaks a string into 3 char octets. 
#>
function Set-StringBreak {
    [OutputType([string[]])]
    param (
        [parameter(Mandatory = $true)]
        [string]$String,
        [char[]]$CAry = $String
    )
    # Set pointers
    $Max = $String.Length - 1
    $Min = $Max - 2
    # Init output
    [array]$Output = @()
    # Loopity loop
    while ($true) {
        if ($Min -lt 0) { $Min = 0 }
        # Grab slice
        [string]$slice = $String[$Min..$Max]
        # Add slice to output
        $Output += $slice -replace '\s', ''
        # escape check
        if ($Min -le 0) { break }
        # Iter array
        $Max -= 3
        $Min -= 3
    }
    # Reverse to get the array in proper order
    [array]::Reverse($Output)
    # Return output
    return $Output
}
#
#
<#
.DESCRIPTION
Breaks a string into 3 char octets. 
#>
function Find-OctetSize {
    param (
        [int]$oct
    )
    switch ($oct) {
        2 { "thousand" }
        3 { "million" }
        4 { "billion" }
        5 { "trillion" }
        6 { "quadrillion" }
        7 { "quintillion" }
        8 { "sextillion" }
        9 { "septillion" }
        10 { "octillion" }
        11 { "nonillion" }
        12 { "decillion" }
        13 { "undecillion" }
        14 { "duodecillion" }
        15 { "tredecillion" }
        16 { "quattuordecillion" }
        17 { "quindecillion" }
        18 { "sexdecillion" }
        19 { "septendecillion" }
        20 { "octodecillion" }
        21 { "novemdecillion" }
        22 { "vigintillion" }
        23 { "unvigintillion" }
        24 { "duovigintillion" }
        25 { "tresvigintillion" }
        26 { "quattuorvigintillion" }
        27 { "quinquavigintillion" }
        28 { "sesvigintillion" }
        29 { "septemvigintillion" }
        30 { "octovigintillion" }
        31 { "novemvigintillion" }
        32 { "trigintillion" }
        33 { "untrigintillion" }
        34 { "duotrigintillion" }
        35 { "trestrigintillion" }
        36 { "quattuortrigintillion" }
        37 { "quinquatrigintillion" }
        38 { "sestrigintillion" }
        39 { "septentrigintillion" }
        40 { "octotrigintillion" }
        41 { "novemtrigintillion" }
        42 { "quadragintillion" }
        43 { "unquadragintillion" }
        44 { "duoquadragintillion" }
        45 { "tresquadragintillion" }
        46 { "quattuorquadragintillion" }
        47 { "quinquaquadragintillion" }
        48 { "sesquadragintillion" }
        49 { "septenquadragintillion" }
        50 { "octoquadragintillion" }
        Default { return "" }
    }
}
#
#
<#
.DESCRIPTION
Processes integers into full length string names
#>
function Set-Number2Name {
    [OutputType([string])]
    param(
        [string]$Number,
        [string]$NumberWorking = ($Number -replace "\s", "")
    )
    # If whole number is one digit
    if ($NumberWorking.Length -eq 1) { return Set-OctetChar2Name $NumberWorking 2 }
    # If whole number is 0
    elseif ($NumberWorking -eq "0") { return "zero" }
    # If number is in Teen range
    elseif ($NumberWorking.Length -eq 2 -and $NumberWorking[0] -eq "1") { return Find-TeenRangeNumbers $NumberWorking }
    # Number is only two digits, not teen
    elseif ($NumberWorking.length -eq 2) { return Set-OctetChar2Name $NumberWorking[0] 1 }
    #
    # Value length is >=2 and not a teen number
    # Maps all octets to a value
    $Names = (Set-StringBreak $NumberWorking) | ForEach-Object {
        #
        # this processes a single octet
        #
        # Re assign iter
        $n = $_
        #
        # single number octet
        if ($n.Length -eq 1) { return Set-OctetChar2Name $n 2 }
        # Octet is only a teen num
        elseif ($n.Length -eq 2 -and $n[0] -eq "1") { return Find-TeenRangeNumbers $n }
        # Octet is only two digits, not teen
        elseif ($n.length -eq 2) { return "{0}-{1}" -f (Set-OctetChar2Name $n[0] 1), (Set-OctetChar2Name $n[1] 2) }
        # octet contains a teen num
        elseif ($n[1] -eq '1') {
            return ("{0}-{1}" -f (Set-OctetChar2Name $n[0] 0), (Find-TeenRangeNumbers ([string]($n[1, 2]) -replace "\s", "")))
        }
        # Octet is all 0s - return nothing
        elseif ($n[0] -eq '0' -and $n[1] -eq '0' -and $n[2] -eq '0') {
            return ""
        }
        # number is a whole hundred
        elseif ($n[1] -eq '0' -and $n[2] -eq '0') {
            return Set-OctetChar2Name $n[0] 0
        }
        #
        # iter octet to build number section
        $Place = -1
        [string[]]$applied = [char[]]$n | ForEach-Object {
            # remap
            $sn = $_
            # Iter place
            $Place += 1
            #
            # 2nd check for a teen
            if ($Place -eq 1 -and $sn -eq '1') {
                Write-Host ($n[$Place..($Place + 1)])
                return Find-TeenRangeNumbers ((($n[$Place..$Place + 1])) -replace "\s", "")
            }
            #
            return (Set-OctetChar2Name $sn $Place)
            #
        }
        # Joins octet | where-object { $_ } removes any possible null array values.
        return (($applied | where-object { $_ } ) -join "-")
        #
    }
    #
    # Single octet, 3-digit number escape
    if ($Names -is [string]) {
        return $Names
    }
    # ONLY APPLIES to lists of strings from here.
    #
    # Need to apply octet size values
    $length = $Names.Length
    #
    [array]::Reverse($Names);
    #
    # Assigne place value
    foreach ($i in 2..$length) { $Names[($i - 1)] = "{0}-{1}" -f $Names[($i - 1)], (Find-OctetSize $i) }
    #
    [array]::Reverse($Names);
    #
    return ($Names | where-object { $_ }) -join "-"
}