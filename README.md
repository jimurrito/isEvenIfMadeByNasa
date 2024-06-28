# IsEven If Made by Nasa
Nasa has mentioned in the past that most of their code logic is based on large blocks of if/then statements. This helps avoid issues when your software is in deep space, but does not really make for streamlined control flow.

I was inspired after reading this [blog by andreasjhkarlsson](https://andreasjhkarlsson.github.io//jekyll/update/2023/12/27/4-billion-if-statements.html). They created a C program that I feel embodies the Nasa ideology to a 'Tee'. With this new found inspiration, I wanted to go one step further; all while using methods of meta-programming.

Please enjoy this abomination. ❤️

> **Update**
> 
> Version 2 now supports `[int64]`. All numbers up to `63`, should work as an exponent. Unable to get `2^64 -1` to work without an overflow. Script is hard-limited to `63` as the highest value for `-EXPO` for now.
>

## [Version 2](./v2/)

```powershell
# allows the script to process all 16-bit numbers
./v2/Generator.ps1 -Expo 16 

# Output
Generation Runtime: (0)m (30)s (506)ms
(433) Files created. (131939) Lines Written
```
```powershell
./is_even.ps1 69 # $false
```

Generates a set of files and folders to check if a number is even.
```directory
|-<OutputDir>
    |-0d042676-d2fa-4838-aa82-2fb91651dc77
    |   |-0d042676-d2fa-4838-aa82-2fb91651dc77.ps1
    |   |-0d042676-d2fa-4838-aa82-2fb91651dc77.psm1
    |-f81ea0e5-a6a8-4733-a220-d7ed15156fa0
    |   |-f81ea0e5-a6a8-4733-a220-d7ed15156fa0.ps1
    |   |-f81ea0e5-a6a8-4733-a220-d7ed15156fa0.psm1
    |-<...>
    |
    |-is_even.ps1
```

Each guid-named folder contains a script (.ps1) and a module (.psm1).
Each set will handle a slice of numbers

The module (.psm1) files contain functions that map a number to a boolean output. Using the locally available [`NumMapper`](v2/NumMapper/README.md) module, we map the input integer to its written representation.

#### *<f81ea0e5-a6a8-4733-a220-d7ed15156fa0.psm1>*
```powershell
# ...
function test-fifty_three_thousand_six_hundred_sixty([int]$int){if(53660-eq$int){return $True}}
function test-fifty_three_thousand_six_hundred_sixty_one([int]$int){if(53661-eq$int){return $False}}
function test-fifty_three_thousand_six_hundred_sixty_two([int]$int){if(53662-eq$int){return $True}}
function test-fifty_three_thousand_six_hundred_sixty_three([int]$int){if(53663-eq$int){return $False}}
function test-fifty_three_thousand_six_hundred_sixty_four([int]$int){if(53664-eq$int){return $True}}
function test-fifty_three_thousand_six_hundred_sixty_five([int]$int){if(53665-eq$int){return $False}}
function test-fifty_three_thousand_six_hundred_sixty_six([int]$int){if(53666-eq$int){return $True}}
function test-fifty_three_thousand_six_hundred_sixty_seven([int]$int){if(53667-eq$int){return $False}}
function test-fifty_three_thousand_six_hundred_sixty_eight([int]$int){if(53668-eq$int){return $True}}
function test-fifty_three_thousand_six_hundred_sixty_nine([int]$int){if(53669-eq$int){return $False}}
function test-fifty_three_thousand_six_hundred_seventy([int]$int){if(53670-eq$int){return $True}}
function test-fifty_three_thousand_six_hundred_seventy_one([int]$int){if(53671-eq$int){return $False}}
function test-fifty_three_thousand_six_hundred_seventy_two([int]$int){if(53672-eq$int){return $True}}
# ...
```

The script file (.ps1) will sort through these functions, to determine which one is relevant to the input.

#### *<f81ea0e5-a6a8-4733-a220-d7ed15156fa0.ps1>*
```Powershell
param([int]$int)
import-module "$PSScriptRoot/f81ea0e5-a6a8-4733-a220-d7ed15156fa0.psm1"
if(53660-eq$int){test-fifty_three_thousand_six_hundred_sixty($int)}
elseif(53661-eq$int){test-fifty_three_thousand_six_hundred_sixty_one($int)}
elseif(53662-eq$int){test-fifty_three_thousand_six_hundred_sixty_two($int)}
elseif(53663-eq$int){test-fifty_three_thousand_six_hundred_sixty_three($int)}
elseif(53664-eq$int){test-fifty_three_thousand_six_hundred_sixty_four($int)}
elseif(53665-eq$int){test-fifty_three_thousand_six_hundred_sixty_five($int)}
elseif(53666-eq$int){test-fifty_three_thousand_six_hundred_sixty_six($int)}
elseif(53667-eq$int){test-fifty_three_thousand_six_hundred_sixty_seven($int)}
elseif(53668-eq$int){test-fifty_three_thousand_six_hundred_sixty_eight($int)}
elseif(53669-eq$int){test-fifty_three_thousand_six_hundred_sixty_nine($int)}
elseif(53670-eq$int){test-fifty_three_thousand_six_hundred_seventy($int)}
elseif(53671-eq$int){test-fifty_three_thousand_six_hundred_seventy_one($int)}
elseif(53672-eq$int){test-fifty_three_thousand_six_hundred_seventy_two($int)}
# ...
```

Finally the entry point script, `is_even.ps1` evaluates which of these guid-name scripts needs to be ran.

#### *<is_even.ps1>*
```powershell
param([int]$int)
if($int-eq0){return $true}
elseif(1..404 -contains $int){return & "$PSScriptRoot/93e80f7f-374a-4370-a670-d0152ddb72be/93e80f7f-374a-4370-a670-d0152ddb72be.ps1" $int}
elseif(405..784 -contains $int){return & "$PSScriptRoot/cab1382a-fe59-428b-bb41-74b267723dc5/cab1382a-fe59-428b-bb41-74b267723dc5.ps1" $int}
elseif(785..1143 -contains $int){return & "$PSScriptRoot/1dda2406-ad50-4bba-b545-55230acd03cf/1dda2406-ad50-4bba-b545-55230acd03cf.ps1" $int}
elseif(1144..1466 -contains $int){return & "$PSScriptRoot/34a131ff-a524-4b96-bb58-2274ea35a5f2/34a131ff-a524-4b96-bb58-2274ea35a5f2.ps1" $int}
elseif(1467..1789 -contains $int){return & "$PSScriptRoot/cb7e63f0-6a03-4218-9d8f-44a95541397e/cb7e63f0-6a03-4218-9d8f-44a95541397e.ps1" $int}
elseif(1790..2115 -contains $int){return & "$PSScriptRoot/26f6eebe-1f3a-447f-996a-7e72dbc3cc0b/26f6eebe-1f3a-447f-996a-7e72dbc3cc0b.ps1" $int}
elseif(2116..2439 -contains $int){return & "$PSScriptRoot/46e87fc7-cb07-43be-9732-94707c272cd3/46e87fc7-cb07-43be-9732-94707c272cd3.ps1" $int}
elseif(2440..2762 -contains $int){return & "$PSScriptRoot/26640948-9fce-48cd-88b7-cecc5f0f92bb/26640948-9fce-48cd-88b7-cecc5f0f92bb.ps1" $int}
elseif(2763..3085 -contains $int){return & "$PSScriptRoot/e9f3a732-851d-4c12-bda9-070f4dfa7ea5/e9f3a732-851d-4c12-bda9-070f4dfa7ea5.ps1" $int}
elseif(3086..3403 -contains $int){return & "$PSScriptRoot/6e267dda-f1e4-4220-8d59-86a25692f61a/6e267dda-f1e4-4220-8d59-86a25692f61a.ps1" $int}
elseif(3404..3720 -contains $int){return & "$PSScriptRoot/e64bc788-6378-4814-81ce-d9292cc93b22/e64bc788-6378-4814-81ce-d9292cc93b22.ps1" $int}
elseif(3721..4036 -contains $int){return & "$PSScriptRoot/4e4bcdee-cab0-4f7e-8500-7af53871c118/4e4bcdee-cab0-4f7e-8500-7af53871c118.ps1" $int}
```

## Benchmarking
Using [`Benchmark.ps1`](Benchmark.ps1), we can generate the files and test how long it takes for each supported number to be calculated.

```powershell
./Benchmark.ps1 -EXPO 16

Generation Runtime: (0)m (30)s (506)ms
(433) Files created. (131939) Lines Written

Benchmark Runtime: (9)m (44)s (866)ms
Average Runtime: (6.31)ms
Longest Runtime: (177)ms
Shortest Runtime: (3)ms
```

In this example, we create a version of `is_even.ps1` that supports all numbers between 0 and 65535. Then, it tests all those same numbers as inputs to the script; tracking the time it takes to precess each operation.

## *SPEEEED*
This version is much faster than the older version, in terms of generation time. At small scopes, its worse. Larger numbers is where this version shines.

| Version | Bit-Size | Generation Time | Total Size |
| ------- | -------- | --------------- | ---------- |
| v1      | 2        | 0.00871s        | 254B       |
| v1      | 4        | 0.01059s        | 308B       |
| v1      | 8        | 0.29078s        | 646B       |
| v1      | 16       | 81 Minutes      | 2.02MB     |
| v2      | 2        | 0.0100s         | 677B       |
| v2      | 4        | 0.0112s         | 1.8KB      |
| v2      | 8        | 0.0701s         | 29.8KB     |
| v2      | 16       | 30.506s         | 2.19MB     |
| v2      | 32       | 52.7 Days       | 324GB      | 

Biggest standout being 16-bit.
`5286.970s > 30.506s` That is `~173 times` faster in v2.

>**Note:**
> 32-bit version will generate, but the resulting `is_even.ps1` file will not work. Executing it with any number will yield a stack-overflow. v3 will work to address this. v3 will create all code JIT (Just In Time) of the is_even calculation.


<br>

## [Version 1](./v1/)
#### Generates a Powershell script, validating all 8bit numbers by default. 

```Powershell
./generator.ps1
```

#### Custom Bit validation amount
```Powershell
# Validates all 5bit numbers.
./generator.ps1 -ExpoLimit 5
```

### Output Size Estimates
| Bit | Size on disk | Time to Generate         |
| --- | ------------ | ------------------------ |
| 1   | 254B         | 0.0087087s               |
| 2   | 308B         | 0.0105919s               |
| 4   | 646B         | 0.2907829s               |
| 8   | 7.46KB       | 2.3082085s               |
| 16  | 2.02MB       | 5286.97019s (81 Minutes) |