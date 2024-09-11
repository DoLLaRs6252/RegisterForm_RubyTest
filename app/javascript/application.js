// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
  document.addEventListener("turbo:load", function() { 
    const phoneInput = document.getElementById("phone");

    if (phoneInput) {
      phoneInput.addEventListener("input", function(e) {
        let value = phoneInput.value.replace(/\D/g, ""); // Remove non-digits
        if (value.length > 3 && value.length <= 6) {
          value = `${value.slice(0, 3)}-${value.slice(3)}`;
        } else if (value.length > 6) {
          value = `${value.slice(0, 3)}-${value.slice(3, 6)}-${value.slice(6, 10)}`;
        }
        phoneInput.value = value;
      });
    }
  });
