module Token
  extend ActiveSupport::Concern

  module ClassMethods
    def find_by_token(token)
      id = token.last(-1).to_i(36)

      if (contact = find(id)) && contact.token == token
        contact
      end
    end
  end

  def token
    # created_at_epoch_last_letter, plus id in base 36
    created_at_epoch_last_letter + base_64_id
  end

  private

    def created_at_epoch_last_letter
      created_at.to_i.to_s.last
    end

    def base_64_id
      id.to_s(36)
    end
end
