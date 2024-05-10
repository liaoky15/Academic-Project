-- COLONIAL DB --
-- Question 1
SELECT TripName FROM colonial.trip WHERE Season = 'Late Spring';

-- Question 2
SELECT TripName FROM colonial.trip WHERE State = 'VT' AND MaxGrpSize > 10;

-- Question 3
SELECT TripName FROM colonial.trip WHERE Season = 'Early Fall' or Season = 'Late Fall';

-- Question 4
SELECT count(*) FROM colonial.trip WHERE State = 'VT' or State = 'CT';

-- Question 5
SELECT TripName FROM colonial.trip WHERE State <> 'NH';

-- Question 6
SELECT TripName, StartLocation FROM colonial.trip WHERE Type = 'Biking';

-- Question 7
SELECT TripName FROM colonial.trip WHERE Type = 'Hiking' AND Distance > 6 ORDER BY TripName;

-- Question 8
SELECT TripName FROM colonial.trip WHERE Type = 'Paddling' OR State = 'VT';

-- Question 9
SELECT count(*) FROM colonial.trip WHERE Type = 'Hiking' OR Type = 'Biking';

-- Question 10
SELECT TripName, State FROM colonial.trip WHERE Season = 'Summer' ORDER BY State, TripName;

-- Question 11
SELECT TripName
FROM colonial.trip t Join colonial.tripguides tg On t.TripID = tg.TripID
JOIN colonial.guide g ON tg.GuideNum = g.GuideNum
WHERE LastName = 'Abrams' AND FirstName = 'Miles';
 
 -- Question 12
SELECT TripName
FROM colonial.trip t Join colonial.tripguides tg On t.TripID = tg.TripID
JOIN colonial.guide g ON tg.GuideNum = g.GuideNum
WHERE Type = 'Biking' AND LastName = 'Boyers' AND FirstName = 'Rita';

-- Question 13
SELECT LastName, TripName, StartLocation
FROM colonial.customer c JOIN colonial.reservation r ON c.CustomerNum = r.CustomerNum
JOIN colonial.trip t ON r.TripID = t.TripID
WHERE TripDate = '2018-07-23';

-- Question 14
SELECT count(*) FROM colonial.reservation WHERE TripPrice > 50 AND TripPrice < 100;

-- Question 15
SELECT LastName, TripName, Type
FROM colonial.customer c JOIN colonial.reservation r ON c.CustomerNum = r.CustomerNum
JOIN colonial.trip t ON r.TripID = t.TripID
WHERE TripPrice > 100;
 
-- Question 16
SELECT LastName
FROM colonial.customer c JOIN colonial.reservation r ON c.CustomerNum = r.CustomerNum
JOIN colonial.trip t ON r.TripID = t.TripID
WHERE t.State = 'ME';
 
-- Question 17
SELECT State, count(State) FROM colonial.trip GROUP BY State ORDER BY State;

-- Question 18
SELECT ReservationID, LastName, TripName
FROM colonial.customer c JOIN colonial.reservation r ON c.CustomerNum = r.CustomerNum
JOIN colonial.trip t ON r.TripID = t.TripID
WHERE NumPersons > 4;

-- Question 19
SELECT t.tripName, g.FirstName, g.LastName
FROM colonial.trip t Join colonial.tripguides tg On t.TripID = tg.TripID
JOIN colonial.guide g ON tg.GuideNum = g.GuideNum
WHERE t.State = 'NH'
ORDER BY t.tripName, g.LastName;

-- Question 20
SELECT ReservationID, c.CustomerNum, c.LastName, c.FirstName
FROM colonial.customer c JOIN colonial.reservation r ON c.CustomerNum = r.CustomerNum
WHERE r.TripDate LIKE '2018-07-%';

-- Question 21
SELECT ReservationID, TripName, LastName, FirstName, (TripPrice+OtherFees)*NumPersons as TotalCost
FROM colonial.customer c JOIN colonial.reservation r ON c.CustomerNum = r.CustomerNum
JOIN colonial.trip t ON r.TripID = t.TripID
WHERE NumPersons > 4;

-- Question 22
SELECT FirstName
FROM colonial.customer
WHERE FirstName LIKE 'L%' or FirstName LIKE 'S%'
ORDER BY FirstName;

-- Question 23
SELECT TripName
FROM colonial.reservation r JOIN colonial.trip t ON r.TripID = t.TripID
WHERE TripPrice > 30 AND TripPrice < 50;

-- Question 24
SELECT count(TripName)
FROM colonial.reservation r JOIN colonial.trip t ON r.TripID = t.TripID
WHERE TripPrice > 30 AND TripPrice < 50;

-- Question 25
SELECT t.TripID, t.TripName, ReservationID
FROM  colonial.reservation r RIGHT JOIN colonial.trip t ON r.TripID = t.TripID
WHERE ReservationID IS NULL;

-- Question 26
SELECT distinct a.*
FROM colonial.trip a JOIN colonial.trip b ON a.StartLocation = b.StartLocation
WHERE a.tripID <> b.TripID;

-- Question 27
SELECT c.*
FROM colonial.customer c LEFT JOIN colonial.reservation r ON c.CustomerNum = r.CustomerNum
WHERE c.State = 'NJ'
OR r.ReservationID IS NOT NULL
OR (c.State = 'NJ' AND r.ReservationID IS NOT NULL);

-- Question 28
SELECT g.*
FROM colonial.guide g LEFT JOIN colonial.tripguides tg ON g.GuideNum = tg.GuideNum
WHERE tg.TripID IS NULL;

-- Question 29
SELECT distinct a.*
FROM colonial.guide a JOIN colonial.guide b ON a.State = b.State
WHERE a.GuideNum <> b.GuideNum
ORDER BY a.State;

-- Question 30
SELECT distinct a.*
FROM colonial.guide a JOIN colonial.guide b ON a.City = b.City
WHERE a.GuideNum <> b.GuideNum;


-- ENTERTAINMENT AGENCY DB --
-- Question 1
SELECT AgtLastName, AgtFirstName, AgtPhoneNumber FROM entertainmentagencyexample.agents ORDER BY AgtLastName, AgtFirstName;

-- Question 2
SELECT EngagementNumber, StartDate FROM entertainmentagencyexample.engagements ORDER BY StartDate DESC, EngagementNumber ASC;

-- Question 3
SELECT AgtLastName, AgtFirstName, DateHired FROM entertainmentagencyexample.agents;

-- Question 4
SELECT * FROM entertainmentagencyexample.engagements WHERE StartDate LIKE '2017-10%' OR EndDate LIKE '2017-10%';

-- Question 5
SELECT * FROM entertainmentagencyexample.engagements WHERE StartDate LIKE '2017-10%' AND (StartTime > '11%' AND StartTime <= '17%') ORDER BY StartDate, StartTime;

-- Question 6
SELECT * FROM entertainmentagencyexample.engagements WHERE StartDate = EndDate ORDER BY StartDate;

-- Question 7
SELECT a.AgentID, a.AgtFirstName, a.AgtLastName, e.StartDate, e.EndDate
FROM entertainmentagencyexample.agents a JOIN entertainmentagencyexample.engagements e ON a.AgentID = e.AgentID
ORDER BY e.StartDate;

-- Question 8
SELECT c.CustFirstName, c.CustLastName, en.EntStageName FROM entertainmentagencyexample.customers c JOIN entertainmentagencyexample.engagements e ON c.CustomerID = e.CustomerID
JOIN entertainmentagencyexample.entertainers en ON e.EntertainerID = en.EntertainerID;

-- Question 9
SELECT a.AgtZipCode, a.AgentID, a.AgtFirstName, a.AgtLastName, e.EntertainerID, e.EntStageName FROM entertainmentagencyexample.agents a JOIN entertainmentagencyexample.entertainers e ON a.AgtZipCode = e.EntZipCode;

-- Question 10
SELECT EntStageName, EntPhoneNumber, EntCity FROM entertainmentagencyexample.entertainers WHERE EntCity = 'Bellevue' OR EntCity = 'Redmond' OR EntCity = 'Woodinville' ORDER BY EntStageName;

-- Question 11
SELECT * FROM entertainmentagencyexample.engagements WHERE EndDate - StartDate = 4;

-- Question 12/13
SELECT ent.EntStageName, eng.StartDate, eng.EndDate, eng.ContractPrice FROM entertainmentagencyexample.entertainers ent JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID;

-- Question 14
SELECT EntStageName FROM entertainmentagencyexample.entertainers ent JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
JOIN entertainmentagencyexample.customers cus ON eng.CustomerID = cus.CustomerID
WHERE cus.CustLastName = 'Berg' OR cus.CustLastName = 'Hallmark';

-- Question 15
SELECT ag.AgtFirstName, ag.AgtLastName, eng.StartDate, eng.StartTime FROM entertainmentagencyexample.agents ag JOIN entertainmentagencyexample.engagements eng ON ag.AgentID = eng.AgentID
ORDER BY StartDate, StartTime;

-- Question 16
SELECT CustFirstName, CustLastName, EntStageName FROM entertainmentagencyexample.entertainers ent JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
JOIN entertainmentagencyexample.customers cus ON eng.CustomerID = cus.CustomerID;

-- Question 17 (Same as Question 9)
SELECT a.AgtZipCode, a.AgentID, a.AgtFirstName, a.AgtLastName, e.EntertainerID, e.EntStageName FROM entertainmentagencyexample.agents a JOIN entertainmentagencyexample.entertainers e ON a.AgtZipCode = e.EntZipCode;

-- Question 18
SELECT ent.EntertainerID, ent.EntStageName, eng.EngagementNumber FROM entertainmentagencyexample.entertainers ent LEFT JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID
WHERE eng.EngagementNumber IS NULL;

-- Question 19
SELECT StyleName,
    CASE
        WHEN PreferenceSeq = 1 THEN CustFirstName
        ELSE NULL
    END AS CustFirstName
FROM entertainmentagencyexample.musical_styles ms LEFT JOIN entertainmentagencyexample.musical_preferences mp ON ms.StyleID = mp.StyleID
JOIN entertainmentagencyexample.customers cus ON mp.CustomerID = cus.CustomerID
ORDER BY ms.StyleID;

-- Question 20
SELECT ag.agentID, AgtFirstName, AgtLastName, EngagementNumber FROM entertainmentagencyexample.agents ag LEFT JOIN entertainmentagencyexample.engagements eng ON ag.AgentID = eng.AgentID
WHERE EntertainerID IS NULL;

-- Question 21
SELECT cus.CustomerID, cus.CustFirstName, cus.CustLastName, eng.EngagementNumber FROM entertainmentagencyexample.customers cus LEFT JOIN entertainmentagencyexample.engagements eng ON cus.CustomerID = eng.CustomerID
WHERE EngagementNumber IS NULL;

-- Question 22
SELECT ent.EntertainerID, ent.EntStageName, eng.EngagementNumber FROM entertainmentagencyexample.entertainers ent LEFT JOIN entertainmentagencyexample.engagements eng ON ent.EntertainerID = eng.EntertainerID;

-- Question 23
SELECT CustomerID as ID, CustLastName as Name FROM entertainmentagencyexample.customers
UNION
SELECT EntertainerID, EntStageName FROM entertainmentagencyexample.entertainers;

-- Question 24
SELECT cus.CustomerID as ID, cus.CustLastName as Name FROM entertainmentagencyexample.customers cus JOIN entertainmentagencyexample.musical_preferences mp ON cus.CustomerID = mp.CustomerID
JOIN entertainmentagencyexample.musical_styles ms ON mp.StyleID = ms.StyleID
WHERE StyleName = 'contemporary'
UNION
SELECT ent.EntertainerID, ent.EntStageName FROM entertainmentagencyexample.entertainers ent JOIN entertainmentagencyexample.entertainer_styles es ON ent.EntertainerID = es.EntertainerID
JOIN entertainmentagencyexample.musical_styles ms ON es.StyleID = ms.StyleID
WHERE StyleName = 'contemporary';

-- Question 25
SELECT AgentID as ID, AgtLastName as Name FROM entertainmentagencyexample.agents
UNION
SELECT EntertainerID, EntStageName FROM entertainmentagencyexample.entertainers;


-- ACCOUNTS PAYABLE DATABASE--
-- Question 1
SELECT * FROM accountspayable.invoices;

-- Question 2
SELECT invoice_number, invoice_date, invoice_total FROM accountspayable.invoices ORDER BY invoice_total desc;

-- Question 3
SELECT * FROM accountspayable.invoices WHERE invoice_date LIKE '%-06-%';

-- Question 4
SELECT * FROM accountspayable.vendors ORDER BY vendor_contact_last_name, vendor_contact_first_name ASC;

-- Question 5
SELECT vendor_contact_last_name, vendor_contact_first_name FROM accountspayable.vendors
WHERE vendor_contact_last_name LIKE 'A%' OR vendor_contact_last_name LIKE 'B%' OR vendor_contact_last_name LIKE 'C%' OR vendor_contact_last_name LIKE 'E%'
ORDER BY vendor_contact_last_name, vendor_contact_first_name ASC;
 
-- Question 6
SELECT invoice_due_date, invoice_total * 1.10 as invoice_amount FROM accountspayable.invoices WHERE invoice_total >= 500 OR invoice_total <= 100 ORDER BY invoice_due_date DESC;

-- Question 7
SELECT invoice_number, invoice_total, payment_total, credit_total, invoice_total - payment_total - credit_total as Balanced_Due
FROM accountspayable.invoices WHERE invoice_total - payment_total - credit_total > 50
ORDER BY Balanced_Due desc
LIMIT 5;
 
-- Question 8
SELECT invoice_number, invoice_total, payment_total, credit_total, invoice_total - payment_total - credit_total as Balanced_Due
FROM accountspayable.invoices WHERE invoice_total - payment_total - credit_total > 0;
 
-- Question 9
SELECT Vendor_name, invoice_total - payment_total - credit_total as Balanced_Due
FROM accountspayable.invoices i JOIN accountspayable.vendors v ON i.vendor_id = v.vendor_id 
WHERE invoice_total - payment_total - credit_total > 0;
 
-- Question 10
SELECT v.*, g.account_description FROM accountspayable.vendors v JOIN accountspayable.general_ledger_accounts g ON v.default_account_number = g.account_number;

-- Question 11
SELECT ven.vendor_id, ven.vendor_name, inv.invoice_id, ili.line_item_description FROM accountspayable.vendors ven JOIN accountspayable.invoices inv ON ven.vendor_id = inv.vendor_id
JOIN accountspayable.invoice_line_items ili ON inv.invoice_id = ili.invoice_id
ORDER BY ven.vendor_id;

-- Question 12
SELECT a.* FROM accountspayable.vendors a JOIN accountspayable.vendors b ON a.vendor_contact_last_name = b.vendor_contact_last_name
WHERE a.vendor_id <> b.vendor_id;

-- Question 13
SELECT gl.*, vn.vendor_id FROM accountspayable.general_ledger_accounts gl LEFT JOIN accountspayable.vendors vn ON gl.account_number = vn.default_account_number
WHERE vendor_id IS NULL;

-- Question 14
SELECT vendor_name,
    CASE
        WHEN vendor_state = 'CA' THEN vendor_state
        ELSE "Outside CA"
    END AS vendor_state
FROM accountspayable.vendors
ORDER BY vendor_name;


-- Prestige Cars Database --
-- Question 1
SELECT CountryName, SalesRegion FROM prestigecars.country;

-- Question 2
SELECT StockCode, Cost FROM prestigecars.stock;

-- Question 3
SELECT distinct cn.CountryName FROM prestigecars.country cn JOIN prestigecars.customer cu ON cn.CountryISO2 = cu.Country; 

-- Question 4
SELECT st.stockcode, ma.MakeName, mo.ModelName, st.Cost FROM prestigecars.stock st JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
ORDER BY makename, modelname;

-- Question 5
SELECT st.stockcode, ma.MakeName, mo.ModelName, sd.SalePrice, sd.LineItemDiscount FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
ORDER BY makename, modelname;

-- Question 6
SELECT * FROM prestigecars.make ma LEFT JOIN prestigecars.model mo ON mo.MakeID = ma.makeID
WHERE mo.ModelID IS NULL;

-- Question 7
SELECT a.*, b.StaffName as Manager FROM prestigecars.staff a LEFT JOIN prestigecars.staff b ON a.ManagerID = b.StaffID;

-- Question 8
select * from prestigecars.salescategory;

SELECT makename, modelname, sd.SalePrice, sc.CategoryDescription
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
JOIN prestigecars.salescategory sc ON sd.SalePrice >= sc.LowerThreshold AND sd.SalePrice <= sc.UpperThreshold
ORDER BY makename, modelname;

-- Question 9
SELECT distinct co.CountryName, ma.MakeName FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
JOIN prestigecars.sales sa ON sd.SalesID = sa.SalesID
JOIN prestigecars.customer cu ON sa.CustomerID = cu.CustomerID
JOIN prestigecars.country co ON cu.Country = co.CountryISO2;

-- Question 10
SELECT distinct ma.MakeName, mo.ModelName FROM prestigecars.stock st JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
ORDER BY makename, modelname;

-- Question 11
SELECT mo.ModelName, s.SaleDate FROM prestigecars.salesdetails sd JOIN prestigecars.sales s ON sd.SalesID = s.SalesID
JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID;

-- Question 12
SELECT m.ModelName, st.Color
FROM prestigecars.model m JOIN prestigecars.stock st ON m.ModelID = st.ModelID
WHERE st.Color = 'Red' OR st.Color = 'Green' OR st.Color = 'Blue';

-- Question 13
SELECT distinct makename
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
WHERE makename <> 'Ferrari'
ORDER BY makename;

-- Question 14
SELECT distinct makename FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
WHERE ma.MakeName <> 'Porsche' AND ma.MakeName <> 'Aston Martin' AND ma.MakeName <> 'Bentley'
ORDER BY makename;

-- Question 15
SELECT MakeName, ModelName, Cost FROM prestigecars.stock st JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
where cost > 50000;

-- Question 16
SELECT distinct ma.MakeName FROM prestigecars.stock st JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
WHERE st.PartsCost >= 1000 and st.PartsCost <= 2000;

-- Question 17
SELECT distinct MakeName, ModelName, IsRHD FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
WHERE IsRHD = 1;

-- Question 18
SELECT distinct MakeName, color FROM prestigecars.stock st JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.makeID
WHERE MakeName <> 'Bentley'
AND (Color = 'Red' OR Color = 'Green' OR Color = 'Blue');
 
-- Question 19
SELECT * FROM prestigecars.stock
WHERE Color = 'Red' AND (RepairsCost > 1000 OR PartsCost > 1000);
 
-- Question 20
SELECT st.*, MakeName, ModelName FROM prestigecars.model mo JOIN prestigecars.stock st ON mo.ModelID = st.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.MakeID
WHERE (ma.MakeName = 'Rolls Royce' AND mo.ModelName = 'Phantom' AND(st.Color = 'Red' OR st.Color = 'Green' OR st.Color = 'Blue'))
OR ( st.PartsCost > 5500 AND st.RepairsCost > 5500)
ORDER BY MakeName, ModelName;

-- Question 21
SELECT * FROM prestigecars.stock
WHERE color LIKE BINARY 'Dark purple';
 
-- Question 22
SELECT * FROM prestigecars.customer
WHERE CustomerName LIKE '%Pete%';

-- Question 23
SELECT * FROM prestigecars.make
WHERE MakeName LIKE BINARY '%L%';

-- Question 24
select md.ModelName, s.InvoiceNumber from prestigecars.sales s JOIN prestigecars.salesdetails sd ON s.SalesID = sd.SalesID
JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
WHERE s.InvoiceNumber LIKE "%FR%";

-- Question 25
SELECT * FROM prestigecars.customer WHERE PostCode IS NULL;

-- Question 26
SELECT mk.MakeName, md.ModelName, st.StockCode, st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) AS TotalCost
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID;

-- Question 27
SELECT mk.MakeName, md.ModelName, st.StockCode, sd.SalePrice, st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) AS TotalCost,
(sd.SalePrice - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)))/sd.SalePrice AS NetMargin
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID;

-- Question 28
SELECT mk.MakeName, md.ModelName, st.StockCode, sd.SalePrice, st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) AS TotalCost, (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0))/sd.SalePrice AS Ratio
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID;

-- Question 29
SELECT mk.MakeName, md.ModelName, st.StockCode, sd.SalePrice * 1.05 as ImprovedSalePrice, st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) AS TotalCost,
((sd.SalePrice * 1.05) - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)))/(sd.SalePrice * 1.05) AS ImprovedSalesMargin
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID;

-- Question 30
CREATE TEMPORARY TABLE temp30_
SELECT mk.MakeName, md.ModelName, st.StockCode, (sd.SalePrice - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)))/sd.SalePrice AS NetMargin
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
ORDER BY (sd.SalePrice - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)))/sd.SalePrice desc
LIMIT 50;

SELECT * FROM temp30_ ORDER BY modelName desc;

-- Question 31
SELECT mk.MakeName, md.ModelName, st.StockCode, sd.SalePrice, sd.LineItemDiscount, st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) AS TotalCost,
(sd.SalePrice-IFNULL(sd.LineItemDiscount,0)) - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)) AS NetProfit
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
WHERE (sd.SalePrice-IFNULL(sd.LineItemDiscount,0)) - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)) > 5000;

-- Question 32
SELECT mk.MakeName, md.ModelName, st.color, st.StockCode, sd.SalePrice, sd.LineItemDiscount, st.RepairsCost, st.PartsCost,
st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) AS TotalCost,
(sd.SalePrice-IFNULL(sd.LineItemDiscount,0)) - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)) AS NetProfit
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
WHERE ((sd.SalePrice-IFNULL(sd.LineItemDiscount,0)) - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0)) > 5000 AND st.Color = 'Red' AND sd.LineItemDiscount >= 1000)
OR (st.PartsCost > 500 AND st.RepairsCost > 500);

-- Question 33
SELECT sum(sd.SalePrice), sum(st.Cost)+sum(st.RepairsCost)+sum(st.PartsCost) as sum_Cost,
(sum(sd.SalePrice)-sum(IFNULL(sd.LineItemDiscount,0))) - (sum(st.Cost) + sum(st.RepairsCost) + sum(IFNULL(st.PartsCost, 0))) AS sum_Profit
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID;

-- Question 34
SELECT md.ModelName, sum(sd.SalePrice), sum(st.Cost)+sum(st.RepairsCost)+sum(st.PartsCost) as sum_Cost,
(sum(sd.SalePrice)-sum(IFNULL(sd.LineItemDiscount,0))) - (sum(st.Cost) + sum(st.RepairsCost) + sum(IFNULL(st.PartsCost, 0))) AS sum_Profit
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
GROUP BY md.ModelID;

-- Question 35
SELECT makename, modelname, sum(st.cost) + sum(st.RepairsCost) + sum(IFNULL(st.PartsCost,0)) + sum(st.TransportInCost) AS TotalPurchaseCost
FROM prestigecars.stock st JOIN prestigecars.model md ON st.ModelID = md.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
Group By makename, modelname with rollup;

-- Question 36
SELECT makename, modelname, avg(st.cost)
FROM prestigecars.stock st JOIN prestigecars.model md ON st.ModelID = md.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
Group By makename, modelname with rollup;

-- Question 37
SELECT makename, modelname, count(*) FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON st.ModelID = md.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
Group By makename, modelname with rollup; 

-- Question 38
SELECT co.CountryName, count(co.CountryName) FROM prestigecars.sales sa JOIN prestigecars.customer cu ON sa.CustomerID = cu.CustomerID
JOIN prestigecars.country co ON cu.Country = co.CountryISO2
GROUP BY co.CountryName;

-- Question 39
SELECT modelname, max(SalePrice) as TopSalePrice, min(SalePrice) as BottomSalePrice
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON st.ModelID = md.ModelID
GROUP BY md.ModelID;

-- Question 40
SELECT MakeName, count(color) FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON st.ModelID = md.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
WHERE st.Color = 'Red'
GROUP BY mk.MakeID;

-- Question 41
SELECT co.CountryName, count(sd.StockID) FROM prestigecars.salesdetails sd JOIN prestigecars.sales sa ON sd.SalesID = sa.SalesID
JOIN prestigecars.customer cu ON sa.CustomerID = cu.CustomerID
JOIN prestigecars.country co ON cu.Country = co.CountryISO2
GROUP BY co.CountryName
HAVING count(sd.StockID) > 50;

-- Question 42
SELECT cu.CustomerName, count(sd.StockID) FROM prestigecars.salesdetails sd JOIN prestigecars.sales sa ON sd.SalesID = sa.SalesID
JOIN prestigecars.customer cu ON sa.CustomerID = cu.CustomerID
JOIN prestigecars.stock st ON sd.StockID = st.StockCode
WHERE ((sd.SalePrice-IFNULL(sd.LineItemDiscount,0)) - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0))) >= 5000
GROUP BY cu.CustomerName
HAVING count(sd.StockID) >= 3;

-- Question 43
SELECT mk.MakeName, sum(sd.SalePrice) as sum_SalePrice, sum(st.Cost)+sum(st.RepairsCost)+sum(st.PartsCost) as sum_Cost,
(sum(sd.SalePrice)-sum(IFNULL(sd.LineItemDiscount,0))) - (sum(st.Cost) + sum(st.RepairsCost) + sum(IFNULL(st.PartsCost, 0))) AS sum_Profit
FROM prestigecars.salesdetails sd JOIN prestigecars.stock st ON sd.StockID = st.StockCode
JOIN prestigecars.model md ON md.ModelID = st.ModelID
JOIN prestigecars.make mk ON md.MakeID = mk.MakeID
GROUP BY mk.MakeID
ORDER BY sum_Profit desc
limit 3;



