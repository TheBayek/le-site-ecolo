$htmlFiles = Get-ChildItem -Path '.' -Filter '*.html'
Write-Host "Injection du logo SVG dans $($htmlFiles.Count) fichiers..."

# Le logo SVG (une jolie feuille minimaliste)
$svgLogo = '<svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/></svg>'
$newLogoHtml = '<div class="logo">' + $svgLogo + ' Eco<span class="accent">Source</span></div>'

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Remplacer les deux occurrences (navbar et footer)
    $content = $content -replace '<div class="logo">Eco<span class="accent">Source</span></div>', $newLogoHtml
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Logo SVG déployé avec succès sur toutes les pages !"
