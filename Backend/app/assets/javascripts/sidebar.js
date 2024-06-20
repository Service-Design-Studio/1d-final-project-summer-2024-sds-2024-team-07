document.addEventListener("DOMContentLoaded", function () {
  // let arrow = document.querySelectorAll(".arrow");
  // let checklistBtn = document.querySelectorAll(".checklist-btn");
  // for (var i = 0; i < arrow.length; i++) {
  //   arrow[i].addEventListener("click", (e) => {
  //     let arrowParent = e.target.parentElement.parentElement; //selecting main parent of arrow
  //     arrowParent.classList.toggle("showMenu");
  //   });
  // }

  // for (var i = 0; i < checklistBtn.length; i++) {
  //   checklistBtn[i].addEventListener("click", (e) => {
  //     let checklistBtnParent = e.target.parentElement.parentElement; //selecting main parent of arrow
  //     checklistBtnParent.classList.toggle("showMenu");
  //   });
  // }
  // Select all .iocn-link elements
  let iconLinks = document.querySelectorAll(".iocn-link");

  // Function to toggle showMenu class
  function toggleMenu(e) {
    let parentElement = e.currentTarget.parentElement; // selecting main parent of the icon link
    parentElement.classList.toggle("showMenu");
  }

  // Attach event listeners to .iocn-link elements
  iconLinks.forEach(iconLink => {
    iconLink.addEventListener("click", toggleMenu);
  });

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
  const links = document.querySelectorAll('.sub-menu a[data-tab]');
  links.forEach(link => {
    link.addEventListener('click', function(event) {
      event.preventDefault();
      const tabId = this.getAttribute('href');
      document.querySelector(tabId).scrollIntoView({
        behavior: 'smooth'
      });
    });
  });
});

// <!-- Include JavaScript to handle the tab switching -->
document.addEventListener('DOMContentLoaded', function() {
  const links = document.querySelectorAll('.sub-menu a[data-tab]');
  links.forEach(link => {
    link.addEventListener('click', function(event) {
      event.preventDefault();
      const tabId = this.getAttribute('data-tab');
      document.getElementById(tabId).checked = true;
    });
  });
});

// <!-- Include JavaScript to handle the tab switching -->
document.addEventListener('DOMContentLoaded', function() {
  const links = document.querySelectorAll('.sub-menu a[data-tab]');
  links.forEach(link => {
    link.addEventListener('click', function(event) {
      event.preventDefault();
      const tabId = this.getAttribute('data-tab');
      document.getElementById(tabId).checked = true;
    });
  });
});
