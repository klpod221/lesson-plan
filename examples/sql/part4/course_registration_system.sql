-- QUẢN LÝ ĐĂNG KÝ MÔN HỌC
-- Hệ thống quản lý đăng ký môn học cho trường đại học
-- ========================================

-- Tạo CSDL và sử dụng
DROP DATABASE IF EXISTS course_registration;
CREATE DATABASE IF NOT EXISTS course_registration;
USE course_registration;

-- ======== CẤU TRÚC DỮ LIỆU ========

-- Bảng Faculties (Khoa)
CREATE TABLE Faculties (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    description TEXT,
    dean VARCHAR(100)
);

-- Bảng Departments (Bộ môn)
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    faculty_id INT,
    head_of_department VARCHAR(100),
    FOREIGN KEY (faculty_id) REFERENCES Faculties(faculty_id)
);

-- Bảng Students (Sinh viên)
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Nam', 'Nữ', 'Khác'),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    department_id INT,
    enrollment_year YEAR,
    status ENUM('Đang học', 'Đã tốt nghiệp', 'Nghỉ học', 'Đình chỉ') DEFAULT 'Đang học',
    credits_earned INT DEFAULT 0,
    gpa DECIMAL(3,2) DEFAULT 0.00,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Bảng Instructors (Giảng viên)
CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    department_id INT,
    academic_rank VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Bảng Courses (Khóa học/Môn học)
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    description TEXT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Bảng Prerequisites (Môn học tiên quyết)
CREATE TABLE Prerequisites (
    course_id INT,
    prerequisite_id INT,
    PRIMARY KEY (course_id, prerequisite_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (prerequisite_id) REFERENCES Courses(course_id)
);

-- Bảng Semesters (Học kỳ)
CREATE TABLE Semesters (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    semester_name VARCHAR(50) NOT NULL,
    academic_year VARCHAR(9) NOT NULL,  -- Ví dụ: "2023-2024"
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    registration_start DATE NOT NULL,
    registration_end DATE NOT NULL,
    status ENUM('Đang diễn ra', 'Kết thúc', 'Sắp tới') DEFAULT 'Sắp tới'
);

-- Bảng Course_offerings (Lớp học phần)
CREATE TABLE Course_offerings (
    offering_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    semester_id INT NOT NULL,
    section_number VARCHAR(10) NOT NULL,  -- Ví dụ: "01", "02"
    instructor_id INT,
    max_students INT NOT NULL DEFAULT 40,
    current_enrollment INT NOT NULL DEFAULT 0,
    classroom VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (semester_id) REFERENCES Semesters(semester_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id),
    UNIQUE KEY (course_id, semester_id, section_number)  -- Đảm bảo không trùng lặp section
);

-- Bảng Course_schedules (Lịch học)
CREATE TABLE Course_schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    offering_id INT NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room VARCHAR(50),
    building VARCHAR(50),
    FOREIGN KEY (offering_id) REFERENCES Course_offerings(offering_id)
);

-- Bảng Enrollments (Đăng ký môn học)
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    offering_id INT NOT NULL,
    enrollment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Đăng ký', 'Đang học', 'Hoàn thành', 'Hủy') DEFAULT 'Đăng ký',
    grade DECIMAL(4,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (offering_id) REFERENCES Course_offerings(offering_id),
    UNIQUE KEY (student_id, offering_id)  -- Đảm bảo sinh viên không đăng ký trùng lặp
);

-- Bảng Enrollment_history (Lịch sử đăng ký)
CREATE TABLE Enrollment_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    student_id INT NOT NULL,
    offering_id INT NOT NULL,
    action_type ENUM('Đăng ký', 'Hủy đăng ký', 'Thay đổi lớp', 'Nhập điểm') NOT NULL,
    action_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (offering_id) REFERENCES Course_offerings(offering_id)
);

-- ======== CHỈ MỤC ĐỂ TỐI ƯU HIỆU SUẤT TRUY VẤN ========

CREATE INDEX idx_student_name ON Students(last_name, first_name);
CREATE INDEX idx_course_name ON Courses(course_name);
CREATE INDEX idx_offering_semester ON Course_offerings(semester_id);
CREATE INDEX idx_enrollment_student ON Enrollments(student_id);
CREATE INDEX idx_enrollment_offering ON Enrollments(offering_id);
CREATE INDEX idx_schedule_day_time ON Course_schedules(day_of_week, start_time, end_time);

-- ======== FUNCTIONS ========

-- Function: Kiểm tra xung đột lịch học
DELIMITER //
CREATE FUNCTION check_schedule_conflict(
    p_student_id INT,
    p_offering_id INT
) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE has_conflict BOOLEAN DEFAULT FALSE;
    DECLARE current_semester_id INT;
    
    -- Lấy học kỳ của lớp học phần muốn đăng ký
    SELECT semester_id INTO current_semester_id
    FROM Course_offerings
    WHERE offering_id = p_offering_id;
    
    -- Kiểm tra xung đột lịch học
    SELECT TRUE INTO has_conflict
    FROM Enrollments e
    JOIN Course_offerings co1 ON e.offering_id = co1.offering_id
    JOIN Course_schedules cs1 ON co1.offering_id = cs1.offering_id
    JOIN Course_offerings co2 ON co2.offering_id = p_offering_id
    JOIN Course_schedules cs2 ON co2.offering_id = cs2.offering_id
    WHERE e.student_id = p_student_id
      AND co1.semester_id = current_semester_id
      AND e.status IN ('Đăng ký', 'Đang học')
      AND cs1.day_of_week = cs2.day_of_week
      AND (
          (cs1.start_time <= cs2.start_time AND cs1.end_time > cs2.start_time) OR
          (cs1.start_time < cs2.end_time AND cs1.end_time >= cs2.end_time) OR
          (cs1.start_time >= cs2.start_time AND cs1.end_time <= cs2.end_time)
      )
    LIMIT 1;
    
    RETURN IFNULL(has_conflict, FALSE);
END //
DELIMITER ;

-- Function: Kiểm tra điều kiện tiên quyết
DELIMITER //
CREATE FUNCTION check_prerequisites_satisfied(
    p_student_id INT,
    p_course_id INT
) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE all_prerequisites_met BOOLEAN DEFAULT TRUE;
    DECLARE prereqs_count INT DEFAULT 0;
    DECLARE passed_prereqs INT DEFAULT 0;
    
    -- Đếm số lượng môn tiên quyết
    SELECT COUNT(*) INTO prereqs_count
    FROM Prerequisites
    WHERE course_id = p_course_id;
    
    -- Nếu không có môn tiên quyết, trả về TRUE
    IF prereqs_count = 0 THEN
        RETURN TRUE;
    END IF;
    
    -- Đếm số lượng môn tiên quyết mà sinh viên đã hoàn thành
    SELECT COUNT(*) INTO passed_prereqs
    FROM Prerequisites p
    JOIN Courses c ON p.prerequisite_id = c.course_id
    JOIN Course_offerings co ON c.course_id = co.course_id
    JOIN Enrollments e ON co.offering_id = e.offering_id
    WHERE p.course_id = p_course_id
      AND e.student_id = p_student_id
      AND e.status = 'Hoàn thành'
      AND e.grade >= 5.0;
    
    -- Nếu số môn đã học không bằng số môn tiên quyết, trả về FALSE
    IF passed_prereqs < prereqs_count THEN
        SET all_prerequisites_met = FALSE;
    END IF;
    
    RETURN all_prerequisites_met;
END //
DELIMITER ;

-- Function: Kiểm tra số lượng tín chỉ tối đa một kỳ
DELIMITER //
CREATE FUNCTION check_max_credits(
    p_student_id INT,
    p_offering_id INT,
    p_max_credits INT
) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE current_credits INT DEFAULT 0;
    DECLARE new_course_credits INT DEFAULT 0;
    DECLARE current_semester_id INT;
    
    -- Lấy học kỳ và số tín chỉ của khóa học muốn đăng ký
    SELECT co.semester_id, c.credits INTO current_semester_id, new_course_credits
    FROM Course_offerings co
    JOIN Courses c ON co.course_id = c.course_id
    WHERE co.offering_id = p_offering_id;
    
    -- Tính tổng số tín chỉ đã đăng ký trong học kỳ
    SELECT IFNULL(SUM(c.credits), 0) INTO current_credits
    FROM Enrollments e
    JOIN Course_offerings co ON e.offering_id = co.offering_id
    JOIN Courses c ON co.course_id = c.course_id
    WHERE e.student_id = p_student_id
      AND co.semester_id = current_semester_id
      AND e.status IN ('Đăng ký', 'Đang học');
    
    -- Kiểm tra nếu thêm khóa học mới có vượt quá giới hạn
    RETURN current_credits + new_course_credits <= p_max_credits;
END //
DELIMITER ;

-- ======== STORED PROCEDURES ========

-- Procedure: Đăng ký khóa học
DELIMITER //
CREATE PROCEDURE sp_enroll_course(
    IN p_student_id INT,
    IN p_offering_id INT,
    OUT p_success BOOLEAN,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_current_enrollment INT;
    DECLARE v_max_students INT;
    DECLARE v_course_id INT;
    DECLARE v_semester_id INT;
    DECLARE v_registration_open BOOLEAN DEFAULT FALSE;
    DECLARE v_is_enrolled BOOLEAN DEFAULT FALSE;
    DECLARE v_max_credits INT DEFAULT 25; -- Số tín chỉ tối đa mỗi học kỳ
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        SET p_success = FALSE;
        SET p_message = 'Đã xảy ra lỗi trong quá trình đăng ký khóa học';
        ROLLBACK;
    END;
    
    START TRANSACTION;
    
    -- Kiểm tra nếu lớp học phần tồn tại
    SELECT course_id, current_enrollment, max_students, semester_id
    INTO v_course_id, v_current_enrollment, v_max_students, v_semester_id
    FROM Course_offerings
    WHERE offering_id = p_offering_id;
    
    IF v_course_id IS NULL THEN
        SET p_success = FALSE;
        SET p_message = 'Lớp học phần không tồn tại';
        SET exit_handler = TRUE;
    END IF;
    
    IF NOT exit_handler THEN
        -- Kiểm tra xem đợt đăng ký có đang mở không
        SELECT COUNT(*) > 0 INTO v_registration_open
        FROM Semesters
        WHERE semester_id = v_semester_id
            AND CURRENT_DATE BETWEEN registration_start AND registration_end;
        
        IF NOT v_registration_open THEN
            SET p_success = FALSE;
            SET p_message = 'Đợt đăng ký không trong thời gian cho phép';
            SET exit_handler = TRUE;
        END IF;
    END IF;

    IF NOT exit_handler THEN
        -- Kiểm tra xem sinh viên đã đăng ký lớp học phần này chưa
        SELECT COUNT(*) > 0 INTO v_is_enrolled
        FROM Enrollments
        WHERE student_id = p_student_id AND offering_id = p_offering_id
            AND status IN ('Đăng ký', 'Đang học');
        
        IF v_is_enrolled THEN
            SET p_success = FALSE;
            SET p_message = 'Sinh viên đã đăng ký lớp học phần này rồi';
            SET exit_handler = TRUE;
        END IF;
    END IF;

    IF NOT exit_handler THEN
        -- Kiểm tra số chỗ còn lại
        IF v_current_enrollment >= v_max_students THEN
            SET p_success = FALSE;
            SET p_message = 'Lớp học phần đã đầy';
            SET exit_handler = TRUE;
        END IF;
    END IF;
    
    IF NOT exit_handler THEN
        -- Kiểm tra điều kiện tiên quyết
        IF NOT check_prerequisites_satisfied(p_student_id, v_course_id) THEN
            SET p_success = FALSE;
            SET p_message = 'Sinh viên chưa hoàn thành các môn học tiên quyết';
            SET exit_handler = TRUE;
        END IF;
    END IF;
    
    IF NOT exit_handler THEN
        -- Kiểm tra xung đột lịch học
        IF check_schedule_conflict(p_student_id, p_offering_id) THEN
            SET p_success = FALSE;
            SET p_message = 'Lịch học bị trùng với môn học khác đã đăng ký';
            SET exit_handler = TRUE;
        END IF;
    END IF;
    
    IF NOT exit_handler THEN
        -- Kiểm tra số tín chỉ tối đa
        IF NOT check_max_credits(p_student_id, p_offering_id, v_max_credits) THEN
            SET p_success = FALSE;
            SET p_message = CONCAT('Vượt quá số tín chỉ tối đa cho phép (', v_max_credits, ' tín chỉ)');
            SET exit_handler = TRUE;
        END IF;
    END IF;
    
    IF NOT exit_handler THEN
        -- Tạo đăng ký mới
        INSERT INTO Enrollments (student_id, offering_id, enrollment_date, status)
        VALUES (p_student_id, p_offering_id, NOW(), 'Đăng ký');
        
        -- Cập nhật số lượng sinh viên đã đăng ký
        UPDATE Course_offerings
        SET current_enrollment = current_enrollment + 1
        WHERE offering_id = p_offering_id;
        
        -- Ghi lại lịch sử
        INSERT INTO Enrollment_history (enrollment_id, student_id, offering_id, action_type, notes)
        VALUES (LAST_INSERT_ID(), p_student_id, p_offering_id, 'Đăng ký', 'Đăng ký thành công');
        
        SET p_success = TRUE;
        SET p_message = 'Đăng ký khóa học thành công';
        COMMIT;
    ELSE
        IF NOT exit_handler THEN
            ROLLBACK;
        END IF;
    END IF;
END //
DELIMITER ;

-- Procedure: Hủy đăng ký khóa học
DELIMITER //
CREATE PROCEDURE sp_cancel_enrollment(
    IN p_student_id INT,
    IN p_offering_id INT,
    OUT p_success BOOLEAN,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_enrollment_id INT;
    DECLARE v_enrollment_status VARCHAR(20);
    DECLARE v_semester_id INT;
    DECLARE v_cancellation_allowed BOOLEAN DEFAULT FALSE;
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        SET p_success = FALSE;
        SET p_message = 'Đã xảy ra lỗi trong quá trình hủy đăng ký';
        ROLLBACK;
    END;
    
    START TRANSACTION;
    
    -- Kiểm tra xem đăng ký có tồn tại không
    SELECT e.enrollment_id, e.status, co.semester_id
    INTO v_enrollment_id, v_enrollment_status, v_semester_id
    FROM Enrollments e
    JOIN Course_offerings co ON e.offering_id = co.offering_id
    WHERE e.student_id = p_student_id AND e.offering_id = p_offering_id;
    
    IF v_enrollment_id IS NULL THEN
        SET p_success = FALSE;
        SET p_message = 'Không tìm thấy đăng ký khóa học';
        SET exit_handler = TRUE;
    END IF;
    
    IF NOT exit_handler THEN
        -- Kiểm tra trạng thái đăng ký
        IF v_enrollment_status NOT IN ('Đăng ký', 'Đang học') THEN
            SET p_success = FALSE;
            SET p_message = 'Không thể hủy đăng ký với trạng thái hiện tại';
            SET exit_handler = TRUE;
        END IF;
    END IF;

    IF NOT exit_handler THEN
        -- Kiểm tra thời gian hủy đăng ký
        SELECT COUNT(*) > 0 INTO v_cancellation_allowed
        FROM Semesters
        WHERE semester_id = v_semester_id
            AND (CURRENT_DATE BETWEEN registration_start AND registration_end
                 OR CURRENT_DATE <= DATE_ADD(start_date, INTERVAL 14 DAY)); -- Cho phép hủy trong 2 tuần đầu
        
        IF NOT v_cancellation_allowed THEN
            SET p_success = FALSE;
            SET p_message = 'Đã hết thời gian hủy đăng ký khóa học';
            SET exit_handler = TRUE;
        END IF;
    END IF;
    
    IF NOT exit_handler THEN
        -- Cập nhật trạng thái đăng ký
        UPDATE Enrollments
        SET status = 'Hủy'
        WHERE enrollment_id = v_enrollment_id;
        
        -- Giảm số lượng sinh viên đăng ký
        UPDATE Course_offerings
        SET current_enrollment = current_enrollment - 1
        WHERE offering_id = p_offering_id;
        
        -- Ghi lại lịch sử
        INSERT INTO Enrollment_history (enrollment_id, student_id, offering_id, action_type, notes)
        VALUES (v_enrollment_id, p_student_id, p_offering_id, 'Hủy đăng ký', 'Hủy đăng ký thành công');
        
        SET p_success = TRUE;
        SET p_message = 'Hủy đăng ký khóa học thành công';
        COMMIT;
    ELSE
        IF NOT exit_handler THEN
            ROLLBACK;
        END IF;
    END IF;
END //
DELIMITER ;

-- Procedure: Thay đổi lớp học phần
DELIMITER //
CREATE PROCEDURE sp_change_class(
    IN p_student_id INT,
    IN p_current_offering_id INT,
    IN p_new_offering_id INT,
    OUT p_success BOOLEAN,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_current_enrollment_id INT;
    DECLARE v_current_enrollment_status VARCHAR(20);
    DECLARE v_new_current_enrollment INT;
    DECLARE v_new_max_students INT;
    DECLARE v_current_course_id INT;
    DECLARE v_new_course_id INT;
    DECLARE v_semester_id INT;
    DECLARE v_change_allowed BOOLEAN DEFAULT FALSE;
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        SET p_success = FALSE;
        SET p_message = 'Đã xảy ra lỗi trong quá trình thay đổi lớp';
        ROLLBACK;
    END;
    
    START TRANSACTION;
    
    -- Kiểm tra đăng ký hiện tại
    SELECT e.enrollment_id, e.status, co.course_id, co.semester_id
    INTO v_current_enrollment_id, v_current_enrollment_status, v_current_course_id, v_semester_id
    FROM Enrollments e
    JOIN Course_offerings co ON e.offering_id = co.offering_id
    WHERE e.student_id = p_student_id AND e.offering_id = p_current_offering_id;
    
    IF v_current_enrollment_id IS NULL THEN
        SET p_success = FALSE;
        SET p_message = 'Không tìm thấy đăng ký khóa học hiện tại';
        SET exit_handler = TRUE;
    END IF;
    
    IF NOT exit_handler THEN
        -- Kiểm tra trạng thái đăng ký
        IF v_current_enrollment_status NOT IN ('Đăng ký', 'Đang học') THEN
            SET p_success = FALSE;
            SET p_message = 'Không thể thay đổi lớp với trạng thái hiện tại';
            SET exit_handler = TRUE;
        END IF;
    END IF;
    
    IF NOT exit_handler THEN
        -- Kiểm tra lớp mới
        SELECT co.course_id, co.current_enrollment, co.max_students
        INTO v_new_course_id, v_new_current_enrollment, v_new_max_students
        FROM Course_offerings co
        WHERE co.offering_id = p_new_offering_id;
        
        IF v_new_course_id IS NULL THEN
            SET p_success = FALSE;
            SET p_message = 'Lớp học phần mới không tồn tại';
            SET exit_handler = TRUE;
        END IF;
        
        -- Kiểm tra xem hai lớp có cùng khóa học không
        IF v_current_course_id != v_new_course_id THEN
            SET p_success = FALSE;
            SET p_message = 'Không thể chuyển sang lớp của khóa học khác';
            SET exit_handler = TRUE;
        END IF;
        
        -- Kiểm tra số chỗ còn lại trong lớp mới
        IF v_new_current_enrollment >= v_new_max_students THEN
            SET p_success = FALSE;
            SET p_message = 'Lớp học phần mới đã đầy';
            SET exit_handler = TRUE;
        END IF;
        
        -- Kiểm tra thời gian thay đổi lớp
        SELECT COUNT(*) > 0 INTO v_change_allowed
        FROM Semesters
        WHERE semester_id = v_semester_id
            AND (CURRENT_DATE BETWEEN registration_start AND registration_end
                 OR CURRENT_DATE <= DATE_ADD(start_date, INTERVAL 14 DAY)); -- Cho phép thay đổi trong 2 tuần đầu
        
        IF NOT v_change_allowed THEN
            SET p_success = FALSE;
            SET p_message = 'Đã hết thời gian thay đổi lớp học phần';
            SET exit_handler = TRUE;
        END IF;
        
        -- Kiểm tra xung đột lịch học với lớp mới
        IF check_schedule_conflict(p_student_id, p_new_offering_id) THEN
            SET p_success = FALSE;
            SET p_message = 'Lịch học của lớp mới bị trùng với môn học khác đã đăng ký';
            SET exit_handler = TRUE;
        END IF;
    END IF;
    
    IF NOT exit_handler THEN
        -- Cập nhật đăng ký
        UPDATE Enrollments
        SET offering_id = p_new_offering_id
        WHERE enrollment_id = v_current_enrollment_id;
        
        -- Giảm số lượng sinh viên đăng ký ở lớp cũ
        UPDATE Course_offerings
        SET current_enrollment = current_enrollment - 1
        WHERE offering_id = p_current_offering_id;
        
        -- Tăng số lượng sinh viên đăng ký ở lớp mới
        UPDATE Course_offerings
        SET current_enrollment = current_enrollment + 1
        WHERE offering_id = p_new_offering_id;
        
        -- Ghi lại lịch sử
        INSERT INTO Enrollment_history (enrollment_id, student_id, offering_id, action_type, notes)
        VALUES (v_current_enrollment_id, p_student_id, p_new_offering_id, 'Thay đổi lớp', 
                CONCAT('Thay đổi từ lớp ', p_current_offering_id, ' sang lớp ', p_new_offering_id));
        
        SET p_success = TRUE;
        SET p_message = 'Thay đổi lớp học phần thành công';
        COMMIT;
    ELSE
        IF NOT exit_handler THEN
            ROLLBACK;
        END IF;
    END IF;
END //
DELIMITER ;

-- ======== VIEWS ========

-- View: Thời khóa biểu sinh viên
CREATE VIEW vw_student_schedule AS
SELECT 
    s.student_id,
    s.student_code,
    CONCAT(s.last_name, ' ', s.first_name) AS student_name,
    sm.semester_name,
    sm.academic_year,
    c.course_code,
    c.course_name,
    c.credits,
    co.section_number,
    cs.day_of_week,
    cs.start_time,
    cs.end_time,
    CONCAT(cs.building, ' - ', cs.room) AS location,
    CONCAT(i.last_name, ' ', i.first_name) AS instructor_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Course_offerings co ON e.offering_id = co.offering_id
JOIN Courses c ON co.course_id = c.course_id
JOIN Semesters sm ON co.semester_id = sm.semester_id
JOIN Course_schedules cs ON co.offering_id = cs.offering_id
LEFT JOIN Instructors i ON co.instructor_id = i.instructor_id
WHERE e.status IN ('Đăng ký', 'Đang học');

-- View: Thông tin đăng ký
CREATE VIEW vw_enrollment_statistics AS
SELECT 
    co.offering_id,
    c.course_code,
    c.course_name,
    co.section_number,
    s.semester_name,
    s.academic_year,
    co.max_students,
    co.current_enrollment,
    (co.max_students - co.current_enrollment) AS available_seats,
    ROUND((co.current_enrollment / co.max_students) * 100, 2) AS enrollment_percentage,
    CONCAT(i.last_name, ' ', i.first_name) AS instructor_name,
    d.department_name
FROM Course_offerings co
JOIN Courses c ON co.course_id = c.course_id
JOIN Semesters s ON co.semester_id = s.semester_id
LEFT JOIN Instructors i ON co.instructor_id = i.instructor_id
LEFT JOIN Departments d ON c.department_id = d.department_id;

-- View: Kiểm tra điều kiện tiên quyết
CREATE VIEW vw_course_prerequisites AS
SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    pc.course_code AS prerequisite_code,
    pc.course_name AS prerequisite_name
FROM Courses c
LEFT JOIN Prerequisites p ON c.course_id = p.course_id
LEFT JOIN Courses pc ON p.prerequisite_id = pc.course_id
ORDER BY c.course_code, pc.course_code;

-- View: Bảng điểm sinh viên
CREATE VIEW vw_student_grades AS
SELECT 
    s.student_id,
    s.student_code,
    CONCAT(s.last_name, ' ', s.first_name) AS student_name,
    d.department_name,
    sm.semester_name,
    sm.academic_year,
    c.course_code,
    c.course_name,
    c.credits,
    e.grade,
    CASE
        WHEN e.grade >= 9.0 THEN 'A+'
        WHEN e.grade >= 8.5 THEN 'A'
        WHEN e.grade >= 8.0 THEN 'B+'
        WHEN e.grade >= 7.0 THEN 'B'
        WHEN e.grade >= 6.5 THEN 'C+'
        WHEN e.grade >= 5.5 THEN 'C'
        WHEN e.grade >= 5.0 THEN 'D+'
        WHEN e.grade >= 4.0 THEN 'D'
        ELSE 'F'
    END AS letter_grade,
    e.status
FROM Students s
JOIN Departments d ON s.department_id = d.department_id
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Course_offerings co ON e.offering_id = co.offering_id
JOIN Courses c ON co.course_id = c.course_id
JOIN Semesters sm ON co.semester_id = sm.semester_id;

-- ======== DỮ LIỆU MẪU ========

-- Thêm dữ liệu mẫu cho bảng Faculties
INSERT INTO Faculties (faculty_name, description, dean) VALUES
('Khoa Công nghệ thông tin', 'Đào tạo về công nghệ thông tin và máy tính', 'TS. Nguyễn Văn A'),
('Khoa Kinh tế', 'Đào tạo về kinh tế và quản lý', 'TS. Trần Thị B'),
('Khoa Ngoại ngữ', 'Đào tạo về ngôn ngữ và văn hóa nước ngoài', 'TS. Lê Văn C');

-- Thêm dữ liệu mẫu cho bảng Departments
INSERT INTO Departments (department_name, faculty_id, head_of_department) VALUES
('Bộ môn Khoa học máy tính', 1, 'TS. Phạm Thị D'),
('Bộ môn Kỹ thuật phần mềm', 1, 'TS. Hoàng Văn E'),
('Bộ môn Mạng máy tính', 1, 'TS. Vũ Thị F'),
('Bộ môn Quản trị kinh doanh', 2, 'TS. Đỗ Văn G'),
('Bộ môn Kế toán', 2, 'TS. Lý Thị H'),
('Bộ môn Tiếng Anh', 3, 'TS. Trịnh Văn I');

-- Thêm dữ liệu mẫu cho bảng Students
INSERT INTO Students (student_code, first_name, last_name, date_of_birth, gender, email, phone, department_id, enrollment_year) VALUES
('SV001', 'Thành', 'Nguyễn Văn', '2000-05-15', 'Nam', 'thanh.nv@example.com', '0901234567', 1, 2020),
('SV002', 'Hương', 'Trần Thị', '2001-07-20', 'Nữ', 'huong.tt@example.com', '0912345678', 1, 2020),
('SV003', 'Dũng', 'Lê Văn', '2000-03-10', 'Nam', 'dung.lv@example.com', '0923456789', 2, 2020),
('SV004', 'Mai', 'Phạm Thị', '2001-11-25', 'Nữ', 'mai.pt@example.com', '0934567890', 2, 2020),
('SV005', 'Hùng', 'Hoàng Văn', '2000-09-05', 'Nam', 'hung.hv@example.com', '0945678901', 3, 2021),
('SV006', 'Lan', 'Vũ Thị', '2001-01-18', 'Nữ', 'lan.vt@example.com', '0956789012', 3, 2021),
('SV007', 'Tuấn', 'Đỗ Văn', '2000-12-30', 'Nam', 'tuan.dv@example.com', '0967890123', 4, 2021),
('SV008', 'Hồng', 'Lý Thị', '2001-04-22', 'Nữ', 'hong.lt@example.com', '0978901234', 4, 2021),
('SV009', 'Minh', 'Trịnh Văn', '2000-08-16', 'Nam', 'minh.tv@example.com', '0989012345', 5, 2022),
('SV010', 'Hà', 'Ngô Thị', '2001-02-27', 'Nữ', 'ha.nt@example.com', '0990123456', 5, 2022);

-- Thêm dữ liệu mẫu cho bảng Instructors
INSERT INTO Instructors (first_name, last_name, email, phone, department_id, academic_rank) VALUES
('Quang', 'Nguyễn Văn', 'quang.nv@example.com', '0901111222', 1, 'Phó Giáo sư'),
('Thu', 'Trần Thị', 'thu.tt@example.com', '0902222333', 1, 'Tiến sĩ'),
('Hải', 'Lê Văn', 'hai.lv@example.com', '0903333444', 2, 'Tiến sĩ'),
('Linh', 'Phạm Thị', 'linh.pt@example.com', '0904444555', 2, 'Thạc sĩ'),
('Tùng', 'Hoàng Văn', 'tung.hv@example.com', '0905555666', 3, 'Tiến sĩ'),
('Huyền', 'Vũ Thị', 'huyen.vt@example.com', '0906666777', 3, 'Thạc sĩ'),
('Nam', 'Đỗ Văn', 'nam.dv@example.com', '0907777888', 4, 'Tiến sĩ'),
('Thảo', 'Lý Thị', 'thao.lt@example.com', '0908888999', 4, 'Tiến sĩ'),
('Long', 'Trịnh Văn', 'long.tv@example.com', '0909999000', 5, 'Phó Giáo sư'),
('Ngọc', 'Ngô Thị', 'ngoc.nt@example.com', '0900000111', 5, 'Tiến sĩ');

-- Thêm dữ liệu mẫu cho bảng Courses
INSERT INTO Courses (course_code, course_name, credits, description, department_id) VALUES
('COMP101', 'Nhập môn lập trình', 3, 'Giới thiệu về lập trình với ngôn ngữ C/C++', 1),
('COMP102', 'Cấu trúc dữ liệu và giải thuật', 4, 'Học về cấu trúc dữ liệu và giải thuật cơ bản', 1),
('COMP201', 'Cơ sở dữ liệu', 3, 'Các nguyên lý cơ sở dữ liệu và SQL', 1),
('COMP202', 'Lập trình hướng đối tượng', 3, 'Lập trình hướng đối tượng với Java', 2),
('COMP301', 'Phát triển ứng dụng web', 4, 'Phát triển các ứng dụng web với HTML, CSS, JavaScript', 2),
('COMP302', 'Mạng máy tính', 3, 'Nguyên lý mạng máy tính và giao thức', 3),
('ECON101', 'Kinh tế vĩ mô', 3, 'Các nguyên lý kinh tế vĩ mô', 4),
('ECON102', 'Kinh tế vi mô', 3, 'Các nguyên lý kinh tế vi mô', 4),
('ACCT201', 'Nguyên lý kế toán', 3, 'Các nguyên lý cơ bản về kế toán', 5),
('ENGL101', 'Tiếng Anh cơ bản', 3, 'Tiếng Anh cho người mới bắt đầu', 6);

-- Thêm dữ liệu mẫu cho bảng Prerequisites
INSERT INTO Prerequisites (course_id, prerequisite_id) VALUES
(2, 1),  -- COMP102 yêu cầu COMP101
(3, 1),  -- COMP201 yêu cầu COMP101
(4, 1),  -- COMP202 yêu cầu COMP101
(5, 4),  -- COMP301 yêu cầu COMP202
(5, 3),  -- COMP301 yêu cầu COMP201
(6, 1),  -- COMP302 yêu cầu COMP101
(8, 7),  -- ECON102 yêu cầu ECON101
(9, 7);  -- ACCT201 yêu cầu ECON101

-- Thêm dữ liệu mẫu cho bảng Semesters
INSERT INTO Semesters (semester_name, academic_year, start_date, end_date, registration_start, registration_end, status) VALUES
('Học kỳ 1', '2022-2023', '2022-09-01', '2023-01-15', '2022-08-01', '2022-08-15', 'Kết thúc'),
('Học kỳ 2', '2022-2023', '2023-02-01', '2023-06-15', '2023-01-16', '2023-01-31', 'Kết thúc'),
('Học kỳ 1', '2023-2024', '2023-09-01', '2024-01-15', '2023-08-01', '2023-08-15', 'Đang diễn ra'),
('Học kỳ 2', '2023-2024', '2024-02-01', '2024-06-15', '2024-01-16', '2024-01-31', 'Sắp tới');

-- Thêm dữ liệu mẫu cho bảng Course_offerings
INSERT INTO Course_offerings (course_id, semester_id, section_number, instructor_id, max_students, classroom) VALUES
(1, 1, '01', 1, 40, 'A101'),
(1, 1, '02', 2, 40, 'A102'),
(2, 1, '01', 3, 35, 'A201'),
(3, 1, '01', 4, 35, 'A202'),
(4, 2, '01', 5, 30, 'B101'),
(4, 2, '02', 6, 30, 'B102'),
(5, 2, '01', 7, 30, 'B201'),
(6, 2, '01', 8, 30, 'B202'),
(1, 3, '01', 1, 40, 'A101'),
(1, 3, '02', 2, 40, 'A102'),
(2, 3, '01', 3, 35, 'A201'),
(3, 3, '01', 4, 35, 'A202'),
(4, 3, '01', 5, 30, 'B101'),
(7, 3, '01', 9, 45, 'C101'),
(8, 3, '01', 10, 45, 'C102'),
(9, 3, '01', 9, 40, 'C201'),
(10, 3, '01', 10, 50, 'D101');

-- Thêm dữ liệu mẫu cho bảng Course_schedules
INSERT INTO Course_schedules (offering_id, day_of_week, start_time, end_time, room, building) VALUES
(1, 'Monday', '08:00:00', '10:00:00', 'A101', 'Tòa A'),
(1, 'Wednesday', '08:00:00', '10:00:00', 'A101', 'Tòa A'),
(2, 'Monday', '13:00:00', '15:00:00', 'A102', 'Tòa A'),
(2, 'Wednesday', '13:00:00', '15:00:00', 'A102', 'Tòa A'),
(3, 'Tuesday', '08:00:00', '11:00:00', 'A201', 'Tòa A'),
(3, 'Thursday', '08:00:00', '11:00:00', 'A201', 'Tòa A'),
(4, 'Tuesday', '13:00:00', '16:00:00', 'A202', 'Tòa A'),
(4, 'Thursday', '13:00:00', '16:00:00', 'A202', 'Tòa A'),
(5, 'Monday', '08:00:00', '10:00:00', 'B101', 'Tòa B'),
(5, 'Wednesday', '08:00:00', '10:00:00', 'B101', 'Tòa B'),
(6, 'Monday', '13:00:00', '15:00:00', 'B102', 'Tòa B'),
(6, 'Wednesday', '13:00:00', '15:00:00', 'B102', 'Tòa B'),
(7, 'Tuesday', '08:00:00', '11:00:00', 'B201', 'Tòa B'),
(7, 'Thursday', '08:00:00', '11:00:00', 'B201', 'Tòa B'),
(8, 'Tuesday', '13:00:00', '16:00:00', 'B202', 'Tòa B'),
(8, 'Thursday', '13:00:00', '16:00:00', 'B202', 'Tòa B'),
(9, 'Monday', '08:00:00', '10:00:00', 'A101', 'Tòa A'),
(9, 'Wednesday', '08:00:00', '10:00:00', 'A101', 'Tòa A'),
(10, 'Monday', '13:00:00', '15:00:00', 'A102', 'Tòa A'),
(10, 'Wednesday', '13:00:00', '15:00:00', 'A102', 'Tòa A'),
(11, 'Tuesday', '08:00:00', '11:00:00', 'A201', 'Tòa A'),
(11, 'Thursday', '08:00:00', '11:00:00', 'A201', 'Tòa A'),
(12, 'Tuesday', '13:00:00', '16:00:00', 'A202', 'Tòa A'),
(12, 'Thursday', '13:00:00', '16:00:00', 'A202', 'Tòa A'),
(13, 'Friday', '08:00:00', '11:00:00', 'B101', 'Tòa B'),
(14, 'Friday', '13:00:00', '16:00:00', 'C101', 'Tòa C'),
(15, 'Monday', '08:00:00', '11:00:00', 'C102', 'Tòa C'),
(16, 'Wednesday', '13:00:00', '16:00:00', 'C201', 'Tòa C'),
(17, 'Friday', '08:00:00', '11:00:00', 'D101', 'Tòa D');

-- Thêm dữ liệu mẫu cho bảng Enrollments (học kỳ trước)
INSERT INTO Enrollments (student_id, offering_id, enrollment_date, status, grade) VALUES
(1, 1, '2022-08-05', 'Hoàn thành', 8.5),
(1, 3, '2022-08-05', 'Hoàn thành', 7.8),
(2, 1, '2022-08-06', 'Hoàn thành', 9.0),
(2, 4, '2022-08-06', 'Hoàn thành', 8.3),
(3, 2, '2022-08-07', 'Hoàn thành', 7.5),
(3, 3, '2022-08-07', 'Hoàn thành', 8.0),
(4, 2, '2022-08-08', 'Hoàn thành', 8.8),
(4, 4, '2022-08-08', 'Hoàn thành', 9.2),
(1, 5, '2023-01-20', 'Hoàn thành', 8.7),
(1, 7, '2023-01-20', 'Hoàn thành', 9.3),
(2, 5, '2023-01-21', 'Hoàn thành', 8.5),
(2, 8, '2023-01-21', 'Hoàn thành', 7.9),
(3, 6, '2023-01-22', 'Hoàn thành', 7.0),
(3, 7, '2023-01-22', 'Hoàn thành', 8.2),
(4, 6, '2023-01-23', 'Hoàn thành', 8.5),
(4, 8, '2023-01-23', 'Hoàn thành', 9.0);

-- Thêm dữ liệu mẫu cho bảng Enrollments (học kỳ hiện tại)
INSERT INTO Enrollments (student_id, offering_id, enrollment_date, status) VALUES
(1, 9, '2023-08-05', 'Đang học'),
(1, 11, '2023-08-05', 'Đang học'),
(2, 9, '2023-08-06', 'Đang học'),
(2, 12, '2023-08-06', 'Đang học'),
(3, 10, '2023-08-07', 'Đang học'),
(3, 11, '2023-08-07', 'Đang học'),
(4, 10, '2023-08-08', 'Đang học'),
(4, 12, '2023-08-08', 'Đang học'),
(5, 9, '2023-08-09', 'Đang học'),
(5, 13, '2023-08-09', 'Đang học'),
(6, 10, '2023-08-10', 'Đang học'),
(6, 13, '2023-08-10', 'Đang học'),
(7, 14, '2023-08-11', 'Đang học'),
(7, 16, '2023-08-11', 'Đang học'),
(8, 15, '2023-08-12', 'Đang học'),
(8, 17, '2023-08-12', 'Đang học'),
(9, 14, '2023-08-13', 'Đang học'),
(9, 17, '2023-08-13', 'Đang học'),
(10, 15, '2023-08-14', 'Đang học'),
(10, 16, '2023-08-14', 'Đang học');

-- Cập nhật số lượng sinh viên đã đăng ký cho mỗi lớp
UPDATE Course_offerings co
SET current_enrollment = (
    SELECT COUNT(*) 
    FROM Enrollments e 
    WHERE e.offering_id = co.offering_id 
    AND e.status IN ('Đăng ký', 'Đang học', 'Hoàn thành')
);

-- ======== VÍ DỤ SỬ DỤNG STORED PROCEDURES ========

-- Ví dụ đăng ký khóa học mới
SET @success = FALSE;
SET @message = '';
CALL sp_enroll_course(1, 13, @success, @message);
SELECT @success, @message;

-- Ví dụ hủy đăng ký khóa học
SET @success = FALSE;
SET @message = '';
CALL sp_cancel_enrollment(1, 11, @success, @message);
SELECT @success, @message;

-- Ví dụ thay đổi lớp học phần
SET @success = FALSE;
SET @message = '';
CALL sp_change_class(2, 9, 10, @success, @message);
SELECT @success, @message;

-- ======== DEMO TRUY VẤN ========

-- 1. Xem thời khóa biểu của một sinh viên
SELECT * FROM vw_student_schedule WHERE student_id = 1;

-- 2. Xem danh sách lớp học phần và tỷ lệ đăng ký
SELECT * FROM vw_enrollment_statistics WHERE semester_name = 'Học kỳ 1' AND academic_year = '2023-2024';

-- 3. Xem bảng điểm của một sinh viên
SELECT * FROM vw_student_grades WHERE student_id = 1 ORDER BY academic_year, semester_name;

-- 4. Xem điều kiện tiên quyết của một môn học
SELECT * FROM vw_course_prerequisites WHERE course_code = 'COMP301';

-- 5. Kiểm tra xung đột lịch học
SELECT check_schedule_conflict(1, 15) AS has_conflict;

-- 6. Kiểm tra điều kiện tiên quyết
SELECT check_prerequisites_satisfied(1, 5) AS prerequisites_met;

-- 7. Kiểm tra số tín chỉ tối đa
SELECT check_max_credits(1, 14, 25) AS credits_limit_ok;
