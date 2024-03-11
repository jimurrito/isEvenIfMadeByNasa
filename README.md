# IsEven If Made by Nasa
Nasa has mentioned in the past that most of thier code logic is based on large blocks of if/then statements. This helps avoid issues when your software is in deep space, but does not really make for streamlined control flow.

I was inspired after reading this [blog by andreasjhkarlsson](https://andreasjhkarlsson.github.io//jekyll/update/2023/12/27/4-billion-if-statements.html). They created a C program that I feel embodies the Nasa ideology to a 'Tee'. With this new found inspiration, I wanted to go one step further. See how many languages we can write this type of logic; all while using methods of metaprograming.

Please enjoy this abomination. ❤️

## Powershell

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
| Bit | Size on disk | Time to Generate |
| --- | --- | --- |
| 1 | 254B | 0.0087087s |
| 2 | 308B | 0.0105919s |
| 4 | 646B | 0.2907829s |
| 8 | 7.46KB | 2.3082085s |
| 16 | 2.02MB | 5286.97019s (81 Minutes) |

<br>

---

### More Languages to come....