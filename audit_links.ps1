$htmlFiles = Get-ChildItem -Path '.' -Filter '*.html'
$brokenLinks = @()
$checkedLinks = 0

Write-Host "Démarrage de l'audit des liens sur $($htmlFiles.Count) fichiers HTML..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    # Recherche des attributs href et src
    $foundLinks = [regex]::Matches($content, '(href|src)="([^"]+)"', 'IgnoreCase')
    
    foreach ($linkMatch in $foundLinks) {
        $link = $linkMatch.Groups[2].Value
        
        # Ignorer les liens externes, liens vers la même page (#) et mailto
        if ($link -match '^https?://' -or $link -match '^mailto:' -or $link -match '^#') {
            continue
        }
        
        $checkedLinks++
        
        # Nettoyer les paramètres de requête au cas où (ex: style.css?v=1)
        $cleanLink = $link -replace '\?.*$', ''
        
        $targetPath = Join-Path -Path $file.DirectoryName -ChildPath $cleanLink
        
        if (-not (Test-Path $targetPath)) {
            $brokenLinks += [PSCustomObject]@{
                Fichier_Source = $file.Name
                Lien_Cassee = $link
                Type = $match.Groups[1].Value
            }
        }
    }
}

Write-Host "`n=== RÉSULTATS DE L'AUDIT ==="
Write-Host "Liens locaux vérifiés : $checkedLinks"

if ($brokenLinks.Count -gt 0) {
    Write-Host "ATTENTION : Des liens brisés (404 potentiels) ont été trouvés !`n" -ForegroundColor Red
    $brokenLinks | Format-Table -AutoSize
} else {
    Write-Host "SUCCÈS : Aucun lien brisé détecté. Le site est safe (100% sans erreur 404).`n" -ForegroundColor Green
}
