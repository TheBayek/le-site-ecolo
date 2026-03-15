$htmlFiles = Get-ChildItem -Path '.' -Filter '*.html'

Write-Host "Ajout du lien du Quiz aux autres pages..."
$quizLinkNav = '<li><a href="quiz.html">Le Quiz</a></li>'

foreach ($file in $htmlFiles) {
    # Skip quiz.html car le lien est déjà correctement inclus
    if ($file.Name -eq 'quiz.html') { continue }
    
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Remplacement dans la navbar (il se peut qu'il y ait la classe "active" sur action.html sur certaines pages)
    # Chercher la balise ul.nav-links... et la fin du ul 
    $content = $content -replace '(?s)(<ul class="nav-links">.*?<li><a href="action\.html"[^>]*>Agir</a></li>)', "`$1`n            $quizLinkNav"
    
    # Remplacement dans le footer
    $content = $content -replace '(?s)(<div class="footer-links">.*?<li><a href="action\.html"[^>]*>Agir</a></li>)', "`$1`n                   $quizLinkNav"
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Le Quiz a bien été intégré sur l'ensemble du site !"
