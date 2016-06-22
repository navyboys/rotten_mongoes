user_names = ["Richard", "Natalia", "Ben", "Max", "Matt", "Eamonn", "Vanessa", "Deepak", "Alexandra", "Juliana", "Terrence"]
email = "@example.com"

user_names.each do |name|
  User.create!(firstname: name, lastname: name, password: 'password', email: name + email)
end
