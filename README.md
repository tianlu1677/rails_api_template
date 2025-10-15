# Rails API Template

[![Github Actions CI](https://github.com/tianlu1677/rails_api_template/actions/workflows/ci.yml/badge.svg?event=push)](https://github.com/tianlu1677/rails_api_template/actions)

Rails API Base is a production-ready boilerplate project for JSON RESTful APIs. It follows community best practices in terms of standards, security, and maintainability, integrating a comprehensive suite of testing and code quality tools. Built on Rails 8.0 and Ruby 3.4.

The template includes a plug-and-play Administration console powered by [ActiveAdmin](https://github.com/activeadmin/activeadmin), background job processing with [GoodJob](https://github.com/bensheldon/good_job), and feature flag management via [Flipper](https://github.com/jnunemaker/flipper).

## Features

This template comes with:

### Database Schema
- **Users** - JWT-authenticated users with profile management
- **Admin Users** - Separate admin accounts for administrative access
- **Posts** - Example resource with full CRUD operations
- **Settings** - Key-value configuration store
- **Feature Flags** - Flipper feature flag system
- **Background Jobs** - GoodJob queue tables

### API Endpoints (v1)
- **Authentication** (via Devise + JWT)
  - Sign up with user credentials (`POST /users`)
  - Sign in with user credentials (`POST /users/sign_in`)
  - Sign out (`DELETE /users/sign_out`)
  - Reset password (`POST /users/password`, `PUT /users/password`)
  - Email confirmations
- **User Profile**
  - Get current user (`GET /api/v1/user`)
  - Update current user (`PUT /api/v1/user`)
- **Posts** (Full CRUD with pagination & search)
  - List posts (`GET /api/v1/posts`)
  - Get post (`GET /api/v1/posts/:id`)
  - Create post (`POST /api/v1/posts`)
  - Update post (`PUT /api/v1/posts/:id`)
  - Delete post (`DELETE /api/v1/posts/:id`)
- **Settings**
  - Check minimum app version (`GET /api/v1/settings/must_update`)
- **Health Check**
  - API status (`GET /api/v1/status`)

### Administration Panel
- ActiveAdmin dashboard with Arctic Admin theme
- User management interface
- Admin user management
- Feature flag management UI (`/admin/feature-flags`)
- Background job monitoring (`/admin/jobs` - GoodJob dashboard)
- PgHero database performance monitoring

### Infrastructure & Tools
- **Authentication**: Devise + Devise-JWT for token-based auth
- **Authorization**: Pundit for policy-based access control
- **API Documentation**: OpenAPI/Swagger via Rswag
- **Background Jobs**: GoodJob for async processing
- **Feature Flags**: Flipper with ActiveRecord adapter
- **Pagination**: Pagy (high-performance pagination)
- **Search/Filtering**: Ransack for query building
- **Error Tracking**: Sentry for production monitoring
- **Performance Monitoring**: New Relic APM
- **Code Quality**: RuboCop, Reek, Rails Best Practices, Brakeman
- **Testing**: RSpec with comprehensive coverage
- **Docker**: Full Docker and docker-compose support

## How to use

1. Clone this repo
1. Install PostgreSQL (if not already installed)
1. Install Node.js v22+ (version specified in `package.json` engines)
1. Install Yarn 4.4+ by running `corepack enable` (Corepack is included in modern Node.js)
1. Run the bootstrap script with your project name:
   ```bash
   ./bin/bootstrap.sh --name=my_awesome_project
   ```
1. Install dependencies and build assets:
   ```bash
   bundle install
   yarn install
   yarn build
   ```
1. Set up the database:
   ```bash
   bin/rails db:create db:migrate db:seed
   ```
1. (Optional) Run tests to verify everything works:
   ```bash
   bundle exec rspec
   # or with headless mode
   HEADLESS=true bundle exec rspec
   ```
1. Start the development server:
   ```bash
   bin/dev
   ```
   This starts both the Rails server and watches for JS/CSS changes.
1. Access the application:
   - **API**: http://localhost:3000/api/v1
   - **Admin Panel**: http://localhost:3000/admin
   - **API Documentation**: http://localhost:3000/api-docs
   - **Feature Flags**: http://localhost:3000/admin/feature-flags (requires admin login)
   - **Background Jobs**: http://localhost:3000/admin/jobs (requires admin login)

## How to use with Docker

1. Have `docker` and `docker-compose` installed (You can check this by doing `docker -v` and `docker-compose -v`)
1. Run `bootstrap.sh` with the name of your project and the `-d` or `--for-docker` flag like `./bin/bootstrap.sh --name=my_awesome_project -d`
    1. Run `./bin/bootstrap.sh --help` for the full details.
1. (Optional) If you want to deny access to the database from outside of the `docker-compose` network, remove the `ports` key in the `docker-compose.yml` from the `db` service.
1. (Optional) Run the tests to make sure everything is working with: `bin/rspec .`.
1. You can now try your REST services!

See [Docker docs](./docs/docker.md) for more info

## Dev scripts

This template provides a handful of scripts to make your dev experience better!

- bin/bundle to run any `bundle` commands.
  - `bin/bundle install`
- bin/rails to run any `rails` commands
  - `bin/rails console`
- bin/web to run any `bash` commands
  - `bin/web ls`
- bin/rspec to run specs
  - `bin/rspec .`
- bin/dev to run both Rails and JS build processes at the same time in a single terminal tab.
  - `bin/dev`

You don't have to use these but they are designed to run the same when running with Docker or not.
To illustrate, `bin/rails console` will run the console in the docker container when running with docker and locally when not.

## Key Gems & Libraries

### Core Framework
- [Rails 8.0](https://rubyonrails.org/) - Web application framework
- [Puma](https://github.com/puma/puma) - High-performance web server
- [PostgreSQL](https://github.com/ged/ruby-pg) - Database adapter
- [Bootsnap](https://github.com/Shopify/bootsnap) - Boot time optimization

### Authentication & Authorization
- [Devise](https://github.com/heartcombo/devise) - Authentication framework
- [Devise JWT](https://github.com/waiting-for-dev/devise-jwt) - JWT token authentication for APIs
- [Pundit](https://github.com/varvet/pundit) - Authorization with policies

### API Development
- [Jbuilder](https://github.com/rails/jbuilder) - JSON templating
- [Rack CORS](https://github.com/cyu/rack-cors) - Cross-Origin Resource Sharing
- [Rack Attack](https://github.com/rack/rack-attack) - Rate limiting and throttling
- [Rails Param](https://github.com/nicolasblanco/rails_param) - Parameter validation
- [OJ](https://github.com/ohler55/oj) - Fast JSON parser

### Admin & UI
- [ActiveAdmin](https://github.com/activeadmin/activeadmin) - Administration framework
- [Draper](https://github.com/drapergem/draper) - View decorators
- [JS Bundling](https://github.com/rails/jsbundling-rails) - JavaScript bundling with esbuild
- [CSS Bundling](https://github.com/rails/cssbundling-rails) - CSS bundling with Sass

### Background Jobs & Feature Flags
- [GoodJob](https://github.com/bensheldon/good_job) - PostgreSQL-based background jobs
- [Flipper](https://github.com/jnunemaker/flipper) - Feature flag system
- [Flipper ActiveRecord](https://github.com/jnunemaker/flipper) - ActiveRecord adapter for Flipper
- [Flipper UI](https://github.com/jnunemaker/flipper) - Web UI for managing feature flags

### Utilities & Tools
- [Pagy](https://github.com/ddnexus/pagy) - Fast pagination
- [Ransack](https://github.com/activerecord-hackery/ransack) - Object-based searching
- [YAAF](https://github.com/tianlu1677/yaaf) - Form objects
- [Enumerize](https://github.com/brainspec/enumerize) - Enumerated attributes
- [Groupdate](https://github.com/ankane/groupdate) - Time series grouping
- [Active Storage Base64](https://github.com/tianlu1677/active-storage-base64) - Base64 file uploads

### Monitoring & Error Tracking
- [New Relic](https://github.com/newrelic/newrelic-ruby-agent) - Application performance monitoring
- [Sentry](https://github.com/getsentry/sentry-ruby) - Error tracking and monitoring
- [PgHero](https://github.com/ankane/pghero) - Database performance monitoring
- [Lograge](https://github.com/roidrage/lograge) - Simplified Rails logging

### API Documentation
- [Rswag API](https://github.com/rswag/rswag) - OpenAPI documentation engine
- [Rswag UI](https://github.com/rswag/rswag) - Swagger UI for API docs
- [RSpec OpenAPI](https://github.com/exoego/rspec-openapi) - Generate OpenAPI from RSpec tests

### Development Tools
- [Annotaterb](https://github.com/drwl/annotaterb) - Schema annotations in model files
- [Better Errors](https://github.com/charliesome/better_errors) - Enhanced error pages
- [Pry Rails](https://github.com/pry/pry-rails) - Pry integration for Rails console
- [Pry Byebug](https://github.com/deivid-rodriguez/pry-byebug) - Debugger integration
- [Letter Opener](https://github.com/ryanb/letter_opener) - Preview emails in browser
- [Dotenv](https://github.com/bkeepers/dotenv) - Environment variable management
- [Listen](https://github.com/guard/listen) - File modification notifications

### Testing
- [RSpec Rails](https://github.com/rspec/rspec-rails) - Testing framework
- [Factory Bot](https://github.com/thoughtbot/factory_bot_rails) - Test data factories
- [Faker](https://github.com/faker-ruby/faker) - Fake data generation
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) - RSpec matchers
- [Capybara](https://github.com/teamcapybara/capybara) - Integration testing
- [Selenium WebDriver](https://github.com/SeleniumHQ/selenium) - Browser automation
- [Webmock](https://github.com/bblimke/webmock) - HTTP request stubbing
- [Simplecov](https://github.com/simplecov-ruby/simplecov) - Code coverage analysis
- [Parallel Tests](https://github.com/grosser/parallel_tests) - Run tests in parallel
- [Knapsack](https://github.com/KnapsackPro/knapsack) - Test suite time execution distributor
- [Prosopite](https://github.com/charkost/prosopite) - N+1 query detection
- [Chaotic Order](https://github.com/jbampton/chaotic_order) - Random test ordering

### Code Quality & Security
- [Rubocop](https://github.com/rubocop/rubocop) - Ruby style guide enforcement
- [Rubocop Rails](https://github.com/rubocop/rubocop-rails) - Rails-specific cops
- [Rubocop RSpec](https://github.com/rubocop/rubocop-rspec) - RSpec-specific cops
- [Rubocop Performance](https://github.com/rubocop/rubocop-performance) - Performance cops
- [Reek](https://github.com/troessner/reek) - Code smell detection
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices) - Rails code quality
- [Brakeman](https://github.com/presidentbeef/brakeman) - Security vulnerability scanner
- [I18n Tasks](https://github.com/glebm/i18n-tasks) - I18n key management

### Storage & Email
- [AWS SDK S3](https://github.com/aws/aws-sdk-ruby) - Amazon S3 integration
- [SendGrid](https://github.com/sendgrid/sendgrid-ruby) - Email delivery service

## Getting Started with Your Project

### Example Resource: Posts

The template includes a fully functional `Post` resource that demonstrates best practices:

```ruby
# Model with user association
class Post < ApplicationRecord
  belongs_to :user
end

# Full CRUD API endpoints at /api/v1/posts
- GET    /api/v1/posts           # List with pagination & search
- GET    /api/v1/posts/:id       # Show single post
- POST   /api/v1/posts           # Create post
- PUT    /api/v1/posts/:id       # Update post
- DELETE /api/v1/posts/:id       # Delete post
```

Use this as a template for creating your own resources!

### Creating a New Resource

To scaffold a new resource similar to Posts:

```bash
# Generate model, migration, controller, and specs
bin/rails generate model Article title:string body:text user:references
bin/rails generate controller api/v1/articles

# Run migration
bin/rails db:migrate

# Add route to config/routes.rb
namespace :api do
  namespace :v1 do
    resources :articles
  end
end

# Add to ActiveAdmin (optional)
# Create app/admin/article.rb
```

## Configuration

### Required Environment Variables

Create a `.env` file in the root directory:

```bash
# Database
DATABASE_URL=postgresql://localhost/rails_api_template_development

# Email (SendGrid)
SENDGRID_API_KEY=your_sendgrid_api_key
DEFAULT_EMAIL_SENDER=noreply@yourapp.com

# Authentication
JWT_SECRET_KEY=your_jwt_secret_key

# Monitoring (Optional)
NEW_RELIC_LICENSE_KEY=your_new_relic_key
NEW_RELIC_APP_NAME=YourAppName

SENTRY_DSN=your_sentry_dsn

# AWS S3 (for file uploads)
AWS_ACCESS_KEY_ID=your_aws_key
AWS_SECRET_ACCESS_KEY=your_aws_secret
AWS_REGION=us-east-1
AWS_BUCKET=your-bucket-name
```

### Optional Configuration

- **CORS**: Set your [frontend URL](https://github.com/cyu/rack-cors#origin) in `config/initializers/rack_cors.rb`
- **Email**: Configure your mail sender in `config/initializers/devise.rb`
- **Timezone**: Set your timezone in `config/application.rb`
- **Feature Flags**: Manage features at `/admin/feature-flags`
- **CI Parallel Execution**: See [CI docs](docs/ci.md)
- **Fullstack Development**: See [Fullstack docs](docs/fullstack.md)

## API Documentation

This project uses OpenAPI (Swagger) specification for API documentation:

### Viewing Documentation

Access the interactive API documentation at:
- **Swagger UI**: http://localhost:3000/api-docs

### Generating Documentation

The OpenAPI spec is automatically generated from RSpec request specs using RSpec OpenAPI:

```bash
# Run specs to generate/update OpenAPI documentation
OPENAPI=1 bundle exec rspec spec/requests

# The generated spec is saved to doc/openapi.yaml
```

### Writing API Tests

When writing request specs, tag them appropriately:

```ruby
RSpec.describe 'Posts API', type: :request do
  describe 'GET /api/v1/posts' do
    it 'returns a list of posts' do
      get '/api/v1/posts', headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end
end
```

See [API documentation docs](./docs/api_documentation.md) for more details.

## Code Quality & Analysis

### Running All Checks

Run the complete code analysis suite:

```bash
bundle exec rails code:analysis
```

This runs:
- **RuboCop** - Ruby style guide enforcement
- **Reek** - Code smell detection  
- **Rails Best Practices** - Rails-specific best practices
- **Brakeman** - Security vulnerability scanning

### Individual Tools

```bash
# RuboCop - Style guide enforcement
bundle exec rubocop
bundle exec rubocop -a  # Auto-correct safe issues

# Reek - Code smell detection
bundle exec reek

# Rails Best Practices
bundle exec rails_best_practices

# Brakeman - Security analysis
bundle exec brakeman
```

### Configuration

Customize code quality rules:
- **RuboCop**: Edit `.rubocop.yml`
- **Reek**: Edit `config.reek`
- **Rails Best Practices**: Edit `config/rails_best_practices.yml`
- **Brakeman**: Run `brakeman -I` to generate `config/brakeman.ignore`

## Testing

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run with coverage report
COVERAGE=true bundle exec rspec

# Run specific file or folder
bundle exec rspec spec/models/user_spec.rb
bundle exec rspec spec/requests

# Run in parallel (faster for large test suites)
bundle exec parallel_rspec spec/

# Run in headless mode (for feature specs)
HEADLESS=true bundle exec rspec
```

### Test Coverage

The project uses **SimpleCov** for test coverage analysis:

```bash
# Generate coverage report
COVERAGE=true bundle exec rspec

# View report at coverage/index.html
open coverage/index.html
```

### N+1 Query Detection

The test suite includes **Prosopite** for detecting N+1 queries:

```bash
# Prosopite will raise errors when N+1 queries are detected
bundle exec rspec

# Configure in spec/rails_helper.rb
```

## Monitoring & Performance

### New Relic APM

Monitor application performance and errors:

1. Sign up at [New Relic](https://newrelic.com)
2. Set environment variables:
   ```bash
   NEW_RELIC_LICENSE_KEY=your_license_key
   NEW_RELIC_APP_NAME=YourAppName
   ```
3. Deploy and view metrics in New Relic dashboard

Configuration: `config/newrelic.yml`

### Sentry Error Tracking

Track and debug production errors:

1. Create project at [Sentry.io](https://sentry.io)
2. Set environment variable:
   ```bash
   SENTRY_DSN=your_sentry_dsn
   ```
3. Errors are automatically captured and reported

### Database Performance (PgHero)

Monitor database performance at `/admin` (requires admin login):
- Query performance
- Index usage
- Slow queries
- Database size metrics

### Background Job Monitoring

Monitor and manage background jobs via **GoodJob Dashboard**:
- Access at `/admin/jobs` (requires admin login)
- View queued, running, and failed jobs
- Retry failed jobs
- Monitor job performance

## Additional Linters

### Hadolint (Docker Linting)

Lint Dockerfiles for best practices:

```bash
# Install
brew install hadolint

# Run
hadolint Dockerfile*

# Configure
# Edit .hadolint.yml to customize rules
```

## Feature Flags

The project uses **Flipper** for feature flag management:

### Managing Feature Flags

1. **Via Admin UI**: Navigate to `/admin/feature-flags` (requires admin login)
2. **In Code**:

```ruby
# Check if feature is enabled
if Flipper.enabled?(:new_feature)
  # New feature code
else
  # Old feature code
end

# Enable for specific users
Flipper.enable_actor(:new_feature, current_user)

# Enable for percentage of users
Flipper.enable_percentage_of_actors(:new_feature, 25)

# Enable globally
Flipper.enable(:new_feature)
```

### Defining Feature Flags

Add feature flags in `config/feature-flags.yml` or create them via the UI.

See [Feature Flags documentation](docs/feature_flags.md) for more details.

## Common Workflows

### Adding a New API Endpoint

1. **Generate Controller & Routes**:
   ```bash
   bin/rails generate controller api/v1/articles
   ```

2. **Add Route** in `config/routes.rb`:
   ```ruby
   namespace :api do
     namespace :v1 do
       resources :articles
     end
   end
   ```

3. **Implement Controller**:
   ```ruby
   module API::V1
     class ArticlesController < APIController
       def index
         @articles = Article.all
       end
     end
   end
   ```

4. **Create View** (Jbuilder template):
   ```ruby
   # app/views/api/v1/articles/index.json.jbuilder
   json.articles @articles do |article|
     json.id article.id
     json.title article.title
   end
   ```

5. **Write Tests**:
   ```ruby
   # spec/requests/api/v1/articles_spec.rb
   RSpec.describe 'Articles API', type: :request do
     describe 'GET /api/v1/articles' do
       it 'returns articles' do
         get '/api/v1/articles', headers: auth_headers
         expect(response).to have_http_status(:ok)
       end
     end
   end
   ```

### Authentication Flow

**For API clients:**

1. **Sign Up**: `POST /users` with user credentials
2. **Sign In**: `POST /users/sign_in` → Returns JWT token in headers
3. **Use Token**: Include token in subsequent requests:
   ```
   Authorization: Bearer <access-token>
   ```
4. **Sign Out**: `DELETE /users/sign_out`

**JWT Headers returned after sign in:**
- `authorization`: Bearer token
- `uid`: User identifier
- `client`: Client identifier

### Creating Background Jobs

```bash
# Generate job
bin/rails generate job ProcessData

# In app/jobs/process_data_job.rb
class ProcessDataJob < ApplicationJob
  queue_as :default
  
  def perform(user_id)
    user = User.find(user_id)
    # Process data
  end
end

# Enqueue job
ProcessDataJob.perform_later(user.id)

# Monitor at /admin/jobs
```

## Deployment

### Environment Setup

Ensure all required environment variables are set (see Configuration section).

### Heroku Deployment

The project includes `heroku.yml` for container-based deployment:

```bash
# Create Heroku app
heroku create your-app-name

# Set environment variables
heroku config:set JWT_SECRET_KEY=your_secret

# Deploy
git push heroku main

# Run migrations
heroku run rails db:migrate

# Create admin user
heroku run rails console
> AdminUser.create!(email: 'admin@example.com', password: 'password')
```

### Docker Deployment

```bash
# Build image
docker build -t rails-api .

# Run with docker-compose
docker-compose up
```

See [Docker documentation](docs/docker.md) for more details.

## Project Structure

```
app/
├── admin/              # ActiveAdmin configuration
├── controllers/        # Controllers
│   ├── api/v1/        # API v1 endpoints
│   └── users/         # Devise user controllers
├── models/            # ActiveRecord models
├── policies/          # Pundit authorization policies
├── jobs/              # Background jobs
├── mailers/           # Email mailers
└── views/             # Jbuilder views for JSON APIs

config/
├── initializers/      # Framework initializers
└── routes.rb          # Application routes

spec/                  # RSpec tests
├── models/           # Model tests
├── requests/         # Request/integration tests
├── policies/         # Policy tests
└── factories/        # FactoryBot factories

docs/                  # Documentation
```

## Code Owners

You can use [CODEOWNERS](https://help.github.com/en/articles/about-code-owners) file to define individuals or teams that are responsible for code in the repository.

Code owners are automatically requested for review when someone opens a pull request that modifies code that they own.

## Credits

Rails API Template is maintained by [tianlu1677](http://www.tianlu1677.com) with the help of our
[contributors](https://github.com/tianlu1677/rails_api_template/contributors).

## Thanks

I've gained a lot of inspiration. Thanks https://github.com/rootstrap/rails_api_base