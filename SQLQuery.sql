-- 1.   From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle. --
SELECT * FROM HumanResources.Employee
ORDER BY jobtitle;
-- 2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname. --
SELECT * FROM Person.Person
ORDER BY lastname;
-- 3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.--
SELECT BusinessEntityID as Employee_id, FirstName, LastName FROM Person.Person
ORDER BY LastName;
-- 4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.--
SELECT ProductID, ProductNumber, Name FROM Production.Product
WHERE SellStartDate is not NULL and ProductLine ='T'
ORDER BY Name; 
-- 5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal. --
SELECT SalesOrderID, CustomerID, OrderDate, SubTotal, (TaxAmt/SubTotal)*100 as PercentageOfTaxeColumn From Sales.SalesOrderHeader
ORDER BY SubTotal DESC;
-- 6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order. --
SELECT DISTINCT JobTitle FROM HumanResources.Employee
ORDER BY JobTitle;
-- 7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid. --
SELECT CustomerID, SUM(Freight) as TotalFreight From Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID;
-- 8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order. --
SELECT CustomerID, SUM(SubTotal) as SubTotalSum, AVG(SubTotal) as SubTotalAvg, SalesPersonID FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC; 
-- 9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order. --
SELECT ProductID, SUM(Quantity) as TotalQuantity From Production.ProductInventory
WHERE Shelf = 'A' OR Shelf = 'C' OR Shelf = 'H'
GROUP BY ProductID
HAVING SUM(Quantity) > 500
ORDER BY ProductID;
-- 10. From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10. --
SELECT LocationID, SUM(Quantity)*10 as TotalQuantity FROM Production.ProductInventory
GROUP BY LocationID;
-- A REVOIR --
-- 11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.--
SELECT Person.Person.BusinessEntityID, PhoneNumber, FirstName, LastName
FROM Person.Person
JOIN Person.PersonPhone ON Person.Person.BusinessEntityID = Person.PersonPhone.BusinessEntityID
WHERE LastName LIKE 'L%'
ORDER BY LastName, FirstName; 
-- 12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.
SELECT SalesPersonID, CustomerID, SUM(SubTotal) as SumSubtotal  FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (SalesPersonID, CustomerID);
-- 13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.--
SELECT LocationID, Shelf, SUM(Quantity) as TotalQuantity FROM Production.ProductInventory
GROUP BY CUBE (LocationID, Shelf)
-- 14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.--
SELECT LocationID, Shelf, SUM(Quantity) as TotalQuantity FROM Production.ProductInventory
FROM production.productinventory
GROUP BY GROUPING SETS ( ROLLUP (LocationID, shelf), CUBE (LocationID, shelf) );
-- 15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.
SELECT locationid, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY GROUPING SETS ( LocationID, () );
-- 16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.--
SELECT a.City, COUNT(b.AddressID) as NumberOfEmployees
FROM Person.BusinessEntityAddress as b 
JOIN Person.Address as a
ON b.AddressID = a.AddressID
GROUP BY a.city
ORDER BY a.city ;
-- 17. From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.--
SELECT YEAR(OrderDate) as Year, SUM(TotalDue) as TotalDueAmount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY Year ;
-- 18. From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date. --
SELECT YEAR(OrderDate) as Year, SUM(TotalDue) as TotalDueAmount
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) <= '2016'
GROUP BY YEAR(OrderDate)
ORDER BY Year ;
-- 19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.--
SELECT ContactTypeID, Name FROM Person.ContactType
WHERE Name Like '%Manager%'
ORDER BY ContactTypeID DESC;
-- 20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName. --
SELECT c.BusinessEntityID, LastName, FirstName 
FROM Person.BusinessEntityContact as a 
JOIN Person.ContactType as b 
ON a.ContactTypeID = b.ContactTypeID
JOIN Person.Person as c 
ON a.PersonID = c.BusinessEntityID
WHERE b.name = 'Purchasing Manager'
ORDER BY LastName, FirstName;
-- 21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
SELECT ROW_NUMBER() OVER (PARTITION BY PostalCode ORDER BY SalesYTD DESC) AS "Row Number", LastName, SalesYTD, PostalCode
FROM Sales.SalesPerson as a 
JOIN Person.Person as b 
ON a.BusinessEntityID = b.BusinessEntityID
JOIN Person.Address as c 
ON c.AddressID = b.BusinessEntityID
WHERE TerritoryID is not NULL and SalesYTD <> 0
ORDER BY PostalCode ASC;
-- 22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts. --
SELECT a.ContactTypeID, Name as ContactTypeName, COUNT(*) as NoContacts
FROM Person.BusinessEntityContact as a
JOIN Person.ContactType as b
ON a.ContactTypeID = b.ContactTypeID
GROUP BY a.ContactTypeID, Name
HAVING COUNT(*) >= 100
ORDER BY COUNT(*) DESC;
-- 23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.--
SELECT CONVERT(date, RateChangeDate) AS FormDate,
       CONCAT(LastName, ' ', FirstName, ' ', MiddleName) AS NameInFull,
       Rate * 40 AS SalaryInaWeek
FROM HumanResources.EmployeePayHistory AS a
JOIN Person.Person AS b ON a.BusinessEntityID = b.BusinessEntityID
ORDER BY NameInFull ASC;
-- 24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.--
SELECT CONVERT(date, RateChangeDate) AS FormDate,
       CONCAT(LastName, ' ', FirstName, ' ', MiddleName) AS NameInFull,
       Rate * 40 AS SalaryInaWeek
FROM HumanResources.EmployeePayHistory AS a
JOIN Person.Person AS b ON a.BusinessEntityID = b.BusinessEntityID
ORDER BY NameInFull ASC;
-- 25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity. -- 
SELECT SalesOrderID, ProductID, OrderQty,
        SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS TotalQuantity,
        AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS AvgQuantity,
        COUNT(SalesOrderID) OVER (PARTITION BY SalesOrderID) AS NoOfOrders,
        MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS MinQuantity,
        MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS MaxQuantity
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664)
-- 26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity. -- 
SELECT SalesOrderID, ProductID, OrderQty,
SUM(OrderQty) OVER (ORDER BY SalesOrderID, ProductID) AS TotalQuantity,
AVG(OrderQty) OVER (PARTITION BY SalesOrderID ORDER BY SalesOrderID, ProductID) AS AvgQuantity,
COUNT(OrderQty) OVER (ORDER BY SalesOrderID, ProductID) AS NoOfOrders
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664) AND ProductID LIKE '71%'
-- 27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost. --
SELECT SalesOrderID, SUM(OrderQty*UnitPrice) AS OrderIDCost
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty*UnitPrice) > 100000
ORDER BY SalesOrderID;
-- 28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. Return product ID, and name and order the result set in ascending order on product ID column. --
SELECT ProductID, Name 
FROM Production.Product
WHERE NAME LIKE 'Lock Washer%'
ORDER BY ProductID;
-- 29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, name, and color of the product. --
SELECT ProductID, Name, Color 
FROM Production.Product
ORDER BY ListPrice;
-- 30. From the following table write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate. --
SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY HireDate;
-- 31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns. 
SELECT LastName, FirstName 
FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC, LastName DESC;
-- 32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns. 
SELECT BusinessEntityID, SalariedFlag  
FROM HumanResources.Employee  
ORDER BY CASE WHEN SalariedFlag = 'false' THEN BusinessEntityID END DESC;
-- 33. From the following table write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows. 
SELECT BusinessEntityID, LastName, TerritoryName, CountryRegionName  
FROM Sales.vSalesPerson  
WHERE TerritoryName IS NOT NULL  
ORDER BY CASE CountryRegionName WHEN 'United States' THEN TerritoryName  
         ELSE CountryRegionName END;
-- 34. From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column. 
SELECT ROW_NUMBER() OVER (ORDER BY PostalCode) AS "Row Number",
RANK() OVER (ORDER BY PostalCode) AS "Rank",
DENSE_RANK() OVER (ORDER BY PostalCode) AS "Dense Rank",
NTILE(4) OVER (ORDER BY PostalCode) AS "Quartile", FirstName, LastName,SalesYTD, PostalCode 
FROM Sales.SalesPerson AS a
JOIN Person.Person AS b
ON a.BusinessEntityID = b.BusinessEntityID
JOIN Person.Address AS c 
ON b.BusinessEntityID = c.AddressID
WHERE TerritoryID is NOT NULL AND SalesYTD <> 0
-- 35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows. 
SELECT DepartmentID, Name, GroupName
FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 10 ROWS;
-- 36. From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set. 
SELECT DepartmentID, Name, GroupName
FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;
-- 37. From the following table write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice. 
SELECT Name, Color, ListPrice FROM Production.Product
WHERE Color IN ('Blue', 'Red')
ORDER BY ListPrice;
-- Correction
SELECT Name, Color, ListPrice  
FROM Production.Product  
WHERE Color = 'Red'  
UNION ALL  
SELECT Name, Color, ListPrice  
FROM Production.Product  
WHERE Color = 'Blue'  
ORDER BY ListPrice ASC;
-- 38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. Return product name, salesorderid. Sort the result set on product name column. 
SELECT Name, SalesOrderID 
FROM Sales.SalesOrderDetail AS a 
FULL OUTER JOIN Production.Product AS b
ON a.ProductID = b.ProductID
ORDER BY Name;
-- 39. From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set. 
SELECT Name, SalesOrderID 
FROM Production.Product AS a 
LEFT OUTER JOIN Sales.SalesOrderDetail AS b 
ON a.ProductID = b.ProductID
ORDER BY Name; 
-- 40. From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column. 
SELECT Name, SalesOrderID 
FROM Production.Product AS a 
INNER JOIN Sales.SalesOrderDetail AS b 
ON a.ProductID = b.ProductID
ORDER BY Name; 
-- 41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople, regardless of whether or not they are assigned a territory.
SELECT Name AS Territory, BusinessEntityID 
FROM Sales.SalesTerritory AS a 
RIGHT OUTER JOIN  Sales.SalesPerson AS b
ON a.TerritoryID = b.TerritoryID
-- 42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. Order the result set on lastname then by firstname. 
SELECT CONCAT(FirstName, ' ', LastName) AS Name, City 
FROM Person.Person AS a 
JOIN HumanResources.Employee AS b 
ON a.BusinessEntityID = b.BusinessEntityID
JOIN Person.BusinessEntityAddress AS c 
ON b.BusinessEntityID = c.BusinessEntityID
JOIN Person.Address AS d 
ON c.AddressID = d.AddressID
ORDER BY LastName, FirstName;
-- 43. Write a SQL query to return the businessentityid, firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table. 
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE PersonType = 'IN' AND LastName = 'Adams'
ORDER BY FirstName; 
-- 44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'. 
SELECT BusinessEntityID, FirstName, LastName 
FROM Person.Person
WHERE BusinessEntityID < 1500 AND LastName LIKE 'A%' AND FirstName LIKE 'M%'
-- 45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.  
SELECT ProductID, Name, Color 
FROM Production.Product
WHERE Name = 'Blade' OR Name = 'Crown Race' OR Name = 'AWC Logo Cap'
ORDER BY ProductID
-- 46. Create a SQL query to display the total number of sales orders each sales representative receives annually. Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID. 
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, YEAR(OrderDate) AS SalesYear
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, YEAR(OrderDate)
ORDER BY SalesPersonID, YEAR(OrderDate);
-- 47. From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives.  
WITH Sales_CTE (SalesPersonID, NumberOfOrders)
AS
(
    SELECT SalesPersonID, COUNT(*)
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
)
SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM Sales_CTE;
-- 48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. The following table's columns must all be returned. 
SELECT ProductPhotoID, ThumbNailPhoto FROM Production.ProductPhoto
WHERE LargePhotoFileName LIKE '%green_%'
-- 49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns. 
SELECT AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode FROM Person.Address AS a 
JOIN Person.StateProvince AS b 
ON a.StateProvinceID = b.StateProvinceID 
WHERE CountryRegionCode <> 'US' AND City LIKE 'Pa%'
-- 50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order. 
SELECT TOP 20 JobTitle, HireDate 
FROM HumanResources.Employee
ORDER BY HireDate DESC;