-- DROP TABLE IF EXISTS debt_indicators;

CREATE TABLE debt_indicators(
	Code varchar(55) NOT NULL PRIMARY KEY,
	License_Type varchar(55),
	Indicator_Name varchar(1300),
	Short_Definition varchar(1300),
	Long_Definition varchar(1300),
	Source varchar(1300),
	Topic varchar(255),
	Dataset varchar(255),
	Periodicity varchar(255),
	Aggregation_Method varchar(255),
	General_Comment varchar(255)
);

-- DROP TABLE IF EXISTS international_debts;

CREATE TABLE international_debts(
	Country_Name varchar(255),
	Series_Name varchar(255),
	Series_Code varchar(255),
	"Year" varchar(4),
	Amount float,
	FOREIGN KEY (Series_Code) REFERENCES debt_indicators(Code)
);

DROP VIEW IF EXISTS countries_debt;

CREATE VIEW countries_debt AS(
	SELECT *
	FROM international_debts
	WHERE country_name NOT LIKE '%income%' AND country_name NOT LIKE '%IDA%' AND country_name NOT LIKE '%developed%'
);

DROP VIEW IF EXISTS countries_series_data;

CREATE VIEW countries_series_data as (
	SELECT
	di.code,
	di.indicator_name,
	di.aggregation_method,
	di.short_definition,
	cd.country_name,
	cd."Year",
	cd.amount
	FROM debt_indicators as di
	JOIN countries_debt as cd ON di.code = cd.series_code
);

DROP VIEW IF EXISTS debt_only_indicators_data;

CREATE VIEW debt_only_indicators_data as(
	SELECT *
	FROM countries_series_data
	WHERE code LIKE 'DT%'
);
