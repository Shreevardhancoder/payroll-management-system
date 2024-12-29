const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');
const bcrypt = require('bcryptjs'); // For password hashing
const jwt = require('jsonwebtoken'); // For JWT token generation
const PDFDocument = require('pdfkit');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// JWT Secret Key
const jwtSecret = 'Shreevardhan';

// MySQL Connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Shree@17',
    database: 'payroll_system'
});

db.connect((err) => {
    if (err) {
        console.error('MySQL Connection Error:', err);
        return;
    }
    console.log('MySQL Connected...');
});

// Middleware to Protect Routes
const verifyToken = (req, res, next) => {
    const token = req.headers['authorization'];
    if (!token) return res.status(403).send('Token is required');
    
    jwt.verify(token, jwtSecret, (err, decoded) => {
        if (err) {
            return res.status(401).send('Invalid token');
        }
        req.userId = decoded.userId;
        next();
    });
};

// User Signup Route
app.post('/signup', (req, res) => {
    const { username, email, password } = req.body;

    // Validate the input fields
    if (!username || !email || !password) {
        return res.status(400).send('Please provide username, email, and password.');
    }

    // Check if username or email is already in use
    const checkUserQuery = 'SELECT * FROM users WHERE username = ? OR email = ?';
    db.query(checkUserQuery, [username, email], (err, result) => {
        if (err) {
            console.error('Error checking user:', err);
            return res.status(500).send('Server error');
        }

        if (result.length > 0) {
            return res.status(400).send('Username or email already in use.');
        }

        // Hash the password
        bcrypt.hash(password, 10, (err, hashedPassword) => {
            if (err) {
                console.error('Error hashing password:', err);
                return res.status(500).send('Server error');
            }

            // Insert the new user into the database
            const sql = 'INSERT INTO users (username, email, password) VALUES (?, ?, ?)';
            db.query(sql, [username, email, hashedPassword], (err, result) => {
                if (err) {
                    console.error('Error adding user:', err);
                    return res.status(500).send('Error adding user');
                }
                res.status(201).send('User registered successfully');
            });
        });
    });
});

       
// User Login Route
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    const sql = 'SELECT * FROM users WHERE username = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            console.error('Error fetching user:', err);
            return res.status(500).send('Server error');
        }

        if (result.length === 0) {
            return res.status(400).send('User not found');
        }

        const user = result[0];
        bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err) {
                console.error('Error comparing passwords:', err);
                return res.status(500).send('Server error');
            }

            if (!isMatch) {
                return res.status(400).send('Incorrect password');
            }

            const token = jwt.sign({ userId: user.id }, jwtSecret, { expiresIn: '1h' });
            res.send({ token });
        });
    });
});

// Add Employee with Duplicate Check
app.post('/addEmployee', verifyToken, (req, res) => {
    const emp = req.body;
    console.log('Received Employee Data:', emp);  // Log received data

    const checkEmployeeQuery = 'SELECT * FROM employees WHERE first_name = ? AND last_name = ? AND hire_date = ?';
    const checkValues = [emp.first_name, emp.last_name, emp.hire_date];

    db.query(checkEmployeeQuery, checkValues, (err, result) => {
        if (err) {
            console.error('Error checking employee:', err);
            return res.status(500).send('Error checking employee');
        }

        if (result.length > 0) {
            return res.status(400).send('Employee already exists.');
        }

        const insertEmployeeQuery = `
            INSERT INTO employees 
            (first_name, last_name, department, designation, basic_salary, hire_date, bank_name, account_number, ifsc_code, branch_name) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;
        const values = [
            emp.first_name ?? '', 
            emp.last_name ?? '', 
            emp.department ?? '', 
            emp.designation ?? '', 
            emp.basic_salary ?? 0, 
            emp.hire_date ?? null,
            emp.bank_name ?? '', 
            emp.account_number ?? '', 
            emp.ifsc_code ?? '', 
            emp.branch_name ?? ''
        ];

        db.query(insertEmployeeQuery, values, (err, result) => {
            console.log('Insert values:', values); // Log values to verify

            if (err) {
                console.error('Error adding employee:', err);
                return res.status(500).send('Error adding employee');
            }
            
            res.send('Employee added successfully');
        });
    });
});


// Get Employee Payroll
app.get('/payroll/:emp_id', verifyToken, (req, res) => {
    const emp_id = req.params.emp_id;
    const sql = 'SELECT * FROM Payroll WHERE emp_id = ?';
    db.query(sql, [emp_id], (err, result) => {
        if (err) {
            console.error('Error fetching payroll:', err);
            return res.status(500).send('Error fetching payroll');
        }
        res.send(result);
    });
});

// Calculate Payroll
app.post('/calculatePayroll', verifyToken, (req, res) => {
    const { emp_id, tax, bonus, deductions } = req.body;

    // Step 1: Retrieve the basic salary for the employee from the 'employees' table
    const salaryQuery = 'SELECT basic_salary FROM employees WHERE id = ?';
    db.query(salaryQuery, [emp_id], (err, result) => {
        if (err) return res.status(500).send('Error fetching basic salary');
        if (result.length === 0) return res.status(404).send('Employee not found');

        // Step 2: Calculate the net salary based on retrieved basic salary and provided tax, bonus, and deductions
        const basic_salary = result[0].basic_salary;
        const net_salary = basic_salary + parseFloat(bonus) - parseFloat(tax) - parseFloat(deductions);

        // Get the current date in YYYY-MM-DD format using JavaScript's Date object
        const today = new Date();
        const pay_date = today.toISOString().split('T')[0]; // Format: YYYY-MM-DD

        // Step 3: Insert or update the payroll record
        const insertPayrollQuery = `
            INSERT INTO Payroll (emp_id, tax, bonus, deductions, net_salary, pay_date) 
            VALUES (?, ?, ?, ?, ?, ?) 
            ON DUPLICATE KEY UPDATE 
                tax = VALUES(tax), 
                bonus = VALUES(bonus), 
                deductions = VALUES(deductions), 
                net_salary = VALUES(net_salary);
        `;

        // Array of values to insert or update the payroll record
        const values = [
            emp_id, 
            tax, 
            bonus, 
            deductions, 
            net_salary, 
            pay_date
        ];

        // Execute the query to insert or update the payroll record
        db.query(insertPayrollQuery, values, (err) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Error calculating payroll');
            }
            res.send({ message: 'Payroll calculated successfully', net_salary });
        });
    });
});



// Delete Employee
app.delete('/deleteEmployee/:id', verifyToken, (req, res) => {
    const id = req.params.id;

    const checkSql = 'SELECT * FROM employees WHERE id = ?';
    db.query(checkSql, [id], (checkErr, checkResult) => {
        if (checkErr) {
            console.error('Error checking employee existence:', checkErr);
            return res.status(500).send('Error checking employee');
        }
        if (checkResult.length === 0) {
            return res.status(404).send('Employee not found');
        }

        const sql = 'DELETE FROM employees WHERE id = ?';
        db.query(sql, [id], (err, result) => {
            if (err) {
                console.error('Error deleting employee:', err);
                return res.status(500).send('Error deleting employee');
            }
            if (result.affectedRows === 0) {
                return res.status(404).send('Employee not found');
            }
            res.send('Employee deleted successfully');
        });
    });
});
app.post('/generatePayrollSlip/:employeeId', verifyToken, async (req, res) => {
    const employeeId = req.params.employeeId;
    const payroll = req.body; // Accept payroll data from the request body
  
    console.log('Received payroll data for Employee ID:', employeeId);
  
    try {
        const [employeeResult] = await db.promise().query('SELECT * FROM employees WHERE id = ?', [employeeId]);
        if (!employeeResult.length) {
            console.log('Employee not found:', employeeId);
            return res.status(404).send('Employee not found');
        }
        const employee = employeeResult[0];

        // Create PDF document
        const doc = new PDFDocument();
        const fileName = `payroll_slip_${employeeId}.pdf`;
        res.setHeader('Content-Disposition', `attachment; filename="${fileName}"`);
        res.setHeader('Content-Type', 'application/pdf');
        doc.pipe(res);

        // Title
        doc.fontSize(20).text('Payroll Slip', { align: 'center' });
        doc.moveDown();

        // Employee details
        doc.fontSize(12).text(`Employee ID: ${employee.id}`);
        doc.text(`Name: ${employee.first_name} ${employee.last_name}`);
        doc.text(`Department: ${employee.department}`);
        doc.text(`Designation: ${employee.designation}`);
        doc.moveDown();

        // Bank details
        doc.text(`Bank Name: ${employee.bank_name || 'N/A'}`);
        doc.text(`Account Number: ${employee.account_number || 'N/A'}`);
        doc.text(`IFSC Code: ${employee.ifsc_code || 'N/A'}`);
        doc.text(`Branch Name: ${employee.branch_name || 'N/A'}`);
        doc.moveDown();

        // Payroll details from request body
        doc.text(`Net Salary: ${payroll.net_salary}`);
        doc.text(`Tax: ${payroll.tax}`);
        doc.text(`Bonus: ${payroll.bonus}`);
        doc.text(`Deductions: ${payroll.deductions}`);
        doc.text(`Pay Date: ${new Date(payroll.pay_date).toLocaleDateString()}`);
        
        // Finalize PDF file
        doc.end();
  
    } catch (error) {
        console.error('Error generating payroll slip:', error);
        res.status(500).send('Error generating payroll slip');
    }
});


  app.listen(3004, () => {
    console.log(`Server running on 3004}`);
  });  