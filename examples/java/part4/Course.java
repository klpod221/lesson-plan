package examples.java.part4;

public class Course {
    private String courseId;
    private String courseName;
    private String instructor;
    private int studentCount;

    // Constructor
    public Course(String courseId, String courseName, String instructor, int studentCount) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.instructor = instructor;
        this.studentCount = studentCount;
    }

    // Getters and Setters
    public String getCourseId() {
        return courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public int getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(int studentCount) {
        this.studentCount = studentCount;
    }

    @Override
    public String toString() {
        return String.format("%-10s %-30s %-20s %d", courseId, courseName, instructor, studentCount);
    }

    // Convert to CSV format for file storage
    public String toCSV() {
        return courseId + "," + courseName + "," + instructor + "," + studentCount;
    }
}
