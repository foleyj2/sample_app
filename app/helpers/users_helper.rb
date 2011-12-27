module UsersHelper
  def gravatar_for(user, options = { :size => 50 } )
    gravatar_image_tag(user.email.downcase, :alt => h(user.name),
                       :class => 'gravatar',
                       :gravatar => options)
  end
end
## Exercise 7.5.3
## How could you get the Gravatar helper gravatar_for to work if our User model used email_address instead of email to represent email addresses?
##     gravatar_image_tag(user.email_address.downcase, :alt => h(user.name),
