$files = Get-ChildItem -Path '.' -Filter '*.html'
foreach ($file in $files) {
    # Read text
    $content = [IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Remove the duplicated navigation list item for donate (keep only the button)
    $content = $content -replace '<li><a href="donate\.html"(?: class="active")?>Faire un don</a></li>\s*', ''
    
    # Fix common double-encoded UTF-8 windows-1252 artifacts
    $content = $content -replace 'Ã©', 'é'
    $content = $content -replace 'Ã¨', 'è'
    $content = $content -replace 'Ãª', 'ê'
    $content = $content -replace 'Ã ', 'à'
    $content = $content -replace 'Ã‰', 'É'
    $content = $content -replace 'Ã§', 'ç'
    $content = $content -replace 'Ã¢', 'â'
    $content = $content -replace 'Ã´', 'ô'
    
    # Save text
    [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Fix Complete"
