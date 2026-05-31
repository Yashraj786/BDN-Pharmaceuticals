#!/bin/bash
# BDN Factory Manager - Start Script
echo "================================================"
echo "  BDN FACTORY MANAGER - STARTING..."
echo "================================================"
echo ""
echo "  Opening at: http://localhost:3000"
echo "  Press Ctrl+C to stop the app"
echo ""

# Open browser (Mac/Linux)
if command -v xdg-open &> /dev/null; then
    sleep 2 && xdg-open http://localhost:3000 &
elif command -v open &> /dev/null; then
    sleep 2 && open http://localhost:3000 &
fi

rails server
