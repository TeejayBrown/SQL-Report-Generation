/********************************************************************
 * Purpose: Assignment 1 -SQLPlus script to generate a report of a simple menu system.
 * Author:  Taiwo Omoleye
 * Date:    Sept 16, 2021
 ********************************************************************/

CONN T216/2021@DBMSDBII

SET ECHO OFF -- To prevent commands being printed on the screen
SET VERIFY OFF --To suppress the output messages when a subs variable is used
SET FEEDBACK OFF --Removes the number of records from the bottom of a page
SET PAGESIZE 30 --The number of lines on a page
SET LINESIZE 120 --The length of a line, columns + commas

-- ACCEPT ensures that Subst variable is valid for the current session
-- If executed second time it re-prompts for a value.
ACCEPT CustID NUMBER FORMAT 999 PROMPT 'Customer ID: ' 

-- Formatting the Report
TTITLE CENTER 'Movie Rental Details for Client' '          '&CustID -
  RIGHT 'Page: 'FORMAT 9 SQL.PNO SKIP 2
--Appearance of the column headings
COLUMN agreement HEADING 'Agreement' 
COLUMN fname FORMAT A15 HEADING 'First Name' -- fORMAT IS USED TO SPECIFY THE WIDTH OF A COLUMN
COLUMN lname FORMAT A15 HEADING 'Last Name' --To display Last Name om 2 lines, use 'Last|Name'
COLUMN name FORMAT A55 HEADING 'Movie Name'
--COLUMN pci FORMAT A14 NULL 'No Other Cust', displays NULL as No other Cust
--SELECT fname, TO_CHAR(PrimaryCustId) pci used in the select to convert pci NUMBER to STRING display
COLUMN adate FORMAT A12 HEADING 'Date'
COLUMN paid HEADING 'Paid' FORMAT $999.00 --without .00 will round up $ value

--BREAK is used to suppress duplicate data when the data is grouped
-- E.g BREAK ON Fname
BREAK ON REPORT SKIP 0 ON agreement ON fname ON lname 

-- Add summary calculations. COMPUTE function LABEL 'Text' OF column1 ON 
COMPUTE SUM LABEL 'Total' OF paid ON REPORT

BTITLE LEFT 'Run by:'SQL.USER

--Spool to a file named 'C:\DBMSDBII\A1\Reports\Omoleye_T.txt'
SPOOL C:\DBMSDBII\A1\Reports\Omoleye_T.txt
SELECT r.AgreementID agreement, SUBSTR(c.FName, 1, 15) fname, SUBSTR(c.LName, 1, 15) lname, 
	r.AgreementDate adate, SUBSTR(m.Name, 1, 55) name, mr.RentalAmount paid
FROM Customer c
JOIN RentalAgreement r ON c.CustID = r.CustID
JOIN MovieRented mr ON r.AgreementID = mr.AgreementID
JOIN Movie m ON m.MovieID = mr.MovieID
WHERE c.CustID = &CustID
ORDER BY agreement ASC;
SPOOL OFF

--Clears the settings applied to BREAK and COLUMN
CLEAR BREAK
CLEAR COLUMN

EXIT