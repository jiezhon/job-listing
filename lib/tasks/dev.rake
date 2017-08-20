namespace :dev do
  task :fake_job_and_resumes => :environment do
    job = Job.create!(title: "Science Officer — Addest Technovation", description: "Main job responsibilities:

  facilitate hands-on workshops/laboratory sessions for teachers and pupils,
  design experiments and edit activity manuals
  develop contents

  Requirements:

  Degree or Diploma in Science (preferably major in Chemistry)
  Passion for Science
  Committed and willingness to work extra
  ", wage_lower_bound: 1000, wage_upper_bound: 20000, contact_email: "",
    is_hidden: false)

    l1 = job.locations.create!( :city => "Beijing", :quantity => 1, :address =>"Soho Buiding 10")
    l2 = job.locations.create!( :city => "Shanghai", :quantity => 2, :address =>"Zhangjiang Buiding 22")
    l3 = job.locations.create!( :city => "Shenzhen", :quantity => 2, :address =>"SISP Buiding 11")
    1000.times do |i|
      job.resumes.create!(:status => ["pending", "confirmed"].sample,
                          :location => [l1, l2, l3].sample,
                          :name => Faker::Cat.name,
                          :email => Faker::Internet.email,
                          :cellphone => "12345678",
                          :content => Faker::Lorem.paragraph,
                          :created_at => Time.now - rand(10).days - rand(24).hours)
    end


  end
end
