$htmlFiles = Get-ChildItem -Path '.' -Filter '*.html'
$brokenLinks = @()
$encodingErrors = @()
$checkedLinks = 0

Write-Host "Démarrage de l'audit final sur $($htmlFiles.Count) fichiers HTML..."
Write-Host "Recherche des erreurs d'encodage et des liens morts...`n"

# Liste des symptômes habituels d'un problème d'encodage (UTF-8 lu comme ANSI)
$weirdChars = @('Ã©', 'Ã¨', 'Ã ', 'Ã§', 'Ã¢', 'Ãª', 'Ã®', 'Ã´', 'Ã»', 'ï¿½', '', 'Ã»', 'Ã¯')

foreach ($file in $htmlFiles) {
    # Lecture brute du fichier
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. Vérification de l'encodage
    foreach ($char in $weirdChars) {
        if ($content.Contains($char)) {
            $encodingErrors += [PSCustomObject]@{
                Fichier = $file.Name
                Caractere_Corrompu = $char
            }
        }
    }
    
    # 2. Vérification des liens et images
    $foundLinks = [regex]::Matches($content, '(href|src)="([^"]+)"', 'IgnoreCase')
    foreach ($linkMatch in $foundLinks) {
        $link = $linkMatch.Groups[2].Value
        if ($link -match '^https?://' -or $link -match '^mailto:' -or $link -match '^tel:' -or $link -match '^#') {
            continue
        }
        $checkedLinks++
        $cleanLink = $link -replace '\?.*$', ''
        $targetPath = Join-Path -Path $file.DirectoryName -ChildPath $cleanLink
        if (-not (Test-Path $targetPath)) {
            $brokenLinks += [PSCustomObject]@{
                Fichier = $file.Name
                Lien_Morts = $link
            }
        }
    }
}

Write-Host "=== SCAN ANTI-CARACTÈRES BIZARRES ==="
if ($encodingErrors.Count -gt 0) {
    Write-Host "ATTENTION : Des caractères étranges ont été trouvés !`n" -ForegroundColor Red
    $encodingErrors | Select-Object -Unique Fichier, Caractere_Corrompu | Format-Table -AutoSize
} else {
    Write-Host "SUCCÈS : Aucun caractère corrompu détecté. Texte propre.`n" -ForegroundColor Green
}

Write-Host "=== SCAN ANTI-ERREUR 404 ==="
Write-Host "Liens et images scannés : $checkedLinks"
if ($brokenLinks.Count -gt 0) {
    Write-Host "ATTENTION : Des liens brisés (404 potentiels) ont été détectés !`n" -ForegroundColor Red
    $brokenLinks | Format-Table -AutoSize
} else {
    Write-Host "SUCCÈS : Aucun lien brisé détecté. Le site est 100% robuste.`n" -ForegroundColor Green
}
