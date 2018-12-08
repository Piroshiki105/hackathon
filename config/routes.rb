Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'start/start'
  get 'start', to: 'start#start'
  get 'input/input'
  get 'input', to: 'input#input'
  get 'confirm/confirm'
  get 'confirm', to: 'confirm#confirm'
end
