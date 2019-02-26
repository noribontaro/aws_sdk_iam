require 'aws-sdk'

iam = Aws::IAM::Client.new(region: 'ap-northeast-1')

iam.list_users.users.each do |user|
  name = user.user_name
  puts "For user #{name}"
  puts "  In groups:"
  
  iam.list_groups_for_user({user_name: name}).groups.each do |group|
    puts "    #{group.group_name}"
  end
  
  puts "  Policies:"
  
  iam.list_user_policies({user_name: name}).policy_names.each do |policy|
    puts "    #{policy}"
  end
  
  puts "  Access keys:"
  
  iam.list_access_keys({user_name: name}).access_key_metadata.each do |key|
    puts "    #{key.access_key_id}"
  end
end
