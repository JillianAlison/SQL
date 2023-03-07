USE h_Accounting;

DROP PROCEDURE IF EXISTS h_accounting.bs_and_pl_team3;

DELIMITER $$

CREATE PROCEDURE h_accounting.bs_and_pl_team3 (varCalendarYear SMALLINT)
	BEGIN

-- Declaring and defining the variables for the stored procedures of balancesheet
/*
"CURRENT ASSETS"	CA
"FIXED ASSETS"	FA
"DEFERRED ASSETS"	DA
"CURRENT LIABILITIES"	CL
"LONG-TERM LIABILITIES"	LLL
"DEFERRED LIABILITIES"	DL
EQUITY	EQ
	Past Year will be variable_PY
*/

DECLARE varCurrent_Assets INT;
DECLARE varCurrent_Assets_PY INT;
DECLARE varFixed_Assets INT;
DECLARE varFixed_Assets_PY INT;
DECLARE varDeferred_Assets INT;
DECLARE varDeferred_Assets_PY INT;
DECLARE varTotal_Assets INT;
DECLARE varTotal_Assets_PY INT;
DECLARE varCurrent_Liabilities INT;
DECLARE varCurrent_Liabilities_PY INT;
DECLARE varLong_Term_Liabilities INT;
DECLARE varLong_Term_Liabilities_PY INT;
DECLARE varDeferred_Liabilities INT;
DECLARE varDeferred_Liabilities_PY INT;
DECLARE varTotal_Liabilities INT;
DECLARE varTotal_Liabilities_PY INT;
DECLARE varEquity INT;
DECLARE varEquity_PY INT;
DECLARE varTotal_Equity_Liabilities INT;
DECLARE varTotal_Equity_Liabilities_PY INT;
-- Defining the variables for the stored procedures for PL

/*
REV = "REVENUE"	
RET = "RETURNS, REFUNDS, DISCOUNTS"
COGS = "COST OF GOODS AND SERVICES"
GEXP = "ADMINISTRATIVE EXPENSES"
SEXP = "SELLING EXPENSES"
OEXP = "OTHER EXPENSES"
OI = "OTHER INCOME"
INCTAX = "INCOME TAX"
OTHTAX = "OTHER TAX"
NET PROFIT/LOSS 

PY = Past Year
*/

-- Declaring the variables for the stored procedures

DECLARE varRevenue INT;
DECLARE varReturns_Refunds_Discounts INT;
DECLARE varCost_Of_Goods_And_Services INT;
DECLARE varAdminstrative_Expenses INT;
DECLARE varSelling_Expenses INT;
DECLARE varOther_Expenses INT;
DECLARE varOther_Income INT;
DECLARE varIncome_Tax INT;
DECLARE varOther_Tax INT;
DECLARE varNet_Profit_Loss INT;
DECLARE varRevenue_PY INT;
DECLARE varReturns_Refunds_Discounts_PY INT;
DECLARE varCost_Of_Goods_And_Services_PY INT;
DECLARE varAdminstrative_Expenses_PY INT;
DECLARE varSelling_Expenses_PY INT;
DECLARE varOther_Expenses_PY INT;
DECLARE varOther_Income_PY INT;
DECLARE varIncome_Tax_PY INT;
DECLARE varOther_Tax_PY INT;
DECLARE varNet_Profit_Loss_PY INT;

-- ASSETS 
-- Current Assets calculation (CA)
SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varCurrent_Assets 
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code = 'CA'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Current Assets Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varCurrent_Assets_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code = 'CA'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;
    
    -- Fixed assets calculation (FA)

SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varFixed_Assets 
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code = 'FA'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Fixed Assets Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varFixed_Assets_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code = 'FA'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

    -- Deferred Assets Calculation (DA)

SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varDeferred_Assets 
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code = 'DA'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Deferred Assets Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varDeferred_Assets_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code = 'DA'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;
    
-- Current Liabilities Calculation (CL)

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varCurrent_Liabilities
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code = 'CL'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Current Liabilities Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varCurrent_Liabilities_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code = 'CL'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;
    
-- Long Term Liabilities Calculation (LLL)

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varLong_Term_Liabilities
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code = 'LLL'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Long Term Liabilities Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varLong_Term_Liabilities_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code = 'LLL'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Deferred Liabilities Calculation (DL)

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varDeferred_Liabilities
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code = 'DL'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Deferred Liabilities Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varDeferred_Liabilities_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code = 'LLL'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;
    

-- Equity Calculation (EQ)

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varEquity
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code = 'EQ'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Equity Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varEquity_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code = 'EQ'
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- TOTALS
-- Total Assets

SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varTotal_Assets
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code IN ('CA','FA','DA')
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.debit,0))) - ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varTotal_Assets_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code IN ('CA','FA','DA')
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;
    
-- Total Liabilities

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varTotal_Liabilities
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code IN ('CL','LLL','DL')
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varTotal_Liabilities_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code IN ('CL','LLL','DL')
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;
    
    -- Total Equity&Liabilities

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varTotal_Equity_Liabilities
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear
    AND ss.statement_section_code IN ('CL','LLL','DL','EQ')
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Calculation for PY

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varTotal_Equity_Liabilities_PY
FROM statement_section AS ss
INNER JOIN `account` AS ac 
	ON ac.balance_sheet_section_id = ss.statement_section_id
INNER JOIN journal_entry_line_item AS jeli 
	ON jeli.account_id = ac.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
WHERE YEAR(je.entry_date) = VarCalendarYear -1
    AND ss.statement_section_code IN ('CL','LLL','DL','EQ')
    AND ss.company_id = 1
    AND je.debit_credit_balanced = 1
    AND ac.balance_sheet_section_id <> 0;

-- Revenue

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varRevenue 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'REV';
    
-- Revenue for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varRevenue_PY
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = VarCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'REV';  
    
-- Returns Refunds and Discounts

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varReturns_Refunds_Discounts 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'RET';
    
-- Returns Refunds and Discounts for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varReturns_Refunds_Discounts_PY
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'RET';  
    
-- Cost Of Goods And Services

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varCost_Of_Goods_And_Services 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'COGS';
    
-- Cost Of Goods And Services for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varCost_Of_Goods_And_Services_PY 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'COGS';
      
    
-- Adminstrative Expenses

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varAdminstrative_Expenses
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'GEXP';
    
    
-- Adminstrative Expenses for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varAdminstrative_Expenses_PY 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'GEXP';
    
-- Selling Expenses

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varSelling_Expenses 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'SEXP';
    
-- Selling Expenses for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varSelling_Expenses_PY
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'SEXP';
    
-- Other Expenses

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varOther_Expenses 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'OEXP';
    
-- Other Expenses for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varOther_Expenses_PY 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'OEXP';
    
-- Other Income

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varOther_Income 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'OI';
    
-- Other Income for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varOther_Income_PY 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'OI';
    
-- Income Tax

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varIncome_Tax 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'INCTAX';
    
-- Income Tax for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varIncome_Tax_PY 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'INCTAX';
    
    -- Other Tax

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varOther_Tax 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear 
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'OTHTAX';
    
-- Other Tax for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0)))
INTO varOther_Tax_PY 
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'OTHTAX';

-- Net Profit/Loss

SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varNet_Profit_Loss
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'NET';
    
-- Other Tax for the past year
    
 SELECT 
	ROUND(SUM(IFNULL(jeli.credit,0))) - ROUND(SUM(IFNULL(jeli.debit,0)))
INTO varNet_Profit_loss_PY
FROM journal_entry_line_item AS jeli 
INNER JOIN `account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN journal_entry AS je
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN statement_section AS ss
	ON ss.statement_section_id = ac.Profit_Loss_section_id
WHERE YEAR(je.entry_date) = varCalendarYear - 1
    AND ac.Profit_Loss_section_id != 0
    AND ss.statement_section_code = 'NET';

-- TABLE CREATION

DROP TABLE IF EXISTS h_accounting.xhamon_tmp;
CREATE TABLE h_accounting.xhamon_tmp
(account_name VARCHAR(50), current_year VARCHAR(50), past_year VARCHAR(50), percentage_change VARCHAR(50)); -- TABLE HEADERS
INSERT INTO xhamon_tmp
(Account_Name, Current_Year, Past_Year, Percentage_Change)
VALUES 
(' BALANCE SHEET FOR:', varCalendarYear, varCalendarYear - 1, '%'),
	('Current Assets', varCurrent_Assets, varCurrent_Assets_PY, ROUND(((varCurrent_Assets - varCurrent_Assets_PY)/varCurrent_Assets_PY)*100,2)),
    ('Fixed Assets', varFixed_Assets, varFixed_Assets_PY, ROUND(((varFixed_Assets - varFixed_Assets_PY)/varFixed_Assets_PY)*100,2)),
    ('Deferred Assets', varDeferred_Assets, varDeferred_Assets_PY, ROUND(((varDeferred_Assets - varDeferred_Assets_PY)/varDeferred_Assets_PY)*100,2)),
    ('Total Assets', varTotal_Assets, varTotal_Assets_PY, ROUND(((varTotal_Assets - varTotal_Assets_PY)/varTotal_Assets_PY)*100,2)),
(' ', ' ',' ',' '),
    ('Current Liabilities', varCurrent_Liabilities, varCurrent_Liabilities_PY, ROUND(((varCurrent_Liabilities - varCurrent_Liabilities_PY)/varCurrent_Liabilities_PY)*100,2)),
    ('Long-Term Liabilities', varLong_Term_Liabilities, varLong_Term_Liabilities_PY, ROUND(((varLong_Term_Liabilities - varLong_Term_Liabilities_PY)/varLong_Term_Liabilities_PY)*100,2)),
    ('Deferred Liabilities', varDeferred_Liabilities, varDeferred_Liabilities_PY, ROUND(((varDeferred_Liabilities - varDeferred_Liabilities_PY)/varDeferred_Liabilities_PY)*100,2)),
    ('Total Liabilities', varTotal_Liabilities, varTotal_Liabilities_PY, ROUND(((varTotal_Liabilities - varTotal_Liabilities_PY)/varTotal_Liabilities_PY)*100,2)),
(' ', ' ',' ',' '),
    ('Equity', varEquity, varEquity_PY, ROUND(((varEquity - varEquity_PY)/varEquity_PY)*100,2)),
    ('Total Liabilities & Equity', varTotal_Equity_Liabilities, varTotal_Equity_Liabilities_PY, ROUND(((varTotal_Equity_Liabilities - varTotal_Equity_Liabilities_PY)/varTotal_Equity_Liabilities_PY)*100,2)),
(' ', ' ',' ',' '),
(' INCOME STATEMENT FOR:', varCalendarYear, varCalendarYear - 1, '%'),
	('Revenue', varRevenue, varRevenue_PY, ROUND(((varRevenue - varRevenue_PY)/varRevenue_PY)*100,2)),
(' ', ' ',' ',' '),
    ('Returns Refunds Discounts', varReturns_Refunds_Discounts, varReturns_Refunds_Discounts_PY, ROUND(((varReturns_Refunds_Discounts - varReturns_Refunds_Discounts_PY)/varReturns_Refunds_Discounts_PY)*100,2)),
    ('Selling Expenses', varSelling_Expenses, varSelling_Expenses_PY, ROUND(((varSelling_Expenses - varSelling_Expenses_PY)/varSelling_Expenses_PY)*100,2)),
    ('Other Expenses', varOther_Expenses, varOther_Expenses_PY, ROUND(((varOther_Expenses - varOther_Expenses_PY)/varOther_Expenses_PY)*100,2)),
    ('Other Income', varOther_Income, varOther_Income_PY, ROUND(((varOther_Income - varOther_Income_PY)/varOther_Income_PY)*100,2)),
    ('Income Tax', varIncome_Tax, varIncome_Tax_PY, ROUND(((varIncome_Tax - varIncome_Tax_PY)/varIncome_Tax_PY)*100,2)),
    ('Total Other Tax', varOther_Tax, varOther_Tax_PY, ROUND(((varOther_Tax - varOther_Tax_PY)/varOther_Tax_PY)*100,2)),
(' ', ' ',' ',' '),
    ('Net Profit/Loss', (varRevenue - IFNULL(varReturns_Refunds_Discounts,0) - IFNULL(varSelling_Expenses,0) -
						IFNULL(varOther_Expenses,0) + IFNULL(varOther_Income,0) - IFNULL(varIncome_Tax,0) - IFNULL(varOther_Tax,0)),
						(varRevenue_PY - IFNULL(varReturns_Refunds_Discounts_PY,0) - IFNULL(varSelling_Expenses_PY,0) - IFNULL(varOther_Expenses_PY,0) + IFNULL(varOther_Income_PY,0) - IFNULL(varIncome_Tax_PY,0) - IFNULL(varOther_Tax_PY,0)), 
                        ROUND(((varRevenue - IFNULL(varReturns_Refunds_Discounts,0) - IFNULL(varSelling_Expenses,0) - 
                        (IFNULL(varOther_Expenses,0) + IFNULL(varOther_Income,0) - IFNULL(varIncome_Tax,0) - IFNULL(varOther_Tax,0)) - (varRevenue_PY - IFNULL(varReturns_Refunds_Discounts_PY,0) - IFNULL(varSelling_Expenses_PY,0) - IFNULL(varOther_Expenses_PY,0) + IFNULL(varOther_Income_PY,0) - IFNULL(varIncome_Tax_PY,0) - IFNULL(varOther_Tax_PY,0)))/
                        (varRevenue_PY - (IFNULL(varReturns_Refunds_Discounts_PY,0) + IFNULL(varSelling_Expenses_PY,0) + IFNULL(varOther_Expenses_PY,0) + IFNULL(varOther_Income_PY,0) + IFNULL(varIncome_Tax_PY,0) + IFNULL(varOther_Tax_PY,0))))*100,2)
 )
;

-- Showing tables BS & PL
SELECT * FROM h_accounting.xhamon_tmp;

END $$
DELIMITER ;

-- Calling the procedure, insert the current year
CALL h_accounting.bs_and_pl_team3(2016);
