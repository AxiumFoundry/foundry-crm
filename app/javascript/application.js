// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Honeybadger from "@honeybadger-io/js"

Honeybadger.configure({
  apiKey: document.querySelector('meta[name="honeybadger-api-key"]')?.content,
  environment: document.body.dataset.env || 'production',
  revision: document.querySelector('meta[name="honeybadger-revision"]')?.content
})
