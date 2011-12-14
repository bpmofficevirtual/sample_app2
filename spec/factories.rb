# By using the symbol ':user', we get Factory Girl to simulate the User Model

Factory.define :user do |user|
  user.name			"Cristiano"
  user.email			"crispquai@gmail.com"
  user.password			"foobar"
  user.password_confirmation	"foobar"
end
