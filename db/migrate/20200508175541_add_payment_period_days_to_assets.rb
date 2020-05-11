class AddPaymentPeriodDaysToAssets < ActiveRecord::Migration[6.0]
  def change
    add_column :assets, :payment_period_days, :integer
  end
end
