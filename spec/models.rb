class EtsyAccount < ActiveRecord::Base
  def token_expired?
    last_token_refresh.nil? || expires_in.nil? || last_token_refresh + expires_in <= DateTime.now
  end
end
