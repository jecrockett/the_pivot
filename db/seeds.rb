class Seed
  def initialize
    generate_causes
    generate_users
    generate_categories
    generate_donations
  end

  def generate_categories
    categories = %w(Tech Travel Food Art Fashion Music
                    Design Games Photography Theater Dance Crafts)
    12.times do |i|
      Category.create!(
        title: categories[i])
      puts "Category #{Category.last.title} created!"
    end
  end

  def generate_users
    20.times do |i|
      user = User.create!(
        username:     Faker::Name.name,
        email:    Faker::Internet.email,
        password_digest: User.digest('password'),
        )
      puts "User #{i}: #{user.username} - #{user.email} created!"
    end
  end

  def generate_causes
    100.times do |i|
      cause = Cause.create!(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(2),
      image_url: Faker::Avatar.image,
      goal: rand(100..100000),
      # user_id: User.pluck(:id).sample,
      category_id: Category.pluck(:id).sample
      )
    puts "Cause #{i}: #{cause.title} - #{cause.user} created!"
    end
  end

  def generate_donations
    Cause.all.each do |cause|
      5.times do |i|
        donation = Donation.create(amount: rand(1..200),
                                   user_id: User.pluck(:id).sample,
                                   cause_id: cause.id)
        cause.donations << donation
        puts "#{cause.title} received #{cause.donations.last.amount} dollars!"
      end
    end
  end
end

Seed.new
