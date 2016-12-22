# This class is used for logins
class Login
  attr_reader :sessions, :users, :passwords

  # Receives a hash with usernames as keys and passwords as values
  def initialize(hash)
    @sessions = []
    @users = hash.keys
    @passwords = hash.values
  end

  def logout(user)
    sessions.delete_if {|session| session == user } 
  end

  # Register user
  def register_user(user, password)
    #do not repeat the same user
    unless users.include?(user)
      users.push(user)
      passwords.push(password)
    end
  end

  def remove_user(user)
    if users.include?(user)
      index = users.index(user)
      users.delete(index)
      passwords.delete(index)
    end
  end

  def check_password(user, password)
    passwords[users.index(user)] == password
  end

  def update_password(user, old_password, new_password)
    # First we check if the user exists
    if users.include?(user)
      passwords[users.index(user)] = new_password
      true
    else
      false
    end
  end

  def login(user, password)
    #if the user exists the password is correct and he is not already logged in
    if users.include?(user) && check_password(user, password) && !logged_in?(user)
      sessions << user
      true
    else
      false
    end
  end

  def logged_in?(user)
    sessions.include?(user)
  end

end

registered_users = {
  'user1' => 'pass1',
  'user2' => 'pass2',
  'user3' => 'pass3'
}

login = Login.new(registered_users)

login.register_user('user4', 'pass4')
login.login('user4', 'pass4')
puts "sessions" + login.sessions.to_s
login.update_password('user3', 'pass3', 'pass5')
login.login('user3', 'pass5')
puts "sessions" + login.sessions.to_s
login.logout('user4')
login.logout('user3')
puts "sessions" + login.sessions.to_s
