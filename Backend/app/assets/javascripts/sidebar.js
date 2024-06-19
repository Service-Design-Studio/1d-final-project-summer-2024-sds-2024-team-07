document.addEventListener("DOMContentLoaded", function () {
  let arrow = document.querySelectorAll(".arrow");
  for (var i = 0; i < arrow.length; i++) {
    arrow[i].addEventListener("click", (e) => {
      let arrowParent = e.target.parentElement.parentElement; //selecting main parent of arrow
      arrowParent.classList.toggle("showMenu");
    });
  }
  let sidebar = document.querySelector(".sidebar");
  let toggleBtn = document.querySelector(".toggle-btn");
  let rightDiv = document.querySelector(".right-div");
  toggleBtn.addEventListener("click", () => {
    sidebar.classList.toggle("close");
    if (sidebar.classList.contains("close")) {
      rightDiv.style.marginLeft = "80px";
    } else {
      rightDiv.style.marginLeft = "260px";
    }
  });
});
