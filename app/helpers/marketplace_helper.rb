module MarketplaceHelper
  def not_current_user(user)
    current_user != user
  end

  def my_profile?(user)
    current_user == user
  end
end
