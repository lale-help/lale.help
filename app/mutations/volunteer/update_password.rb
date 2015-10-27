class Volunteer::UpdatePassword < Mutations::Command
  required do
    model  :volunteer
    string :password
    string :password_confirmation
  end

  def execute
    return if password_invalid

    identity = volunteer.identities.first
    identity.password = password
    identity.save!
  end

  def password_invalid
    add_error(:password_confirmation, :did_not_match) if password != password_confirmation
    add_error(:password, :too_short)                  if password.size < 8

    has_errors?
  end
end
