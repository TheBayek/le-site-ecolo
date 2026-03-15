const questions = [
    {
        question: "Quel est le plus grand puits de carbone naturel de la planète ?",
        options: ["La forêt amazonienne", "Les océans", "Les sols permafrost", "L'atmosphère"],
        answer: 1,
        explanation: "Les océans absorbent environ 25% de toutes les émissions de CO2 produites par l'homme et génèrent 50% de l'oxygène que nous respirons."
    },
    {
        question: "Quelle méthode est recommandée avant d'acheter un objet neuf ?",
        options: ["La méthode A.C.H.A.T", "La méthode B.I.S.O.U", "La règle des 3 jours", "La méthode Marie Kondo"],
        answer: 1,
        explanation: "La méthode BISOU signifie : Besoin, Immédiat, Semblable, Origine, Utile. Elle permet d'éviter la surconsommation."
    },
    {
        question: "Parmi ces choix, quelle est la principale cause de déforestation tropicale ?",
        options: ["L'industrie du papier", "L'agriculture et l'élevage bovin", "L'exploitation minière", "L'expansion des routes"],
        answer: 1,
        explanation: "L'agriculture, et particulièrement l'élevage bovin (ainsi que la culture du soja pour nourrir les animaux), cause environ 70% de la déforestation."
    },
    {
        question: "Environ, quelle proportion de nos déchets plastiques historiques a été réellement recyclée ?",
        options: ["Moins de 10%", "Environ 35%", "Plus de 50%", "Près de 80%"],
        answer: 0,
        explanation: "Seulement 9% environ de tout le plastique jamais produit a été recyclé. Le reste est incinéré, mis en décharge ou s'accumule dans la nature."
    },
    {
        question: "Que sont les PFAS ?",
        options: ["Des panneaux solaires", "Des polluants 'éternels'", "Des forêts protégées", "Un traité sur l'eau"],
        answer: 1,
        explanation: "Les PFAS sont des perturbateurs endocriniens très résistants (polluants éternels) utilisés dans les poêles anti-adhésives et emballages imperméables."
    },
    {
        question: "Quelle est la température de chauffage recommandée dans une pièce à vivre ?",
        options: ["17°C", "19°C", "21°C", "23°C"],
        answer: 1,
        explanation: "19°C est la température idéale pour le salon. Chaque degré en moins permet d'économiser environ 7% d'énergie !"
    },
    {
        question: "Quel secteur est particulièrement ravageur pour les fonds marins ?",
        options: ["Le chalutage de fond", "La pêche à la ligne", "L'aquaculture côtière", "Le surf industriel"],
        answer: 0,
        explanation: "Le chalutage de fond racle les fonds marins avec de lourds filets, détruisant des écosystèmes riches (dont ceux stockant du 'carbone bleu')."
    },
    {
        question: "Quelle est l'empreinte carbone moyenne d'un Français aujourd'hui ?",
        options: ["~2 tonnes / an", "~4.5 tonnes / an", "~9.5 tonnes / an", "~15 tonnes / an"],
        answer: 2,
        explanation: "Elle est d'environ 9 à 10 tonnes. Pour respecter l'Accord de Paris, il faudrait descendre collectivement à environ 2 tonnes par personne d'ici 2050."
    },
    {
        question: "Quel impact l'absorption excessive de CO2 a-t-elle sur la chimie de l'océan ?",
        options: ["L'évaporation", "La désalinisation", "L'acidification", "La fossilisation"],
        answer: 2,
        explanation: "L'océan devient plus 'acide' (baisse du pH), ce qui dissout le carbonate de calcium des coraux et des coquillages, menaçant la chaîne alimentaire."
    },
    {
        question: "Lequel de ces aliments a la plus forte empreinte carbone ?",
        options: ["Le poulet", "Le bœuf", "Le fromage", "Le soja"],
        answer: 1,
        explanation: "Le bœuf émet de grandes quantités de méthane lors de sa digestion, un puissant gaz à effet de serre, en plus d'exiger d'immenses surfaces agricoles."
    }
];

let currentQuestion = 0;
let score = 0;
let hasAnswered = false;

const questionEl = document.getElementById('question');
const optionsEl = document.getElementById('options');
const explanationEl = document.getElementById('explanation');
const nextBtn = document.getElementById('next-btn');
const progressEl = document.getElementById('progress');
const levelDisplay = document.getElementById('level-display');

const quizBlock = document.getElementById('quiz-block');
const scoreBlock = document.getElementById('score-block');
const finalScoreEl = document.getElementById('final-score');
const scoreMessageEl = document.getElementById('score-message');

function loadQuestion() {
    hasAnswered = false;
    explanationEl.style.display = 'none';
    nextBtn.style.display = 'none';
    
    levelDisplay.innerText = `Niveau ${currentQuestion + 1} / ${questions.length}`;
    progressEl.style.width = `${(currentQuestion / questions.length) * 100}%`;
    
    const q = questions[currentQuestion];
    questionEl.innerText = q.question;
    
    optionsEl.innerHTML = '';
    q.options.forEach((opt, index) => {
        const btn = document.createElement('button');
        btn.classList.add('option-btn');
        btn.innerText = opt;
        btn.onclick = () => checkAnswer(index, btn);
        optionsEl.appendChild(btn);
    });
}

function checkAnswer(selectedIndex, btnElement) {
    if (hasAnswered) return;
    hasAnswered = true;
    
    const q = questions[currentQuestion];
    const allButtons = optionsEl.querySelectorAll('.option-btn');
    
    if (selectedIndex === q.answer) {
        btnElement.classList.add('correct');
        score++;
    } else {
        btnElement.classList.add('wrong');
        allButtons[q.answer].classList.add('correct');
    }
    
    explanationEl.innerText = q.explanation;
    explanationEl.style.display = 'block';
    
    if (currentQuestion < questions.length - 1) {
        nextBtn.innerText = "Question suivante →";
    } else {
        nextBtn.innerText = "Voir les résultats !";
    }
    nextBtn.style.display = 'block';
}

nextBtn.addEventListener('click', () => {
    currentQuestion++;
    if (currentQuestion < questions.length) {
        loadQuestion();
    } else {
        showResults();
    }
});

function showResults() {
    quizBlock.style.display = 'none';
    scoreBlock.style.display = 'block';
    
    finalScoreEl.innerText = score;
    
    if (score === 10) {
        scoreMessageEl.innerText = "Parfait ! Vous êtes un véritable expert en écologie. 🌍🏆";
        scoreMessageEl.style.color = "var(--primary)";
    } else if (score >= 7) {
        scoreMessageEl.innerText = "Très bien joué ! Vous maîtrisez parfaitement le sujet. 🌱";
    } else if (score >= 4) {
        scoreMessageEl.innerText = "Bon début. Le portail d'information est là pour vous aider à approfondir ! 📖";
    } else {
        scoreMessageEl.innerText = "Il est encore temps d'apprendre ! Explorez le site pour découvrir les enjeux. 💧";
    }
}

// Initialisation
loadQuestion();
