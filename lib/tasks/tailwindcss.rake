namespace :tailwindcss do
  desc "Build the customer-facing Tailwind and DaisyUI stylesheet"
  task build_users: :environment do
    input = Rails.root.join("app/assets/tailwind/users.css")
    output = Rails.root.join("app/assets/builds/users.css")
    command = [Tailwindcss::Ruby.executable, "-i", input.to_s, "-o", output.to_s]
    command << "--minify" unless Rails.application.config.assets.css_compressor.present?
    system(*command, exception: true)
  end
end

Rake::Task["assets:precompile"].enhance(["tailwindcss:build_users"])
