class Donation < ActiveRecord::Base
  belongs_to :user

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: Figaro.env.PAYPAL_BUSINESS,
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: self.amount,
        item_name: "Bonsai List Donation",
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/donation_notifications"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
