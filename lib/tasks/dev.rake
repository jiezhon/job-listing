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

    1000.times do |i|
      job.resumes.create!(:name => Faker::Cat.name,
                          :email => Faker::Internet.email,
                          :cellphone => "12345678",
                          :content => Faker::Lorem.paragraph,
                          :created_at => Time.now - rand(10).days - rand(24).hours)
    end

    
  end
end
