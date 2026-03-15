$files = Get-ChildItem -Path '.' -Filter '*.html'
foreach ($file in $files) {
    if ($file.Name -eq 'donate.html') { continue }
    $content = [IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Supprimer le bouton de don dans la navbar
    $content = $content -replace '(?m)[ \t]*<a href="donate\.html"[^>]*>Faire un don</a>\r?\n?', ''
    
    # Supprimer les liens de don dans les listes (footer, navbar, etc.)
    $content = $content -replace '(?m)[ \t]*<li><a href="donate\.html"[^>]*>Faire un don</a></li>\r?\n?', ''
    
    [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}

# Supprimer le fichier donate.html s'il existe
if (Test-Path 'donate.html') {
    Remove-Item 'donate.html' -Force
}

# Correction spécifique pour le script de génération qui contient encore les liens
if (Test-Path 'generate_pages.ps1') {
    $genContent = [IO.File]::ReadAllText('generate_pages.ps1', [System.Text.Encoding]::UTF8)
    $genContent = $genContent -replace '(?m)[ \t]*<a href="donate\.html"[^>]*>Faire un don</a>\r?\n?', ''
    $genContent = $genContent -replace '(?m)[ \t]*<li><a href="donate\.html"[^>]*>Faire un don</a></li>\r?\n?', ''
    [IO.File]::WriteAllText('generate_pages.ps1', $genContent, [System.Text.Encoding]::UTF8)
}

Write-Output "Donation feature removed from all files."
