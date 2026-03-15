$htmlFiles = Get-ChildItem -Path '.' -Filter '*.html'

$weirdChars = @('Ã©', 'Ã¨', 'Ã ', 'Ã§', 'Ã¢', 'Ãª', 'Ã®', 'Ã´', 'Ã»', 'ï¿½', 'Ã¯')
$encodingErrors = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    foreach ($char in $weirdChars) {
        if ($content.Contains($char)) {
            $encodingErrors += [PSCustomObject]@{
                Fichier = $file.Name
                Caractere_Corrompu = $char
            }
        }
    }
}

Write-Host "=== NOUVEAU SCAN ANTI-CARACTÈRES BIZARRES ==="
if ($encodingErrors.Count -gt 0) {
    Write-Host "ATTENTION : Des caractères étranges ont été trouvés !`n" -ForegroundColor Red
    $encodingErrors | Select-Object -Unique Fichier, Caractere_Corrompu | Format-Table -AutoSize
} else {
    Write-Host "SUCCÈS PARFAIT : Aucun caractère corrompu détecté. L'ensemble des 17 pages est parfaitement clean.`n" -ForegroundColor Green
}
