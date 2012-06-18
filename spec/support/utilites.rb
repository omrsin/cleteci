# encoding: utf-8

def login(user)
  visit admin_path
  fill_in "Usuario", with: user.username
  fill_in "Contraseña", with: user.password
  click_button "Iniciar Sesión"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end
