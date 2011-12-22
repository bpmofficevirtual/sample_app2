# By using the symbol ':user', we get Factory Girl to simulate the User Model

Factory.define :user do |user|
  user.name			"Cristiano"
  user.email			"crispquai@gmail.com"
  user.password			"foobar"
  user.password_confirmation	"foobar"
# user.admin			false
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end


Factory.define :micropost do |micropost|
   micropost.content     "Foo bar"
   micropost.association :user
end

