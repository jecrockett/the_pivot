class Seed
  def initialize
    generate_users
    generate_categories
    generate_causes
    generate_donations
    moon
    potato
    squirrel
    ostrich
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
      user_id: User.pluck(:id).sample,
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

  def moon
    Cause.create!(
    title: "Colonize The Moon",
    description: "Act now before Elon Musk owns the whole damn thing",
    image_url: Faker::Avatar.image,
    goal: 100000000000,
    user_id: User.pluck(:id).sample,
    category_id: Category.pluck(:id).sample)
  end

  def potato
    Cause.create!(
    title: "Potato Salad",
    description: "Leonard's greatest ambition is to make Potato Salad - help him achieve this noble goal",
    image_url: Faker::Avatar.image,
    goal: 12.75,
    user_id: User.pluck(:id).sample,
    category_id: Category.pluck(:id).sample)
  end

  def squirrel
    Cause.create!(
    title: "Squirrel Census",
    description: "Those furry little bastards have flown under the radar for far too long",
    image_url: Faker::Avatar.image,
    goal: 25000,
    user_id: User.pluck(:id).sample,
    category_id: Category.pluck(:id).sample)
  end

  def ostrich
    Cause.create!(
    title: "Ostrich Pillow",
    description: "Get your nap on anytime, anywhere",
    image_url: Faker::Avatar.image,
    goal: 3800,
    user_id: User.pluck(:id).sample,
    category_id: Category.pluck(:id).sample)
  end
end

Seed.new
