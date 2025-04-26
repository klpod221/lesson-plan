import java.util.Scanner;

public class StudentGradeManager {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Hiển thị tiêu đề chương trình
        System.out.println("CHƯƠNG TRÌNH QUẢN LÝ ĐIỂM SINH VIÊN");
        System.out.println("-----------------------------------");

        // Nhập thông tin sinh viên
        System.out.print("Nhập tên sinh viên: ");
        String name = scanner.nextLine();

        System.out.print("Nhập điểm Toán: ");
        double mathScore = scanner.nextDouble();

        System.out.print("Nhập điểm Lý: ");
        double physicsScore = scanner.nextDouble();

        System.out.print("Nhập điểm Hóa: ");
        double chemistryScore = scanner.nextDouble();

        // Tính điểm trung bình
        double averageScore = (mathScore + physicsScore + chemistryScore) / 3;

        // Xếp loại học lực
        String rating;
        if (averageScore >= 8.0) {
            rating = "Giỏi";
        } else if (averageScore >= 6.5) {
            rating = "Khá";
        } else if (averageScore >= 5.0) {
            rating = "Trung bình";
        } else {
            rating = "Yếu";
        }

        // Hiển thị kết quả
        System.out.println("\nKẾT QUẢ XẾP LOẠI");
        System.out.println("-----------------------------------");
        System.out.println("Sinh viên: " + name);
        System.out.println("Điểm Toán: " + mathScore);
        System.out.println("Điểm Lý: " + physicsScore);
        System.out.println("Điểm Hóa: " + chemistryScore);
        System.out.printf("Điểm trung bình: %.2f\n", averageScore);
        System.out.println("Xếp loại: " + rating);

        // Đóng scanner
        scanner.close();
    }
}
