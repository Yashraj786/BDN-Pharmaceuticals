#!/bin/bash
# BDN Factory Manager - Install Script
echo "================================================"
echo "  BDN FACTORY MANAGER - INSTALLATION"
echo "================================================"
echo ""

# Check Ruby
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby not found. Please install Ruby 3.3+ first."
    echo "   Visit: https://www.ruby-lang.org/en/downloads/"
    exit 1
fi
echo "✅ Ruby found: $(ruby --version)"

# Check PostgreSQL
if ! command -v psql &> /dev/null; then
    echo "❌ PostgreSQL not found. Please install PostgreSQL first."
    echo "   Visit: https://www.postgresql.org/download/"
    exit 1
fi
echo "✅ PostgreSQL found"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
gem install bundler --quiet
bundle install

# Setup database
echo ""
echo "🗄️  Setting up database..."
rails db:create db:migrate db:seed

echo ""
echo "================================================"
echo "  ✅ INSTALLATION COMPLETE!"
echo "================================================"
echo ""
echo "  To start the app, run:"
echo "  bash start.sh"
echo ""
echo "  Or: rails server"
echo "  Then open: http://localhost:3000"
echo ""
echo "  Login: admin@bdn.com / admin"
echo "================================================"
