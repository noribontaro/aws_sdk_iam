require 'aws-sdk'

iam = Aws::IAM::Client.new(region: 'ap-northeast-1')

begin
  user = iam.create_user(user_name: '#{_user}')
  iam.wait_until(:user_exists, user_name: '#{_user}')

  user.create_login_profile({
    password: 'REPLACE_ME',
    password_reset_required: true,
    user_name: '#{_user}'
  })

  arn_parts = user.arn.split(':')
  puts 'Account ID:        ' + arn_parts[4]
rescue Aws::IAM::Errors::EntityAlreadyExists
  puts 'User already exists'
end
