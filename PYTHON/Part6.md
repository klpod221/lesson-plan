# 📊 PHẦN 6: PHÂN TÍCH VÀ TRỰC QUAN HÓA DỮ LIỆU

## 🎯 Mục tiêu tổng quát

- Thành thạo môi trường làm việc Jupyter Notebook cho phân tích dữ liệu.
- Nắm vững cách sử dụng NumPy để thực hiện các phép toán trên mảng hiệu suất cao.
- Sử dụng Pandas để thực hiện các tác vụ phân tích dữ liệu từ đầu đến cuối: đọc, khám phá, làm sạch, biến đổi và tổng hợp dữ liệu.
- Sử dụng Matplotlib và Seaborn để tạo ra các biểu đồ trực quan, truyền tải thông tin hiệu quả.
- Hoàn thành một dự án phân tích dữ liệu nhỏ, trả lời các câu hỏi kinh doanh dựa trên một bộ dữ liệu thực tế.

## 🧑‍🏫 Bài 1: Môi trường làm việc và Giới thiệu NumPy

### Jupyter Notebook: Sân chơi của nhà khoa học dữ liệu

- Jupyter Notebook là một ứng dụng web cho phép bạn tạo và chia sẻ các tài liệu chứa code, phương trình, trực quan hóa và văn bản tường thuật.
- Cực kỳ hữu ích cho việc khám phá dữ liệu tương tác vì bạn có thể chạy từng khối code (cell) và xem ngay kết quả.
- **Cài đặt**:

  ```bash
  pip install notebook
  ```

- **Khởi động**:

  ```bash
  jupyter notebook
  ```

### NumPy: Nền tảng tính toán khoa học

- NumPy (Numerical Python) là thư viện cốt lõi cho tính toán khoa học trong Python.
- Cung cấp đối tượng mảng đa chiều (`ndarray`) mạnh mẽ, hiệu quả hơn nhiều so với List của Python cho các phép toán số học.

```python
import numpy as np

# Tạo một mảng NumPy từ List
a = np.array([1, 2, 3, 4, 5])
print(f"Mảng a: {a}")
print(f"Kiểu dữ liệu: {a.dtype}")

# Phép toán trên toàn bộ mảng (vectorization) - rất nhanh!
b = a * 2
print(f"Mảng b = a * 2: {b}")

# Các hàm thống kê cơ bản
print(f"Trung bình: {np.mean(a)}")
print(f"Tổng: {np.sum(a)}")
print(f"Giá trị lớn nhất: {np.max(a)}")

# Mảng 2 chiều (ma trận)
matrix = np.array([[1, 2, 3], [4, 5, 6]])
print("Ma trận:\n", matrix)
print(f"Kích thước: {matrix.shape}") # (2, 3) -> 2 hàng, 3 cột
```

## 🧑‍🏫 Bài 2: Phân tích Dữ liệu với Pandas - Phần 1

### Giới thiệu Pandas: Series và DataFrame

- **Series**: Một mảng một chiều có nhãn (giống một cột trong bảng tính), với các chỉ số (index).
- **DataFrame**: Một cấu trúc dữ liệu hai chiều có nhãn (giống một bảng tính hoàn chỉnh), với các cột có thể có kiểu dữ liệu khác nhau. Đây là đối tượng chính bạn sẽ làm việc trong Pandas.

```python
import pandas as pd

# Tạo một Series
s = pd.Series([10, 20, 30, 40], index=['a', 'b', 'c', 'd'])
print("Series:\n", s)

# Tạo một DataFrame từ Dictionary
data = {
    'Tên': ['An', 'Bình', 'Chi', 'Dũng'],
    'Tuổi': [22, 25, 21, 30],
    'Thành phố': ['Hà Nội', 'TP.HCM', 'Đà Nẵng', 'Hà Nội']
}
df = pd.DataFrame(data)
print("\nDataFrame:\n", df)
```

### Đọc và Ghi dữ liệu (CSV, Excel)

```python
# Giả sử có file 'sales.csv'
# df = pd.read_csv('sales.csv')

# Ghi DataFrame ra file CSV
# df.to_csv('output.csv', index=False) # index=False để không ghi cột chỉ số
```

### Khám phá dữ liệu ban đầu

```python
# Hiển thị 5 dòng đầu tiên
print("5 dòng đầu:\n", df.head())

# Hiển thị 5 dòng cuối cùng
print("\n5 dòng cuối:\n", df.tail())

# Xem thông tin tổng quan (kiểu dữ liệu, số lượng giá trị không null)
print("\nThông tin DataFrame:")
df.info()

# Xem các thống kê mô tả cơ bản cho các cột số
print("\nThống kê mô tả:\n", df.describe())
```

## 🧑‍🏫 Bài 3: Phân tích Dữ liệu với Pandas - Phần 2

### Lựa chọn và Lọc dữ liệu (Indexing & Slicing)

```python
# Chọn một cột (trả về một Series)
ages = df['Tuổi']
print("Cột Tuổi:\n", ages)

# Chọn nhiều cột (trả về một DataFrame)
name_city = df[['Tên', 'Thành phố']]
print("\nCột Tên và Thành phố:\n", name_city)

# Lọc các hàng dựa trên điều kiện
# Lấy những người có tuổi lớn hơn 23
older_than_23 = df[df['Tuổi'] > 23]
print("\nNhững người trên 23 tuổi:\n", older_than_23)

# Lọc với nhiều điều kiện (& là AND, | là OR)
# Những người ở Hà Nội VÀ trên 25 tuổi
hanoi_older_25 = df[(df['Thành phố'] == 'Hà Nội') & (df['Tuổi'] > 25)]
print("\nNgười ở Hà Nội và trên 25 tuổi:\n", hanoi_older_25)
```

### Làm sạch dữ liệu (Handling Missing Values)

```python
# Tạo một DataFrame có giá trị thiếu (NaN - Not a Number)
data_with_nan = {
    'A': [1, 2, np.nan, 4],
    'B': [5, np.nan, np.nan, 8],
    'C': [10, 20, 30, 40]
}
df_nan = pd.DataFrame(data_with_nan)
print("DataFrame với NaN:\n", df_nan)

# Xóa các hàng có chứa NaN
print("\nXóa hàng có NaN:\n", df_nan.dropna())

# Thay thế NaN bằng một giá trị khác (ví dụ: trung bình của cột)
mean_B = df_nan['B'].mean()
print("\nĐiền NaN bằng giá trị trung bình:\n", df_nan.fillna(value={'B': mean_B}))
```

### Thao tác trên cột và thêm cột mới

```python
# Thêm một cột mới
df['Năm sinh'] = 2024 - df['Tuổi']
print("\nDataFrame với cột Năm sinh:\n", df)

# Áp dụng một hàm lên một cột
def categorize_age(age):
    if age < 25:
        return 'Trẻ'
    else:
        return 'Lớn tuổi'

df['Nhóm tuổi'] = df['Tuổi'].apply(categorize_age)
print("\nDataFrame với cột Nhóm tuổi:\n", df)
```

## 🧑‍🏫 Bài 4: Trực quan hóa Dữ liệu với Matplotlib và Seaborn

### Matplotlib: Xây dựng biểu đồ từ gốc

```python
import matplotlib.pyplot as plt

x = ['A', 'B', 'C', 'D']
y = [10, 25, 15, 30]

plt.figure(figsize=(8, 5)) # Thiết lập kích thước
plt.bar(x, y) # Vẽ biểu đồ cột
plt.title('Biểu đồ Cột Đơn giản')
plt.xlabel('Hạng mục')
plt.ylabel('Giá trị')
plt.show() # Hiển thị biểu đồ
```

### Seaborn: Vẽ biểu đồ thống kê đẹp mắt

```python
import seaborn as sns

# Seaborn có thể vẽ trực tiếp từ DataFrame của Pandas
plt.figure(figsize=(8, 5))
sns.barplot(x='Tên', y='Tuổi', data=df)
plt.title('Biểu đồ Tuổi của Mọi người')
plt.show()

# Biểu đồ phân tán (scatterplot) để xem mối quan hệ
# sns.scatterplot(x='col1', y='col2', data=real_df)
```

## 🧑‍🏫 Bài 5: Phân tích nâng cao với Pandas

### Gom nhóm dữ liệu (Grouping with `groupby`)

Đây là một trong những tính năng mạnh mẽ nhất của Pandas, tương tự `GROUP BY` trong SQL.

```python
# Gom nhóm theo 'Thành phố' và tính tuổi trung bình cho mỗi thành phố
city_avg_age = df.groupby('Thành phố')['Tuổi'].mean()
print("Tuổi trung bình theo thành phố:\n", city_avg_age)

# Gom nhóm và tính nhiều thống kê cùng lúc
city_stats = df.groupby('Thành phố')['Tuổi'].agg(['mean', 'count', 'max'])
print("\nThống kê tuổi theo thành phố:\n", city_stats)
```

### Kết hợp các DataFrame (Merging, Joining, Concatenating)

- `pd.concat()`: Nối các DataFrame theo chiều dọc hoặc ngang.
- `pd.merge()`: Kết hợp các DataFrame dựa trên các cột chung (giống `JOIN` trong SQL).

```python
# Ví dụ về merge
df1 = pd.DataFrame({'key': ['A', 'B', 'C'], 'value1': [1, 2, 3]})
df2 = pd.DataFrame({'key': ['A', 'B', 'D'], 'value2': [4, 5, 6]})

# Inner join
merged_inner = pd.merge(df1, df2, on='key', how='inner')
print("Inner Merge:\n", merged_inner)

# Left join
merged_left = pd.merge(df1, df2, on='key', how='left')
print("\nLeft Merge:\n", merged_left)
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Phân tích Dữ liệu Bán lẻ

### Mô tả bài toán

Bạn được cung cấp một bộ dữ liệu về các giao dịch bán hàng của một siêu thị trực tuyến. Nhiệm vụ của bạn là thực hiện phân tích khám phá dữ liệu (Exploratory Data Analysis - EDA) để tìm ra những hiểu biết (insights) có giá trị, giúp doanh nghiệp đưa ra quyết định tốt hơn.

(Gợi ý bộ dữ liệu: [Online Retail Data Set từ UCI](https://archive.ics.uci.edu/dataset/352/online+retail). Bạn có thể tải file `Online Retail.xlsx` về.)

### Yêu cầu

Sử dụng Jupyter Notebook để thực hiện và trình bày toàn bộ quá trình phân tích.

1. **Đọc và Khám phá Dữ liệu**:
    - Đọc file dữ liệu vào một DataFrame.
    - Hiển thị thông tin cơ bản: `head()`, `info()`, `describe()`.
    - Kiểm tra xem có bao nhiêu dữ liệu bị thiếu ở mỗi cột.

2. **Làm sạch và Tiền xử lý Dữ liệu**:
    - Xóa các hàng có `CustomerID` bị thiếu (vì không thể phân tích theo khách hàng).
    - Chuyển cột `InvoiceDate` sang kiểu dữ liệu datetime.
    - Tạo các cột mới để phân tích dễ hơn:
        - `TotalPrice = Quantity * UnitPrice`.
        - `Month`, `DayOfWeek`, `Hour` từ cột `InvoiceDate`.

3. **Phân tích và Trả lời câu hỏi**:
    - **Top 10 sản phẩm bán chạy nhất là gì?** (dựa trên tổng số lượng `Quantity`).
    - **Top 10 khách hàng chi tiêu nhiều nhất là ai?** (dựa trên tổng `TotalPrice`).
    - **Doanh thu thay đổi như thế nào theo từng tháng?**
    - **Khách hàng thường mua sắm vào thời điểm nào trong ngày/trong tuần?**

4. **Trực quan hóa Dữ liệu**:
    - Vẽ biểu đồ cột cho Top 10 sản phẩm và Top 10 khách hàng.
    - Vẽ biểu đồ đường thể hiện doanh thu theo tháng.
    - Vẽ biểu đồ cột thể hiện số lượng đơn hàng theo giờ trong ngày.

5. **Tổng kết**: Viết một vài câu kết luận về những insight bạn tìm thấy được từ dữ liệu (ví dụ: "Tháng 11 có doanh thu cao nhất, có thể do chuẩn bị cho dịp lễ. Công ty nên đẩy mạnh marketing vào thời gian này.").
