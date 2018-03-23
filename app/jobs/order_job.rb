class OrderJob < ApplicationJob
  queue_as :default

  def perform(user, order)
  	@user = user
  	@order = order
    ApplicationMailer.sample_email(@user, @order).deliver_now
  end
end
