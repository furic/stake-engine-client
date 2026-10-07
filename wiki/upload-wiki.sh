#!/bin/bash

# Upload wiki pages to GitHub
# This script helps upload the wiki pages to GitHub's wiki system

echo "🚀 Uploading Stake Engine Client Wiki Pages"
echo "=========================================="

REPO_URL="https://github.com/furic/stake-engine-client.wiki.git"
WIKI_DIR="wiki-upload"

# Check if we're in the right directory
if [ ! -f "Home.md" ]; then
    echo "❌ Error: Please run this script from the wiki directory containing the .md files"
    exit 1
fi

# Create temporary directory for wiki upload
echo "📁 Creating temporary wiki directory..."
mkdir -p "$WIKI_DIR"
cd "$WIKI_DIR"

# Initialize wiki repository
echo "📡 Cloning wiki repository..."
git clone "$REPO_URL" .
if [ $? -ne 0 ]; then
    echo "ℹ️  Wiki repository doesn't exist yet, initializing..."
    git init
    git remote add origin "$REPO_URL"
fi

# Copy wiki files
echo "📋 Copying wiki files..."
cp ../*.md .

# Add and commit files
echo "💾 Adding files to git..."
git add *.md

echo "📝 Committing changes..."
git commit -m "docs: Add comprehensive wiki documentation

- Add Home page with complete navigation
- Add Getting Started guide with URL parameter setup
- Add detailed function reference pages for all API methods
- Add Error Handling guide with examples
- Add Status Codes reference
- Add Amount Conversion guide
- Include practical examples and best practices

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

echo "🚀 Pushing to GitHub..."
git push origin master

if [ $? -eq 0 ]; then
    echo "✅ Wiki successfully uploaded to GitHub!"
    echo "🌐 View at: https://github.com/furic/stake-engine-client/wiki"
else
    echo "❌ Upload failed. You may need to:"
    echo "   1. Enable wiki in repository settings"
    echo "   2. Create initial wiki page manually"
    echo "   3. Check repository permissions"
fi

# Cleanup
echo "🧹 Cleaning up..."
cd ..
rm -rf "$WIKI_DIR"

echo "✨ Done!"