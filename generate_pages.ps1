$OutputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$topics = @(
    @{"id"="biodiversity"; "title"="La Biodiversité"; "img"="assets/forest.png"; "desc"="Comprendre l'importance de chaque espèce et le risque d'extinction de masse."; "content"="La biodiversité représente l'ensemble du tissu vivant de notre planète..."},
    @{"id"="energy"; "title"="Énergies Renouvelables"; "img"="assets/hero.png"; "desc"="Transitionner des fossiles vers le solaire, l'éolien et la géothermie."; "content"="Les combustibles fossiles (charbon, pétrole, gaz) sont la cause principale du réchauffement climatique..."},
    @{"id"="food"; "title"="Alimentation"; "img"="assets/climate.png"; "desc"="L'impact de l'agriculture intensive et les solutions pour une alimentation durable."; "content"="L'agriculture et la déforestation liée représentent près du quart des émissions mondiales..."},
    @{"id"="water"; "title"="Ressources en Eau"; "img"="assets/ocean.png"; "desc"="Gérer et protéger la ressource la plus précieuse et menacée de la planète."; "content"="Seulement 2.5% de l'eau sur Terre est douce, et une fraction minime est accessible..."},
    @{"id"="waste"; "title"="Gestion des Déchets"; "img"="assets/urgency_hero.png"; "desc"="La règle des 5R et comment mettre fin à l'ère du plastique jetable."; "content"="Chaque année, l'humanité produit plus de 2 milliards de tonnes de déchets municipaux..."},
    @{"id"="mobility"; "title"="Mobilité Durable"; "img"="assets/hero.png"; "desc"="Repenser nos déplacements au quotidien pour réduire notre empreinte."; "content"="Le secteur des transports dépend à 95% du pétrole et représente un quart des émissions de CO2..."},
    @{"id"="oceans"; "title"="Protection des Océans"; "img"="assets/ocean.png"; "desc"="Préserver le plus grand puits de carbone de la Terre et ses écosystèmes."; "content"="Les océans couvrent 71% de la surface du globe et ont absorbé plus de 90% de l'excès de chaleur..."},
    @{"id"="forests"; "title"="Forêts"; "img"="assets/forest.png"; "desc"="Poumons verts de la Terre, comprendre pourquoi leur protection est vitale."; "content"="Environ 30% de la surface terrestre est recouverte par les forêts, qui abritent la majorité de la biodiversité terrestre..."},
    @{"id"="climate"; "title"="Climat Global"; "img"="assets/climate.png"; "desc"="Le fonctionnement du système climatique et de l'effet de serre."; "content"="L'effet de serre est à l'origine un phénomène naturel indispensable, mais les activités humaines l'ont amplifié..."},
    @{"id"="economy"; "title"="Économie Circulaire"; "img"="assets/urgency_hero.png"; "desc"="Passer d'une économie linéaire (extraire-produire-jeter) à une économie circulaire."; "content"="Notre modèle économique ne peut durer sur une planète finie. L'économie circulaire propose..."},
    @{"id"="activism"; "title"="Mouvements Citoyens"; "img"="assets/hero.png"; "desc"="L'histoire et l'impact des marches pour le climat et de la désobéissance civile."; "content"="La pression populaire est l'un des leviers les plus puissants pour forcer l'action politique..."},
    @{"id"="tech"; "title"="Technologies Vertes"; "img"="assets/ocean.png"; "desc"="L'innovation technologique peut-elle vraiment nous sauver ?"; "content"="Des réseaux électriques intelligents aux matériaux de construction biosourcés, la technologie offre des solutions..."}
)

$templateBase = @"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>__TITLE__ - EcoSource Encyclopedia</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo">Eco<span class="accent">Source</span></div>
        <ul class="nav-links">
            <li><a href="index.html">Accueil</a></li>
            <li><a href="portal.html" class="__ACTIVE_PORTAL__">Le Portail</a></li>
            <li><a href="urgency.html">L'Urgence</a></li>
            <li><a href="action.html">Agir</a></li>
        </ul>
        <div class="hamburger">
            <span class="bar"></span>
            <span class="bar"></span>
            <span class="bar"></span>
        </div>
    </nav>

    __CONTENT_BODY__

    <footer>
        <div class="container footer-content">
            <div class="footer-brand">
                <div class="logo">Eco<span class="accent">Source</span></div>
                <p>Création pour la sensibilisation écologique et la protection de notre environnement commun.</p>
            </div>
            <div class="footer-links">
                <h4>Navigation</h4>
                <ul style="list-style: none; display: flex; flex-direction: column; gap: 10px; color: var(--text-muted);">
                   <li><a href="index.html">Accueil</a></li>
                   <li><a href="portal.html">Le Portail</a></li>
                   <li><a href="urgency.html">L'Urgence</a></li>
                   <li><a href="action.html">Agir</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 EcoSource. Version Encyclopédique.</p>
        </div>
    </footer>
    <script src="script.js"></script>
</body>
</html>
"@

$portalCards = ""
foreach ($t in $topics) {
    $topicId = $t["id"]
    $topicImg = $t["img"]
    $topicTitle = $t["title"]
    $topicDesc = $t["desc"]
    $portalCards += @"
        <a href="${topicId}.html" class="card portal-card reveal fade-up">
            <div class="card-img" style="background-image: url('${topicImg}'); height: 200px;"></div>
            <div class="card-content">
                <h3>${topicTitle}</h3>
                <p>${topicDesc}</p>
                <span style="color: var(--primary); font-weight: bold; margin-top: 15px; display: inline-block;">Lire l'article &rarr;</span>
            </div>
        </a>
"@
}

$portalBody = @"
    <header class="page-header" style="height: 40vh;">
        <div class="hero-bg" style="background-image: url('assets/hero.png');"></div>
        <div class="hero-overlay"></div>
        <div class="page-header-content">
            <h1 class="reveal fade-up">Portail <span class="highlight">Écologique</span></h1>
            <p class="reveal fade-up delay-1">L'encyclopédie interactive pour comprendre chaque facette de notre environnement.</p>
        </div>
    </header>
    <section class="section" style="background: var(--bg-dark);">
        <div class="container">
            <div class="cards-grid portal-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 40px;">
                $portalCards
            </div>
        </div>
    </section>
"@

$portalContent = $templateBase -replace '__TITLE__', 'Le Portail' -replace '__ACTIVE_PORTAL__', 'active' -replace '__CONTENT_BODY__', $portalBody
[IO.File]::WriteAllText("portal.html", $portalContent, [System.Text.Encoding]::UTF8)

foreach ($t in $topics) {
    $topicTitle = $t["title"]
    $topicImg = $t["img"]
    $topicDesc = $t["desc"]
    $topicContent = $t["content"]
    $topicId = $t["id"]
    
    $topicBody = @"
    <header class="page-header" style="height: 50vh;">
        <div class="hero-bg" style="background-image: url('${topicImg}');"></div>
        <div class="hero-overlay"></div>
        <div class="page-header-content">
            <div style="margin-bottom: 20px;"><a href="portal.html" style="color: var(--primary); font-weight: bold;">&larr; Retour au portail</a></div>
            <h1 class="reveal fade-up">${topicTitle}</h1>
            <p class="reveal fade-up delay-1">${topicDesc}</p>
        </div>
    </header>
    <section class="section">
        <div class="container" style="max-width: 800px; margin: 0 auto; font-size: 1.15rem; line-height: 1.8; color: #d1d5db;">
            <div class="glass-panel reveal fade-up" style="padding: 50px;">
                <h2 style="color: white; margin-bottom: 30px; font-size: 2rem;">Introduction à la thématique</h2>
                <p style="margin-bottom: 25px;">${topicContent}</p>
                <p style="margin-bottom: 25px;">(Ce contenu est une illustration encyclopédique générée dynamiquement. Pour aller plus loin dans l'exploration de ce sujet, les actions individuelles restent le levier numéro un.)</p>
                
                <h3 style="color: white; margin: 40px 0 20px;">Pourquoi est-ce crucial ?</h3>
                <ul style="list-style-type: disc; margin-left: 20px; margin-bottom: 30px; display: flex; flex-direction: column; gap: 15px;">
                    <li>L'équilibre de ce système dicte la viabilité de notre planète sur le long terme.</li>
                    <li>Les impacts se font déjà ressentir sur les populations locales.</li>
                    <li>L'inaction coûterait exponentiellement plus cher que la transition immédiate.</li>
                </ul>
                
                <div style="margin-top: 50px; text-align: center; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 40px;">
                    <a href="action.html" class="btn btn-primary">Découvrir comment agir</a>
                </div>
            </div>
        </div>
    </section>
"@
    $pageContent = $templateBase -replace '__TITLE__', $topicTitle -replace '__ACTIVE_PORTAL__', 'active' -replace '__CONTENT_BODY__', $topicBody
    [IO.File]::WriteAllText("${topicId}.html", $pageContent, [System.Text.Encoding]::UTF8)
}

Write-Output "Generation OK"
