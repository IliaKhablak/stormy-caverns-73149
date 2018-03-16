class ApplicationMailer < ActionMailer::Base
  default from: 'testairbnb111@gmail.com'
  layout 'mailer'

  def sample_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Order from testapp')
  end
end
