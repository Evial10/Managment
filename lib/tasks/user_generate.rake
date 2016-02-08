require 'open-uri'
desc "Generation users"
task :generate_users => :environment do
  50.times do
    puts 'Model is not save' unless User.new(user_params).save
    File.delete(File.join(Rails.root, '/public/uploads/pattern.jpg'))
  end
  puts 'Task is successful'
end

def user_params
  password = Faker::Internet.password  

  open(URI.parse(Faker::Avatar.image), 'rb') do |file_ext|   
    File.open(File.join(Rails.root, '/public/uploads/pattern.jpg'), 'wb') do |file_int|    
      file_int.puts(file_ext.read)
    end   
  end 
  
  { :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name, 
    :email => Faker::Internet.email, 
    :password => password, 
    :password_confirmation => password,
    :birth_date => Faker::Date.forward(rand(30)),
    :phone => Faker::PhoneNumber.cell_phone,
    :trainee => rand(2),
    :admin => rand(2),
    :avatar => File.open(File.join(Rails.root, '/public/uploads/pattern.jpg')) 
   }   
end
