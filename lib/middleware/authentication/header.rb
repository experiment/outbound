class Authentication::Header < Authentication::Base

  def authenticated?
    # TODO, real header auth logic
    false
  end
end
