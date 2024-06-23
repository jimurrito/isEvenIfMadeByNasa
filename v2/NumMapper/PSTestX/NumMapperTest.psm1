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
    [PSTest(100, { $r -eq "one_hundred" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-OneHunAndOne {
    [PSTest(101, { $r -eq "one_hundred_and_one" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-OneHunEleven {
    [PSTest(111, { $r -eq "one_hundred_eleven" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-OneHuntwenty {
    [PSTest(120, { $r -eq "one_hundred_twenty" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-44000 {
    [PSTest(44000, { $r -eq "forty_four_thousand" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}
function Test-Biggest {
    [PSTest(2147483647, { $r -eq "two_billion_one_hundred_forty_seven_million_four_hundred_eighty_three_thousand_six_hundred_forty_seven" })]
    param (
        [int]$num
    )
    return Set-Number2Name $num
}