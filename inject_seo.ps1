$files = Get-ChildItem -Path '.' -Filter '*.html'
foreach ($file in $files) {
    $content = [IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # If meta description already exists, skip
    if ($content -notmatch '<meta name="description"') {
        $metaTags = @"
    <meta name="description" content="EcoSource : L'encyclopédie interactive et la plateforme de passage à l'action pour comprendre et protéger notre environnement.">
    <meta property="og:title" content="EcoSource - Protéger notre futur">
    <meta property="og:description" content="Découvrez les défis écologiques actuels et passez à l'action.">
    <meta property="og:type" content="website">
    <meta name="theme-color" content="#2fb56a">
"@
        
        # Inject metadata just before the <title> tag
        $content = $content -replace '(\s*<title>)', "`n$metaTags`$1"
        [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    }
}
Write-Output "SEO Meta tags injected successfully."
