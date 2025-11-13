# 🤖 PHẦN 7: NHẬP MÔN KHOA HỌC DỮ LIỆU VÀ MACHINE LEARNING

## 🎯 Mục tiêu tổng quát

- Hiểu rõ vị trí của Machine Learning trong lĩnh vực AI và Khoa học Dữ liệu.
- Nắm vững quy trình chuẩn để thực hiện một dự án Machine Learning từ đầu đến cuối.
- Xây dựng và đánh giá được các mô hình dự đoán cho cả bài toán hồi quy và phân loại bằng Scikit-learn.
- Áp dụng được thuật toán gom cụm để khám phá các nhóm tiềm ẩn trong dữ liệu.
- Có cái nhìn tổng quan về Deep Learning và các thư viện phổ biến như TensorFlow/Keras.
- Hoàn thành một dự án phân loại hoàn chỉnh, giải quyết một bài toán kinh doanh thực tế.

## 🧑‍🏫 Bài 1: Tổng quan và Quy trình làm việc

### AI, ML, và Khoa học Dữ liệu

- **AI (Trí tuệ Nhân tạo)**: Là mục tiêu lớn nhằm tạo ra các hệ thống thông minh.
- **ML (Học máy)**: Là một phương pháp cốt lõi của AI, tập trung vào việc cho máy tính "học" từ dữ liệu.
- **Khoa học Dữ liệu**: Là một lĩnh vực liên ngành, sử dụng ML và các công cụ khác để trích xuất kiến thức từ dữ liệu.

### Quy trình một dự án Machine Learning

Sơ đồ quy trình tiêu chuẩn:

```text
+----------------+   +-----------+   +---------------+   +------------+   +-----------+   +-----------+
|   Xác định     |   | Thu thập  |   | Tiền xử lý &  |   | Lựa chọn & |   |  Đánh giá  |   | Tinh chỉnh |
|   Bài toán     |-->|  Dữ liệu  |-->|  Khám phá     |-->|  Huấn luyện |-->|  Mô hình  |-->| & Triển khai|
| (Problem Def.) |   | (Data Acq)|   |  (EDA & Prep) |   |  (Modeling)  |   | (Evaluation)|   | (Deployment)|
+----------------+   +-----------+   +---------------+   +------------+   +-----------+   +-----------+
```

Chúng ta sẽ đi theo quy trình này trong suốt phần học.

### Giới thiệu Scikit-learn

- Là thư viện ML phổ biến nhất cho các tác vụ ML "cổ điển" (không phải Deep Learning).
- Cung cấp một API (giao diện) nhất quán và đơn giản:
  - `model.fit(X, y)`: Huấn luyện (dạy) mô hình.
  - `model.predict(X_new)`: Đưa ra dự đoán cho dữ liệu mới.
  - `model.score(X, y)`: Đánh giá hiệu suất của mô hình.

## 🧑‍🏫 Bài 2: Học có giám sát (Supervised Learning) - Hồi quy (Regression)

### Bài toán Hồi quy là gì?

- **Mục tiêu**: Dự đoán một giá trị **liên tục** (số).
- **Ví dụ**: Dự đoán giá nhà, dự đoán cân nặng dựa trên chiều cao, dự đoán doanh số bán hàng.
- **Yêu cầu**: Dữ liệu huấn luyện phải có "nhãn" (giá trị thực tế để so sánh).

### Mô hình Hồi quy Tuyến tính (Linear Regression)

- Đây là mô hình đơn giản và dễ diễn giải nhất. Nó cố gắng tìm một đường thẳng (hoặc một siêu phẳng) phù hợp nhất với dữ liệu.

**Ví dụ code:**

```python
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

# Dữ liệu giả định: diện tích nhà (m2) và giá nhà (tỷ VNĐ)
X = np.array([[50], [60], [70], [80], [100]]) # Features (diện tích)
y = np.array([2.5, 3.1, 3.4, 4.2, 5.0])       # Target (giá)

# 1. Chia dữ liệu
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 2. Tạo và huấn luyện mô hình
model = LinearRegression()
model.fit(X_train, y_train)

# 3. Dự đoán
# Dự đoán giá của một căn nhà 90m2
predicted_price = model.predict([[90]])
print(f"Giá nhà 90m2 được dự đoán là: {predicted_price[0]:.2f} tỷ VNĐ")
```

### Đánh giá mô hình Hồi quy (MSE, R²)

- **Mean Squared Error (MSE)**: Trung bình của bình phương các sai số. Con số này càng nhỏ càng tốt.
- **R-squared (R²)**: Cho biết mức độ (từ 0 đến 1) mà các features giải thích được sự biến thiên của target. `R² = 0.8` có nghĩa là mô hình giải thích được 80% sự biến động của giá nhà. Càng gần 1 càng tốt.

```python
from sklearn.metrics import mean_squared_error, r2_score

# Đánh giá trên tập test
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print(f"Mean Squared Error (MSE): {mse:.2f}")
print(f"R-squared (R²): {r2:.2f}")
```

## 🧑‍🏫 Bài 3: Học có giám sát (Supervised Learning) - Phân loại (Classification)

### Bài toán Phân loại là gì?

- **Mục tiêu**: Dự đoán một nhãn **rời rạc** (một lớp cụ thể).
- **Ví dụ**: Email là "spam" hay "không spam"? Giao dịch có "gian lận" hay "không"? Bức ảnh chứa "chó" hay "mèo"?
- Có thể là phân loại nhị phân (2 lớp) hoặc đa lớp (> 2 lớp).

### Các mô hình Phân loại phổ biến

- **Logistic Regression**: Dùng để phân loại nhị phân, dự đoán xác suất một điểm dữ liệu thuộc về lớp 1.
- **Decision Tree (Cây quyết định)**: Mô hình dễ hiểu, hoạt động bằng cách liên tục chia dữ liệu dựa trên các câu hỏi có/không về các feature.

**Ví dụ code với Cây quyết định:**

```python
from sklearn.tree import DecisionTreeClassifier
from sklearn import datasets

# Tải bộ dữ liệu hoa Iris nổi tiếng
iris = datasets.load_iris()
X = iris.data
y = iris.target

# 1. Chia dữ liệu
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# 2. Tạo và huấn luyện mô hình
clf = DecisionTreeClassifier()
clf.fit(X_train, y_train)

# 3. Dự đoán
predictions = clf.predict(X_test)
```

### Đánh giá mô hình Phân loại (Accuracy, Confusion Matrix)

- **Accuracy (Độ chính xác)**: Tỷ lệ tổng số dự đoán đúng. `accuracy = (Số dự đoán đúng) / (Tổng số dự đoán)`.
- **Confusion Matrix (Ma trận nhầm lẫn)**: Một bảng 2x2 (cho bài toán nhị phân) cho thấy:
  - **True Positives (TP)**: Dự đoán là "Có", thực tế là "Có".
  - **True Negatives (TN)**: Dự đoán là "Không", thực tế là "Không".
  - **False Positives (FP)**: Dự đoán là "Có", thực tế là "Không" (Lỗi loại I).
  - **False Negatives (FN)**: Dự đoán là "Không", thực tế là "Có" (Lỗi loại II).

```python
from sklearn.metrics import accuracy_score, confusion_matrix
import seaborn as sns
import matplotlib.pyplot as plt

# Đánh giá độ chính xác
acc = accuracy_score(y_test, predictions)
print(f"Accuracy: {acc:.2f}")

# Vẽ ma trận nhầm lẫn
cm = confusion_matrix(y_test, predictions)
sns.heatmap(cm, annot=True, fmt='d')
plt.xlabel('Predicted')
plt.ylabel('Actual')
plt.show()
```

## 🧑‍🏫 Bài 4: Học không giám sát (Unsupervised Learning) - Gom cụm (Clustering)

### Khi nào cần Học không giám sát?

- Khi dữ liệu của bạn **không có nhãn** (không có cột kết quả `y`).
- **Mục tiêu**: Tự động khám phá các cấu trúc, các mẫu hoặc các nhóm (cụm) tự nhiên trong dữ liệu.
- **Ứng dụng**: Phân khúc khách hàng, hệ thống gợi ý, phát hiện bất thường.

### Thuật toán K-Means Clustering

- Là thuật toán gom cụm phổ biến và đơn giản nhất.
- Bạn cần chỉ định trước số cụm (K) mà bạn muốn tìm.
- Thuật toán sẽ cố gắng phân chia các điểm dữ liệu vào K cụm sao cho các điểm trong cùng một cụm gần nhau nhất có thể.

**Ví dụ code:**

```python
from sklearn.cluster import KMeans
from sklearn.datasets import make_blobs

# Tạo dữ liệu giả lập có 3 cụm
X, _ = make_blobs(n_samples=300, centers=3, cluster_std=0.8, random_state=42)

# Tạo và huấn luyện mô hình K-Means với K=3
kmeans = KMeans(n_clusters=3, random_state=42, n_init=10)
kmeans.fit(X)

# Lấy nhãn cụm cho mỗi điểm dữ liệu
labels = kmeans.labels_
centers = kmeans.cluster_centers_

# Trực quan hóa kết quả
plt.scatter(X[:, 0], X[:, 1], c=labels, cmap='viridis', s=50, alpha=0.7)
plt.scatter(centers[:, 0], centers[:, 1], c='red', s=200, marker='X')
plt.title('K-Means Clustering')
plt.show()
```

## 🧑‍🏫 Bài 5: Giới thiệu về Deep Learning và Mạng Neural

### Khi nào Machine Learning là không đủ?

- Các mô hình ML truyền thống hoạt động tốt với dữ liệu có cấu trúc (dạng bảng).
- Tuy nhiên, chúng gặp khó khăn với dữ liệu phi cấu trúc và phức tạp như **hình ảnh, âm thanh, văn bản**. Đây là lúc Deep Learning tỏa sáng.

### Mạng Neural nhân tạo là gì?

- Lấy cảm hứng từ não bộ, mạng neural gồm các "neuron" được kết nối với nhau trong các "lớp".
- Dữ liệu đi vào lớp đầu vào (input layer), đi qua một hoặc nhiều lớp ẩn (hidden layers) để xử lý, và đi ra ở lớp đầu ra (output layer) để cho kết quả.
- **Deep Learning** là việc sử dụng các mạng neural có nhiều lớp ẩn (deep networks).

### Giới thiệu TensorFlow và Keras

- **TensorFlow**: Là một nền tảng mã nguồn mở mạnh mẽ cho ML và DL do Google phát triển.
- **Keras**: Là một API bậc cao, cực kỳ thân thiện với người dùng, được tích hợp sẵn trong TensorFlow. Keras giúp việc xây dựng một mạng neural trở nên đơn giản như xếp các khối Lego.

**Ví dụ xây dựng một mạng neural đơn giản với Keras:**

```python
import tensorflow as tf
from tensorflow import keras

# Xây dựng một mô hình tuần tự
model = keras.Sequential([
    # Lớp đầu vào, làm phẳng ảnh 28x28 thành vector 784
    keras.layers.Flatten(input_shape=(28, 28)), 
    # Lớp ẩn với 128 neurons, hàm kích hoạt 'relu'
    keras.layers.Dense(128, activation='relu'), 
    # Lớp đầu ra với 10 neurons (cho 10 chữ số 0-9)
    keras.layers.Dense(10, activation='softmax')
])

# Biên dịch mô hình
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# (Sau đó sẽ là bước huấn luyện model.fit(X_train, y_train, ...))
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Dự đoán Khách hàng rời bỏ (Customer Churn Prediction)

### Mô tả bài toán

Một công ty viễn thông muốn dự đoán những khách hàng nào có khả năng sẽ hủy hợp đồng (churn) trong tương lai gần. Việc này giúp công ty có thể đưa ra các chương trình ưu đãi để giữ chân họ. Bạn được cung cấp một bộ dữ liệu về khách hàng, bao gồm thông tin nhân khẩu học, các dịch vụ họ sử dụng và liệu họ có rời bỏ hay không.

(Gợi ý bộ dữ liệu: [Telco Customer Churn từ Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)).

### Yêu cầu

Thực hiện toàn bộ quy trình của một dự án Machine Learning trong Jupyter Notebook.

1. **Phân tích Khám phá Dữ liệu (EDA)**:
    - Đọc và làm sạch dữ liệu (xử lý giá trị thiếu nếu có).
    - Sử dụng các kiến thức từ Phần 6 để trực quan hóa dữ liệu, tìm hiểu mối quan hệ giữa các đặc trưng và biến `Churn` (ví dụ: loại hợp đồng, thời gian gắn bó ảnh hưởng đến tỷ lệ rời bỏ như thế nào?).

2. **Tiền xử lý Dữ liệu**:
    - Chuyển đổi các cột dạng chữ (categorical) thành dạng số mà mô hình có thể hiểu được (sử dụng `pd.get_dummies` hoặc `OneHotEncoder`).
    - Chuẩn hóa (scale) các cột số để chúng có cùng thang đo (sử dụng `StandardScaler` hoặc `MinMaxScaler`).

3. **Xây dựng và Huấn luyện Mô hình**:
    - Chia dữ liệu thành tập train và tập test.
    - Thử nghiệm ít nhất 2 mô hình phân loại khác nhau (ví dụ: Logistic Regression và Decision Tree/Random Forest).

4. **Đánh giá Mô hình**:
    - Tính toán `accuracy` cho cả hai mô hình.
    - Vẽ `confusion matrix` để hiểu rõ hơn về hiệu suất của mô hình tốt nhất. Chú ý đến số lượng khách hàng bị dự đoán sai là "Không rời bỏ" trong khi thực tế họ "Có rời bỏ" (False Negatives).
    - Dựa trên kết quả, bạn sẽ đề xuất mô hình nào cho công ty? Tại sao?

5. **Kết luận**: Tóm tắt kết quả và đưa ra một vài gợi ý cho phía kinh doanh dựa trên những gì mô hình đã học được (ví dụ: "Những khách hàng có hợp đồng theo tháng và sử dụng dịch vụ Internet cáp quang có tỷ lệ rời bỏ cao nhất. Cần có chính sách chăm sóc đặc biệt cho nhóm này.").
