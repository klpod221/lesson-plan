import { defineConfig } from "vitepress";
import { withMermaid } from "vitepress-plugin-mermaid";

// https://vitepress.dev/reference/site-config
export default withMermaid(
  defineConfig({
    title: "Lesson Plan - By klpod221",
    base: "/lesson-plan/",

    // Ignore dead links for now (English content is not fully translated yet)
    ignoreDeadLinks: true,

    // Internationalization configuration
    locales: {
      root: {
        label: "English",
        lang: "en-US",
        description: "Programming Learning Resources - By klpod221",
        themeConfig: {
          // English theme config
          logo: "/logo.png",
          siteTitle: "Lesson Plan",

          nav: [
            { text: "Home", link: "/" },
            { text: "Introduction", link: "/INTRODUCTION" },
            { text: "Installation", link: "/INSTALL" },
            {
              text: "Learning Path",
              items: [
                { text: "Self-Learning", link: "/SELF-LEARNING/Part1" },
                { text: "Java", link: "/JAVA/Part1" },
                { text: "SQL", link: "/SQL/Part1" },
                { text: "DSA", link: "/DSA/Part1" },
                { text: "Web", link: "/WEB/Part1" },
                { text: "PHP", link: "/PHP/Part1" },
                { text: "DevOps", link: "/DEVOPS/Docker1" },
              ],
            },
            {
              text: "Other Resources",
              items: [
                { text: "C/C++", link: "/C-CPP/Part1" },
                { text: "Python", link: "/PYTHON/Part1" },
                { text: "Rust", link: "/RUST/Part1" },
                { text: "React", link: "/REACT/Part1" },
                { text: "Vue", link: "/VUE/Part1" },
              ],
            },
            { text: "Conclusion", link: "/CONCLUSION" },
          ],

          sidebar: {
            "/": [
              {
                text: "Getting Started",
                items: [
                  { text: "📘 Introduction", link: "/INTRODUCTION" },
                  { text: "🛠️ Installation", link: "/INSTALL" },
                  { text: "📘 Git and Github Basics", link: "/GIT" },
                ],
              },
            ],
            "/SELF-LEARNING/": [
              {
                text: "🧠 Self-Learning Skills",
                items: [
                  {
                    text: "🔍 Information Search",
                    link: "/SELF-LEARNING/Part1",
                  },
                  {
                    text: "📑 Document Processing",
                    link: "/SELF-LEARNING/Part2",
                  },
                  {
                    text: "🧠 Self-Learning Techniques",
                    link: "/SELF-LEARNING/Part3",
                  },
                  {
                    text: "📈 Personal Development",
                    link: "/SELF-LEARNING/Part4",
                  },
                ],
              },
            ],

            "/JAVA/": [
              {
                text: "☕ Java Programming",
                items: [
                  { text: "☕ Introduction to Java", link: "/JAVA/Part1" },
                  {
                    text: "📊 Arrays, Strings and Functions",
                    link: "/JAVA/Part2",
                  },
                  {
                    text: "🧩 Object-Oriented Programming",
                    link: "/JAVA/Part3",
                  },
                  {
                    text: "📁 File I/O and Collections",
                    link: "/JAVA/Part4",
                  },
                  {
                    text: "🧵 Threads, Multithreading and JDBC",
                    link: "/JAVA/Part5",
                  },
                  { text: "🏆 Final Project", link: "/JAVA/FINAL" },
                ],
              },
            ],

            "/SQL/": [
              {
                text: "💾 SQL & Database",
                items: [
                  { text: "💾 Introduction to SQL", link: "/SQL/Part1" },
                  { text: "📊 Advanced SQL", link: "/SQL/Part2" },
                  { text: "🔄 SQL and Applications", link: "/SQL/Part3" },
                  { text: "⚡ In-Depth SQL", link: "/SQL/Part4" },
                  { text: "🏆 Final Project", link: "/SQL/FINAL" },
                ],
              },
            ],

            "/DSA/": [
              {
                text: "🧮 Data Structures & Algorithms",
                items: [
                  { text: "🧮 Introduction to DSA", link: "/DSA/Part1" },
                  {
                    text: "🌐 Advanced Data Structures",
                    link: "/DSA/Part2",
                  },
                  { text: "🧠 Advanced Algorithms", link: "/DSA/Part3" },
                  {
                    text: "🔍 Specialized Data Structures",
                    link: "/DSA/Part4",
                  },
                  { text: "⚡ Applied Algorithms", link: "/DSA/Part5" },
                ],
              },
            ],

            "/WEB/": [
              {
                text: "🌐 Web Development",
                items: [
                  { text: "📝 Introduction to HTML", link: "/WEB/Part1" },
                  {
                    text: "🎨 CSS - Styling Web Pages",
                    link: "/WEB/Part2",
                  },
                  { text: "🔄 JavaScript", link: "/WEB/Part3" },
                  { text: "⚙️ Frameworks & Tools", link: "/WEB/Part4" },
                ],
              },
            ],

            "/PHP/": [
              {
                text: "🐘 PHP Development",
                items: [
                  { text: "🐘 Introduction to PHP", link: "/PHP/Part1" },
                  { text: "🧩 OOP with PHP", link: "/PHP/Part2" },
                  { text: "💾 Advanced PHP", link: "/PHP/Part3" },
                  { text: "🏗️ Frameworks & Applications", link: "/PHP/Part4" },
                  { text: "🚀 Modern Trends", link: "/PHP/Part5" },
                  {
                    text: "🌐 Professional Deployment",
                    link: "/PHP/Part6",
                  },
                ],
              },
            ],

            "/DEVOPS/": [
              {
                text: "🐳 DevOps & Containers",
                items: [
                  { text: "🐳 Docker: Foundations", link: "/DEVOPS/Docker1" },
                  {
                    text: "🐳 Docker: Orchestration",
                    link: "/DEVOPS/Docker2",
                  },
                  { text: "⚙️ Kubernetes", link: "/DEVOPS/Kubernetes" },
                ],
              },
            ],

            "/C-CPP/": [
              {
                text: "🔤 C/C++ Programming",
                items: [
                  { text: "🏁 Introduction to C", link: "/C-CPP/Part1" },
                  { text: "📊 Arrays and Strings", link: "/C-CPP/Part2" },
                  {
                    text: "🔍 Pointers and Memory Management",
                    link: "/C-CPP/Part3",
                  },
                  {
                    text: "📁 Structs, Files and Preprocessor",
                    link: "/C-CPP/Part4",
                  },
                  { text: "➕ Introduction to C++", link: "/C-CPP/Part5" },
                  { text: "🚀 Advanced C++", link: "/C-CPP/Part6" },
                ],
              },
            ],

            "/PYTHON/": [
              {
                text: "🐍 Python Programming",
                items: [
                  { text: "🐍 Introduction to Python", link: "/PYTHON/Part1" },
                  { text: "🧩 OOP with Python", link: "/PYTHON/Part2" },
                  { text: "📚 Modules and Packages", link: "/PYTHON/Part3" },
                  {
                    text: "📁 File I/O and Data Processing",
                    link: "/PYTHON/Part4",
                  },
                  { text: "🔧 Standard Library", link: "/PYTHON/Part5" },
                  { text: "🌐 Web Development", link: "/PYTHON/Part6" },
                  { text: "📊 Data Science & ML", link: "/PYTHON/Part7" },
                  { text: "🔬 Advanced Python", link: "/PYTHON/Part8" },
                  { text: "🚀 Real-World Projects", link: "/PYTHON/Part9" },
                ],
              },
            ],

            "/REACT/": [
              {
                text: "⚛️ React.js",
                items: [
                  { text: "⚛️ React Foundations", link: "/REACT/Part1" },
                  { text: "🎯 State and Lifecycle", link: "/REACT/Part2" },
                  { text: "🔄 Hooks and Side Effects", link: "/REACT/Part3" },
                  { text: "🌐 Routing and Navigation", link: "/REACT/Part4" },
                  { text: "📡 API Integration", link: "/REACT/Part5" },
                  {
                    text: "🎨 Styling and UI Libraries",
                    link: "/REACT/Part6",
                  },
                  {
                    text: "🚀 Production & Best Practices",
                    link: "/REACT/Part7",
                  },
                ],
              },
            ],

            "/VUE/": [
              {
                text: "💚 Vue.js",
                items: [
                  { text: "💚 Introduction to Vue.js", link: "/VUE/Part1" },
                  { text: "🔧 Components and Props", link: "/VUE/Part2" },
                  {
                    text: "🎯 Advanced Composition API",
                    link: "/VUE/Part3",
                  },
                  { text: "🌐 Vue Router", link: "/VUE/Part4" },
                  {
                    text: "📡 State Management with Pinia",
                    link: "/VUE/Part5",
                  },
                  { text: "🚀 Ecosystem and Production", link: "/VUE/Part6" },
                ],
              },
            ],

            "/RUST/": [
              {
                text: "🦀 Rust Programming",
                items: [
                  { text: "🦀 Introduction to Rust", link: "/RUST/Part1" },
                  { text: "🔐 Ownership and Borrowing", link: "/RUST/Part2" },
                  { text: "🏗️ Structs and Enums", link: "/RUST/Part3" },
                  {
                    text: "📦 Collections and Error Handling",
                    link: "/RUST/Part4",
                  },
                  { text: "🧬 Traits and Generics", link: "/RUST/Part5" },
                  { text: "⚡ Advanced Topics", link: "/RUST/Part6" },
                ],
              },
            ],
          },

          socialLinks: [
            { icon: "github", link: "https://github.com/klpod221/lesson-plan" },
          ],

          footer: {
            message: "Released under the MIT License.",
            copyright: "Copyright © 2025-present klpod221",
          },

          search: {
            provider: "local",
            options: {
              translations: {
                button: {
                  buttonText: "Search",
                  buttonAriaLabel: "Search",
                },
                modal: {
                  noResultsText: "No results found",
                  resetButtonTitle: "Clear search",
                  footer: {
                    selectText: "to select",
                    navigateText: "to navigate",
                    closeText: "to close",
                  },
                },
              },
            },
          },

          editLink: {
            pattern: "https://github.com/klpod221/lesson-plan/edit/main/:path",
            text: "Edit this page on GitHub",
          },

          lastUpdated: {
            text: "Last Updated",
            formatOptions: {
              dateStyle: "short",
              timeStyle: "short",
            },
          },

          docFooter: {
            prev: "Previous",
            next: "Next",
          },

          outline: {
            label: "On this page",
            level: [2, 3],
          },

          returnToTopLabel: "Return to top",
          sidebarMenuLabel: "Menu",
          darkModeSwitchLabel: "Appearance",
          lightModeSwitchTitle: "Switch to light theme",
          darkModeSwitchTitle: "Switch to dark theme",
        },
      },

      vi: {
        label: "Tiếng Việt",
        lang: "vi-VN",
        description: "Tổng Hợp Tài Liệu Học Lập Trình - By klpod221",
        themeConfig: {
          // Vietnamese theme config
          logo: "/logo.png",
          siteTitle: "Lesson Plan",

          nav: [
            { text: "Trang Chủ", link: "/vi/" },
            { text: "Giới Thiệu", link: "/vi/INTRODUCTION" },
            { text: "Cài Đặt", link: "/vi/INSTALL" },
            {
              text: "Lộ Trình",
              items: [
                { text: "Tự Học", link: "/vi/SELF-LEARNING/Part1" },
                { text: "Java", link: "/vi/JAVA/Part1" },
                { text: "SQL", link: "/vi/SQL/Part1" },
                { text: "DSA", link: "/vi/DSA/Part1" },
                { text: "Web", link: "/vi/WEB/Part1" },
                { text: "PHP", link: "/vi/PHP/Part1" },
                { text: "DevOps", link: "/vi/DEVOPS/Docker1" },
              ],
            },
            {
              text: "Tài Liệu Khác",
              items: [
                { text: "C/C++", link: "/vi/C-CPP/Part1" },
                { text: "Python", link: "/vi/PYTHON/Part1" },
                { text: "Rust", link: "/vi/RUST/Part1" },
                { text: "React", link: "/vi/REACT/Part1" },
                { text: "Vue", link: "/vi/VUE/Part1" },
              ],
            },
            { text: "Tổng Kết", link: "/vi/CONCLUSION" },
          ],

          sidebar: {
            "/vi/": [
              {
                text: "Bắt Đầu",
                items: [
                  { text: "📘 Giới Thiệu", link: "/vi/INTRODUCTION" },
                  { text: "🛠️ Cài Đặt", link: "/vi/INSTALL" },
                  { text: "📘 Git và Github Cơ Bản", link: "/vi/GIT" },
                ],
              },
            ],
            "/vi/SELF-LEARNING/": [
              {
                text: "🧠 Kỹ Năng Tự Học",
                items: [
                  {
                    text: "🔍 Tìm Kiếm Thông Tin",
                    link: "/vi/SELF-LEARNING/Part1",
                  },
                  {
                    text: "📑 Xử Lý Tài Liệu",
                    link: "/vi/SELF-LEARNING/Part2",
                  },
                  {
                    text: "🧠 Kỹ Thuật Tự Học",
                    link: "/vi/SELF-LEARNING/Part3",
                  },
                  {
                    text: "📈 Phát Triển Bản Thân",
                    link: "/vi/SELF-LEARNING/Part4",
                  },
                ],
              },
            ],

            "/vi/JAVA/": [
              {
                text: "☕ Java Programming",
                items: [
                  { text: "☕ Nhập Môn Java", link: "/vi/JAVA/Part1" },
                  { text: "📊 Mảng, Chuỗi và Hàm", link: "/vi/JAVA/Part2" },
                  {
                    text: "🧩 Lập Trình Hướng Đối Tượng",
                    link: "/vi/JAVA/Part3",
                  },
                  {
                    text: "📁 File I/O và Collections",
                    link: "/vi/JAVA/Part4",
                  },
                  {
                    text: "🧵 Luồng, Đa Luồng và JDBC",
                    link: "/vi/JAVA/Part5",
                  },
                  { text: "🏆 Bài Tập Lớn", link: "/vi/JAVA/FINAL" },
                ],
              },
            ],

            "/vi/SQL/": [
              {
                text: "💾 SQL & Database",
                items: [
                  { text: "💾 Nhập Môn SQL", link: "/vi/SQL/Part1" },
                  { text: "📊 SQL Nâng Cao", link: "/vi/SQL/Part2" },
                  { text: "🔄 SQL và Ứng Dụng", link: "/vi/SQL/Part3" },
                  { text: "⚡ SQL Chuyên Sâu", link: "/vi/SQL/Part4" },
                  { text: "🏆 Bài Tập Lớn", link: "/vi/SQL/FINAL" },
                ],
              },
            ],

            "/vi/DSA/": [
              {
                text: "🧮 Data Structures & Algorithms",
                items: [
                  { text: "🧮 Nhập Môn DSA", link: "/vi/DSA/Part1" },
                  {
                    text: "🌐 Cấu Trúc Dữ Liệu Nâng Cao",
                    link: "/vi/DSA/Part2",
                  },
                  { text: "🧠 Thuật Toán Nâng Cao", link: "/vi/DSA/Part3" },
                  {
                    text: "🔍 Cấu Trúc Dữ Liệu Chuyên Biệt",
                    link: "/vi/DSA/Part4",
                  },
                  { text: "⚡ Thuật Toán Ứng Dụng", link: "/vi/DSA/Part5" },
                ],
              },
            ],

            "/vi/WEB/": [
              {
                text: "🌐 Web Development",
                items: [
                  { text: "📝 Nhập Môn HTML", link: "/vi/WEB/Part1" },
                  {
                    text: "🎨 CSS - Định Dạng Trang Web",
                    link: "/vi/WEB/Part2",
                  },
                  { text: "🔄 JavaScript", link: "/vi/WEB/Part3" },
                  { text: "⚙️ Framework & Công Cụ", link: "/vi/WEB/Part4" },
                ],
              },
            ],

            "/vi/PHP/": [
              {
                text: "🐘 PHP Development",
                items: [
                  { text: "🐘 Nhập Môn PHP", link: "/vi/PHP/Part1" },
                  { text: "🧩 OOP với PHP", link: "/vi/PHP/Part2" },
                  { text: "💾 PHP Nâng Cao", link: "/vi/PHP/Part3" },
                  { text: "🏗️ Framework & Ứng Dụng", link: "/vi/PHP/Part4" },
                  { text: "🚀 Xu Hướng Hiện Đại", link: "/vi/PHP/Part5" },
                  {
                    text: "🌐 Triển Khai Chuyên Nghiệp",
                    link: "/vi/PHP/Part6",
                  },
                ],
              },
            ],

            "/vi/DEVOPS/": [
              {
                text: "🐳 DevOps & Containers",
                items: [
                  { text: "🐳 Docker: Nền Tảng", link: "/vi/DEVOPS/Docker1" },
                  {
                    text: "🐳 Docker: Orchestration",
                    link: "/vi/DEVOPS/Docker2",
                  },
                  { text: "⚙️ Kubernetes", link: "/vi/DEVOPS/Kubernetes" },
                ],
              },
            ],

            "/vi/C-CPP/": [
              {
                text: "🔤 C/C++ Programming",
                items: [
                  { text: "🏁 Nhập Môn C", link: "/vi/C-CPP/Part1" },
                  { text: "📊 Mảng và Chuỗi", link: "/vi/C-CPP/Part2" },
                  {
                    text: "🔍 Con Trỏ và Quản Lý Bộ Nhớ",
                    link: "/vi/C-CPP/Part3",
                  },
                  {
                    text: "📁 Struct, File và Tiền Xử Lý",
                    link: "/vi/C-CPP/Part4",
                  },
                  { text: "➕ Giới Thiệu C++", link: "/vi/C-CPP/Part5" },
                  { text: "🚀 C++ Nâng Cao", link: "/vi/C-CPP/Part6" },
                ],
              },
            ],

            "/vi/PYTHON/": [
              {
                text: "🐍 Python Programming",
                items: [
                  { text: "🐍 Nhập Môn Python", link: "/vi/PYTHON/Part1" },
                  { text: "🧩 OOP với Python", link: "/vi/PYTHON/Part2" },
                  { text: "📚 Module, Package", link: "/vi/PYTHON/Part3" },
                  {
                    text: "📁 File I/O và Xử Lý Dữ Liệu",
                    link: "/vi/PYTHON/Part4",
                  },
                  { text: "🔧 Thư Viện Chuẩn", link: "/vi/PYTHON/Part5" },
                  { text: "🌐 Phát Triển Web", link: "/vi/PYTHON/Part6" },
                  { text: "📊 Data Science & ML", link: "/vi/PYTHON/Part7" },
                  { text: "🔬 Python Nâng Cao", link: "/vi/PYTHON/Part8" },
                  { text: "🚀 Dự Án Thực Chiến", link: "/vi/PYTHON/Part9" },
                ],
              },
            ],

            "/vi/REACT/": [
              {
                text: "⚛️ React.js",
                items: [
                  { text: "⚛️ Nền Tảng React", link: "/vi/REACT/Part1" },
                  { text: "🎯 State và Lifecycle", link: "/vi/REACT/Part2" },
                  { text: "🔄 Hooks và Side Effects", link: "/vi/REACT/Part3" },
                  { text: "🌐 Routing và Navigation", link: "/vi/REACT/Part4" },
                  { text: "📡 API Integration", link: "/vi/REACT/Part5" },
                  {
                    text: "🎨 Styling và UI Libraries",
                    link: "/vi/REACT/Part6",
                  },
                  {
                    text: "🚀 Production & Best Practices",
                    link: "/vi/REACT/Part7",
                  },
                ],
              },
            ],

            "/vi/VUE/": [
              {
                text: "💚 Vue.js",
                items: [
                  { text: "💚 Nhập Môn Vue.js", link: "/vi/VUE/Part1" },
                  { text: "🔧 Components và Props", link: "/vi/VUE/Part2" },
                  {
                    text: "🎯 Composition API Nâng Cao",
                    link: "/vi/VUE/Part3",
                  },
                  { text: "🌐 Vue Router", link: "/vi/VUE/Part4" },
                  {
                    text: "📡 State Management với Pinia",
                    link: "/vi/VUE/Part5",
                  },
                  { text: "🚀 Ecosystem và Production", link: "/vi/VUE/Part6" },
                ],
              },
            ],

            "/vi/RUST/": [
              {
                text: "🦀 Rust Programming",
                items: [
                  { text: "🦀 Nhập Môn Rust", link: "/vi/RUST/Part1" },
                  { text: "🔐 Ownership và Borrowing", link: "/vi/RUST/Part2" },
                  { text: "🏗️ Structs và Enums", link: "/vi/RUST/Part3" },
                  {
                    text: "📦 Collections và Error Handling",
                    link: "/vi/RUST/Part4",
                  },
                  { text: "🧬 Traits và Generics", link: "/vi/RUST/Part5" },
                  { text: "⚡ Advanced Topics", link: "/vi/RUST/Part6" },
                ],
              },
            ],
          },

          socialLinks: [
            { icon: "github", link: "https://github.com/klpod221/lesson-plan" },
          ],

          footer: {
            message: "Released under the MIT License.",
            copyright: "Copyright © 2025-present klpod221",
          },

          search: {
            provider: "local",
            options: {
              translations: {
                button: {
                  buttonText: "Tìm kiếm",
                  buttonAriaLabel: "Tìm kiếm",
                },
                modal: {
                  noResultsText: "Không tìm thấy kết quả",
                  resetButtonTitle: "Xóa tìm kiếm",
                  footer: {
                    selectText: "để chọn",
                    navigateText: "để điều hướng",
                    closeText: "để đóng",
                  },
                },
              },
            },
          },

          editLink: {
            pattern: "https://github.com/klpod221/lesson-plan/edit/main/:path",
            text: "Chỉnh sửa trang này trên GitHub",
          },

          lastUpdated: {
            text: "Cập nhật lần cuối",
            formatOptions: {
              dateStyle: "short",
              timeStyle: "short",
            },
          },

          docFooter: {
            prev: "Bài trước",
            next: "Bài tiếp theo",
          },

          outline: {
            label: "Mục lục",
            level: [2, 3],
          },

          returnToTopLabel: "Về đầu trang",
          sidebarMenuLabel: "Menu",
          darkModeSwitchLabel: "Giao diện",
          lightModeSwitchTitle: "Chuyển sang chế độ sáng",
          darkModeSwitchTitle: "Chuyển sang chế độ tối",
        },
      },
    },

    markdown: {
      languages: [
        {
          id: "env",
          scopeName: "source.env",
          aliases: ["dotenv", "environment"],
          path: "../../node_modules/shiki/languages/dotenv.tmLanguage.json",
        },
      ],
      languageAlias: {
        env: "dotenv",
        conf: "ini",
        config: "ini",
        assembly: "asm",
      },
    },

    // Mermaid configuration
    mermaid: {
      // Optional: Mermaid configuration options
    },

    head: [
      ["link", { rel: "icon", href: "/lesson-plan/favicon.ico" }],
      ["meta", { name: "author", content: "klpod221" }],
      [
        "meta",
        {
          name: "keywords",
          content:
            "programming tutorial, learn programming, java, sql, web development, tutorial, documentation",
        },
      ],
    ],
  })
);
