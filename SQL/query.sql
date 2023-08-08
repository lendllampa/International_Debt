-- How many countries are indebted to the bank?
SELECT count(DISTINCT country_name) as total_distinct_countries
FROM debt_only_indicators_data;


-- List of the countries.
SELECT DISTINCT country_name
FROM debt_only_indicators_data;


-- List of the different debt indicators?
SELECT DISTINCT code, indicator_name, aggregation_method, short_definition
FROM debt_only_indicators_data
ORDER BY code;


-- What is the total amount of debt that countries owe to the World Bank?
SELECT SUM(amount) as Total_Debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum';


-- What is the total amount of money each country owes to the World Bank?
SELECT country_name, SUM(amount) as Total_Debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum'
GROUP BY country_name;


-- Top 10 countries with the highest debt.
SELECT country_name, SUM(amount) as total_debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum'
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 10;

-- Top 10 countries with the lowest debt
SELECT country_name, SUM(amount) as total_debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum'
GROUP BY country_name
ORDER BY total_debt ASC
LIMIT 10;


-- What is the average debt across different indicators?
SELECT code, indicator_name, AVG(amount) as average_debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum' and amount IS NOT NULL
GROUP BY code, indicator_name
ORDER BY code DESC;


-- What indicator holds the most debt?
SELECT code, indicator_name, SUM(amount) as total_debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum' and amount IS NOT NULL
GROUP BY code, indicator_name
ORDER BY (total_debt) DESC;


-- Most common debt indicators used?
SELECT code, indicator_name, COUNT(code) as indicator_count
FROM debt_only_indicators_data
WHERE amount IS NOT NULL AND amount != 0
GROUP BY code, indicator_name
ORDER BY (indicator_count) DESC
LIMIT 10;


--What is the maximum debt loaned out by the bank?
SELECT country_name,indicator_name, MAX(amount) as highest_amount
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum' AND amount IS NOT NULL
GROUP BY country_name,indicator_name
ORDER BY highest_amount DESC NULLS LAST
LIMIT 1;


-- Which country owns the most debt for each debt indicator?
SELECT country_name, code, SUM(amount) as total_debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum' AND amount IS NOT NULL
GROUP BY country_name, code
ORDER BY total_debt DESC;

-- Countries debt across different debt indicators.
SELECT country_name, code, SUM(amount) as total_debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum' AND amount IS NOT NULL
GROUP BY country_name, code
ORDER BY country_name, code;


-- Total debt per debt indicator
SELECT DISTINCT(code), SUM(amount) as total_debt
FROM debt_only_indicators_data
WHERE aggregation_method = 'Sum' AND amount IS NOT NULL
GROUP BY (code)
ORDER BY total_debt DESC;
