Rails.application.routes.draw do
  root 'index#home'
  get    '/terms',  to: 'index#terms'
end
