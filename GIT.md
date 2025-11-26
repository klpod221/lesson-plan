---
prev:
  text: '🛠️ Environment Setup'
  link: '/INSTALL'
next:
  text: '🔍 Module 1: Information Search'
  link: '/SELF-LEARNING/Part1'
---

# 📘 GIT AND GITHUB BASICS

- [📘 GIT AND GITHUB BASICS](#-git-and-github-basics)
  - [🎯 General Objectives](#-general-objectives)
  - [🧑‍🏫 Lesson 1: Introduction to Git and GitHub](#-lesson-1-introduction-to-git-and-github)
    - [What is Git?](#what-is-git)
    - [Benefits of Git](#benefits-of-git)
    - [What is GitHub?](#what-is-github)
    - [Basic Concepts in Git](#basic-concepts-in-git)
    - [Git Workflow Diagram](#git-workflow-diagram)
  - [🧑‍🏫 Lesson 2: Basic Git Commands](#-lesson-2-basic-git-commands)
    - [Initialize Repository](#initialize-repository)
    - [View Status and History](#view-status-and-history)
    - [Manage Changes](#manage-changes)
    - [Undo Changes](#undo-changes)
    - [Working with Remote Repository](#working-with-remote-repository)
    - [.gitignore File](#gitignore-file)
  - [🧑‍🏫 Lesson 3: Working with GitHub](#-lesson-3-working-with-github)
    - [Create Account and Repository](#create-account-and-repository)
    - [Link Local Repository with GitHub](#link-local-repository-with-github)
    - [Using SSH with GitHub](#using-ssh-with-github)
    - [GitHub Pages](#github-pages)
    - [GitHub Actions](#github-actions)
  - [🧑‍🏫 Lesson 4: Branching and Merging](#-lesson-4-branching-and-merging)
    - [Manage Branches](#manage-branches)
    - [Merge Branches](#merge-branches)
    - [Rebasing](#rebasing)
    - [Fast-forward vs. No-fast-forward](#fast-forward-vs-no-fast-forward)
    - [Stashing](#stashing)
  - [🧑‍🏫 Lesson 5: Teamwork and Conflict Resolution](#-lesson-5-teamwork-and-conflict-resolution)
    - [Pull Request (PR)](#pull-request-pr)
    - [Code Review](#code-review)
    - [Resolving Conflicts](#resolving-conflicts)
    - [Teamwork Best Practices](#teamwork-best-practices)
  - [🧑‍🏫 Lesson 6: Git Flow and Development Workflow](#-lesson-6-git-flow-and-development-workflow)
    - [What is Git Flow?](#what-is-git-flow)
    - [Branch Types in Git Flow](#branch-types-in-git-flow)
    - [Git Flow Workflow](#git-flow-workflow)
    - [Extensions and Variants](#extensions-and-variants)
  - [🧑‍🏫 Lesson 7: Advanced Git Techniques](#-lesson-7-advanced-git-techniques)
    - [Tagging](#tagging)
    - [Cherry-picking](#cherry-picking)
    - [Interactive Rebase](#interactive-rebase)
    - [Reflog - Recovering History](#reflog---recovering-history)
    - [Git Hooks](#git-hooks)
    - [Submodule and Subtree](#submodule-and-subtree)
    - [Git Bisect](#git-bisect)
    - [Git Aliases](#git-aliases)
  - [🧪 FINAL PROJECT: Create and Manage Code for Future Course Sections Using Git and GitHub](#-final-project-create-and-manage-code-for-future-course-sections-using-git-and-github)

## 🎯 General Objectives

- Get familiar with Git and GitHub, basic commands for source code management.
- Know how to create and manage repositories on GitHub.
- Practice operations like commit, push, pull, branch and merge.
- Understand how to work in teams with Git and GitHub, resolve source code conflicts.
- Master software development workflow with Git Flow.
- Practice source code management techniques like tag, rebase and cherry-pick.

## 🧑‍🏫 Lesson 1: Introduction to Git and GitHub

### What is Git?

Git is a Distributed Version Control System (DVCS) developed by Linus Torvalds in 2005. Git allows tracking source code changes, coordinating teamwork, and easily reverting to previous versions when needed.

### Benefits of Git

- **Work offline**: Can commit and view history even without network connection
- **Distributed**: Everyone has a complete copy of the repository
- **Fast**: Operations on local repository are faster than centralized systems
- **Powerful branching**: Easy to create, merge and manage branches
- **Ensure integrity**: Uses hash codes to ensure data integrity

### What is GitHub?

GitHub is a cloud-based Git hosting service, providing a web interface to manage Git repositories, along with many additional features such as:

- Issue tracking
- Pull requests
- Code review
- Project management
- CI/CD integration
- Wiki and documentation

### Basic Concepts in Git

1. **Repository (Repo)**: Storage for source code and change history

   - **Local repository**: Repo on personal computer
   - **Remote repository**: Repo on server (like GitHub)

2. **Commit**: Save current state of source code with a unique identifier (hash)

3. **Branch**: Independent development branch of source code

   - **master/main**: Main branch, contains stable code
   - **feature branches**: Branches for developing new features

4. **Merge**: Combine changes from one branch to another

5. **Clone**: Create a copy of repository from remote to local

6. **Pull**: Fetch changes from remote repository to local repository

7. **Push**: Push changes from local repository to remote repository

8. **Working Directory**: Working directory containing project files

9. **Staging Area (Index)**: Intermediate area where changes are prepared before commit

### Git Workflow Diagram

```text
+------------+    git add     +-------------+    git commit    +----------------+
| Working    | -------------> | Staging     | --------------> | Local          |
| Directory  |                | Area        |                  | Repository     |
+------------+                +-------------+                  +----------------+
       ^                                                              |
       |                                                              |
       | git checkout                                         git push|
       |                                                              |
       |                                                              V
       |                  git pull                     +----------------+
       +-----------------------------------------------|  Remote        |
                                                       | Repository     |
                                                       +----------------+
```

## 🧑‍🏫 Lesson 2: Basic Git Commands

### Initialize Repository

```bash
# Create new repository
git init

# Clone existing repository
git clone https://github.com/username/repository.git
```

### View Status and History

```bash
# View current status
git status

# View commit history
git log

# View compact history on one line
git log --oneline

# View detailed changes
git diff
```

### Manage Changes

```bash
# Add file to staging area
git add filename.txt

# Add all changed files
git add .

# Commit changes in staging area
git commit -m "Description of changes"

# Add and commit simultaneously (only for tracked files)
git commit -am "Description of changes"
```

### Undo Changes

```bash
# Discard changes in working directory (not yet added)
git checkout -- filename.txt

# Unstage changes already added to staging area
git reset HEAD filename.txt

# Undo last commit (keep changes in working directory)
git reset --soft HEAD~1

# Completely undo last commit (delete changes too)
git reset --hard HEAD~1
```

### Working with Remote Repository

```bash
# View list of remotes
git remote -v

# Add remote
git remote add origin https://github.com/username/repository.git

# Fetch changes from remote (without merge)
git fetch origin

# Fetch changes and merge into current branch
git pull origin main

# Push changes to remote
git push origin main
```

### .gitignore File

The `.gitignore` file lists files and directories that Git will ignore when tracking changes:

```text
# Example .gitignore file
node_modules/
.env
*.log
.DS_Store
```

Common `.gitignore` templates by language available at: [github.com/github/gitignore](https://github.com/github/gitignore)

## 🧑‍🏫 Lesson 3: Working with GitHub

### Create Account and Repository

1. Register at [github.com](https://github.com)
2. Create new repository:
   - Click "New" from GitHub homepage
   - Fill in name, description, choose access rights (public/private)
   - Choose to initialize with README if needed
   - Click "Create repository"

### Link Local Repository with GitHub

```bash
# With new repository created on GitHub
git remote add origin https://github.com/username/repository.git
git branch -M main
git push -u origin main

# With existing repository on local
cd existing-project
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/username/repository.git
git push -u origin main
```

### Using SSH with GitHub

1. **Generate SSH key**:

   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. **Add SSH key to SSH agent**:

   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. **Add SSH key to GitHub account**:

   - Copy key: `cat ~/.ssh/id_ed25519.pub`
   - Add to GitHub: Settings > SSH and GPG keys > New SSH key

4. **Test connection**:

   ```bash
   ssh -T git@github.com
   ```

### GitHub Pages

GitHub Pages is GitHub's free static hosting service:

1. Create repository named `username.github.io`
2. Clone repository to local
3. Add HTML, CSS, JavaScript code
4. Push to GitHub
5. Access `https://username.github.io`

### GitHub Actions

GitHub Actions is GitHub's integrated CI/CD service:

1. Create file `.github/workflows/main.yml`:

   ```yaml
   name: CI

   on:
     push:
       branches: [main]
     pull_request:
       branches: [main]

   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v2
         - name: Run tests
           run: |
             npm install
             npm test
   ```

2. Push to GitHub
3. View results in "Actions" tab

## 🧑‍🏫 Lesson 4: Branching and Merging

### Manage Branches

```bash
# List all branches
git branch

# Create new branch
git branch feature-login

# Switch to another branch
git checkout feature-login

# Create and switch to new branch simultaneously
git checkout -b feature-register

# Delete branch
git branch -d feature-login

# Delete branch pushed to remote
git push origin --delete feature-login
```

### Merge Branches

```bash
# Switch to destination branch (usually main)
git checkout main

# Merge another branch into current branch
git merge feature-login

# Merge and create new merge commit (no fast-forward)
git merge --no-ff feature-login
```

### Rebasing

Rebase is a way to reorganize commits for linear history:

```bash
# In feature branch
git rebase main

# If conflicts occur, resolve and continue
git rebase --continue

# Or abort rebase
git rebase --abort
```

### Fast-forward vs. No-fast-forward

```text
# Fast-forward merge (default when possible)
A---B---C (main)
         \
          D---E (feature)

After merge:
A---B---C---D---E (main, feature)

# No-fast-forward merge (git merge --no-ff)
A---B---C (main)
         \
          D---E (feature)

After merge:
A---B---C---F (main)
         \   /
          D---E (feature)
```

### Stashing

Stash temporarily saves uncommitted changes:

```bash
# Save current changes temporarily
git stash

# View stash list
git stash list

# Apply latest stash and keep in stash list
git stash apply

# Apply latest stash and remove from stash list
git stash pop

# Delete stash
git stash drop stash@{0}

# Delete all stashes
git stash clear
```

## 🧑‍🏫 Lesson 5: Teamwork and Conflict Resolution

### Pull Request (PR)

Pull Request is a way to propose changes in GitHub:

1. Fork repository (if no direct access)
2. Create new branch for feature
3. Commit changes
4. Push branch to GitHub
5. Create Pull Request from this branch to main
6. Wait for review and approval
7. Merge PR

### Code Review

1. View PR in GitHub
2. View changes (Files changed)
3. Add comments to individual code lines if needed
4. Approve or Request changes
5. Submit review

### Resolving Conflicts

Conflicts occur when the same part of a file is changed:

```bash
# When merge or pull causes conflict
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
Automatic merge failed; fix conflicts and then commit the result.
```

Resolution steps:

1. **Open conflicted file, find marked sections:**

   ```text
   <<<<<<< HEAD
   Changes from current branch
   =======
   Changes from branch being merged
   >>>>>>> feature-branch
   ```

2. **Edit to keep desired changes (remove conflict markers)**

3. **Mark as resolved**:

   ```bash
   git add file.txt
   ```

4. **Complete merge**:

   ```bash
   git commit -m "Resolved merge conflict in file.txt"
   ```

### Teamwork Best Practices

1. **Pull frequently**: Get latest changes before starting work
2. **Commit small and often**: Easy to review and debug
3. **Clear commit descriptions**: Help understand purpose of changes
4. **One branch per feature**: Avoid mixing multiple features in one branch
5. **Code review**: Always have someone else review code before merge
6. **Test before push**: Ensure code works correctly
7. **Update documentation**: Ensure documentation is always up-to-date

## 🧑‍🏫 Lesson 6: Git Flow and Development Workflow

### What is Git Flow?

Git Flow is a branching model that helps manage software projects. It defines specific branch types and how they interact with each other.

### Branch Types in Git Flow

```text
                    +----------------------+
                    |                      |
                    |      Production      |
                    |      (master/main)   |
                    |                      |
                    +------+------+--------+
                           |      ^
                  hotfixes |      | releases
                           |      |
          +-----------+    |      |    +-----------+
          |           |    |      |    |           |
          | hotfix    +----v------+----+ release   |
          | branches  |        ^       | branches  |
          |           |        |       |           |
          +-----------+        |       +-----------+
                               |
                               |
                       +-------+--------+
                       |                |
                       |  Development   |
                       |  (develop)     |
                       |                |
                       +-------+--------+
                               ^
                               |
                       +-------+--------+
                       |                |
                       |  Feature       |
                       |  branches      |
                       |                |
                       +----------------+
```

1. **master/main**: Main branch, contains production code
2. **develop**: Development branch, integrates new features
3. **feature/**: Branches for specific features
4. **release/**: Branch preparing for new version
5. **hotfix/**: Branch for urgent fixes on production

### Git Flow Workflow

1. **Feature development**:

   ```bash
   # Create feature branch from develop
   git checkout -b feature/login develop

   # Work, commit...

   # When complete, merge back to develop
   git checkout develop
   git merge --no-ff feature/login
   git push origin develop

   # Delete feature branch (optional)
   git branch -d feature/login
   ```

2. **Release preparation**:

   ```bash
   # Create release branch from develop
   git checkout -b release/1.0.0 develop

   # Fix minor bugs, update version, etc.

   # Merge to master and develop
   git checkout master
   git merge --no-ff release/1.0.0
   git tag -a v1.0.0 -m "Version 1.0.0"

   git checkout develop
   git merge --no-ff release/1.0.0

   # Delete release branch
   git branch -d release/1.0.0
   ```

3. **Hotfix**:

   ```bash
   # Create hotfix branch from master
   git checkout -b hotfix/1.0.1 master

   # Fix bug

   # Merge to master and develop
   git checkout master
   git merge --no-ff hotfix/1.0.1
   git tag -a v1.0.1 -m "Version 1.0.1"

   git checkout develop
   git merge --no-ff hotfix/1.0.1

   # Delete hotfix branch
   git branch -d hotfix/1.0.1
   ```

### Extensions and Variants

- **GitHub Flow**: Simplified with only main and feature branches
- **GitLab Flow**: Add environment branches (production, staging)
- **Trunk-based Development**: Develop mainly on main branch, short feature branches

## 🧑‍🏫 Lesson 7: Advanced Git Techniques

### Tagging

Tags mark important versions in history:

```bash
# Create annotated tag
git tag -a v1.0.0 -m "Version 1.0.0"

# List tags
git tag

# Push tags to remote
git push origin v1.0.0
# Or push all tags
git push origin --tags

# Checkout to a tag
git checkout v1.0.0
```

### Cherry-picking

Cherry-pick applies specific commit to current branch:

```bash
# View commits on another branch
git log feature-branch

# Cherry-pick one commit
git cherry-pick abc123def

# Cherry-pick multiple commits
git cherry-pick abc123def..ghi456jkl
```

### Interactive Rebase

Interactive rebase allows adjusting commit history:

```bash
# Interactive rebase last 3 commits
git rebase -i HEAD~3
```

Commands in interactive rebase:

- `pick`: Keep commit
- `reword`: Edit commit message
- `edit`: Stop to edit commit
- `squash`: Combine commit with previous commit
- `fixup`: Combine commit but drop message
- `drop`: Delete commit

### Reflog - Recovering History

Reflog saves all changes on local repository:

```bash
# View reflog
git reflog

# Recover to previous state
git reset --hard HEAD@{2}
```

### Git Hooks

Git hooks are scripts that automatically run before/after Git actions:

1. **Pre-commit hook**: `.git/hooks/pre-commit`

   ```bash
   #!/bin/sh
   # Run linter before commit
   npm run lint

   # If error, prevent commit
   if [ $? -ne 0 ]; then
     echo "Linting failed!"
     exit 1
   fi
   ```

2. **Pre-push hook**: `.git/hooks/pre-push`

   ```bash
   #!/bin/sh
   # Run test before push
   npm test

   # If test fails, prevent push
   if [ $? -ne 0 ]; then
     echo "Tests failed!"
     exit 1
   fi
   ```

### Submodule and Subtree

1. **Submodule**: Embed another repository as a subdirectory:

   ```bash
   # Add submodule
   git submodule add https://github.com/user/repo.git libs/repo

   # Update submodule
   git submodule update --remote
   ```

2. **Subtree**: Integrate another repository into project:

   ```bash
   # Add subtree
   git subtree add --prefix=libs/repo https://github.com/user/repo.git main

   # Update subtree
   git subtree pull --prefix=libs/repo https://github.com/user/repo.git main
   ```

### Git Bisect

Git bisect helps find the commit that caused a bug:

```bash
# Start bisect
git bisect start

# Mark current commit as bad
git bisect bad

# Mark old commit as good
git bisect good v1.0.0

# Git will checkout commits to test
# After each checkout, test and mark:
git bisect good  # If no bug
# or
git bisect bad   # If bug exists

# End bisect when bug-causing commit is found
git bisect reset
```

### Git Aliases

Create shortcuts for complex Git commands:

```bash
# Create alias
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
```

## 🧪 FINAL PROJECT: Create and Manage Code for Future Course Sections Using Git and GitHub

1. Register and login to GitHub account.
2. Create a new repository with a name of your choice (e.g., `self-learning`).
3. Create a new folder on your computer with a similar name.
4. Create subfolders within this folder for each section of the course.
5. Use `git init` command to initialize Git in this folder.
6. Use `git add .` command to add all files to staging area.
7. Use `git commit -m "Initial commit"` command to commit changes.
8. Use `git remote add origin <repository-url>` command to link with GitHub repository.
9. Use `git push -u origin main` command to push changes to GitHub.
10. Continue working on course sections and commit changes frequently.
11. When completing a section, create a new branch for the next section and repeat the commit and push process.
