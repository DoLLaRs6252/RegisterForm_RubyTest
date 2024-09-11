// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Application } from "@hotwired/stimulus";
import PhoneFormatterController from "./controllers/phone_formatter_controller";

const application = Application.start();
application.register("phone-formatter", PhoneFormatterController);

document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('confirmation-modal');
    const confirmDeleteButton = document.getElementById('confirm-delete');
    const cancelDeleteButton = document.getElementById('cancel-delete');
    let deleteForm = null;
  
    // Show the modal when a delete button is clicked
    document.querySelectorAll('.delete-button').forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault(); // Prevent form submission
        deleteForm = button.closest('form');
        modal.classList.remove('hidden');
      });
    });
  
    // Confirm deletion
    confirmDeleteButton.addEventListener('click', () => {
      if (deleteForm) {
        deleteForm.submit();
      }
    });
  
    // Cancel deletion
    cancelDeleteButton.addEventListener('click', () => {
      modal.classList.add('hidden');
    });
  });
  