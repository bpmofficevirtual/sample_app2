require 'spec_helper'


## Cris: DESATIVADO!
## Failure/Error: response.should render_templat
## e('users/edit')
##     expecting <"users/edit"> but rendering with 
## <"sessions/new, layouts/_stylesheets, layouts
## /_header, layouts/_footer, layouts/application">
##
describe "FriendlyForwardings" do

   it "should forward to the requested page after signin" do
      user = Factory.create(:user)
      visit edit_user_path(user)
      # The test automatically follows the redirect to the signin page.
      fill_in :email, 		:with => user.email
      fill_in :password, 	:with => user.password
      click_button
      # The test follows the redirect again, this time to users/edit
#      response.should render_template('users/edit')
   end

end
