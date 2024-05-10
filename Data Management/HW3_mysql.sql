-------- PRESTIGE CARS DB ----------
-- Question 1
SELECT MakeName, ModelName, DateBought FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
WHERE s.DateBought = '2015-07-25';

-- Question 2
SELECT MakeName, ModelName, DateBought FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
WHERE s.DateBought BETWEEN '2018-07-15' AND '2018-08-31';

-- Question 3
SELECT MakeName, ModelName, date(saledate) as SaleDate, DateBought, DATEDIFF(date(saledate), datebought) as Days
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
ORDER BY Days desc;

-- Question 4
SELECT DateBought, Avg(cost)
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
WHERE s.DateBought BETWEEN '2015-07-01' AND '2015-12-31'
GROUP BY DateBought
ORDER BY DateBought;

-- Question 5
SELECT MakeName, ModelName, SaleDate, StockID
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE SaleDate LIKE '2015%';

-- Question 6
SELECT MakeName, ModelName, SaleDate, StockID
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE SaleDate LIKE '2015%' OR SaleDate LIKE '2016%'
ORDER BY SaleDate;

-- Question 7
SELECT MakeName, ModelName, SaleDate, StockID
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE SaleDate LIKE '2015-07%';

-- Question 8
SELECT MakeName, ModelName, SaleDate, StockID
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE SaleDate BETWEEN '2015-07-01' AND '2015-09-30';

-- Question 9
SELECT MakeName, ModelName, SaleDate, StockID
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE weekday(SaleDate) = 4 AND SaleDate LIKE '2016%';

-- Question 10
SELECT MakeName, ModelName, SaleDate, StockID
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE weekofyear(SaleDate) = 26 AND SaleDate LIKE '2017%';

-- Question 11
SELECT weekday(saledate), count(StockID) as NumberSold
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE SaleDate LIKE '2015%'
Group By weekday(saledate)
ORDER BY weekday(saledate);

-- Question 12
SELECT weekday(saledate), dayname(saledate), count(StockID) as NumberSold
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE SaleDate LIKE '2015%'
Group By weekday(saledate), dayname(saledate)
ORDER BY weekday(saledate);

-- Question 13
SELECT weekday(saledate), dayname(saledate), sum(TotalSalePrice), avg(TotalSalePrice)
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
Group By weekday(saledate), dayname(saledate)
ORDER BY weekday(saledate);

-- Question 14
SELECT dayofmonth(saledate) as DayofMonth, sum(TotalSalePrice), avg(TotalSalePrice)
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
Group By dayofmonth(saledate)
ORDER BY dayofmonth(saledate);

-- Question 15
SELECT Month(saledate), monthname(saledate), count(StockID) as NumberSold
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE SaleDate LIKE '2018%'
Group By Month(saledate), monthname(saledate)
ORDER BY Month(saledate);

-- Question 16
SELECT MakeName, sum(TotalSalePrice)
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
Where MakeName LIKE 'Jaguar'
AND SaleDate BETWEEN subdate('2015-07-25', 25) AND '2015-07-25'
Group By MakeName;

-- Question 17
SELECT CustomerID, CONCAT_WS(' - ', Address1, Address2, Town, Country, postcode) as Address, IsReseller, IsCreditRisk
FROM prestigecars.customer;

-- Question 18
SELECT CONCAT(MakeName, " ", ModelName) as Make_Model, sum(SalePrice) as TotalSalesPrice
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
GROUP BY MakeName, ModelName
ORDER BY MakeName, ModelName;

-- Question 19
SELECT CONCAT(ModelName, '(', LEFT(MakeName,3),')') as Make_Model
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
ORDER BY MakeName, ModelName;

-- Question 20
SELECT RIGHT(InvoiceNumber,3) FROM prestigecars.sales;

-- Question 21
SELECT MID(InvoiceNumber,4,2) FROM prestigecars.sales;

-- Question 22
SELECT * FROM prestigecars.sales
WHERE InvoiceNumber LIKE 'EUR%';

-- Question 23
SELECT StockCode, MakeName, ModelName, MakeCountry, InvoiceNumber
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE MakeCountry = 'ITA'
AND MID(InvoiceNumber,4,2) = 'FR';

-- Question 24
SELECT StockCode, MakeName, ModelName, MID(InvoiceNumber,4,2) as DestinationCountry
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID;

-- Question 25
SELECT StockCode, ModelID, format(Cost, 2) as Cost, RepairsCost, PartsCost, TransportInCost, IsRHD, Color, BuyerComments, DateBought, TimeBought
FROM prestigecars.stock;

-- Question 26
SELECT StockID, MakeName, ModelName, concat('£',format(SalePrice, 2)) as SalePrice
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID;

-- Question 27
SELECT StockID, MakeName, ModelName, concat('£',format(SalePrice, 2, 'de_DE')) as SalePrice
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID;

-- Question 28
SELECT InvoiceNumber, DATE_FORMAT(SaleDate, '%d %b %Y') as SaleDate FROM prestigecars.sales;

-- Question 29
SELECT InvoiceNumber, DATE(SaleDate) as SaleDate FROM prestigecars.sales;

-- Question 30
SELECT InvoiceNumber, Time(SaleDate) as Time FROM prestigecars.sales;

-- Question 31
SELECT * FROM prestigecars.stock
WHERE PartsCost > RepairsCost;

-- Question 32
SELECT CONCAT(left(buyerComments, 25),"...") as BuyerComments
FROM prestigecars.stock
where BuyerComments IS not null;

-- Question 33
SELECT StockID, SalePrice, cost, SalePrice - Cost as Profit, PartsCost, RepairsCost,
CASE
WHEN SalePrice - Cost < Cost*0.1 AND RepairsCost >= PartsCost*2 THEN 'Warning!'
ELSE 'OK'
END as Flag
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID;


-- Question 34
SELECT StockID, SalePrice, cost, SalePrice - Cost as Profit,
CASE
WHEN SalePrice - Cost > SalePrice*0.1 AND SalePrice - Cost < SalePrice*0.5 THEN 'Acceptable'
ELSE 'OK'
END as Flag
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID;

-- Question 35
SELECT CountryName,
CASE WHEN CountryName = 'United Kingdom' THEN 'Pound Sterling'
WHEN CountryName = 'United States' THEN 'Dollar'
WHEN SalesRegion = 'EMEA' THEN 'Eurozone'
ELSE 'Other'
END as Currency
FROM prestigecars.country;

-- Question 36
SELECT CASE WHEN MakeCountry = 'GBR' THEN 'British'
	WHEN MakeCountry = 'USE' THEN 'United States'
	WHEN MakeCountry = 'ITA' OR MakeCountry = 'FRA' OR MakeCountry = 'GER' THEN 'European'
	ELSE 'other'
END as Region, count(MakeName)
FROM prestigecars.make
GROUP BY CASE WHEN MakeCountry = 'GBR' THEN 'British'
	WHEN MakeCountry = 'USE' THEN 'United States'
	WHEN MakeCountry = 'ITA' OR MakeCountry = 'FRA' OR MakeCountry = 'GER' THEN 'European'
	ELSE 'other' END;

-- Question 37
SELECT
CASE WHEN SalePrice < 5000 THEN 'Under 5000'
	WHEN SalePrice >= 5000 AND SalePrice <=50000 THEN '5000-50000'
    WHEN SalePrice >= 50001 AND SalePrice <=100000 THEN '50001-100000'
    WHEN SalePrice >= 100001 AND SalePrice <= 200000 THEN '100001-200000'
    WHEN SalePrice >200000 THEN 'Over 200000'
    ELSE 'other' END as Category, Count(StockID) as VehicleCount
FROM prestigecars.salesdetails sd JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
GROUP BY CASE WHEN SalePrice < 5000 THEN 'Under 5000'
	WHEN SalePrice >= 5000 AND SalePrice <=50000 THEN '5000-50000'
    WHEN SalePrice >= 50001 AND SalePrice <=100000 THEN '50001-100000'
    WHEN SalePrice >= 100001 AND SalePrice <= 200000 THEN '100001-200000'
    WHEN SalePrice >200000 THEN 'Over 200000'
    ELSE 'other' END
ORDER BY VehicleCount;

-- Question 38
SELECT SalesID, month(SaleDate) as MonthNumber, SaleDate,
CASE WHEN month(SaleDate) = 11 OR month(SaleDate) = 12 OR month(SaleDate) = 1 OR month(SaleDate) = 2 THEN 'Winter'
	WHEN month(SaleDate) = 3 OR month(SaleDate) = 4 THEN 'Spring'
    WHEN month(SaleDate) = 5 OR month(SaleDate) = 6 OR month(SaleDate) = 7 OR month(SaleDate) = 8 THEN 'Summer'
    WHEN month(SaleDate) = 9 OR month(SaleDate) = 10 THEN 'Autumn'
    END as SaleSeason
FROM prestigecars.sales;

-- Question 39
SELECT MakeName, sum(SalePrice) as TotalSales
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
Group by MakeName
Order By TotalSales desc
Limit 5;

-- Question 40
SELECT Color, Count(sa.salesID) as numberSold, sum(SalePrice) as totalPrice,
(SUM(SalePrice) / (SELECT SUM(SalePrice) FROM prestigecars.salesdetails)) * 100 AS percentage_of_total_sales
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
Group BY Color
ORDER BY totalPrice desc;

-- Question 41
SELECT ma.MakeName, m.ModelName, sa.salesID, Year(SaleDate)
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
WHERE (ma.MakeName, m.ModelName, Year(SaleDate)-1)  NOT IN
	(SELECT ma.MakeName, m.ModelName, Year(SaleDate)
	FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
	JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
	JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
	JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
    )
ORDER BY MakeName, ModelName, Year(SaleDate);
        
-- Question 42
select SalesDetailsID, MakeName, ModelName, SalePrice,
SalePrice/(SELECT sum(SalePrice) FROM prestigecars.salesbycountry WHERE SaleDate LIKE '2017%')*100 as Percentage
FROM prestigecars.salesbycountry
Where SaleDate LIKE '2017%'
ORDER BY Percentage desc;

-- Question 43
select MakeName, sum(SalePrice),
sum(SalePrice)/(SELECT sum(SalePrice) FROM prestigecars.salesbycountry WHERE SaleDate LIKE '2017%')*100 as Percentage
FROM prestigecars.salesbycountry
Where SaleDate LIKE '2017%'
Group BY MakeName
ORDER BY Percentage DESC;

-- Question 44
WITH ranking AS(
	SELECT makeName, color,
	RANK() OVER (PARTITION BY makeName ORDER BY sum(SalePrice) DESC) AS color_rank
	FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
	JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
	JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
	JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
	GROUP BY makeName, color
)
SELECT makeName, color FROM ranking WHERE color_rank = 1;

-- Question 45
WITH SalesWithPercentile AS (
    SELECT sa.SalesID, stockID, makename, modelname, SalePrice,
    NTILE(5) OVER (ORDER BY SalePrice DESC) AS price_percentile
	FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
	JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
	JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
	JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
)
SELECT * FROM SalesWithPercentile WHERE price_percentile = 2 LIMIT 3;

-- Question 46
SELECT SaleDate, salePrice,
SUM(salePrice) OVER (PARTITION BY YEAR(SaleDate) ORDER BY SaleDate) AS running_total
FROM prestigecars.stock s JOIN prestigecars.model m ON s.ModelID = m.ModelID
JOIN prestigecars.make ma ON m.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON s.StockCode = sd.StockID
JOIN prestigecars.sales sa ON sd.SalesDetailsID = sa.SalesID
ORDER BY SaleDate;

-- Question 47
WITH RankedSales AS (
    SELECT customerID, SalesID, SaleDate,
        ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY SaleDate) AS row_num_asc,
        ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY SaleDate DESC) AS row_num_desc
    FROM prestigecars.sales
)
SELECT * FROM RankedSales WHERE row_num_asc = 1 OR row_num_desc <= 4;

-- Question 48
SELECT dayname(SaleDate), sum(salePrice) as TotalSalePrice
FROM prestigecars.sales2017
WHERE weekday(SaleDate) BETWEEN 0 AND 4
GROUP BY  dayname(SaleDate)
ORDER BY TotalSalePrice DESC;


-------- COLONIAL DATABASE --------
-- Question 1a
SELECT ReservationID, t.tripID, TripDate FROM colonial.trip t
JOIN colonial.reservation r ON t.TripID = r.TripID
WHERE t.State = 'ME';

-- Question 1b
SELECT ReservationID, tripID, TripDate FROM colonial.reservation
WHERE TripID IN (
	SELECT TripID FROM colonial.trip WHERE State = 'ME');

-- Question 1c
SELECT ReservationID, a.TripID, TripDate
FROM colonial.reservation r
JOIN  (SELECT TripID FROM colonial.trip WHERE State = 'ME') a
ON r.TripID = a.TripID;

-- Question 2
SELECT TripID, TripName FROM colonial.trip
WHERE MaxGrpSize > (
	SELECT max(MaxGrpSize) FROM colonial.trip
	WHERE Type = 'Hiking'
);

-- Question 3
SELECT TripID, TripName FROM colonial.trip
WHERE MaxGrpSize > ANY (
	SELECT MaxGrpSize FROM colonial.trip
	WHERE Type = 'Biking'
);


-------- ENTERTAINMENT AGENCY DB --------
-- Question 1a
SELECT ent.EntertainerID, ent.EntStageName
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
WHERE eng.CustomerID IN (
	SELECT customerID FROM entertainmentagencyexample.customers
    WHERE CustLastName = 'Berg' OR CustLastName = 'Hallmark'
);

-- Question 1b
SELECT ent.EntertainerID, ent.EntStageName
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
JOIN (SELECT * FROM entertainmentagencyexample.customers WHERE CustLastName = 'Berg' OR CustLastName = 'Hallmark') cus ON eng.CustomerID = cus.CustomerID;

-- Question 2
SELECT avg(salary) FROM entertainmentagencyexample.agents;

-- Question 3
SELECT EngagementNumber FROM entertainmentagencyexample.engagements
WHERE ContractPrice >= (SELECT avg(ContractPrice) FROM entertainmentagencyexample.engagements);

-- Question 4
SELECT count(*) FROM entertainmentagencyexample.entertainers
WHERE EntCity = 'Bellevue';

-- Question 5
SELECT * FROM entertainmentagencyexample.engagements
WHERE StartDate LIKE '2017-10%'
ORDER BY StartTime
LIMIT 1;

-- Question 6
SELECT ent.EntertainerID, EntStageName, count(EngagementNumber) FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
GROUP BY EntertainerID, EntStageName;

-- Question 7
SELECT distinct cus.* FROM entertainmentagencyexample.customers cus
JOIN entertainmentagencyexample.engagements eng ON cus.CustomerID = eng.CustomerID
WHERE eng.EntertainerID IN (
	SELECT ent.EntertainerID FROM entertainmentagencyexample.entertainers ent
	JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
	JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
	WHERE ms.StyleName = 'Country' or ms.StyleName = 'Country Rock'
);

-- Question 8
SELECT distinct cus.* FROM entertainmentagencyexample.customers cus
JOIN entertainmentagencyexample.engagements eng ON cus.CustomerID = eng.CustomerID
JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
WHERE ms.StyleName = 'Country' or ms.StyleName = 'Country Rock';

-- Question 9
SELECT distinct ent.EntertainerID, ent.EntStageName
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
WHERE eng.CustomerID IN (
	SELECT customerID FROM entertainmentagencyexample.customers
    WHERE CustLastName = 'Berg' OR CustLastName = 'Hallmark'
);

-- Question 10
SELECT distinct ent.EntertainerID, ent.EntStageName
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
JOIN entertainmentagencyexample.customers cus ON eng.CustomerID = cus.CustomerID
WHERE CustLastName = 'Berg' OR CustLastName = 'Hallmark';

-- Question 11a
SELECT * FROM entertainmentagencyexample.agents
WHERE agentID NOT IN (
	SELECT agentID FROM entertainmentagencyexample.engagements
);

-- Question 11b
SELECT *
FROM entertainmentagencyexample.agents a
WHERE NOT EXISTS (
    SELECT 1
    FROM entertainmentagencyexample.engagements e
    WHERE e.agentID = a.agentID
);

-- Question 12
SELECT ag.* FROM entertainmentagencyexample.agents ag
LEFT JOIN entertainmentagencyexample.engagements eng ON ag.AgentID = eng.AgentID
WHERE eng.EngagementNumber IS NULL;

-- Question 13
SELECT cus.CustFirstName, cus.CustLastName, eng.* FROM entertainmentagencyexample.customers cus
JOIN (
	SELECT CustomerID, max(StartDate) as LastBookingDate FROM entertainmentagencyexample.engagements GROUP BY CustomerID
) eng ON cus.CustomerID = eng.CustomerID;

-- Question 14a
SELECT distinct ent.EntertainerID, ent.EntStageName
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
WHERE eng.CustomerID IN (
	SELECT CustomerID FROM entertainmentagencyexample.customers WHERE CustLastName = 'Berg'
    );

-- Question 14b
SELECT EntertainerID, EntStageName
FROM entertainmentagencyexample.entertainers
WHERE EntertainerID IN (
	SELECT EntertainerID FROM entertainmentagencyexample.engagements eng JOIN entertainmentagencyexample.customers cu
    ON eng.CustomerID = cu.CustomerID
	WHERE CustLastName = 'Berg'
    );
    
-- Question 15
SELECT distinct ent.EntertainerID, ent.EntStageName
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
JOIN entertainmentagencyexample.customers cus ON eng.CustomerID = cus.CustomerID
WHERE CustLastName = 'Berg';

-- Question 16
SELECT EngagementNumber, ContractPrice
FROM entertainmentagencyexample.engagements
WHERE ContractPrice > (
	SELECT sum(ContractPrice) FROM entertainmentagencyexample.engagements
	WHERE Year(StartDate) = 2017 AND Month(StartDate) = 11
    );
    
-- Question 17
SELECT EngagementNumber, ContractPrice FROM entertainmentagencyexample.engagements
WHERE StartDate = (
	SELECT min(StartDate) FROM entertainmentagencyexample.engagements
    );
    
-- Question 18
SELECT sum(ContractPrice) FROM entertainmentagencyexample.engagements
WHERE StartDate LIKE '2017-10%' OR EndDate LIKE'2017-10%';

-- Question 19
SELECT cus.*
FROM entertainmentagencyexample.customers cus
LEFT JOIN entertainmentagencyexample.engagements eng ON cus.CustomerID = eng.CustomerID
WHERE eng.EngagementNumber IS NULL;

-- Question 20a
SELECT * FROM entertainmentagencyexample.customers
WHERE CustomerID NOT IN(
	SELECT customerID FROM entertainmentagencyexample.engagements
    );

-- Question 20b
SELECT * FROM entertainmentagencyexample.customers cus
WHERE NOT EXISTS(
	SELECT 1 FROM entertainmentagencyexample.engagements eng
	WHERE eng.CustomerID = cus.CustomerID
    );

-- Question 21
SELECT EntCity, count(distinct ms.styleID) as MusicalStyleCount
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
GROUP BY EntCity WITH ROLLUP;

-- Question 22
SELECT ag.agentID, ag.AgtFirstName, ag.AgtLastName, sum(ContractPrice)
FROM entertainmentagencyexample.agents ag
JOIN entertainmentagencyexample.engagements eng ON ag.AgentID = eng.AgentID
WHERE StartDate LIKE '2017-12%'
GROUP BY ag.agentID, ag.AgtFirstName, ag.AgtLastName
HAVING sum(ContractPrice) > 3000;

-- Question 23
SELECT agentID, count(EngagementNumber) FROM entertainmentagencyexample.engagements
GROUP BY agentID
HAVING count(EngagementNumber) > 2;

-- Question 24
SELECT ag.AgentID, ag.AgtFirstName, ag.AgtLastName, sum(ContractPrice) as TotalContractPrice, sum(ContractPrice)*ag.CommissionRate as TotalCommission
FROM entertainmentagencyexample.agents ag
JOIN entertainmentagencyexample.engagements eng ON ag.AgentID = eng.AgentID
GROUP BY ag.AgentID, ag.AgtFirstName, ag.AgtLastName, ag.CommissionRate
HAVING sum(ContractPrice)*ag.CommissionRate > 1000;

-- Question 25
SELECT DISTINCT ag.agentID, ag.AgtFirstName, ag.AgtLastName FROM entertainmentagencyexample.agents ag
JOIN entertainmentagencyexample.engagements eng ON ag.AgentID = eng.AgentID
JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
WHERE ms.StyleName NOT IN ('Country', 'Country Rock');

-- Question 26
SELECT * FROM entertainmentagencyexample.entertainers
WHERE EntertainerID NOT IN (
	SELECT DISTINCT eng.EntertainerID FROM entertainmentagencyexample.engagements eng
	JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
	WHERE StartDate BETWEEN DATE_SUB('2018-05-01', INTERVAL 90 DAY) AND '2018-05-01'
);

-- Question 27a
SELECT ent.EntertainerID, ent.EntStageName FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
WHERE StyleID IN (
	SELECT StyleID FROM entertainmentagencyexample.musical_styles
    WHERE StyleName IN ('Jazz', 'Rhythm and Blues', 'Salsa')
    );

-- Question 27b
SELECT ent.EntertainerID, ent.EntStageName FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
WHERE ms.StyleName IN ('Jazz', 'Rhythm and Blues', 'Salsa');

-- Question 28a
SELECT * FROM entertainmentagencyexample.customers cus
WHERE CustomerID IN (
	SELECT eng.CustomerID FROM entertainmentagencyexample.engagements eng
    JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
    WHERE ent.EntStageName IN ('Carol Peacock Trio', 'Caroline Coie Cuartet', 'Jazz Persuasion')
    );

-- Question 28b
SELECT distinct cus.* FROM entertainmentagencyexample.customers cus
JOIN entertainmentagencyexample.engagements eng ON cus.CustomerID = eng.CustomerID
WHERE EntertainerID IN (
	SELECT EntertainerID FROM entertainmentagencyexample.entertainers ent
    WHERE ent.EntStageName IN ('Carol Peacock Trio', 'Caroline Coie Cuartet', 'Jazz Persuasion')
    );
    
-- Question 28c
SELECT cus.* FROM entertainmentagencyexample.customers cus
WHERE cus.CustomerID IN (
    SELECT eng.CustomerID FROM entertainmentagencyexample.engagements eng
    WHERE eng.EntertainerID IN (
        SELECT ent.EntertainerID FROM entertainmentagencyexample.entertainers ent
        WHERE ent.EntStageName IN ('Carol Peacock Trio', 'Caroline Coie Cuartet', 'Jazz Persuasion')
    )
);

-- Question 29
SELECT ms.styleID, ms.StyleName, ent.EntertainerID, ent.EntStageName, cus.CustomerID, cus.CustFirstName, cus.CustLastName
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
JOIN entertainmentagencyexample.musical_preferences mp ON ms.StyleID = mp.StyleID
JOIN entertainmentagencyexample.customers cus ON cus.CustomerID = mp.CustomerID;

-- Question 30
SELECT ent.EntertainerID, ent.EntStageName, count(em.MemberID) as Members
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.entertainer_members em ON ent.EntertainerID = em.EntertainerID
JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
WHERE ms.StyleName = 'Jazz'
GROUP BY ent.EntertainerID, ent.EntStageName
HAVING count(em.MemberID) > 3;

-- Question 31
SELECT cus.CustomerID, CustFirstName, CustLastName, PreferenceSeq,
CASE WHEN StyleName = "50's Music" OR StyleName = "60's Music" OR StyleName = "70's Music" OR StyleName = "80's Music" THEN 'Oldies'
ELSE StyleName
END as StyleName
FROM entertainmentagencyexample.musical_styles ms
JOIN entertainmentagencyexample.musical_preferences mp ON ms.StyleID = mp.StyleID
JOIN entertainmentagencyexample.customers cus ON cus.CustomerID = mp.CustomerID;

-- Question 32
SELECT * FROM entertainmentagencyexample.engagements
WHERE StartDate LIKE '2017-10%'
AND (StartTime BETWEEN '12:00:00' AND '17:00:00')
ORDER BY StartDate, StartTime;

-- Question 33
SELECT ent.EntertainerID, ent.EntStageName, StartDate, EndDate,
CASE
	WHEN StartDate <= '2017-12-25' AND EndDate >= '2017-12-25' THEN 'Booked'
	ELSE 'Not Booked'
END as XmasStatus
FROM entertainmentagencyexample.entertainers ent
JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
WHERE StartDate <= '2017-12-25' AND EndDate >= '2017-12-25';

-- Question 34
SELECT cus.CustomerID, cus.CustFirstName, cus.CustLastName, StyleName
FROM entertainmentagencyexample.musical_styles ms
JOIN entertainmentagencyexample.musical_preferences mp ON ms.StyleID = mp.StyleID
JOIN entertainmentagencyexample.customers cus ON cus.CustomerID = mp.CustomerID
WHERE CASE WHEN styleName = 'Jazz' THEN 1 ELSE 0 END = 1
AND cus.CustomerID NOT IN (
	SELECT cus.CustomerID
    FROM entertainmentagencyexample.musical_styles ms
	JOIN entertainmentagencyexample.musical_preferences mp ON ms.StyleID = mp.StyleID
	JOIN entertainmentagencyexample.customers cus ON cus.CustomerID = mp.CustomerID
    WHERE StyleName = 'Standards'
);

-- Question 35
WITH RankedStyles AS (
    SELECT cus.CustomerID, CONCAT(cus.CustFirstName, ' ', cus.CustLastName) AS CustomerName, ms.StyleName, mp.Preferenceseq
	FROM entertainmentagencyexample.musical_styles ms
	JOIN entertainmentagencyexample.musical_preferences mp ON ms.StyleID = mp.StyleID
	JOIN entertainmentagencyexample.customers cus ON cus.CustomerID = mp.CustomerID
)
SELECT rs.CustomerID, CustomerName, rs.StyleName, COUNT(mp.StyleID) AS NumberofPreference
FROM RankedStyles rs JOIN entertainmentagencyexample.musical_preferences mp ON rs.CustomerID = mp.CustomerID
WHERE rs.Preferenceseq = 1
GROUP BY CustomerID, CustomerName, StyleName;

-- Question 36
WITH RankedStyles AS (
SELECT rs.CustomerID, CustomerName, rs.StyleName, COUNT(mp.StyleID) AS NumberofPreference
FROM (
	SELECT cus.CustomerID, CONCAT(cus.CustFirstName, ' ', cus.CustLastName) AS CustomerName, ms.StyleName, mp.Preferenceseq
	FROM entertainmentagencyexample.musical_styles ms
	JOIN entertainmentagencyexample.musical_preferences mp ON ms.StyleID = mp.StyleID
	JOIN entertainmentagencyexample.customers cus ON cus.CustomerID = mp.CustomerID
    ) rs
JOIN entertainmentagencyexample.musical_preferences mp ON rs.CustomerID = mp.CustomerID
WHERE rs.Preferenceseq = 1
GROUP BY CustomerID, CustomerName, StyleName
)
SELECT *,
sum(NumberofPreference) OVER (ORDER BY CustomerID) as RunningTotal
FROM RankedStyles;

-- Question 37
SELECT cus.CustCity, cus.CustomerID, CONCAT(cus.CustFirstName, ' ', cus.CustLastName) AS CustomerName,
	count(mp.PreferenceSeq) as NumberPref,
	sum(count(mp.PreferenceSeq)) OVER (PARTITION BY cus.Custcity ORDER BY cus.CustomerID) as RunningTotal
FROM entertainmentagencyexample.customers cus
JOIN entertainmentagencyexample.musical_preferences mp ON cus.CustomerID = mp.CustomerID
GROUP BY cus.CustCity, cus.CustomerID, CONCAT(cus.CustFirstName, ' ', cus.CustLastName);

-- Question 38
SELECT ROW_NUMBER() OVER (ORDER BY CustFirstName) as Number,
	CustomerID, CONCAT(CustFirstName, ' ', CustLastName) AS CustomerName, CustState
FROM entertainmentagencyexample.customers
ORDER BY CustomerName;

-- Question 39
SELECT ROW_NUMBER() OVER (PARTITION BY CustCity ORDER BY CustFirstName) as Number,
	CustomerID, CONCAT(CustFirstName, ' ', CustLastName) AS CustomerName, CustCity, CustState
FROM entertainmentagencyexample.customers
ORDER BY CustCity, CustomerName;

-- Question 40
SELECT StartDate, CONCAT(cus.CustFirstName, ' ', cus.CustLastName) AS CustomerName, ent.EntStageName,
	ROW_NUMBER() OVER (ORDER BY ent.EntertainerID) as NumEnt,
	ROW_NUMBER() OVER (PARTITION BY StartDate ORDER BY eng.EngagementNumber) as NumEng
FROM entertainmentagencyexample.engagements eng
JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
JOIN entertainmentagencyexample.customers cus ON eng.CustomerID = cus.CustomerID
ORDER BY StartDate;

-- Question 41
WITH RankedEntertainers AS (
    SELECT ent.EntertainerID, count(EngagementNumber) as EngagementsBooked,
		RANK() OVER (ORDER BY count(EngagementNumber) DESC) AS EntertainerRank
    FROM entertainmentagencyexample.engagements eng
    RIGHT JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
    GROUP BY ent.EntertainerID
)
SELECT EntertainerID, EngagementsBooked,
    CASE
        WHEN EntertainerRank <= CEIL((SELECT COUNT(*) FROM RankedEntertainers) / 3.0) THEN 'Group 1'
        WHEN EntertainerRank <= CEIL((SELECT COUNT(*) FROM RankedEntertainers) * 2.0 / 3.0) THEN 'Group 2'
        ELSE 'Group 3'
    END AS EntertainerGroup
FROM RankedEntertainers;

-- Question 42
SELECT ag.AgentID, sum(ContractPrice),
	RANK() OVER (ORDER BY sum(ContractPrice) DESC) AS AgentRank
FROM entertainmentagencyexample.agents ag LEFT JOIN entertainmentagencyexample.engagements eng ON ag.AgentID = eng.AgentID
GROUP BY ag.AgentID;

-- Question 43
WITH total AS(
	SELECT ent.EntertainerID, count(eng.EngagementNumber) as TotalNumber
    FROM entertainmentagencyexample.engagements eng JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
	JOIN entertainmentagencyexample.customers cus ON eng.CustomerID = cus.CustomerID
    GROUP BY EntertainerID
)
SELECT eng.EngagementNumber, ent.EntStageName, CONCAT(cus.CustFirstName, ' ', cus.CustLastName) AS CustomerName, StartDate, TotalNumber
FROM total t
JOIN entertainmentagencyexample.engagements eng ON t.EntertainerID = eng.EntertainerID
JOIN entertainmentagencyexample.entertainers ent ON eng.EntertainerID = ent.EntertainerID
JOIN entertainmentagencyexample.customers cus ON eng.CustomerID = cus.CustomerID;

-- Question 44
SELECT EntStageName, m.MbrFirstName, m.MbrLastName,
	ROW_NUMBER() OVER (PARTITION BY EntStageName ORDER BY m.MbrFirstName) as Number
FROM entertainmentagencyexample.entertainer_members em
JOIN entertainmentagencyexample.entertainers ent ON em.EntertainerID = ent.EntertainerID
JOIN entertainmentagencyexample.members m ON em.MemberID = m.MemberID
ORDER BY EntStageName, m.MbrFirstName;


-------- Accounts Payable DB --------
-- Question 1
SELECT count(invoice_id) as Count, sum(invoice_total) as TotalDue
FROM accountspayable.invoices
WHERE payment_date IS NULL;

-- Question 2
SELECT inv.* FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
WHERE vn.vendor_state = 'CA';

-- Question 3
SELECT * FROM accountspayable.invoices
WHERE vendor_id IN (
	SELECT vendor_id FROM accountspayable.vendors WHERE vendor_state = 'CA'
    );

-- Question 4
SELECT vn.* FROM accountspayable.invoices inv RIGHT JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
WHERE invoice_id IS NULL;

-- Question 5a
SELECT * FROM accountspayable.vendors
WHERE vendor_id NOT IN (
	SELECT vendor_id FROM accountspayable.invoices);

-- Question 5b
SELECT *
FROM accountspayable.vendors AS v
WHERE NOT EXISTS (
    SELECT 1
    FROM accountspayable.invoices AS i
    WHERE i.vendor_id = v.vendor_id
);

-- Question 6
SELECT * FROM accountspayable.invoices
WHERE invoice_total - payment_total - credit_total < (
	SELECT avg(invoice_total - payment_total - credit_total) as Average FROM accountspayable.invoices
);

-- Question 7a
SELECT vn.vendor_name, inv.invoice_number, inv.invoice_total
FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
WHERE inv.invoice_total > (
	SELECT max(inv.invoice_total)
	FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
	WHERE vn.vendor_id = 34
);

-- Question 7b
SELECT vn.vendor_name, inv.invoice_number, inv.invoice_total
FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
WHERE inv.invoice_total > ALL (
	SELECT max(inv.invoice_total)
	FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
    WHERE vn.vendor_id = 34
);

-- Question 8a
SELECT vn.vendor_name, inv.invoice_number, inv.invoice_total
FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
WHERE inv.invoice_total < (
	SELECT max(inv.invoice_total)
	FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
	WHERE vn.vendor_id = 115
);

-- Question 8b
SELECT vn.vendor_name, inv.invoice_number, inv.invoice_total
FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
WHERE inv.invoice_total < ALL (
	SELECT max(inv.invoice_total)
	FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
    WHERE vn.vendor_id = 115
);

-- Question 9
SELECT vn.vendor_id, vn.vendor_name, (
	SELECT MAX(inv.invoice_date)
	FROM accountspayable.invoices inv
	WHERE inv.vendor_id = vn.vendor_id
) AS LatestInvoiceDate
FROM accountspayable.vendors vn
WHERE (
	SELECT MAX(inv.invoice_date)
	FROM accountspayable.invoices inv
	WHERE inv.vendor_id = vn.vendor_id
) IS NOT NULL;

-- Question 10
SELECT vn.vendor_id, vn.vendor_name, max(invoice_date) LatestInvoiceDate
FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
GROUP BY vn.vendor_id, vn.vendor_name;

-- Question 11
SELECT inv.* FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
JOIN (
	SELECT vn.vendor_id, avg(invoice_total) as avgTotal
    FROM accountspayable.invoices inv
    JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
    GROUP BY vn.vendor_id
) avg ON inv.vendor_id = avg.vendor_id
WHERE inv.invoice_total > avg.avgTotal;

-- Question 12
WITH RankedVendors AS (
    SELECT vn.vendor_id, vn.vendor_state, inv.invoice_total,
        ROW_NUMBER() OVER (PARTITION BY vendor_state ORDER BY invoice_total DESC) AS RowNum
    FROM accountspayable.invoices inv JOIN accountspayable.vendors vn ON inv.vendor_id = vn.vendor_id
)
SELECT vendor_id, vendor_state, invoice_total
FROM RankedVendors
WHERE RowNum = 1;

-- Question 13
SELECT account_description, count(line_item_amount)
FROM accountspayable.general_ledger_accounts gla JOIN accountspayable.invoice_line_items ili ON gla.account_number = ili.account_number
GROUP BY account_description
HAVING count(line_item_amount) > 1;

-- Question 14
SELECT account_description, sum(line_item_amount) as TotalAmount
FROM accountspayable.general_ledger_accounts gla JOIN accountspayable.invoice_line_items ili ON gla.account_number = ili.account_number
GROUP BY account_description WITH ROLLUP;

-- Question 15
SELECT vn.vendor_id, count(ili.account_number) NumberAccounts
FROM accountspayable.general_ledger_accounts gla JOIN accountspayable.vendors vn ON gla.account_number = vn.default_account_number
JOIN invoice_line_items ili ON gla.account_number = ili.account_number
JOIN invoices inv ON inv.vendor_id = vn.vendor_id AND ili.invoice_id = inv.invoice_id
GROUP BY vn.vendor_id
HAVING count(ili.account_number) > 1;

-- Question 16
SELECT t.terms_id, vn.vendor_id, min(payment_date) LastPaymentDate, sum(invoice_total - payment_total - credit_total) as TotalAmount
FROM accountspayable.vendors vn JOIN accountspayable.invoices inv ON vn.vendor_id = inv.vendor_id
JOIN terms t ON inv.terms_id = t.terms_id
GROUP BY t.terms_id, vn.vendor_id WITH ROLLUP;

-- Question 17
SELECT CONCAT('$', invoice_total) as InvoiceTotal FROM accountspayable.invoices;

-- Question 18
SELECT invoice_id, vendor_id, invoice_number, CAST(invoice_date AS CHAR) as InvoiceDate, CAST(invoice_total AS UNSIGNED) as InvoiceTotal  FROM accountspayable.invoices;

-- Question 19
SELECT LPAD(invoice_id, 3, '0') as invoice_id, vendor_id, invoice_number, invoice_date, invoice_total FROM accountspayable.invoices;

-- Question 20
SELECT round(invoice_total, 1) as invoice_total_1, round(invoice_total) as invoice_total_no FROM accountspayable.invoices;

-- Question 21
SELECT start_date, 
    DATE_FORMAT(start_date, '%b/%d/%y') AS Format_1, 
    DATE_FORMAT(start_date, '%c/%e/%y') AS Format_2,
    DATE_FORMAT(start_date, '%l:%i %p') AS twelve_hour,
    DATE_FORMAT(start_date, '%c/%e/%y %l:%i %p') AS Format_3 
FROM date_sample;

-- Question 22
SELECT vendor_name, UPPER(vendor_name), vendor_phone, RIGHT(vendor_phone, 4) as LastFour,
CONCAT(
        SUBSTRING(vendor_phone, 2, 3), '.',
        SUBSTRING(vendor_phone, 7, 3), '.',
        SUBSTRING(vendor_phone, 11, 4)
    ) AS formatted_phone,
CASE
	WHEN LENGTH(vendor_name) - LENGTH(REPLACE(vendor_name, ' ', '')) >= 1
	THEN SUBSTRING_INDEX(SUBSTRING_INDEX(vendor_name, ' ', 2), ' ', -1)
	ELSE ''
END AS second_word
FROM accountspayable.vendors;

-- Question 23
SELECT invoice_number, invoice_date, DATE_ADD(invoice_date, INTERVAL 30 DAY) as plus30, payment_date, datediff(payment_date, invoice_date) as days_to_pay,
MONTH(invoice_date)as month, YEAR(invoice_date) as year
FROM accountspayable.invoices
WHERE invoice_date LIKE '%-05-%';

-- Question 24
SELECT emp_name,
  REGEXP_SUBSTR(emp_name, '^[^ ]+') as first_name,
  TRIM(REGEXP_REPLACE(emp_name, '^[^ ]+', '')) as last_name
FROM accountspayable.string_sample;

-- Question 25
SELECT vendor_id, (invoice_total-payment_total-credit_total) as BalanceDue,
	sum(invoice_total-payment_total-credit_total) over() as all_BalanceDue,
    sum(invoice_total-payment_total-credit_total) over(partition by vendor_id) as vn_BalanceDue
FROM accountspayable.invoices;

-- Question 26
SELECT vendor_id, (invoice_total-payment_total-credit_total) as BalanceDue,
	sum(invoice_total-payment_total-credit_total) over() as all_BalanceDue,
    sum(invoice_total-payment_total-credit_total) over(partition by vendor_id) as vn_BalanceDue,
    avg(invoice_total-payment_total-credit_total) over(partition by vendor_id) as avg_vn_balancedue
FROM accountspayable.invoices;

-- Question 27
SELECT month(invoice_date), sum(invoice_total),
avg(sum(invoice_total)) over(order by month(invoice_date) rows between 3 preceding and current row) as moving_avg
FROM accountspayable.invoices
GROUP BY month(invoice_date)










