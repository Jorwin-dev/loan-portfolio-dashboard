SELECT * FROM bank_loan_data

/* BANK LOAN REPORT | SUMMARY */

/* KPI's */
-- Total Loan Applications
SELECT COUNT(id) as Total_Loan_Applications FROM bank_loan_data

-- Month-to-Date (MTD) Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Previous Month-to-Date (PMTD) Loan Applications 
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11
/*
*/
-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

-- MTD Total Funded Amount 
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11
/*
*/
-- Total Amount Received 
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11
/*
*/
-- Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data

-- MTD Average Interest
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- PMTD Average Interest 
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11
/*
*/
-- Average Debt to Income Ratio (DTI)
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data

-- MTD Average DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Average DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11
/*
*/
/* GOOD LOANS ISSUED */
-- Good Loan Percentage
SELECT 
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) *100.0) /
		COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Amount Received 
SELECT SUM(total_payment) AS Good_Loam_Amount_Received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
/*
*/
/* BAD LOANS ISSUED */
-- Bad Loan Percentage
SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) /
		COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received FROM bank_loan_data
WHERE loan_status = 'Charged Off'
/*
*/
/* LOAN STATUS */
SELECT
	loan_status,
	COUNT(id) AS LoanCount,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) as DTI
FROM bank_loan_data
GROUP BY loan_status

-- MTD
SELECT
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

/* BANK LOAN REPORT | OVERVIEW */

-- MONTH
SELECT
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

-- STATE
SELECT
	address_state AS State,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

-- TERM
SELECT
	term as TERM,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

-- EMPLOYEE LENGTH
SELECT
	emp_length as Employee_Length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

-- PURPOSE
SELECT
	purpose as Purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

-- HOME OWNERSHIP
SELECT
	home_ownership AS Home_Ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership
