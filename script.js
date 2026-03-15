// Hamburger Menu Toggle
const hamburger = document.querySelector(".hamburger");
const navMenu = document.querySelector(".nav-links");

hamburger.addEventListener("click", () => {
    hamburger.classList.toggle("active");
    navMenu.classList.toggle("active");
});

document.querySelectorAll(".nav-links a").forEach(n => n.addEventListener("click", () => {
    hamburger.classList.remove("active");
    navMenu.classList.remove("active");
}));

// Navbar Scroll Effect
const navbar = document.querySelector(".navbar");

window.addEventListener("scroll", () => {
    if (window.scrollY > 50) {
        navbar.classList.add("scrolled");
    } else {
        navbar.classList.remove("scrolled");
    }
});

// Set active link based on current URL
document.addEventListener("DOMContentLoaded", () => {
    const activePage = window.location.pathname.split("/").pop();
    document.querySelectorAll(".nav-links a").forEach((link) => {
        link.classList.remove("active");
        if (link.getAttribute("href") === activePage || (activePage === "" && link.getAttribute("href") === "index.html")) {
            link.classList.add("active");
        }
    });
});

// Reveal Elements on Scroll
function reveal() {
    var reveals = document.querySelectorAll(".reveal");
    
    for (var i = 0; i < reveals.length; i++) {
        var windowHeight = window.innerHeight;
        var elementTop = reveals[i].getBoundingClientRect().top;
        var elementVisible = 100; // Trigger threshold
        
        if (elementTop < windowHeight - elementVisible) {
            reveals[i].classList.add("active");
        }
    }
}

// Initial check
window.addEventListener("scroll", reveal);
document.addEventListener("DOMContentLoaded", () => {
    // Trigger reveals for elements already in viewport
    setTimeout(reveal, 100);
});

// Back to Top Button
const backToTop = document.createElement('div');
backToTop.classList.add('back-to-top');
backToTop.innerHTML = '&uarr;';
document.body.appendChild(backToTop);

window.addEventListener('scroll', () => {
    if (window.scrollY > 500) {
        backToTop.classList.add('visible');
    } else {
        backToTop.classList.remove('visible');
    }
});

backToTop.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// Newsletter Interaction
const newsletterButtons = document.querySelectorAll('.footer-cta button');
newsletterButtons.forEach(btn => {
    btn.addEventListener('click', (e) => {
        const input = e.target.previousElementSibling;
        if (input && input.value.trim() !== "") {
            const originalText = e.target.innerText;
            e.target.innerText = "Merci ! \u2713";
            e.target.style.background = "var(--primary-hover)";
            input.value = "";
            setTimeout(() => {
                e.target.innerText = originalText;
                e.target.style.background = "";
            }, 3000);
        } else {
            input.focus();
        }
    });
});
