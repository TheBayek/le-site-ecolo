$files = @("index.html", "urgency.html", "action.html", "donate.html")
foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        # 1. Clean duplicated Le Portail links
        $content = [regex]::Replace($content, '(?s)(<li><a href="portal\.html"[^>]*>Le Portail</a></li>\s*)+', '<li><a href="portal.html">Le Portail</a></li>' + "`r`n            ")
        
        # 2. Fix the "Faire un don" <li>
        $content = $content -replace '<li><a href="donate\.html"(?: class="active")?>Faire un don</a></li>\s*', ''

        [IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
    }
}
Write-Output "Cleanup OK"
