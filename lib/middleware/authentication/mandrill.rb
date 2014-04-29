class Authentication::Mandrill < Authentication::Base

  def authenticated?
    # Treat as authenticated if mandrill signature header is present
    # and this is a mandrill route
    # Real authentication will happen in MandrillHooksController
    @env['PATH_INFO'] == '/mandrill_hooks'# &&
      # @env.has_key?('HTTP_X_MANDRILL_SIGNATURE')
  end
end
