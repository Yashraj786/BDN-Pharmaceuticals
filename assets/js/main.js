// BDN Pharmaceuticals site behaviour. Plain JS, no build step.
(function(){
  "use strict";

  /* ---- pause all animation when the tab is hidden ---- */
  document.addEventListener("visibilitychange", function(){
    document.body.classList.toggle("paused", document.hidden);
  });

  /* ---- scroll entrance choreography ---- */
  var revealTargets = document.querySelectorAll(".reveal, .reveal-stagger");
  if ("IntersectionObserver" in window && revealTargets.length){
    var io = new IntersectionObserver(function(entries){
      entries.forEach(function(entry){
        if (entry.isIntersecting){
          entry.target.classList.add("in");
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.16 });
    revealTargets.forEach(function(el){ io.observe(el); });
  } else {
    revealTargets.forEach(function(el){ el.classList.add("in"); });
  }

  /* ---- FAQ accordion ---- */
  document.querySelectorAll(".faq-item").forEach(function(item){
    var q = item.querySelector(".faq-q");
    if (!q) return;
    q.addEventListener("click", function(){
      var wasOpen = item.classList.contains("open");
      item.closest(".faq").querySelectorAll(".faq-item.open").forEach(function(other){
        if (other !== item) other.classList.remove("open");
      });
      item.classList.toggle("open", !wasOpen);
    });
  });

  /* ---- the one interactive moment: the dilution calculator ---- *
   * Liquophin's own label instruction is 1:100 with water. This lets
   * a visitor enter the water they plan to use and see how much
   * Liquophin the label's own ratio calls for. Real math, no gimmick. */
  var calcInput = document.getElementById("calc-water");
  var calcResult = document.getElementById("calc-result");
  var calcBtn = document.getElementById("calc-run");
  if (calcInput && calcResult && calcBtn){
    function runCalc(){
      var litres = parseFloat(calcInput.value);
      if (!litres || litres <= 0){
        calcResult.classList.remove("show");
        return;
      }
      var needed = litres / 100;
      var text = needed < 1
        ? Math.round(needed * 1000) + " ml of Liquophin"
        : needed.toFixed(2) + " litres of Liquophin";
      calcResult.textContent = "For " + litres + " L of water at 1:100 → " + text + ".";
      calcResult.classList.add("show");
    }
    calcBtn.addEventListener("click", runCalc);
    calcInput.addEventListener("keydown", function(e){ if (e.key === "Enter") runCalc(); });
  }

  /* ---- enquiry form: JS-only success state ----
   * No backend exists on this static site. The form does not submit
   * anywhere yet. Swap the handler below for a mailto link or a form
   * service (see the comment in index.html) once BDN decides where
   * partner enquiries should land. */
  var form = document.getElementById("enquiry-form");
  var success = document.getElementById("enquiry-success");
  if (form && success){
    form.addEventListener("submit", function(e){
      e.preventDefault();
      form.style.display = "none";
      success.classList.add("show");
    });
  }

  /* ---- mobile nav toggle ---- */
  var navToggle = document.querySelector(".nav-toggle");
  var navLinks = document.querySelector(".nav-links");
  if (navToggle && navLinks){
    navToggle.addEventListener("click", function(){
      var open = navLinks.style.display === "flex";
      navLinks.style.display = open ? "none" : "flex";
      navToggle.setAttribute("aria-expanded", String(!open));
    });
  }
})();
