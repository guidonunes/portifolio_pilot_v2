# Portfolio Pilot v2

A comprehensive financial portfolio management application built with Ruby on Rails. This is a learning project derived from a bootcamp final project, focusing on tracking both traditional stocks and cryptocurrencies in a unified interface.

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Running the Application](#running-the-application)
- [Key Fixes and Improvements](#key-fixes-and-improvements)
- [Project Structure](#project-structure)

## ✨ Features

- **Multi-Asset Portfolio Management**: Track both traditional stocks (Brazilian market) and cryptocurrencies in one place
- **Multiple Wallets**: Create and manage multiple wallets for different investment goals
- **Real-Time Price Updates**: Automatic price fetching from Brapi API (stocks) and CryptoCompare API (cryptocurrencies)
- **Performance Tracking**: View all-time profit/loss, best/worst performers, and percentage changes
- **Dark Theme Support**: Toggle between light and dark themes with persistent user preference
- **Multi-Language Support**: Available in English, Portuguese (Brazil), and German
- **Responsive Design**: Fully responsive layout for mobile and desktop devices
- **Brazilian Number Formatting**: Numbers displayed in Brazilian format (e.g., 400.000,89)
- **Price Privacy**: Toggle visibility of balance amounts with eye icon
- **Asset Allocation Visualization**: Interactive donut chart showing portfolio distribution

## 🛠 Tech Stack

- **Backend**: Ruby on Rails 7.1.3
- **Database**: PostgreSQL
- **Frontend**: 
  - Bootstrap 5.2
  - Stimulus.js
  - Chartkick for data visualization
- **Authentication**: Devise
- **Authorization**: Pundit
- **Background Jobs**: Sidekiq
- **APIs**: 
  - Brapi (Brazilian stock market data)
  - CryptoCompare (Cryptocurrency data)
- **Styling**: SCSS/Sass
- **Icons**: Font Awesome 6

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- Ruby 3.3.5
- Rails 7.1.3 or higher
- PostgreSQL (with Unix socket support)
- Node.js and npm
- Bundler gem

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd portifolio_pilot_v2
```

### 2. Install Dependencies

```bash
# Install Ruby gems (configured to install locally in vendor/bundle)
bundle install

# Install JavaScript dependencies
npm install
```

### 3. Database Setup

```bash
# Create the database
rails db:create

# Run migrations
rails db:migrate

# (Optional) Seed the database with sample data
rails db:seed
```

### 4. Environment Variables

Create a `.env` file in the root directory:

```bash
# PostgreSQL Unix socket path (adjust for your system)
PGHOST=/var/run/postgresql

# Brapi API Key (optional - some stocks work without it)
Brapi_API_KEY=your_api_key_here
```

### 5. Enable Development Caching (Optional but Recommended)

```bash
rails dev:cache
```

This enables caching in development mode for better performance testing.

## ▶️ Running the Application

### Start the Rails Server

```bash
rails server
# or
rails s
```

The application will be available at `http://localhost:3000`

### Start Sidekiq (for background jobs)

In a separate terminal:

```bash
bundle exec sidekiq
```

### Access the Application

1. Navigate to `http://localhost:3000`
2. Sign up for a new account or log in
3. Create wallets and start adding operations

## 🔧 Key Fixes and Improvements

This project has undergone significant improvements from the original bootcamp version. Here are the major fixes and enhancements:

### 1. **Bundler Configuration**
- **Issue**: Permission errors when installing gems system-wide
- **Fix**: Configured Bundler to install gems locally in `vendor/bundle`
- **Files**: `.bundle/config`

### 2. **PostgreSQL Connection**
- **Issue**: Connection errors due to incorrect socket path
- **Fix**: Configured database to use Unix socket connection with `PGHOST` environment variable
- **Files**: `config/database.yml`, `.env`

### 3. **Responsive Design**
- **Issue**: Application not optimized for mobile devices
- **Fix**: 
  - Added Bootstrap responsive utilities throughout
  - Implemented mobile-first CSS with media queries
  - Fixed alignment issues for numbers and cards on mobile
- **Files**: Multiple SCSS files in `app/assets/stylesheets/components/`

### 4. **Internationalization (i18n)**
- **Feature**: Multi-language support
- **Implementation**:
  - Added Portuguese (Brazil) and German translations
  - Created locale files with comprehensive translations
  - Implemented locale switching with session persistence
  - Added language switcher UI component
- **Files**: 
  - `config/locales/pt-BR.yml`
  - `config/locales/de.yml`
  - `app/views/shared/_language_switcher.html.erb`
  - `app/controllers/application_controller.rb`

### 5. **Dark Theme**
- **Feature**: Complete dark theme implementation
- **Implementation**:
  - Created theme switcher with localStorage persistence
  - Defined CSS variables for consistent theming
  - Styled all components for dark mode
  - Fixed color issues for cards, navbar, text, and icons
- **Files**:
  - `app/assets/stylesheets/components/_dark_theme.scss`
  - `app/javascript/controllers/theme_controller.js`
  - `app/views/shared/_theme_switcher.html.erb`

### 6. **Performance Optimizations**
- **N+1 Query Fixes**:
  - Added eager loading with `.includes()` in controllers
  - Replaced Ruby loops with SQL aggregations
  - Optimized wallet calculations
- **Caching**:
  - Implemented 5-minute caching for external API calls
  - Enabled development caching
  - Smart cache invalidation (only cache successful responses)
- **Database Indexes**:
  - Added indexes on `holdings.asset_type`
  - Added composite index on `operations(wallet_id, holding_id)`
  - Added index on `holdings.current_price`
- **Files**:
  - `app/controllers/wallets_controller.rb`
  - `app/models/wallet.rb`
  - `app/models/holding.rb`
  - `db/migrate/20251125005008_add_indexes_for_performance.rb`

### 7. **Brapi API Integration**
- **Issue**: Stock prices and variations not displaying correctly
- **Fix**:
  - Corrected API parameter from `apikey` to `token`
  - Fixed URL construction
  - Added comprehensive error handling and logging
  - Implemented fallback to database values on API failures
  - Prevented caching of failed API responses
- **Files**:
  - `app/services/Brapi.rb`
  - `app/models/holding.rb`

### 8. **Number Formatting**
- **Feature**: Brazilian number format (dot for thousands, comma for decimals)
- **Implementation**:
  - Created `format_brazilian_number` helper method
  - Applied formatting throughout the application
  - Examples: `400000.89` → `400.000,89`
- **Files**:
  - `app/helpers/application_helper.rb`
  - All view files displaying numbers

### 9. **Currency and Display Updates**
- Changed currency symbol from `$` to `R$` (Brazilian Real)
- Updated all displays to show asset symbols (e.g., "PETR4") instead of long names
- Fixed percentage variation colors (green for positive, red for negative) in dark theme
- Applied Bootstrap alert warning color to action icons (eye, arrow, trash) in dark theme

### 10. **UI/UX Improvements**
- Fixed alignment issues in trending section
- Improved grid layouts for better responsiveness
- Enhanced modal styling for dark theme
- Fixed search dropdown colors and functionality
- Improved icon visibility and consistency

## 📁 Project Structure

```
portifolio_pilot_v2/
├── app/
│   ├── assets/          # Stylesheets, images, JavaScript
│   ├── controllers/     # Application controllers
│   ├── models/          # ActiveRecord models
│   ├── services/        # Service objects (Brapi API)
│   ├── views/           # ERB templates
│   └── javascript/      # Stimulus controllers
├── config/
│   ├── locales/         # Translation files
│   └── routes.rb        # Application routes
├── db/
│   ├── migrate/         # Database migrations
│   └── seeds.rb         # Seed data
└── README.md            # This file
```

## 🎯 Learning Outcomes

This project demonstrates:

- Rails MVC architecture
- Database optimization and query performance
- API integration and error handling
- Internationalization (i18n)
- Responsive web design
- Dark theme implementation
- Caching strategies
- Background job processing
- Authentication and authorization
- Modern JavaScript with Stimulus

## 📝 Notes

- This is a learning project and may contain code that could be further optimized
- API keys should be kept secure and not committed to version control
- The application uses external APIs (Brapi and CryptoCompare) which may have rate limits
- Some stocks require a Brapi API key, while test stocks (PETR4, VALE3, MGLU3) work without authentication

## 🤝 Contributing

This is a personal learning project, but suggestions and feedback are welcome!

## 📄 License

This project is for educational purposes.

---

**Built with ❤️ as a learning project**
