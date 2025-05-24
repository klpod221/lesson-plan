<?php
// Lấy thông điệp tùy chỉnh từ biến môi trường, nếu không có thì dùng giá trị mặc định
$message = getenv('CUSTOM_MESSAGE') ?: "Chào mừng bạn đến với ứng dụng PHP Dockerized!";

// Lấy màu nền từ biến môi trường, nếu không có thì dùng màu mặc định
$bgColor = getenv('BACKGROUND_COLOR') ?: "#f0f8ff"; // AliceBlue làm mặc định

// Logic cho bộ đếm lượt truy cập (phần nâng cao)
$counterDir = 'data';
$counterFile = $counterDir . '/counter.txt';
$visits = 0;

// Tạo thư mục 'data' nếu chưa tồn tại và có thể ghi được
// (Trong thực tế, quyền ghi cho thư mục này cần được thiết lập đúng trong Dockerfile)
if (!is_dir($counterDir)) {
  @mkdir($counterDir, 0755); // Cố gắng tạo thư mục
}

if (is_writable($counterDir) && (file_exists($counterFile) || is_writable(dirname($counterFile)))) {
  if (file_exists($counterFile)) {
    $visits = (int)file_get_contents($counterFile);
  }
  $visits++;
  file_put_contents($counterFile, $visits);
} else {
  // Ghi nhận lỗi nếu không thể ghi file - trong bài tập có thể bỏ qua phần này cho đơn giản
  // error_log("Warning: Cannot write to counter file: $counterFile");
}
?>
<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8">
  <title>Ứng Dụng PHP Động Dockerized</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      display: flex;
      flex-direction: column;
      /* Sắp xếp các item theo chiều dọc */
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      background-color: <?php echo htmlspecialchars($bgColor); ?>;
      color: #333;
    }

    .container {
      text-align: center;
      padding: 30px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
    }

    h1 {
      color: #2c3e50;
      /* Dark Blue */
      margin-bottom: 15px;
    }

    p {
      font-size: 1.1em;
      line-height: 1.6;
    }

    .visits {
      margin-top: 20px;
      font-size: 1em;
      color: #555;
    }

    .docker-logo {
      margin-top: 25px;
      width: 80px;
    }
  </style>
</head>

<body>
  <div class="container">
    <h1><?php echo htmlspecialchars($message); ?></h1>
    <p>Đây là một ứng dụng PHP đang chạy bên trong một Docker container.</p>
    <?php if (is_writable($counterDir) && (file_exists($counterFile) || is_writable(dirname($counterFile)))): ?>
      <p class="visits">Số lượt truy cập trang: <strong><?php echo $visits; ?></strong></p>
    <?php else: ?>
      <p class="visits" style="color: red;">(Bộ đếm không hoạt động do vấn đề về quyền ghi vào thư mục 'data')</p>
    <?php endif; ?>
    <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png" alt="Docker Logo" class="docker-logo">
  </div>
</body>

</html>
