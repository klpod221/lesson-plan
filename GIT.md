# 📘 GIT VÀ GITHUB CƠ BẢN

- [📘 GIT VÀ GITHUB CƠ BẢN](#-git-và-github-cơ-bản)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu về Git và GitHub](#-bài-1-giới-thiệu-về-git-và-github)
  - [🧑‍🏫 Bài 2: Các lệnh Git cơ bản](#-bài-2-các-lệnh-git-cơ-bản)
  - [🧑‍🏫 Bài 3: Làm việc với GitHub](#-bài-3-làm-việc-với-github)
  - [🧑‍🏫 Bài 4: Branching và Merging](#-bài-4-branching-và-merging)
  - [🧑‍🏫 Bài 5: Làm việc nhóm và giải quyết xung đột](#-bài-5-làm-việc-nhóm-và-giải-quyết-xung-đột)
  - [🧑‍🏫 Bài 6: Git Flow và quy trình phát triển](#-bài-6-git-flow-và-quy-trình-phát-triển)
  - [🧑‍🏫 Bài 7: Kỹ thuật Git nâng cao](#-bài-7-kỹ-thuật-git-nâng-cao)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: tạo và quản lý code mà bạn sẽ thực hiện trong các phần sau của khóa học bằng Git và GitHub](#-bài-tập-lớn-cuối-phần-tạo-và-quản-lý-code-mà-bạn-sẽ-thực-hiện-trong-các-phần-sau-của-khóa-học-bằng-git-và-github)

---

## 🎯 Mục tiêu tổng quát

- Làm quen với Git và GitHub, các lệnh cơ bản để quản lý mã nguồn.
- Biết cách tạo và quản lý repository trên GitHub.
- Thực hành các thao tác như commit, push, pull, branch và merge.
- Hiểu cách làm việc nhóm với Git và GitHub, giải quyết xung đột mã nguồn.
- Nắm vững quy trình phát triển phần mềm với Git Flow.
- Thực hành các kỹ thuật quản lý mã nguồn như tag, rebase và cherry-pick.

---

## 🧑‍🏫 Bài 1: Giới thiệu về Git và GitHub

**Git là gì?**

Git là hệ thống quản lý phiên bản phân tán (DVCS - Distributed Version Control System) được phát triển bởi Linus Torvalds vào năm 2005. Git cho phép theo dõi thay đổi của mã nguồn, phối hợp làm việc nhóm, và dễ dàng quay lại phiên bản trước khi cần.

**Lợi ích của Git:**

- **Làm việc offline**: Có thể commit và xem lịch sử ngay cả khi không có kết nối mạng
- **Phân tán**: Mỗi người có một bản sao đầy đủ của repository
- **Nhanh chóng**: Thao tác trên repository cục bộ nhanh hơn so với hệ thống tập trung
- **Phân nhánh mạnh mẽ**: Dễ dàng tạo, hợp nhất và quản lý các branch
- **Bảo đảm tính toàn vẹn**: Sử dụng mã hash để đảm bảo tính toàn vẹn của dữ liệu

**GitHub là gì?**

GitHub là dịch vụ lưu trữ Git trên cloud, cung cấp giao diện web để quản lý các Git repository, cùng với nhiều tính năng bổ sung như:

- Issue tracking
- Pull requests
- Code review
- Project management
- CI/CD integration
- Wiki và documentation

**Các khái niệm cơ bản trong Git:**

1. **Repository (Repo)**: Kho lưu trữ mã nguồn và lịch sử thay đổi

   - **Local repository**: Repo trên máy tính cá nhân
   - **Remote repository**: Repo trên server (như GitHub)

2. **Commit**: Lưu trạng thái hiện tại của mã nguồn với một mã định danh (hash) duy nhất

3. **Branch**: Nhánh phát triển độc lập của mã nguồn

   - **master/main**: Branch chính, chứa code ổn định
   - **feature branches**: Các nhánh phát triển tính năng mới

4. **Merge**: Hợp nhất các thay đổi từ branch này sang branch khác

5. **Clone**: Tạo bản sao của repository từ remote về local

6. **Pull**: Lấy các thay đổi từ remote repository về local repository

7. **Push**: Đẩy các thay đổi từ local repository lên remote repository

8. **Working Directory**: Thư mục làm việc chứa các file của dự án

9. **Staging Area (Index)**: Khu vực trung gian nơi các thay đổi được chuẩn bị trước khi commit

**Sơ đồ hoạt động của Git:**

```text
+------------+    git add     +-------------+    git commit    +----------------+
| Working    | -------------> | Staging     | ---------------> | Local          |
| Directory  |                | Area        |                  | Repository     |
+------------+                +-------------+                  +----------------+
       ^                                                              |
       |                                                              |
       | git checkout                                         git push|
       |                                                              |
       |                                                              V
       |                  git pull                     +----------------+
       +-----------------------------------------------| Remote         |
                                                       | Repository     |
                                                       +----------------+
```

**Cài đặt Git:**

- **Windows**: Tải và cài đặt từ [git-scm.com](https://git-scm.com/)
- **macOS**:

  ```bash
  brew install git
  ```

  Hoặc tải từ [git-scm.com](https://git-scm.com/)

- **Linux (Ubuntu/Debian)**:

  ```bash
  sudo apt-get update
  sudo apt-get install git
  ```

**Kiểm tra cài đặt:**

```bash
git --version
```

**Cấu hình ban đầu:**

```bash
git config --global user.name "Tên của bạn"
git config --global user.email "email@example.com"
```

---

## 🧑‍🏫 Bài 2: Các lệnh Git cơ bản

**Khởi tạo repository:**

```bash
# Tạo repository mới
git init

# Clone repository có sẵn
git clone https://github.com/username/repository.git
```

**Xem trạng thái và lịch sử:**

```bash
# Xem trạng thái hiện tại
git status

# Xem lịch sử commit
git log

# Xem lịch sử rút gọn trên một dòng
git log --oneline

# Xem thay đổi chi tiết
git diff
```

**Quản lý thay đổi:**

```bash
# Thêm file vào staging area
git add filename.txt

# Thêm tất cả các file đã thay đổi
git add .

# Commit các thay đổi trong staging area
git commit -m "Mô tả về thay đổi"

# Thêm và commit cùng lúc (chỉ với file đã được theo dõi)
git commit -am "Mô tả về thay đổi"
```

**Hoàn tác thay đổi:**

```bash
# Hủy thay đổi trong working directory (chưa add)
git checkout -- filename.txt

# Hủy thay đổi đã add vào staging area
git reset HEAD filename.txt

# Hoàn tác commit gần nhất (vẫn giữ thay đổi trong working directory)
git reset --soft HEAD~1

# Hoàn tác hoàn toàn commit gần nhất (xóa cả thay đổi)
git reset --hard HEAD~1
```

**Làm việc với remote repository:**

```bash
# Xem danh sách remote
git remote -v

# Thêm remote
git remote add origin https://github.com/username/repository.git

# Lấy thay đổi từ remote (không merge)
git fetch origin

# Lấy thay đổi và merge vào branch hiện tại
git pull origin main

# Đẩy thay đổi lên remote
git push origin main
```

**File .gitignore:**

File `.gitignore` liệt kê các file và thư mục mà Git sẽ bỏ qua khi theo dõi thay đổi:

```text
# Ví dụ về file .gitignore
node_modules/
.env
*.log
.DS_Store
```

Các mẫu phổ biến cho `.gitignore` theo ngôn ngữ có sẵn tại: [github.com/github/gitignore](https://github.com/github/gitignore)

---

## 🧑‍🏫 Bài 3: Làm việc với GitHub

**Tạo tài khoản và repository:**

1. Đăng ký tại [github.com](https://github.com)
2. Tạo repository mới:
   - Click "New" từ trang chủ GitHub
   - Điền tên, mô tả, chọn quyền truy cập (public/private)
   - Chọn khởi tạo với README nếu cần
   - Click "Create repository"

**Liên kết repository local với GitHub:**

```bash
# Với repository mới tạo trên GitHub
git remote add origin https://github.com/username/repository.git
git branch -M main
git push -u origin main

# Với repository đã tồn tại trên local
cd existing-project
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/username/repository.git
git push -u origin main
```

**Sử dụng SSH với GitHub:**

1. Tạo SSH key:

   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. Thêm SSH key vào SSH agent:

   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. Thêm SSH key vào tài khoản GitHub:

   - Copy key: `cat ~/.ssh/id_ed25519.pub`
   - Thêm vào GitHub: Settings > SSH and GPG keys > New SSH key

4. Kiểm tra kết nối:

   ```bash
   ssh -T git@github.com
   ```

**GitHub Pages:**

GitHub Pages là dịch vụ hosting tĩnh miễn phí của GitHub:

1. Tạo repository tên là `username.github.io`
2. Clone repository về local
3. Thêm mã HTML, CSS, JavaScript
4. Push lên GitHub
5. Truy cập `https://username.github.io`

**GitHub Actions:**

GitHub Actions là dịch vụ CI/CD tích hợp của GitHub:

1. Tạo file `.github/workflows/main.yml`:

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

2. Push lên GitHub
3. Xem kết quả trong tab "Actions"

---

## 🧑‍🏫 Bài 4: Branching và Merging

**Quản lý branch:**

```bash
# Liệt kê tất cả branch
git branch

# Tạo branch mới
git branch feature-login

# Chuyển sang branch khác
git checkout feature-login

# Tạo và chuyển sang branch mới cùng lúc
git checkout -b feature-register

# Xóa branch
git branch -d feature-login

# Xóa branch đã được push lên remote
git push origin --delete feature-login
```

**Merge branch:**

```bash
# Chuyển về branch đích (thường là main)
git checkout main

# Merge branch khác vào branch hiện tại
git merge feature-login

# Merge và tạo commit merge mới (không fast-forward)
git merge --no-ff feature-login
```

**Rebasing:**

Rebase là cách tái sắp xếp commit để có lịch sử tuyến tính:

```bash
# Trong branch feature
git rebase main

# Nếu có xung đột, giải quyết và tiếp tục
git rebase --continue

# Hoặc hủy rebase
git rebase --abort
```

**Fast-forward vs. No-fast-forward:**

```text
# Fast-forward merge (mặc định khi có thể)
A---B---C (main)
         \
          D---E (feature)

Sau khi merge:
A---B---C---D---E (main, feature)

# No-fast-forward merge (git merge --no-ff)
A---B---C (main)
         \
          D---E (feature)

Sau khi merge:
A---B---C---F (main)
         \   /
          D---E (feature)
```

**Stashing:**

Stash lưu tạm các thay đổi chưa commit:

```bash
# Lưu tạm thay đổi hiện tại
git stash

# Xem danh sách stash
git stash list

# Áp dụng stash gần nhất và giữ trong stash list
git stash apply

# Áp dụng stash gần nhất và xóa khỏi stash list
git stash pop

# Xóa stash
git stash drop stash@{0}

# Xóa tất cả stash
git stash clear
```

---

## 🧑‍🏫 Bài 5: Làm việc nhóm và giải quyết xung đột

**Pull Request (PR):**

Pull Request là cách đề xuất thay đổi trong GitHub:

1. Fork repository (nếu không có quyền trực tiếp)
2. Tạo branch mới cho tính năng
3. Commit thay đổi
4. Push branch lên GitHub
5. Tạo Pull Request từ branch này vào main
6. Đợi review và approval
7. Merge PR

**Review code:**

1. Xem PR trong GitHub
2. Xem các thay đổi (Files changed)
3. Thêm comment vào từng dòng code nếu cần
4. Approve hoặc Request changes
5. Submit review

**Giải quyết xung đột (Conflict):**

Xung đột xảy ra khi cùng thay đổi một phần của file:

```bash
# Khi merge hoặc pull gây xung đột
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
Automatic merge failed; fix conflicts and then commit the result.
```

Các bước giải quyết:

1. Mở file có xung đột, tìm phần được đánh dấu:

   ```text
   <<<<<<< HEAD
   Thay đổi từ branch hiện tại
   =======
   Thay đổi từ branch đang merge vào
   >>>>>>> feature-branch
   ```

2. Chỉnh sửa để giữ thay đổi mong muốn (xóa các dấu hiệu xung đột)

3. Đánh dấu đã giải quyết xong:

   ```bash
   git add file.txt
   ```

4. Hoàn tất merge:

   ```bash
   git commit -m "Resolved merge conflict in file.txt"
   ```

**Best practices làm việc nhóm:**

1. **Pull thường xuyên**: Lấy thay đổi mới nhất trước khi bắt đầu làm việc
2. **Commit nhỏ và thường xuyên**: Dễ review và debug
3. **Mô tả commit rõ ràng**: Giúp hiểu được mục đích thay đổi
4. **Một branch cho một tính năng**: Tránh trộn lẫn nhiều tính năng trong một branch
5. **Code review**: Luôn có người khác review code trước khi merge
6. **Test trước khi push**: Đảm bảo code hoạt động đúng
7. **Cập nhật documentation**: Đảm bảo tài liệu luôn mới nhất

---

## 🧑‍🏫 Bài 6: Git Flow và quy trình phát triển

**Git Flow là gì?**

Git Flow là một mô hình phân nhánh giúp quản lý dự án phần mềm. Nó định nghĩa các loại branch cụ thể và cách chúng tương tác với nhau.

**Các loại branch trong Git Flow:**

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

1. **master/main**: Branch chính, chứa code sản phẩm
2. **develop**: Branch phát triển, tích hợp các tính năng mới
3. **feature/**: Các branch cho tính năng cụ thể
4. **release/**: Branch chuẩn bị cho phiên bản mới
5. **hotfix/**: Branch sửa lỗi khẩn cấp trên production

**Quy trình Git Flow:**

1. **Feature development**:

   ```bash
   # Tạo feature branch từ develop
   git checkout -b feature/login develop

   # Làm việc, commit...

   # Khi hoàn thành, merge về develop
   git checkout develop
   git merge --no-ff feature/login
   git push origin develop

   # Xóa feature branch (tùy chọn)
   git branch -d feature/login
   ```

2. **Release preparation**:

   ```bash
   # Tạo release branch từ develop
   git checkout -b release/1.0.0 develop

   # Sửa lỗi nhỏ, cập nhật version, etc.

   # Merge vào master và develop
   git checkout master
   git merge --no-ff release/1.0.0
   git tag -a v1.0.0 -m "Version 1.0.0"

   git checkout develop
   git merge --no-ff release/1.0.0

   # Xóa release branch
   git branch -d release/1.0.0
   ```

3. **Hotfix**:

   ```bash
   # Tạo hotfix branch từ master
   git checkout -b hotfix/1.0.1 master

   # Sửa lỗi

   # Merge vào master và develop
   git checkout master
   git merge --no-ff hotfix/1.0.1
   git tag -a v1.0.1 -m "Version 1.0.1"

   git checkout develop
   git merge --no-ff hotfix/1.0.1

   # Xóa hotfix branch
   git branch -d hotfix/1.0.1
   ```

**Mở rộng và biến thể:**

- **GitHub Flow**: Đơn giản hóa với chỉ main và feature branches
- **GitLab Flow**: Thêm các environment branches (production, staging)
- **Trunk-based Development**: Phát triển chủ yếu trên branch chính, branch tính năng ngắn

---

## 🧑‍🏫 Bài 7: Kỹ thuật Git nâng cao

**Tagging:**

Tag đánh dấu các phiên bản quan trọng trong lịch sử:

```bash
# Tạo tag có chú thích
git tag -a v1.0.0 -m "Version 1.0.0"

# Liệt kê tags
git tag

# Push tags lên remote
git push origin v1.0.0
# Hoặc push tất cả tags
git push origin --tags

# Checkout về một tag
git checkout v1.0.0
```

**Cherry-picking:**

Cherry-pick áp dụng commit cụ thể vào branch hiện tại:

```bash
# Xem các commit trên branch khác
git log feature-branch

# Cherry-pick một commit
git cherry-pick abc123def

# Cherry-pick nhiều commit
git cherry-pick abc123def..ghi456jkl
```

**Interactive rebase:**

Rebase tương tác cho phép điều chỉnh lịch sử commit:

```bash
# Rebase tương tác 3 commit gần nhất
git rebase -i HEAD~3
```

Các lệnh trong rebase tương tác:

- `pick`: Giữ commit
- `reword`: Sửa message commit
- `edit`: Dừng để sửa commit
- `squash`: Gộp commit với commit trước đó
- `fixup`: Gộp commit nhưng bỏ qua message
- `drop`: Xóa commit

**Reflog - khôi phục lịch sử:**

Reflog lưu mọi thay đổi trên repository local:

```bash
# Xem reflog
git reflog

# Khôi phục về trạng thái trước đó
git reset --hard HEAD@{2}
```

**Git hooks:**

Git hooks là script tự động chạy trước/sau các hành động Git:

1. Pre-commit hook: `.git/hooks/pre-commit`

   ```bash
   #!/bin/sh
   # Chạy linter trước khi commit
   npm run lint

   # Nếu lỗi, ngăn commit
   if [ $? -ne 0 ]; then
     echo "Linting failed!"
     exit 1
   fi
   ```

2. Pre-push hook: `.git/hooks/pre-push`

   ```bash
   #!/bin/sh
   # Chạy test trước khi push
   npm test

   # Nếu test fail, ngăn push
   if [ $? -ne 0 ]; then
     echo "Tests failed!"
     exit 1
   fi
   ```

**Submodule và Subtree:**

1. **Submodule**: Nhúng repository khác như một thư mục con:

   ```bash
   # Thêm submodule
   git submodule add https://github.com/user/repo.git libs/repo

   # Cập nhật submodule
   git submodule update --remote
   ```

2. **Subtree**: Tích hợp repository khác vào dự án:

   ```bash
   # Thêm subtree
   git subtree add --prefix=libs/repo https://github.com/user/repo.git main

   # Cập nhật subtree
   git subtree pull --prefix=libs/repo https://github.com/user/repo.git main
   ```

**Git bisect:**

Git bisect giúp tìm commit gây ra lỗi:

```bash
# Bắt đầu bisect
git bisect start

# Đánh dấu commit hiện tại có lỗi
git bisect bad

# Đánh dấu commit cũ không có lỗi
git bisect good v1.0.0

# Git sẽ checkout các commit để test
# Sau mỗi commit checkout, test và đánh dấu:
git bisect good  # Nếu không có lỗi
# hoặc
git bisect bad   # Nếu có lỗi

# Kết thúc bisect khi tìm ra commit gây lỗi
git bisect reset
```

**Git aliases:**

Tạo lệnh tắt cho các lệnh Git phức tạp:

```bash
# Tạo alias
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: tạo và quản lý code mà bạn sẽ thực hiện trong các phần sau của khóa học bằng Git và GitHub

1. Đăng ký và đăng nhập vào tài khoản GitHub.
2. Tạo một repository mới với tên tùy chọn (VD: `sefl-learning`).
3. Tạo một folder mới trên máy tính của bạn với tên tương tự.
4. Tạo các folder con trong folder này cho từng phần của khóa học.
5. Sử dụng lệnh `git init` để khởi tạo Git trong folder này.
6. Sử dụng lệnh `git add .` để thêm tất cả các file vào staging area.
7. Sử dụng lệnh `git commit -m "Initial commit"` để commit các thay đổi.
8. Sử dụng lệnh `git remote add origin <repository-url>` để liên kết với repository trên GitHub.
9. Sử dụng lệnh `git push -u origin main` để đẩy các thay đổi lên GitHub.
10. Tiếp tục thực hiện các phần của khóa học và commit các thay đổi thường xuyên.
11. Khi hoàn thành một phần, tạo một branch mới cho phần tiếp theo và lặp lại quy trình commit và push.

---

Ở phần tiếp theo, chúng ta sẽ chính thức bắt đầu với ngôn ngữ lập trình JAVA. Rất có thể bạn sẽ gặp một số khái niệm mới và thú vị nhưng cũng không kém phần "ngộp". Hãy yên tâm, mọi thứ sẽ trở nên dễ dàng hơn khi bạn đã quen với chúng. Chúng ta sẽ cùng nhau khám phá và thực hành từng bước một.

Hãy nhớ rằng, việc học lập trình không chỉ là việc hiểu lý thuyết mà còn là thực hành và áp dụng những gì đã học vào thực tế. Đừng ngần ngại thử nghiệm và tìm hiểu thêm về các công cụ và kỹ thuật mới.

Hãy chuẩn bị tinh thần và sẵn sàng cho những thử thách mới!

---

[⬅️ Trở lại: SELF-LEARNING/Part4.md](./SELF-LEARNING/Part4.md) |
[🏠 Home](./README.md) |
[➡️Tiếp theo: JAVA/Part1.md](./JAVA/Part1.md)`
