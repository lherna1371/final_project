module UserHelper
	def one_user
		@attr = {
			:first_name =>  'first',
			:last_name =>  'last',
			:zipcode =>  '60060',
			:username =>  'username',
			:email =>  "email@email.com",
			:password =>  "password",
			:password_confirmation =>  "password",
		}
		User.create(@attr)
	end

	def user_login
		one_user
		visit login_path
		fill_in 'session_username', with: 'username'
		fill_in 'session_password', with: "password"
	end
end