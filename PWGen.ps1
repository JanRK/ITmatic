$dicLanguage="da_DK"

if (!(Test-Path -Path "$env:temp\$dicLanguage.dic")) {Invoke-WebRequest -Uri "https://github.com/ONLYOFFICE/dictionaries/raw/master/$dicLanguage/$dicLanguage.dic" -OutFile "$env:temp\$dicLanguage.dic"}
$content = ( Get-Content $env:temp\$dicLanguage.dic | Out-String -Stream )
$content= $content -replace "/.*" -replace "-"
$words=$content | Where-Object { $_.Length -gt 3 } | Where-Object { $_.Length -lt 6 } | Select-String -Pattern "æ","ø","å","'","á","é","ú" -NotMatch

function Get-Word {
    $words[(Get-Random -Maximum $words.count)]
}

$output = @()
(1..20) | % { $output += [pscustomobject]@{'a'=(Get-Word);'b'=(Get-Word);'c'=(Get-Word);'d'=(Get-Word);'e'=(Get-Word);'f'=(Get-Word);'g'=(Get-Word);'h'=(Get-Word)} }
$output |format-table
Remove-Variable content
Remove-Variable words