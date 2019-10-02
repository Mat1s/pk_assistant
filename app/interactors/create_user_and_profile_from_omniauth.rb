class CreateUserAndProfileFromOmniauth
  include Interactor::Organizer

  organize CreateUserFromOmniauth, CreateProfileFromOmniauth
end