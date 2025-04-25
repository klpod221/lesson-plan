import java.util.Scanner;

public class StudentGradeArrayManager {
    // Khai báo các mảng để lưu trữ thông tin sinh viên
    private static String[] studentNames;
    private static double[][] studentScores;
    private static double[] averageScores;
    private static String[] ratings;
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Nhập thông tin sinh viên
        inputStudentData(scanner);
        
        // Tính điểm trung bình và xếp loại
        calculateAveragesAndRatings();
        
        // Hiển thị kết quả
        displayResults();
        
        scanner.close();
    }
    
    /**
     * Hàm nhập điểm cho các sinh viên và lưu vào mảng
     */
    private static void inputStudentData(Scanner scanner) {
        System.out.print("Nhập số lượng sinh viên: ");
        int numStudents = scanner.nextInt();
        scanner.nextLine(); // Đọc bỏ dòng mới
        
        // Khởi tạo các mảng
        studentNames = new String[numStudents];
        studentScores = new double[numStudents][3]; // 3 môn: Toán, Lý, Hóa
        averageScores = new double[numStudents];
        ratings = new String[numStudents];
        
        // Nhập thông tin cho từng sinh viên
        for (int i = 0; i < numStudents; i++) {
            System.out.printf("Nhập tên sinh viên %d: ", i + 1);
            studentNames[i] = scanner.nextLine();
            
            System.out.print("Nhập điểm Toán: ");
            studentScores[i][0] = scanner.nextDouble();
            
            System.out.print("Nhập điểm Lý: ");
            studentScores[i][1] = scanner.nextDouble();
            
            System.out.print("Nhập điểm Hóa: ");
            studentScores[i][2] = scanner.nextDouble();
            
            scanner.nextLine(); // Đọc bỏ dòng mới
            System.out.println();
        }
    }
    
    /**
     * Hàm tính điểm trung bình và xếp loại học lực cho tất cả sinh viên
     */
    private static void calculateAveragesAndRatings() {
        for (int i = 0; i < studentNames.length; i++) {
            // Tính điểm trung bình
            averageScores[i] = calculateAverage(studentScores[i]);
            
            // Xếp loại học lực
            ratings[i] = getRating(averageScores[i]);
        }
    }
    
    /**
     * Hàm tính điểm trung bình của một sinh viên
     */
    private static double calculateAverage(double[] scores) {
        double sum = 0;
        for (double score : scores) {
            sum += score;
        }
        return sum / scores.length;
    }
    
    /**
     * Hàm xếp loại học lực dựa trên điểm trung bình
     */
    private static String getRating(double averageScore) {
        if (averageScore >= 8.0) {
            return "Giỏi";
        } else if (averageScore >= 6.5) {
            return "Khá";
        } else if (averageScore >= 5.0) {
            return "Trung bình";
        } else {
            return "Yếu";
        }
    }
    
    /**
     * Hàm hiển thị kết quả cho tất cả sinh viên
     */
    private static void displayResults() {
        System.out.println("-----------------------------------");
        System.out.println("Danh sách sinh viên và điểm trung bình:");
        
        for (int i = 0; i < studentNames.length; i++) {
            System.out.printf("%s - Điểm trung bình: %.2f - Xếp loại: %s%n", 
                studentNames[i], averageScores[i], ratings[i]);
        }
    }
}