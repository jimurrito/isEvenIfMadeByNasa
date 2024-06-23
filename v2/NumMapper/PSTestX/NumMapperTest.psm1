#
#using module PSTestLib
import-module "$PSScriptRoot\..\NumMapper.psm1"
#

function Test-SingleDigit {
    [PSTest(1,{$r -eq "one"})]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}

function Test-Twelve {
    [PSTest(12,{$r -eq "twelve"})]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-Twenty {
    [PSTest(20,{$r -eq "twenty"})]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-OneHun {
    [PSTest(100, { $r -eq "one-hundred" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-OneHunAndOne {
    [PSTest(101, { $r -eq "one-hundred-and-one" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-OneHunEleven {
    [PSTest(111, { $r -eq "one-hundred-eleven" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-OneHuntwenty {
    [PSTest(120, { $r -eq "one-hundred-twenty" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-Biggest {
    [PSTest(2147483647, { $r -eq "two-billion-one-hundred-forty-seven-million-four-hundred-eighty-three-thousand-six-hundred-forty-seven" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}