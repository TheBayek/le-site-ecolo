$htmlFiles = Get-ChildItem -Path '.' -Filter '*.html'
Write-Host "Ajout de la favicon.svg à $($htmlFiles.Count) fichiers..."

$faviconTag = '    <link rel="icon" type="image/svg+xml" href="favicon.svg">'

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # On insère juste avant la fermeture du </head>
    if ($content -notmatch 'favicon\.svg') {
        $content = $content -replace '</head>', "$faviconTag`n</head>"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    }
}

Write-Host "Favicon intégrée ! L'icône de l'onglet apparaîtra en haut du navigateur !"
