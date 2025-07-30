# 🚀 Local Boilerplate Setup Script

This script helps you quickly start a new project by copying a local boilerplate into a fresh GitHub repository. It ensures a clean structure, sets up secret protection, and pushes your first commit safely.

---

## ✅ What It Does

- Clones your empty GitHub repo (must contain a README, LICENSE, and python `.gitignore` template)
- Copies in your local boilerplate files
- Verifies `.gitignore` is present to avoid committing secrets
- Overwrites the .gitignore and README with boilerplate version (optional)
- Stages, commits, and pushes everything cleanly

---

## 🛠 Prerequisites

- Git must be installed
- Clone your git template `SaaS-boilerplate` locally to reuse for future apps.
- Your new GitHub repo must already be created with:
  - `README.md`
  - `.gitignore` (should exclude `.env`, `secrets.toml`, etc.)
  - `LICENSE`
---

## 🚀 How to Use

### This is a bash script so run it in GitBash or a bash terminal in VS Code!

Navigate into the local folder you wish to clone the local boilerplate folder into:

eg. 
```bash
cd git-hub-repos
```

Make the script executable:
```bash
chmod +x clone-local-boilerplate.sh
```

Run the script with your project name and GitHub repo URL:

```bash
./clone-local-boilerplate.sh repo-name https://github.com/your-username/repo-name.git
```

---

## 📦 What Happens

1. A folder named `repo-name` is created inside your working folder `git-hub-repos`
2. Your GitHub repo is cloned into it
3. Local boilerplate files are copied in
4. Everything is staged, committed, and pushed to `main`

---

## 🧠 Notes

- The default boilerplate path is: `~/boilerplates/python` — you can update this in the script
- This script is designed for **local boilerplate reuse** across many GitHub repos

---

### 👤 Created by Nana E. A. Johnson  

Tech Founder & Secure Systems Architect | [FemmeOps](https://github.com/goldielockz30)

