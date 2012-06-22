namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
  	User.create!(username: 							"omar.erminy",
  							 password: 							"omar123",
  							 password_confirmation: "omar123")
  
    Contact.create!(name: 		 "Example",
    								lastname:  "Contact",    								
                 		email: 		 "example@contact.com",
                 		skypeid:   "example.contact",
                 		phone:  	 "01234567890",
                 		wish_info: true)
    99.times do |n|
      name  = Faker::Name.first_name
      lastname = Faker::Name.last_name
      email = "example-#{n+1}@contact.com"
      skypeid  = "example#{n+1}.contact"
      phone = "01234567890"
      wish_info = true
      Contact.create!(name: 		 name,
    									lastname:  lastname,    								
                 			email: 		 email,
                 			skypeid:   skypeid,
                 			phone:  	 phone,
                 			wish_info: wish_info)
    end
    
    contacts = Contact.all(limit: 10)
    2.times do
    	contacts.each do |contact|
    		contact.appointments.create!( topic: Faker::Lorem.sentence(30),
    																	date:  Date.current,
    																	time:  "Between 2 and 3 in the afternoon",
    																	via: 	 "skype")
    	end
    end
  end
end
