# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create sample credentials
Credential.create!([
  {
    title: "Senior Full-Stack Engineer",
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
  industry: "Local Services",
  challenge_summary: "Building a full-featured motorcycle services marketplace with native iOS app as a solo developer",
  challenge_details: "As a solo founder, I set out to build the #1 hub for motorcycle riders to find trusted service providers across 8 categories: storage, mechanics, detailing, mentoring, gear, training, towing, and insurance. The platform needed a complete booking system, provider subscriptions (Stripe + Apple IAP), business claim verification, admin moderation workflows, and a native iOS app—all without hiring a team or learning Swift.",
  solution: "Built a comprehensive two-sided marketplace using Rails 8 with Hotwire and Turbo Native. The platform features real-time booking management, multi-channel notifications (in-app, push, email), Stripe and Apple In-App Purchase payment processing, a business claim system with document verification, duplicate detection with fuzzy matching, and full admin tools for moderation. Wrapped the entire experience in Hotwire Native to ship a native iOS app to the App Store—100% shared codebase, zero Swift code.",
  results: "Launched a production marketplace at ridementor.com with native iOS app on the App Store. The platform supports provider subscriptions ($79/month unlimited plan), processes bookings across 8 service categories, and includes complete admin tooling for approval workflows, review moderation, and marketing campaigns. Deployed via Kamal with automated PostgreSQL backups to S3.",
  metrics: {
    "Team size" => "Solo developer",
    "Service categories" => "8",
    "Platforms shipped" => "Web + iOS",
    "Test coverage" => "1,239+ tests"
  },
  testimonial_quote: "Building RideMentor solo proved that with Rails 8, Hotwire, and Turbo Native, a single developer can ship a sophisticated multi-platform marketplace. This is the power I bring to every client engagement.",
  testimonial_author: "Dmitry Sychev",
  testimonial_role: "Founder, Axium Foundry & RideMentor",
  featured: true,
  published: true,
  position: 1
)

# Create technologies
technologies = [
  # Backend & Core
  { name: "Ruby", category: "backend", proficiency_level: 5, featured: true },
  { name: "Rails", category: "backend", proficiency_level: 5, featured: true },
  { name: "PostgreSQL", category: "backend", proficiency_level: 5, featured: true },
  { name: "MongoDB", category: "backend", proficiency_level: 4, featured: true },
  { name: "Solid Queue", category: "backend", proficiency_level: 5, featured: true },

  # Frontend
  { name: "JavaScript", category: "frontend", proficiency_level: 5, featured: true },
  { name: "HTML5", category: "frontend", proficiency_level: 5, featured: true },
  { name: "CSS", category: "frontend", proficiency_level: 5, featured: true },
  { name: "Tailwind CSS", category: "frontend", proficiency_level: 5, featured: true },
  { name: "Bootstrap", category: "frontend", proficiency_level: 4, featured: false },

  # Database & Infrastructure
  { name: "Git", category: "devops", proficiency_level: 5, featured: true },
  { name: "Docker", category: "devops", proficiency_level: 5, featured: true },
  { name: "Heroku", category: "devops", proficiency_level: 5, featured: true },
  { name: "Hetzner", category: "devops", proficiency_level: 4, featured: true },
  { name: "Kamal", category: "devops", proficiency_level: 5, featured: true },
  { name: "RSpec", category: "devops", proficiency_level: 5, featured: true }
]

technologies.each do |tech|
  Technology.find_or_create_by!(name: tech[:name]) do |t|
    t.category = tech[:category]
    t.proficiency_level = tech[:proficiency_level]
    t.featured = tech[:featured]
  end
end

User.find_or_create_by!(email: "admin@axiumfoundry.com") do |user|
  user.password = "changeme123"
  user.password_confirmation = "changeme123"
end

puts "Seed data created successfully!"
