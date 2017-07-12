Rails.application.routes.draw do

  devise_for :users#, controllers: {registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :skills
  resources :user_skills
  resources :teams
  resources :invites
  resources :members
  resources :yes_lists
  resources :competitions
  resources :preferences
  resources :simulations
  match 'team_skills/simulations' => 'simulations#team_skills', as: :simulations_team_skills, via: [:get]
  match 'search/simulations' => 'simulations#search', as: :simulations_search, via: [:get]

  # Additional routes.
  get 'members/:id/join' => 'members#join', as: :members_join, via: [:get]
  get 'welcome/home'
  get 'welcome/contact_us'
  get 'welcome/about_us'

  match 'users/edit_password' => 'users#edit_password', as: :user_edit_password, via: [:get]
  match 'users/update_password' => 'users#update_password', as: :user_update_password, via: [:post]
  match 'user/dashboard' => 'users#dashboard', as: :user_dashboard, via: [:get]

  match 'pie_chart/skills' => 'skills#pie_chart', as: :pie_chart_skills, via: [:get]
  match 'column_graph/:id/users' => 'users#column_graph', as: :column_graph_users, via: [:get]
  match 'indi_graph/:id/users' => 'users#indi_graph', as: :indi_graph_users, via: [:get]
  get 'yes_lists/:id/toggle' => 'yes_lists#toggle', as: :toggle_yes_lists, via: [:get]
  match 'difficult_graph/yes_lists' => 'yes_lists#difficult_graph', as: :difficult_graph_yes_lists, via: [:get]
  match 'hated_graph/yes_lists' => 'yes_lists#hated_graph', as: :hated_graph_yes_lists, via: [:get]

  get 'mine/teams' => 'teams#mine', as: :teams_mine, via: [:get]

  match 'admin/make_admin' => 'admin#make_admin', as: :admin_make_admin, via: [:get]
  match 'admin/get_pass' => 'admin#get_pass', as: :admin_get_pass, via: [:get]


  root to: 'welcome#home'
end

  # Probably do not need any of this nonsense:-
  # match 'members/join' => 'members#join', as: :members_join, via: [:get]
  # match 'members/leave' => 'members#leave', as: :members_leave, via: [:get]
  # match 'invites/invite' => 'invites#invite', as: :invites_invite, via: [:get]
  # match 'invites/send' => 'invites#send', as: :invites_send, via: [:get]
  # match 'invites/reject' => 'invites#reject', as: :invites_reject, via: [:get]

  # UserSkills default routes list -> managed under 'resources'
  # get 'user_skills/index'
  # get 'user_skills/new'
  # match 'user_skills/create' => 'user_skills#create', as: :user_skills_create, via: [:post]
  # get 'user_skills/edit'
  # get 'user_skills/update'
  # get 'user_skills/destroy'

  # Competitions default routes list -> managed under 'resources'
  # get 'competitions/index'
  # get 'competitions/:id/show' => 'competitions#show', as: :competition, via: [:get]
  # get 'competitions/new'
  # match 'competitions/create' => 'competitions#create', as: :competitions_create, via: [:post]
  # get 'competitions/edit'
  # get 'competitions/update'
  # get 'competitions/destroy'

  # Users default routes list -> managed under 'resources'
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/edit_password' => 'users#edit_password'

  # YesLists default routes list -> managed under 'resources'
  # get 'yes_lists/new'
  # get 'yes_lists/create'
  # get 'yes_lists/index'
  # get 'yes_lists/edit'
  # get 'yes_lists/update'
  # get 'yes_lists/destroy'