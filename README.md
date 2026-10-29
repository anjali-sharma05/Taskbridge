# TaskBridge – Smart Academic Task Management System

TaskBridge is an enterprise-grade academic management web portal designed for college departments to seamlessly publish, evaluate, and track diverse coursework submissions. It enforces standardized marking rubrics across multiple academic task types and delivers real-time interactive performance analytics for students.

---

## 🚀 Key Features

### 1. Modern Professional Dark Theme
- Sleek charcoal and deep navy design system (`#0b0f19`, `#162032`) with purple (`#8b5cf6`), cyan (`#06b6d4`), and sky blue (`#38bdf8`) accents.
- Responsive desktop and mobile navigation layout with modern sidebars, stats cards, and glowing interactive hover states.
- Clean typography (Plus Jakarta Sans) with high contrast for optimal readability in demos and presentations.

### 2. Teacher Registration with Subject Specialization
- Specialized registration workflow for faculty members with required teaching subject selection.
- Pre-populated dropdown options:
  - Advanced Internet Programming (AIP)
  - Java Programming
  - Database Management System (DBMS)
  - Data Structures and Algorithms (DSA)
  - Computer Networks
  - Operating Systems
  - Software Engineering
  - Artificial Intelligence
  - Machine Learning
  - Other (with dynamic custom subject name input)
- Automatically tags all published academic tasks with the instructor's subject.
- Server-side session authentication prevents browser spoofing of teacher IDs.

### 3. Three Standardized Academic Work Types
Automatically applies and strictly enforces marking scales on both client and server:
- **Assignment**: Evaluated out of **10 marks** (homework, lab exercises, problem sets).
- **Case Study**: Evaluated out of **20 marks** (analytical studies, system designs).
- **Project Report**: Evaluated out of **50 marks** (capstone projects, mini-project documentation).

### 4. Student Performance Line Graph (Chart.js)
- Responsive line graph plotting evaluated coursework scores across all 3 academic categories:
  - **X-Axis**: Assignment (10m), Case Study (20m), Project Report (50m).
  - **Y-Axis**: Actual marks obtained or normalized percentage.
- **Interactive Toggle**: Switch between **Marks Obtained** (raw score vs. max scale benchmark) and **Performance %** (0%–100% normalized view for fair comparison across categories).
- Displays category averages and gracefully handles unevaluated categories without skewing data to zero.

### 5. Detailed Marks & Feedback Breakdown
Directly below the performance graph, verified results are presented in dedicated cards:
- **A. Assignment Results**: Title, Subject, Marks out of 10, %, Teacher Feedback, Evaluation Timestamp.
- **B. Case Study Results**: Title, Subject, Marks out of 20, %, Teacher Feedback, Evaluation Timestamp.
- **C. Project Report Results**: Title, Subject, Marks out of 50, %, Teacher Feedback, Evaluation Timestamp.
- Clearly displays "Feedback pending" when grading has not yet concluded.

### 6. Teacher Evaluation Panel with Boundary Enforcement
- Review submissions by task with attached file download links.
- Strict input validation enforcing category boundaries:
  - Assignment: `0` to `10`
  - Case Study: `0` to `20`
  - Project Report: `0` to `50`
- Rejects negative marks or values exceeding applicable maximums.
- Teacher authorization prevents evaluating tasks belonging to other instructors.

### 7. Security & Access Control
- Jakarta Servlets 6.1 & JSP 4.0 compliant for Apache Tomcat 11.
- BCrypt password hashing (work factor 10) for secure credential storage.
- 100% Parameterized queries with `PreparedStatement` to prevent SQL Injection.
- Role-based route protection via `AuthFilter` (`/teacher/*`, `/student/*`, `/download`).
- File upload sanitization with academic extension whitelisting (`.pdf`, `.docx`, `.zip`, etc.) and path traversal prevention.

---

## 🛠️ Technology Stack

| Layer | Technology |
| :--- | :--- |
| **Language & Platform** | Java 17+ (compatible with JDK 17, 21, 26) |
| **Web Tier** | Jakarta Servlet 6.1, JSP 4.0, JSTL 3.0 |
| **Web Server** | Apache Tomcat 11 |
| **Database** | MySQL 8.0+ |
| **Database Driver** | MySQL Connector / J 8.3.0 |
| **Security** | jBCrypt 0.4 (Password Hashing), Session Invalidation |
| **Frontend** | HTML5, Modern CSS3 Dark Design System, Vanilla JS |
| **Visualization** | Chart.js |

---

## 🗄️ Database Setup & Migration

### Option A: Clean Installation
Execute the complete schema and seed data in MySQL:
```bash
mysql -u root -p < StudentAssignmentSystem/database.sql
```
*(Default database credentials in `DBConnectionUtil.java`: `root` / `root` on `localhost:3306`)*.

### Option B: Safe Migration for Existing Databases
If you already have data in `student_assignment_db`, run the migration script without losing any records:
```bash
mysql -u root -p < StudentAssignmentSystem/migration_taskbridge.sql
```

---

## 🔑 Demo Login Credentials

For quick evaluation and Viva demonstrations, pre-configured accounts are available:

| Role | Email Address | Password | Details |
| :--- | :--- | :--- | :--- |
| **Teacher** | `teacher@college.edu` | `teacher123` | Prof. Sharma (Subject: Java Programming) |
| **Student** | `student@college.edu` | `student123` | Rahul Verma |

*(Clickable pre-fill buttons are also available directly on the login page!)*

---

## 📦 How to Build and Run

### Running on Apache Tomcat 11:
1. Open the project in your IDE (Eclipse, IntelliJ IDEA, or VS Code) or deploy the exploded folder to Tomcat:
   ```
   Tomcat 11 webapps directory:
   <tomcat_home>/webapps/StudentAssignmentSystem/
   ```
2. Build the project using the included builder:
   ```cmd
   cd StudentAssignmentSystem
   build-project.bat
   ```
3. Start Tomcat using `run-server.bat` or standard `catalina.bat run`.
4. Open your browser and navigate to:
   ```
   http://localhost:8080/StudentAssignmentSystem/
   ```

---

## 🧪 Testing Checklist

1. **Teacher Registration with Subject**:
   - Go to `/register.jsp`. Select **Teacher**.
   - Verify the subject dropdown appears. Select "Other" and type a custom subject.
   - Register and log in. Verify your subject appears in the sidebar and top navbar.
2. **Publish Academic Tasks**:
   - On the Teacher Dashboard, click **Publish Task**.
   - Switch task type between Assignment (10m), Case Study (20m), and Project Report (50m). Notice the automatic marking scale badge.
   - Publish all 3 types.
3. **Student Submission**:
   - Log in as `student@college.edu` / `student123`.
   - Filter tasks using the category pills (All, Assignments, Case Studies, Project Reports).
   - Upload a solution file (`.pdf` or `.docx`).
4. **Teacher Evaluation & Grading**:
   - Log in as the teacher, open **Review Submissions**.
   - Try entering marks greater than the maximum (e.g. 15 for an Assignment or 25 for a Case Study). Verify the server validation blocks the input.
   - Award valid marks (e.g. 9/10, 18/20, 45/50) and leave feedback.
5. **Student Performance Analytics**:
   - Log back in as the student.
   - Observe the **Performance Line Graph** plotted for the categories.
   - Toggle between **Marks Obtained** and **Performance %**.
   - Check the **Detailed Results** section below the graph for sections A, B, and C.
