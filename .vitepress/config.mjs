import { defineConfig } from 'vitepress'
import { withMermaid } from 'vitepress-plugin-mermaid'

// https://vitepress.dev/reference/site-config
export default withMermaid(defineConfig({
  title: "Lesson Plan",
  description: "Tổng Hợp Tài Liệu Học Lập Trình - By klpod221",
  lang: 'vi-VN',
  base: '/lesson-plan/',
  
  markdown: {
    languages: [
      {
        id: 'env',
        scopeName: 'source.env',
        aliases: ['dotenv', 'environment'],
        path: '../../node_modules/shiki/languages/dotenv.tmLanguage.json'
      }
    ],
    languageAlias: {
      'env': 'dotenv',
      'conf': 'ini',
      'config': 'ini',
      'assembly': 'asm'
    }
  },

  // Mermaid configuration
  mermaid: {
    // Optional: Mermaid configuration options
  },
  
  head: [
    ['link', { rel: 'icon', href: '/lesson-plan/favicon.ico' }],
    ['meta', { name: 'author', content: 'klpod221' }],
    ['meta', { name: 'keywords', content: 'tài liệu lập trình, học lập trình, java, sql, web development, tutorial, programming' }]
  ],

  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    logo: '/logo.png',
    
    nav: [
      { text: 'Trang Chủ', link: '/' },
      { text: 'Giới Thiệu', link: '/INTRODUCTION' },
      { text: 'Cài Đặt', link: '/INSTALL' },
      {
        text: 'Lộ Trình',
        items: [
          { text: 'Tự Học', link: '/SELF-LEARNING/Part1' },
          { text: 'Java', link: '/JAVA/Part1' },
          { text: 'SQL', link: '/SQL/Part1' },
          { text: 'DSA', link: '/DSA/Part1' },
          { text: 'Web', link: '/WEB/Part1' },
          { text: 'PHP', link: '/PHP/Part1' },
          { text: 'DevOps', link: '/DEVOPS/Docker1' }
        ]
      },
      {
        text: 'Tài Liệu Khác',
        items: [
          { text: 'C/C++', link: '/C-CPP/Part1' },
          { text: 'Python', link: '/PYTHON/Part1' },
          { text: 'Rust', link: '/RUST/Part1' },
          { text: 'React', link: '/REACT/Part1' },
          { text: 'Vue', link: '/VUE/Part1' }
        ]
      },
      { text: 'Tổng Kết', link: '/CONCLUSION' }
    ],

    sidebar: {
      // Trang giới thiệu và cài đặt
      '/INTRODUCTION': [
        {
          text: '🎓 Bắt Đầu',
          collapsed: false,
          items: [
            { text: '🌐 Tổng Quan Lập Trình', link: '/INTRODUCTION' },
            { text: '🛠️ Cài Đặt Môi Trường', link: '/INSTALL' },
            { text: '🔄 Git & GitHub', link: '/GIT' }
          ]
        },
        {
          text: '📚 Module 1: Kỹ Năng Tự Học',
          collapsed: true,
          items: [
            { text: '🔍 Tìm Kiếm Thông Tin', link: '/SELF-LEARNING/Part1' },
            { text: '📑 Xử Lý Tài Liệu', link: '/SELF-LEARNING/Part2' }
          ]
        }
      ],

      '/INSTALL': [
        {
          text: '🎓 Bắt Đầu',
          collapsed: false,
          items: [
            { text: '🌐 Tổng Quan Lập Trình', link: '/INTRODUCTION' },
            { text: '🛠️ Cài Đặt Môi Trường', link: '/INSTALL' },
            { text: '🔄 Git & GitHub', link: '/GIT' }
          ]
        },
        {
          text: '📚 Module 1: Kỹ Năng Tự Học',
          collapsed: true,
          items: [
            { text: '🔍 Tìm Kiếm Thông Tin', link: '/SELF-LEARNING/Part1' },
            { text: '📑 Xử Lý Tài Liệu', link: '/SELF-LEARNING/Part2' }
          ]
        }
      ],

      '/GIT': [
        {
          text: '🎓 Bắt Đầu',
          collapsed: false,
          items: [
            { text: '🌐 Tổng Quan Lập Trình', link: '/INTRODUCTION' },
            { text: '🛠️ Cài Đặt Môi Trường', link: '/INSTALL' },
            { text: '🔄 Git & GitHub', link: '/GIT' }
          ]
        },
        {
          text: '📚 Module 1: Kỹ Năng Tự Học',
          collapsed: true,
          items: [
            { text: '🔍 Tìm Kiếm Thông Tin', link: '/SELF-LEARNING/Part1' },
            { text: '📑 Xử Lý Tài Liệu', link: '/SELF-LEARNING/Part2' }
          ]
        }
      ],

      // Lộ trình chính - có liên kết giữa các module
      '/SELF-LEARNING/': [
        {
          text: '🎓 Bắt Đầu',
          collapsed: true,
          items: [
            { text: '🌐 Tổng Quan Lập Trình', link: '/INTRODUCTION' },
            { text: '🛠️ Cài Đặt Môi Trường', link: '/INSTALL' },
            { text: '🔄 Git & GitHub', link: '/GIT' }
          ]
        },
        {
          text: '📚 Module 1: Kỹ Năng Tự Học',
          collapsed: false,
          items: [
            { text: '🔍 Tìm Kiếm Thông Tin', link: '/SELF-LEARNING/Part1' },
            { text: '📑 Xử Lý Tài Liệu', link: '/SELF-LEARNING/Part2' },
            { text: '🧠 Kỹ Thuật Tự Học', link: '/SELF-LEARNING/Part3' },
            { text: '📈 Phát Triển Bản Thân', link: '/SELF-LEARNING/Part4' }
          ]
        },
        {
          text: '📚 Module 2: Java Cơ Bản',
          collapsed: true,
          items: [
            { text: '☕ Nhập Môn Java', link: '/JAVA/Part1' },
            { text: '📊 Mảng, Chuỗi và Hàm', link: '/JAVA/Part2' }
          ]
        },
        {
          text: '📚 Module 3: OOP',
          collapsed: true,
          items: [
            { text: '🧩 Lập Trình Hướng Đối Tượng', link: '/JAVA/Part3' }
          ]
        }
      ],

      '/JAVA/': [
        {
          text: '📚 Module 1: Kỹ Năng Tự Học',
          collapsed: true,
          items: [
            { text: '🔍 Tìm Kiếm Thông Tin', link: '/SELF-LEARNING/Part1' },
            { text: '📑 Xử Lý Tài Liệu', link: '/SELF-LEARNING/Part2' },
            { text: '🧠 Kỹ Thuật Tự Học', link: '/SELF-LEARNING/Part3' },
            { text: '📈 Phát Triển Bản Thân', link: '/SELF-LEARNING/Part4' }
          ]
        },
        {
          text: '📚 Module 2: Java Cơ Bản',
          collapsed: false,
          items: [
            { text: '☕ Nhập Môn Java', link: '/JAVA/Part1' },
            { text: '📊 Mảng, Chuỗi và Hàm', link: '/JAVA/Part2' }
          ]
        },
        {
          text: '📚 Module 3: OOP',
          collapsed: false,
          items: [
            { text: '🧩 Lập Trình Hướng Đối Tượng', link: '/JAVA/Part3' },
            { text: '📁 File I/O và Collections', link: '/JAVA/Part4' },
            { text: '🧵 Luồng, Đa Luồng và JDBC', link: '/JAVA/Part5' },
            { text: '🏆 Bài Tập Lớn', link: '/JAVA/FINAL' }
          ]
        },
        {
          text: '📚 Module 4: SQL & Database',
          collapsed: true,
          items: [
            { text: '💾 Nhập Môn SQL', link: '/SQL/Part1' },
            { text: '📊 SQL Nâng Cao', link: '/SQL/Part2' }
          ]
        }
      ],

      '/SQL/': [
        {
          text: '📚 Module 3: OOP',
          collapsed: true,
          items: [
            { text: '🧩 Lập Trình Hướng Đối Tượng', link: '/JAVA/Part3' },
            { text: '� File I/O và Collections', link: '/JAVA/Part4' }
          ]
        },
        {
          text: '📚 Module 4: SQL & Database',
          collapsed: false,
          items: [
            { text: '💾 Nhập Môn SQL', link: '/SQL/Part1' },
            { text: '📊 SQL Nâng Cao', link: '/SQL/Part2' },
            { text: '🔄 SQL và Ứng Dụng', link: '/SQL/Part3' },
            { text: '⚡ SQL Chuyên Sâu', link: '/SQL/Part4' },
            { text: '🏆 Bài Tập Lớn', link: '/SQL/FINAL' }
          ]
        },
        {
          text: '📚 Module 5: DSA',
          collapsed: true,
          items: [
            { text: '🧮 Nhập Môn DSA', link: '/DSA/Part1' },
            { text: '🌐 Cấu Trúc Dữ Liệu Nâng Cao', link: '/DSA/Part2' }
          ]
        }
      ],

      '/DSA/': [
        {
          text: '📚 Module 4: SQL & Database',
          collapsed: true,
          items: [
            { text: '💾 Nhập Môn SQL', link: '/SQL/Part1' },
            { text: '⚡ SQL Chuyên Sâu', link: '/SQL/Part4' }
          ]
        },
        {
          text: '📚 Module 5: DSA',
          collapsed: false,
          items: [
            { text: '🧮 Nhập Môn DSA', link: '/DSA/Part1' },
            { text: '🌐 Cấu Trúc Dữ Liệu Nâng Cao', link: '/DSA/Part2' },
            { text: '🧠 Thuật Toán Nâng Cao', link: '/DSA/Part3' },
            { text: '🔍 Cấu Trúc Dữ Liệu Chuyên Biệt', link: '/DSA/Part4' },
            { text: '⚡ Thuật Toán Ứng Dụng', link: '/DSA/Part5' }
          ]
        },
        {
          text: '📚 Module 6: Web Frontend',
          collapsed: true,
          items: [
            { text: '📝 Nhập Môn HTML', link: '/WEB/Part1' },
            { text: '🎨 CSS - Định Dạng Trang Web', link: '/WEB/Part2' }
          ]
        }
      ],

      '/WEB/': [
        {
          text: '📚 Module 5: DSA',
          collapsed: true,
          items: [
            { text: '🧮 Nhập Môn DSA', link: '/DSA/Part1' },
            { text: '⚡ Thuật Toán Ứng Dụng', link: '/DSA/Part5' }
          ]
        },
        {
          text: '📚 Module 6: Web Frontend',
          collapsed: false,
          items: [
            { text: '📝 Nhập Môn HTML', link: '/WEB/Part1' },
            { text: '🎨 CSS - Định Dạng Trang Web', link: '/WEB/Part2' },
            { text: '🔄 JavaScript', link: '/WEB/Part3' },
            { text: '⚙️ Framework & Công Cụ', link: '/WEB/Part4' }
          ]
        },
        {
          text: '📚 Module 7: Backend',
          collapsed: true,
          items: [
            { text: '🐘 Nhập Môn PHP', link: '/PHP/Part1' },
            { text: '🧩 OOP với PHP', link: '/PHP/Part2' }
          ]
        }
      ],

      '/PHP/': [
        {
          text: '� Module 6: Web Frontend',
          collapsed: true,
          items: [
            { text: '📝 Nhập Môn HTML', link: '/WEB/Part1' },
            { text: '⚙️ Framework & Công Cụ', link: '/WEB/Part4' }
          ]
        },
        {
          text: '📚 Module 7: Backend (PHP)',
          collapsed: false,
          items: [
            { text: '🐘 Nhập Môn PHP', link: '/PHP/Part1' },
            { text: '🧩 OOP với PHP', link: '/PHP/Part2' },
            { text: '💾 PHP Nâng Cao', link: '/PHP/Part3' },
            { text: '🏗️ Framework & Ứng Dụng', link: '/PHP/Part4' },
            { text: '🚀 Xu Hướng Hiện Đại', link: '/PHP/Part5' },
            { text: '🌐 Triển Khai Chuyên Nghiệp', link: '/PHP/Part6' }
          ]
        },
        {
          text: '📚 Module 8: DevOps',
          collapsed: true,
          items: [
            { text: '🐳 Docker: Nền Tảng', link: '/DEVOPS/Docker1' },
            { text: '🐳 Docker: Orchestration', link: '/DEVOPS/Docker2' }
          ]
        }
      ],


      '/DEVOPS/': [
        {
          text: '📚 Module 7: Backend',
          collapsed: true,
          items: [
            { text: '🐘 Nhập Môn PHP', link: '/PHP/Part1' },
            { text: '🌐 Triển Khai Chuyên Nghiệp', link: '/PHP/Part6' }
          ]
        },
        {
          text: '📚 Module 8: DevOps',
          collapsed: false,
          items: [
            { text: '🐳 Docker: Nền Tảng', link: '/DEVOPS/Docker1' },
            { text: '🐳 Docker: Orchestration', link: '/DEVOPS/Docker2' },
            { text: '⚙️ Kubernetes', link: '/DEVOPS/Kubernetes' }
          ]
        },
        {
          text: '🎓 Hoàn Thành Lộ Trình',
          collapsed: true,
          items: [
            { text: '📋 Tổng Kết & Định Hướng', link: '/CONCLUSION' }
          ]
        }
      ],

      '/CONCLUSION': [
        {
          text: '📚 Module 8: DevOps',
          collapsed: true,
          items: [
            { text: '🐳 Docker: Nền Tảng', link: '/DEVOPS/Docker1' },
            { text: '🐳 Docker: Orchestration', link: '/DEVOPS/Docker2' },
            { text: '⚙️ Kubernetes', link: '/DEVOPS/Kubernetes' }
          ]
        },
        {
          text: '🎓 Hoàn Thành Lộ Trình',
          collapsed: false,
          items: [
            { text: '📋 Tổng Kết & Định Hướng', link: '/CONCLUSION' }
          ]
        },
        {
          text: '📚 Tài Liệu Bổ Sung',
          collapsed: true,
          items: [
            { text: '🔤 C/C++', link: '/C-CPP/Part1' },
            { text: '🐍 Python', link: '/PYTHON/Part1' },
            { text: '🦀 Rust', link: '/RUST/Part1' },
            { text: '⚛️ React', link: '/REACT/Part1' },
            { text: '💚 Vue', link: '/VUE/Part1' }
          ]
        }
      ],

      // Tài liệu bổ sung - không có liên kết với lộ trình chính
      '/C-CPP/': [
        {
          text: '🔤 C/C++ Programming',
          collapsed: false,
          items: [
            { text: '🏁 Nhập Môn C', link: '/C-CPP/Part1' },
            { text: '📊 Mảng và Chuỗi', link: '/C-CPP/Part2' },
            { text: '🔍 Con Trỏ và Quản Lý Bộ Nhớ', link: '/C-CPP/Part3' },
            { text: '📁 Struct, File và Tiền Xử Lý', link: '/C-CPP/Part4' },
            { text: '➕ Giới Thiệu C++', link: '/C-CPP/Part5' },
            { text: '🚀 C++ Nâng Cao', link: '/C-CPP/Part6' }
          ]
        }
      ],

      '/PYTHON/': [
        {
          text: '🐍 Python Programming',
          collapsed: false,
          items: [
            { text: '🐍 Nhập Môn Python', link: '/PYTHON/Part1' },
            { text: '🧩 OOP với Python', link: '/PYTHON/Part2' },
            { text: '📚 Module, Package', link: '/PYTHON/Part3' },
            { text: '📁 File I/O và Xử Lý Dữ Liệu', link: '/PYTHON/Part4' },
            { text: '🔧 Thư Viện Chuẩn', link: '/PYTHON/Part5' },
            { text: '🌐 Phát Triển Web', link: '/PYTHON/Part6' },
            { text: '📊 Data Science & ML', link: '/PYTHON/Part7' },
            { text: '🔬 Python Nâng Cao', link: '/PYTHON/Part8' },
            { text: '🚀 Dự Án Thực Chiến', link: '/PYTHON/Part9' }
          ]
        }
      ],

      '/REACT/': [
        {
          text: '⚛️ React.js',
          collapsed: false,
          items: [
            { text: '⚛️ Nền Tảng React', link: '/REACT/Part1' },
            { text: '🎯 State và Lifecycle', link: '/REACT/Part2' },
            { text: '🔄 Hooks và Side Effects', link: '/REACT/Part3' },
            { text: '🌐 Routing và Navigation', link: '/REACT/Part4' },
            { text: '📡 API Integration', link: '/REACT/Part5' },
            { text: '🎨 Styling và UI Libraries', link: '/REACT/Part6' },
            { text: '🚀 Production & Best Practices', link: '/REACT/Part7' }
          ]
        }
      ],

      '/VUE/': [
        {
          text: '💚 Vue.js',
          collapsed: false,
          items: [
            { text: '💚 Nhập Môn Vue.js', link: '/VUE/Part1' },
            { text: '🔧 Components và Props', link: '/VUE/Part2' },
            { text: '🎯 Composition API Nâng Cao', link: '/VUE/Part3' },
            { text: '🌐 Vue Router', link: '/VUE/Part4' },
            { text: '📡 State Management với Pinia', link: '/VUE/Part5' },
            { text: '🚀 Ecosystem và Production', link: '/VUE/Part6' }
          ]
        }
      ],

      '/RUST/': [
        {
          text: '🦀 Rust Programming',
          collapsed: false,
          items: [
            { text: '🦀 Nhập Môn Rust', link: '/RUST/Part1' },
            { text: '🔐 Ownership và Borrowing', link: '/RUST/Part2' },
            { text: '🏗️ Structs và Enums', link: '/RUST/Part3' },
            { text: '📦 Collections và Error Handling', link: '/RUST/Part4' },
            { text: '🧬 Traits và Generics', link: '/RUST/Part5' },
            { text: '⚡ Advanced Topics', link: '/RUST/Part6' }
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/klpod221/lesson-plan' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025-present klpod221'
    },

    search: {
      provider: 'local',
      options: {
        locales: {
          root: {
            translations: {
              button: {
                buttonText: 'Tìm kiếm',
                buttonAriaLabel: 'Tìm kiếm'
              },
              modal: {
                noResultsText: 'Không tìm thấy kết quả',
                resetButtonTitle: 'Xóa tìm kiếm',
                footer: {
                  selectText: 'để chọn',
                  navigateText: 'để điều hướng',
                  closeText: 'để đóng'
                }
              }
            }
          }
        }
      }
    },

    editLink: {
      pattern: 'https://github.com/klpod221/lesson-plan/edit/main/:path',
      text: 'Chỉnh sửa trang này trên GitHub'
    },

    lastUpdated: {
      text: 'Cập nhật lần cuối',
      formatOptions: {
        dateStyle: 'short',
        timeStyle: 'short'
      }
    },

    docFooter: {
      prev: 'Bài trước',
      next: 'Bài tiếp theo'
    },

    outline: {
      label: 'Mục lục',
      level: [2, 3]
    },

    returnToTopLabel: 'Về đầu trang',
    sidebarMenuLabel: 'Menu',
    darkModeSwitchLabel: 'Giao diện',
    lightModeSwitchTitle: 'Chuyển sang chế độ sáng',
    darkModeSwitchTitle: 'Chuyển sang chế độ tối'
  }
}))
