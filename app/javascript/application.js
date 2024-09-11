// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Application } from "@hotwired/stimulus";
import PhoneFormatterController from "./controllers/phone_formatter_controller";

const application = Application.start();
application.register("phone-formatter", PhoneFormatterController);

