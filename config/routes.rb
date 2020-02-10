Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'shelters#index'
  
  get '/shelters', to: "shelters#index"
  get '/shelters/new', to: "shelters#new"
  get '/shelters/:id', to: "shelters#show"
  post '/shelters', to: "shelters#create"
  get '/shelters/:id/edit', to: "shelters#edit"
  patch '/shelters/:id', to: "shelters#update"
  delete '/shelters/:id', to: "shelters#destroy"

  get '/shelters/:shelter_id/pets', to: "shelterpets#index"
  get '/shelters/:shelter_id/pets/new', to: "shelterpets#new"
  post '/shelters/:shelter_id/pets', to: "shelterpets#create"

  get '/pets', to: "pets#index"
  get '/pets/:id', to: "pets#show"
  get '/pets/:id/edit', to: "pets#edit"
  patch '/pets/:id', to: "pets#update"
  delete '/pets/:id', to: "pets#destroy"
  get 'pets/:pet_id/adopt_forms', to: "adopt_forms#index"

  get '/shelters/:shelter_id/reviews/new', to: "reviews#new"
  post '/shelters/:shelter_id/reviews', to: "reviews#create"
  delete '/shelters/:shelter_id/reviews/:review_id', to: "reviews#destroy"
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  
  get '/favorites', to: "favorites#index"
  post '/favorites/:id', to: "favorites#create"
  delete '/favorites/:id', to: "favorites#destroy"
  delete '/favorites', to: "favorites#destroy_all"

  get '/adopt_forms/new', to: "adopt_forms#new"
  post '/adopt_forms', to: "adopt_forms#create"
  get '/adopt_forms/:adopt_form_id', to: "adopt_forms#show"
  patch '/adopt_forms/:adopt_form_id/pets/:pet_id', to: "pet_adopt_forms#update"

end
