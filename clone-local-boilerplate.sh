#!/bin/bash

# Usage: ./clone-local-boilerplate.sh "my-project-name" "https://github.com/YOU/my-new-project.git"
set -e

project_name="$1"
repo_url="$2"
boilerplate_path="$HOME/boilerplates/python"  # Update to your local boilerplate directory eg. "$HOME/Desktop/my-local-boilerplate" - that's all you need to change for it to work.

if [ -z "$project_name" ] || [ -z "$repo_url" ]; then
  echo "❌ Usage: $0 <project-name> <repo-url>"
  exit 1
fi

# 1. Create new folder and move into it
echo "📁 Creating local folder: $project_name"
mkdir "$project_name"
cd "$project_name"

# 2. Clone GitHub repo (must already include README, LICENSE, and .gitignore)
echo "🌐 Cloning clean template repo..."
git clone "$repo_url" .
echo "✅ Repo cloned into $(pwd)"

# 3. Overwrite .gitignore with boilerplate version
if [ -f "$boilerplate_path/.gitignore" ]; then
  echo "📄 Overwriting .gitignore with boilerplate version..."
  cp "$boilerplate_path/.gitignore" .gitignore
else
  echo "❌ .gitignore is missing from the boilerplate!"
  echo "🛑 Aborting to prevent secrets from being tracked."
  exit 1
fi


echo "📄 .gitignore found. Contents:"
cat .gitignore

# 4. Copy boilerplate files into repo (adjust as needed)
echo "🧱 Copying boilerplate files from $boilerplate_path..."
cp -r "$boilerplate_path/"* .

# 5. Overwrite README.md if boilerplate has one
if [ -f "$boilerplate_path/README.md" ]; then
  echo "✏️ Overwriting README.md with boilerplate version..."
  cp "$boilerplate_path/README.md" .
fi

# 6. Add pre-commit hook to block secrets
echo "🔒 Installing pre-commit hook to block secrets..."
mkdir -p .git/hooks
cat << 'EOF' > .git/hooks/pre-commit
#!/bin/bash
if grep -q "sk-" .env 2>/dev/null; then
  echo "❌ Secrets detected in .env. Commit blocked."
  exit 1
fi
if git diff --cached --name-only | grep -E '\.env|secrets\.toml'; then
  echo "❌ Attempting to commit secret file! Commit blocked."
  exit 1
fi
EOF
chmod +x .git/hooks/pre-commit

# 7. Clean Git index to untrack anything cached (just in case)
echo "🧹 Cleaning Git index..."
git rm -r --cached . > /dev/null 2>&1 || true

# 8. Stage and commit everything cleanly
echo "📦 Staging and committing boilerplate files..."
git add .
git commit -m "Initial boilerplate commit (secrets protected)"
git push -u origin main

echo "✅ Project '$project_name' is now set up with secret protection and clean history!"
