Rails.application.routes.draw do
  resources :students
  root to: 'application#index'
  get('/tv', controller: 'televisions', action: 'filter')
  get('/tv-result', controller: 'televisions', action: 'result')
  get('/tv-product', controller: 'televisions', action: 'product')
  get('/test/:id', controller: 'televisions', action: 'test')
end
