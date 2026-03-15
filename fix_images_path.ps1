$files = Get-ChildItem -Path '.' -Include '*.html', '*.css' -Recurse
Write-Host "Correction des chemins d'images dans $($files.Count) fichiers..."

foreach ($file in $files) {
    if ($file.Name -match '\.ps1$|\.md$') { continue }
    
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Remplacer "assets/" par ""
    $newContent = $content -replace ' src="assets/', ' src="'
    $newContent = $newContent -replace " url\('assets/", " url('"
    $newContent = $newContent -replace ' url\("assets/', ' url("'
    
    # Remplacer "images/" par "" (au cas où il y en aurait eu)
    $newContent = $newContent -replace ' src="images/', ' src="'
    $newContent = $newContent -replace " url\('images/", " url('"
    $newContent = $newContent -replace ' url\("images/', ' url("'
    
    # Remplacer également 'assets/' sans src ou url juste au cas où
    # Mais prudemment
    
    if ($content -cne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "Mis à jour : $($file.Name)"
    }
}
Write-Host "Tous les chemins d'images ont été corrigés pour pointer vers la racine !"
