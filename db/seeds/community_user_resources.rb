org_community = Organization.create_if_not_exists(
  id: 1,
  name: 'ChaturBots AI',
)
user_community = User.create_or_update(
  id: 2,
  login: 'vaibhav@chaturbots.com',
  firstname: 'Vaibhav',
  lastname: 'Maheshwari',
  email: 'vaibhav@chaturbots.com',
  password: '',
  active: true,
  roles: [ Role.find_by(name: 'Customer') ],
  organization_id: org_community.id,
)

UserInfo.current_user_id = user_community.id

if Ticket.count.zero?
  ticket = Ticket.create!(
    group_id: Group.find_by(name: 'Users').id,
    customer_id: User.find_by(login: 'vaibhav@chaturbots.com').id,
    title: 'Welcome to ChaturBots!',
  )
  Ticket::Article.create!(
    ticket_id: ticket.id,
    type_id: Ticket::Article::Type.find_by(name: 'phone').id,
    sender_id: Ticket::Article::Sender.find_by(name: 'Customer').id,
    from: 'ChaturBots Feedback <feedback@chaturbots.com>',
    body: 'Welcome!

  Thank you for choosing ChaturBots AI.

  We are here to help you get started. You can send us an email vaibhav@chaturbots.com or simply say hello
  at any social media platforms. 
  Regards,

  Your ChaturBots Team
  ',
    internal: false,
  )
end

UserInfo.current_user_id = 1
