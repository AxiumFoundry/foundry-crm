# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create sample credentials
Credential.create!([
  {
    title: "4+ Years Full-Stack Development",
    organization: "Material (Associate Director)",
    description: "Led greenfield projects, mentored offshore teams, and reduced onboarding from 4 weeks to days with Docker",
    credential_type: "experience",
    featured: true,
    position: 1
  },
  {
    title: "Fullstack Lead Engineer",
    organization: "Chirrup (Travel Tech SaaS)",
    description: "Architected and launched production CRM platform with multi-API integration serving 100+ tour operators",
    credential_type: "experience",
    featured: true,
    position: 2
  },
  {
    title: "Solo Founder & Developer",
    organization: "RideMentor (Marketplace Platform)",
    description: "Shipped both web and native iOS app to App Store as solo developer using Rails + Turbo Native",
    credential_type: "experience",
    featured: true,
    position: 3
  }
])

# Create Chirrup case study
CaseStudy.create!(
  client_name: "Chirrup",
  industry: "SaaS & Travel Tech",
  challenge_summary: "A travel tech startup needed to build a specialized CRM from scratch for tour operators losing customers to missed calls and slow response times",
  challenge_details: "The founding team identified a critical gap in the market: Hawaii-based tour and activity operators were losing bookings because when potential customers called and didn't get through, they'd simply book with a competitor. The travel industry needed a specialized CRM that could handle two-way texting, integrate with booking platforms like FareHarbor, automate follow-ups, and turn missed calls into captured leads. No existing solution was purpose-built for the tour operator workflow—it needed to be designed specifically for their industry from the ground up.",
  solution: "Partnered with the founding team to architect and build a complete customer communication platform from scratch using Rails and PostgreSQL. Integrated multiple third-party APIs (Twilio for SMS, Slack for team notifications, SendGrid for email, Magpie for phone systems, and FareHarbor for booking sync) into a unified team inbox. Created automated workflows for missed call recovery, scheduled reminder messages, quick reply templates, and an AI-powered chatbot trained on tour operator conversations. Designed a scalable multi-tenant database architecture to handle real-time communication across hundreds of operators.",
  results: "Successfully launched a production SaaS platform now serving tour operators across Hawaii and beyond. The platform processes thousands of customer conversations daily, automatically recovers leads from missed calls, and has become an essential tool for activity operators to manage customer relationships. Deployed on Heroku with 99.9% uptime and real-time synchronization across all integrated platforms.",
  metrics: {
    "API integrations" => "5 platforms",
    "Time to launch" => "8 months",
    "Uptime" => "99.9%",
    "Active operators" => "100+"
  },
  testimonial_quote: "Working with Dmitry was transformative for our business. He took our vision and turned it into a production-ready platform that our customers love. His ability to integrate complex APIs and design scalable systems was exactly what we needed.",
  testimonial_author: "Founder",
  testimonial_role: "CEO, Chirrup",
  featured: false,
  published: true,
  position: 2
)

# Create RideMentor case study
CaseStudy.create!(
  client_name: "RideMentor",
  industry: "Marketplace & EdTech",
  challenge_summary: "Building a two-sided marketplace iOS app as a solo developer without a mobile engineering background",
  challenge_details: "As a solo founder, I needed to build a complex two-sided marketplace connecting motorcycle riders with experienced mentors. The challenge wasn't just building the web app—I needed a native iOS experience without hiring a mobile team or learning Swift. The app required real-time features, complex matching logic, payment processing, and had to feel native on iOS while sharing 100% of the business logic with the web platform.",
  solution: "Leveraged Rails 8 with Hotwire and Turbo Native to build once, deploy everywhere. Built the entire backend and business logic in Rails, used Turbo to create real-time interactions without JavaScript frameworks, and wrapped the entire experience in Turbo Native for iOS. This allowed me to ship a native iOS app to the App Store as a solo Rails developer—no Swift, no separate mobile codebase, no mobile team required.",
  results: "Successfully launched both web and native iOS applications as a single developer. The Rails monolith powers both platforms with zero code duplication. Deployed to the iOS App Store and achieved feature parity between web and mobile with a fraction of the typical development time and cost.",
  metrics: {
    "Team size" => "Solo developer",
    "Platforms shipped" => "Web + iOS",
    "Shared codebase" => "100%",
    "Time to App Store" => "6 months"
  },
  testimonial_quote: "Building RideMentor solo taught me that with the right stack-Rails, Hotwire, and Turbo Native-you don't need a full team to ship sophisticated multi-platform applications. This is the power I bring to every client engagement.",
  testimonial_author: "Dmitry Sychev",
  testimonial_role: "Founder, Axium Foundry & RideMentor",
  featured: true,
  published: true,
  position: 1
)

# Create technologies
technologies = [
  # Backend
  { name: "Ruby on Rails", category: "backend", proficiency_level: 5, featured: true },
  { name: "Node.js", category: "backend", proficiency_level: 4, featured: true },
  { name: "Python", category: "backend", proficiency_level: 4, featured: false },
  { name: "Go", category: "backend", proficiency_level: 3, featured: false },

  # Frontend
  { name: "React", category: "frontend", proficiency_level: 4, featured: true },
  { name: "Hotwire/Turbo", category: "frontend", proficiency_level: 5, featured: true },
  { name: "TypeScript", category: "frontend", proficiency_level: 4, featured: true },
  { name: "Vue.js", category: "frontend", proficiency_level: 3, featured: false },

  # Database
  { name: "PostgreSQL", category: "database", proficiency_level: 5, featured: true },
  { name: "Redis", category: "database", proficiency_level: 4, featured: true },
  { name: "MongoDB", category: "database", proficiency_level: 3, featured: false },

  # DevOps
  { name: "AWS", category: "devops", proficiency_level: 4, featured: true },
  { name: "Docker", category: "devops", proficiency_level: 4, featured: true },
  { name: "Kubernetes", category: "devops", proficiency_level: 3, featured: false },
  { name: "CI/CD", category: "devops", proficiency_level: 5, featured: true }
]

technologies.each do |tech|
  Technology.find_or_create_by!(name: tech[:name]) do |t|
    t.category = tech[:category]
    t.proficiency_level = tech[:proficiency_level]
    t.featured = tech[:featured]
  end
end

puts "Seed data created successfully!"
