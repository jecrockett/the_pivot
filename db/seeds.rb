class Seed
  def initialize
    generate_users
    generate_specific_users
    generate_categories
    generate_causes
    generate_donations
    generate_pending_causes
    featured_cause_user
    deleted_user_placeholder
    deleted_cause_placeholder
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
    120.times do |i|
      user = User.create!(
        username:     Faker::Name.first_name,
        email:    Faker::Internet.email,
        password_digest: User.digest('password'),
        )
      puts "User #{i}: #{user.username} created!"
    end
  end

  def generate_causes
    600.times do |i|
      cause = Cause.create!(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(10),
      image_url: Faker::Avatar.image,
      goal: rand(100..10000),
      user_id: User.pluck(:id).sample,
      category_id: Category.pluck(:id).sample,
      current_status: 'active'
      )
      puts "Cause #{i}: #{cause.title} created!"
    end
  end

  def generate_pending_causes
    10.times do |i|
      cause = Cause.create!(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(4),
      image_url: Faker::Avatar.image,
      goal: rand(100..100000),
      user_id: User.pluck(:id).sample,
      category_id: Category.pluck(:id).sample,
      )
      puts "Pending cause #{i}: #{cause.title} created!"
    end
  end

  def generate_specific_users
    User.create!(
    username:     'steve',
    email:    'steve@dreambuilder.com',
    password_digest: User.digest('password'),
    role: 1
    )
    User.create!(
    username:     'jamie',
    email:    'jamie@dreambuilder.com',
    password_digest: User.digest('password'),
    role: 1
    )
    User.create!(
    username:     'david',
    email:    'david@dreambuilder.com',
    password_digest: User.digest('password'),
    role: 1
    )
    User.create!(
    username:     'jorge',
    email:    'jorge@turing.io',
    password_digest: User.digest('password'),
    role: 1
    )
    User.create!(
    username:     'andrew',
    email:    'andrew@turing.io',
    password_digest: User.digest('password'),
    role: 1
    )
  end

  def featured_cause_user
    User.create!(
    username:     'mike_dao',
    email:    'mike_dao@dreambuilder.com',
    password_digest: User.digest('password'),
    )
    User.create!(
    username:     'josh',
    email:    'josh@turing.io',
    password_digest: User.digest('password'),
    )
  end

  def deleted_cause_placeholder
    cause = Cause.create!(
    title: "Dead Dream",
    description: "Dream, dream, little angel",
    image_url: Faker::Avatar.image,
    goal: 0,
    user_id: User.find_by(email: "gone@heaven.com").id,
    category_id: 1,
    current_status: 'active'
    )
  end

  def deleted_user_placeholder
    user = User.create!(
    username: "Dead Person",
    email: "gone@heaven.com",
    password_digest: User.digest('password')
    )
  end

  def generate_donations
    User.all.each do |user|
      15.times do |i|
        cause_id = Cause.pluck(:id).sample
        cause_title = Cause.find(cause_id).title
        user.donations.create(amount: rand(1..200),
                              user_id: user.id,
                              cause_id: cause_id,
                              cause_name: cause_title,
                              stripe_token: "tok_17d5KG2eZvKYlo2CVqCp7FQl")
        puts "#{user.username} donated to #{cause_title}!"
      end
    end
  end

  def moon
    Cause.create!(
    title: "Colonize The Moon",
    description: "Act now before Elon Musk owns the whole damn thing",
    image_url: '/assets/moon-pic.jpg',
    goal: 100000,
    user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
    category_id: Category.pluck(:id).sample,
    current_status: "active")
  end

  def potato
    Cause.create!(
    title: "Potato Salad",
    description: "Leonard's greatest ambition is to make Potato Salad",
    image_url: "/assets/potato-salad.jpg",
    goal: 13,
    user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
    category_id: Category.pluck(:id).sample,
    current_status: "active")
  end

  def squirrel
    Cause.create!(
    title: "Squirrel Census",
    description: "Those furry little bastards have flown under the radar for far too long",
    image_url: "/assets/squirrel_pic.jpg",
    goal: 25000,
    user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
    category_id: Category.pluck(:id).sample,
    current_status: "active")
  end

  def ostrich
    Cause.create!(
    title: "Ostrich Pillow",
    description: "Get your nap on anytime, anywhere",
    image_url: "/assets/ostrich-pillow.jpeg",
    goal: 3800,
    user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
    category_id: Category.pluck(:id).sample,
    current_status: "active")
  end
end

Seed.new
