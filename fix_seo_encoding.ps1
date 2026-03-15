$htmlFiles = Get-ChildItem -Path '.' -Filter '*.html'

Write-Host "Correction des caractères d'encodage SEO dans $($htmlFiles.Count) fichiers HTML..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    $original = $content
    
    $content = $content -replace 'L''encyclopÃ©die', "L'encyclopédie"
    $content = $content -replace 'protÃ©ger', "protéger"
    $content = $content -replace 'ProtÃ©ger', "Protéger"
    $content = $content -replace 'DÃ©couvrez', "Découvrez"
    $content = $content -replace 'dÃ©fis', "défis"
    $content = $content -replace 'Ã©cologiques', "écologiques"
    $content = $content -replace "Ã\s*l'action", "à l'action"
    
    if ($content -cne $original) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    }
}
Write-Host "Correction appliquée !"
