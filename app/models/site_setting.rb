class SiteSetting < ApplicationRecord
  CONTENT_DEFAULTS = {
    "site_title" => "Foundry CRM - Technical Consultancy for Startups",
    "site_description" => "Expert technical consultancy for ambitious startups. Ship faster without hiring senior developers. Fractional CTO services, technical leadership, and engineering excellence.",

    "nav_logo" => "Foundry CRM",
    "nav_work" => "Work",
    "nav_about" => "About",
    "nav_cta" => "Get Started",

    "home_hero_heading" => "Ship faster.",
    "home_hero_accent" => "Without the headcount.",
    "home_hero_description" => "Expert technical leadership for ambitious startups. Senior engineering expertise without the full-time hire.",
    "home_hero_cta" => "Get Free Health Check",
    "home_hero_secondary_cta" => "View My Work →",

    "home_services_heading" => "What I Do",
    "home_services_description" => "Full-stack expertise from idea to production. I build, modernize, deploy, and scale.",

    "home_service_1_title" => "Ship Products Faster",
    "home_service_1_description" => "Rapid prototyping to production-ready products. Build and launch MVPs, web apps, and native iOS in weeks, not months. Validate your idea quickly with senior engineering judgment.",
    "home_service_1_tags" => "MVP Development • Modern Rails • iOS • Web",

    "home_service_2_title" => "Rescue & Modernize",
    "home_service_2_description" => "Revive slow or outdated Rails applications. Update to modern Rails, fix performance issues, eliminate technical debt, and reduce hosting costs. Your app will feel brand new.",
    "home_service_2_tags" => "Rails Upgrades • Performance Tuning • Cost Reduction",

    "home_service_3_title" => "Deploy & Scale",
    "home_service_3_description" => "Launch anywhere, scale confidently. I handle deployment, monitoring, and infrastructure, without vendor lock-in. Own your stack, control your costs.",
    "home_service_3_tags" => "Kamal • Docker • Any Cloud • Monitoring",

    "home_service_4_title" => "Integrate & Extend",
    "home_service_4_description" => "Connect payments, SMS, email, and other services. Add native iOS apps without hiring mobile teams. Expand your platform without rebuilding from scratch.",
    "home_service_4_tags" => "APIs • Stripe • Twilio • SendGrid • Turbo Native",

    "home_service_5_title" => "White Label AI Agents",
    "home_service_5_description" => "Custom AI agents integrated into your product. Customer support, data analysis, content generation, workflow automation. Fully white labeled as your product.",
    "home_service_5_tags" => "LLM Integration • Custom Agents • RAG • Function Calling",
    "home_service_learn_more" => "Learn more →",

    "home_credentials_heading" => "Proven Track Record",
    "home_credentials_description" => "Trusted by fast-growing startups to solve their toughest technical challenges",

    "home_case_study_heading" => "Latest Success Story",
    "home_case_study_description" => "Real results from real startups. See how I help companies ship faster.",
    "home_case_study_challenge_label" => "The Challenge",
    "home_case_study_solution_label" => "The Solution",
    "home_case_study_results_label" => "The Results",
    "home_case_study_link" => "View All Case Studies →",

    "home_cta_heading" => "Ready to ship faster?",
    "home_cta_description" => "I take on 2-3 projects at a time. Get a free technical health check and I'll identify quick wins to accelerate your product development.",
    "home_cta_button" => "Get Your Free Health Check",

    "about_heading" => "About",
    "about_heading_accent" => "Foundry CRM",
    "about_description" => "Expert technical leadership for startups. Honest advice. Fast execution.",
    "about_back_link" => "Back to Home",

    "about_story_heading" => "Why Foundry CRM Exists",
    "about_story_p1" => "I started Foundry CRM after seeing the same problem over and over: ambitious founders with great ideas, stuck waiting months to hire senior engineers or burning cash on offshore teams that deliver technical debt.",
    "about_story_p2" => "The typical options all suck. Heroku-style platforms lock you in and cost 3x more. AWS overwhelms with complexity. Offshore dev shops produce code you'll spend twice as much fixing later. Junior developers mean months of management overhead. And hiring senior engineers? That's 3-6 months of recruiting before a single line of code.",
    "about_story_highlight" => "There had to be a better way.",
    "about_story_p3" => "Foundry CRM is that better way. You get senior engineering expertise when you need it, without the overhead of full time hires. I build fast, I build right, and I don't lock you into anything proprietary. You own your code, you control your infrastructure, and you can hire your own team whenever you're ready.",

    "about_process_heading" => "How I Work",
    "about_process_1_title" => "Free Health Check",
    "about_process_1_description" => "I start every engagement with a free consultation. You explain your situation, I give you honest technical advice. No sales pitch. If I don't think I can help, I'll tell you. If there's a better approach than what you're considering, I'll explain why.",
    "about_process_2_title" => "Clear Scope & Timeline",
    "about_process_2_description" => "No vague estimates. I'll write a detailed scope document that explains exactly what I'm building, what's included, what's not, and how long it will take. You'll know what to expect before I start.",
    "about_process_3_title" => "Weekly Demos & Updates",
    "about_process_3_description" => "You see progress every week. I show you what's working, what's next, and where I need your input. No disappearing for weeks and hoping it turns out right. Continuous feedback means I build exactly what you need.",
    "about_process_4_title" => "Ship Production-Ready Code",
    "about_process_4_description" => "When I launch, it's ready. Tests, monitoring, documentation, deployment automation. Your future team can take over seamlessly, or you can keep working with me. Either way, you own everything.",
    "about_process_5_title" => "Your Choice What Happens Next",
    "about_process_5_description" => "After launch, it's up to you. Many clients keep me on retainer for ongoing development and support. Others hire their own team and transition gradually. Some come back for specific projects. No long term contracts. No lock-in. Work with me as long as it makes sense.",

    "about_beliefs_heading" => "What I Believe",
    "about_belief_1_title" => "Honest Technical Advice",
    "about_belief_1_description" => "I'll tell you what you need to hear, not what you want to hear. If you're overbuilding, I'll tell you. If you're considering the wrong stack, I'll explain why. Honest advice saves you time and money.",
    "about_belief_2_title" => "No Vendor Lock-In",
    "about_belief_2_description" => "You own your code, you own your data, you own your infrastructure. I don't build proprietary systems that trap you. If you want to move on, you can. If you want to hire your own team, great. I'll help with the transition.",
    "about_belief_3_title" => "Modern Tools, Proven Stack",
    "about_belief_3_description" => "Rails isn't trendy, it's proven. It powers Shopify, GitHub, Basecamp, and thousands of successful startups. Combined with modern deployment tools, it's the fastest way to build and the cheapest way to run.",
    "about_belief_4_title" => "Speed Without Shortcuts",
    "about_belief_4_description" => "Fast doesn't mean sloppy. I move quickly because I use the right tools and have done this many times before. But I never skip tests, monitoring, or proper architecture. Fast and right aren't mutually exclusive.",
    "about_belief_5_title" => "Based in NYC, Available Everywhere",
    "about_belief_5_description" => "I'm based in NYC and work with startups across the country. Local clients get the option of in-person meetings, but most work happens remotely. Whether you're in New York or anywhere else, you get the same level of attention and expertise.",
    "about_belief_6_title" => "One Person, Real Expertise",
    "about_belief_6_description" => "You work directly with me, not a sales team that hands you off to junior developers. I've built products, scaled startups, and know what actually works. No account managers. No surprises. Just senior engineering expertise.",

    "about_tech_heading" => "Why Rails, Hotwire, and Turbo Native?",
    "about_tech_rails" => "Rails is still the fastest way to build web applications. It's been around since 2004, powers some of the biggest companies in tech, and has a massive ecosystem of gems and developers. Most importantly, it lets you ship fast without accumulating technical debt.",
    "about_tech_hotwire" => "Hotwire and Turbo let you build modern, reactive interfaces without heavy JavaScript frameworks. You get the speed and interactivity users expect, with less complexity and better maintainability. No more managing state across two separate applications (backend and frontend).",
    "about_tech_turbo_native" => "Turbo Native is the secret weapon for mobile. Wrap your Rails app in a native iOS shell and you have a real App Store app with 100% code sharing. Companies like Basecamp and HEY have proven this approach works at scale. For startups, it means shipping mobile without hiring mobile developers.",
    "about_tech_highlight" => "This isn't the newest stack. It's the stack that works.",
    "about_tech_alt_heading" => "What if you need something else?",
    "about_tech_alt_description" => "I'm pragmatic. If your specific requirements genuinely need a different stack, I'll tell you honestly and potentially recommend other partners. But 95% of startups don't need the complexity of microservices, separate frontend frameworks, or native mobile codebases. Rails + Hotwire + Turbo Native covers most use cases faster and cheaper.",

    "about_clients_heading" => "Who I Work With",
    "about_client_1_title" => "Pre-Seed & Seed Stage Startups",
    "about_client_1_description" => "You have an idea and maybe some early customers. You need to build an MVP fast and validate product market fit before hiring a full team. You want senior judgment, not junior execution.",
    "about_client_2_title" => "Companies with Legacy Rails Apps",
    "about_client_2_description" => "Your Rails app is slow, outdated, or expensive to run. The original developer is gone. Your current team is afraid to touch it. You need someone who can rescue and modernize without a full rewrite.",
    "about_client_3_title" => "Solo Founders Who Need Technical Leadership",
    "about_client_3_description" => "You're technical enough to be dangerous but not experienced enough to build production systems. You want someone who can make architectural decisions, not just write code. You need a technical co-founder, but hiring one hasn't worked out.",
    "about_client_4_title" => "Startups Between Engineering Hires",
    "about_client_4_description" => "Your CTO or senior engineer just left. You're recruiting but it takes months. Meanwhile, your product needs updates, bugs need fixes, and customers are waiting. You need someone senior to keep things moving.",

    "about_cta_heading" => "Let's make something great together",
    "about_cta_description" => "I keep my client list small so I can give each project real attention. Get a free health check. Honest advice, no obligation.",
    "about_cta_button" => "Get Your Free Health Check →",
    "about_cta_secondary" => "View My Work",

    "footer_quick_links_heading" => "Quick Links",
    "footer_connect_heading" => "Connect",
    "footer_description" => "Expert technical consultancy for ambitious startups. Ship faster without hiring senior developers.",
    "footer_cta" => "Start a Project →",
    "footer_copyright" => "Foundry CRM. Licensed under Elastic License 2.0.",

    "footer_email" => "hello@example.com",
    "footer_location" => "New York, NY",

    "health_check_heading" => "Get Your Free\nHealth Check",
    "health_check_description" => "30-minute technical audit of your startup's engineering practices",
    "health_check_submit" => "Request Free Health Check →",
    "health_check_privacy" => "I respect your privacy. Your information will only be used to contact you about your health check.",

    "case_studies_heading" => "My Work",
    "case_studies_description" => "Real results from real startups. See how I help companies ship faster without hiring senior developers.",
    "case_studies_view_link" => "View Case Study →",
    "case_studies_empty_heading" => "Case studies coming soon",
    "case_studies_empty_description" => "I'm wrapping up some exciting projects. In the meantime, let's talk about yours.",
    "case_studies_empty_cta" => "Get in Touch →",
    "case_studies_cta_heading" => "Want similar results?",
    "case_studies_cta_description" => "Let's discuss how I can help your startup ship faster. Get a free technical health check.",
    "case_studies_cta_button" => "Get Your Free Health Check",
    "case_studies_cta_back" => "← Back to Home",

    "case_study_back_link" => "All Case Studies",
    "case_study_challenge_label" => "The Challenge",
    "case_study_solution_label" => "The Solution",
    "case_study_results_label" => "The Results",
    "case_study_cta_heading" => "Ready for similar results?",
    "case_study_cta_description" => "Let's discuss how I can help your startup ship faster. Get a free technical health check.",
    "case_study_cta_button" => "Get Your Free Health Check",
    "case_study_cta_back" => "← Back to All Case Studies",

    "chat_title" => "Foundry CRM",
    "chat_subtitle" => "AI Assistant",
    "chat_welcome" => "Hi! I'm the Foundry CRM AI assistant. Ask me about our services, capabilities, or how we can help your startup ship faster.",
    "chat_system_prompt" => "You are a helpful AI assistant for this business. Answer questions about services, capabilities, and expertise.\n\nYour role:\n- Be professional, concise, and genuinely helpful\n- If you have relevant context from the knowledge base, use it to give accurate answers\n- When visitors seem interested in working together, suggest they use the contact form\n- If you don't have specific information, say so honestly and offer to connect them with the team\n- Keep responses conversational and under 150 words unless more detail is needed"
  }.freeze

  validates :business_name, presence: true

  def self.current
    first || create!(business_name: "Foundry CRM")
  end

  def text(key)
    content&.dig(key).presence || CONTENT_DEFAULTS[key] || ""
  end
end
