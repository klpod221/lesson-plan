package examples.java.part4;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CourseManager {
    private List<Course> courses;
    private static final String FILE_PATH = "examples/java/part4/courses.csv";

    // Constructor
    public CourseManager() {
        this.courses = new ArrayList<>();
    }

    // Add a new course
    public void addCourse(Course course) throws CourseException {
        // Check if course with the same ID already exists
        for (Course existingCourse : courses) {
            if (existingCourse.getCourseId().equals(course.getCourseId())) {
                throw new CourseException("Khóa học với mã " + course.getCourseId() + " đã tồn tại.");
            }
        }
        courses.add(course);
    }

    // Update an existing course
    public void updateCourse(String courseId, String courseName, String instructor, int studentCount) throws CourseException {
        for (Course course : courses) {
            if (course.getCourseId().equals(courseId)) {
                course.setCourseName(courseName);
                course.setInstructor(instructor);
                course.setStudentCount(studentCount);
                return;
            }
        }
        throw new CourseException("Không tìm thấy khóa học với mã " + courseId);
    }

    // Delete a course
    public void deleteCourse(String courseId) throws CourseException {
        for (int i = 0; i < courses.size(); i++) {
            if (courses.get(i).getCourseId().equals(courseId)) {
                courses.remove(i);
                return;
            }
        }
        throw new CourseException("Không tìm thấy khóa học với mã " + courseId);
    }

    // Search course by ID
    public Course findCourseById(String courseId) {
        for (Course course : courses) {
            if (course.getCourseId().equals(courseId)) {
                return course;
            }
        }
        return null;
    }

    // Search courses by name (partial match)
    public List<Course> findCoursesByName(String courseName) {
        List<Course> result = new ArrayList<>();
        for (Course course : courses) {
            if (course.getCourseName().toLowerCase().contains(courseName.toLowerCase())) {
                result.add(course);
            }
        }
        return result;
    }

    // Get courses by instructor
    public List<Course> getCoursesByInstructor(String instructor) {
        List<Course> result = new ArrayList<>();
        for (Course course : courses) {
            if (course.getInstructor().equalsIgnoreCase(instructor)) {
                result.add(course);
            }
        }
        return result;
    }

    // Get all courses
    public List<Course> getAllCourses() {
        return new ArrayList<>(courses);
    }

    // Save courses to file
    public void saveToFile() throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            // Write header
            writer.write("CourseID,CourseName,Instructor,StudentCount");
            writer.newLine();
            
            // Write data
            for (Course course : courses) {
                writer.write(course.toCSV());
                writer.newLine();
            }
        }
    }

    // Load courses from file
    public void loadFromFile() throws IOException {
        courses.clear();
        File file = new File(FILE_PATH);
        
        // If file doesn't exist, return without loading
        if (!file.exists()) {
            return;
        }
        
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            // Skip header line
            reader.readLine();
            
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 4) {
                    try {
                        Course course = new Course(
                            data[0],
                            data[1], 
                            data[2],
                            Integer.parseInt(data[3])
                        );
                        courses.add(course);
                    } catch (NumberFormatException e) {
                        System.err.println("Lỗi định dạng số: " + e.getMessage());
                    }
                }
            }
        }
    }
}
