USE PMDB;
GO

INSERT INTO PM.Companies (CRNNO, CompanyName) VALUES (101, N'Company A');

INSERT INTO PM.Companies (CompanyName, CRNNO) VALUES (N'Company B', 102);

INSERT INTO PM.Companies  VALUES (103, N'Company C');

INSERT INTO PM.Companies  VALUES 
           (104, N'Company D'),
           (105, N'Company E'),
           (106, N'Company F'),
           (107, N'Company G');
GO


INSERT INTO PM.Managers (Id ,Email) VALUES (201, 'peter@fake.com');
INSERT INTO PM.Managers (Id ,Email) VALUES (202, 'mike@fake.com');
INSERT INTO PM.Managers (Id ,Email) VALUES (203, 'reem@fake.com');
INSERT INTO PM.Managers (Id ,Email) VALUES (204, 'salah@fake.com'); 

GO
INSERT INTO PM.Technologies(Id , Name) VALUES (301, 'SQL SERVER');
INSERT INTO PM.Technologies(Id , Name) VALUES (302, 'ASP NET CORE');
INSERT INTO PM.Technologies(Id , Name) VALUES (303, 'ANGULAR');
INSERT INTO PM.Technologies(Id , Name) VALUES (304, 'REACT');
INSERT INTO PM.Technologies(Id , Name) VALUES (305, 'WPF');
INSERT INTO PM.Technologies(Id , Name) VALUES (306, 'ANDROID');
INSERT INTO PM.Technologies(Id , Name) VALUES (307, 'ORACLE');
INSERT INTO PM.Technologies(Id , Name) VALUES (308, 'PHP'); 

GO

INSERT INTO PM.Projects ( PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO)
     VALUES ( 401, 'CMS', 201, '2022-01-01', 15000000, 0, 101),
            ( 402, 'ERP', 202, '2022-02-01', 20000000, 0, 102),
            ( 403, 'CMS', 203, '2022-03-01', 15000000, 0, 105),
            ( 404, 'Authenticator', 204, '2022-04-01', 150000, 0, 101),
            ( 405, 'CRM-DESKTOP', 203, '2022-05-01', 20000000, 0, 104),
            ( 406, 'ERP', 204, '2022-06-01', 20000000, 0, 105),
            ( 407, 'HUB', 204, '2022-06-01', 20000000, 1, 104);

GO

INSERT INTO PM.ProjectTechnologies (PRJNO, TechnologyId) VALUES 
        ( 401, 301), 
        ( 401, 302),
		( 401, 303),
		( 402, 301), 
        ( 402, 302),
		( 402, 304),
		( 403, 301), 
        ( 403, 302),
		( 403, 308),
		( 404, 306),
		( 405, 307),
		( 405, 305),
		( 406, 307),
		( 406, 308);
GO

-- SELECT

SELECT PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO
FROM PM.Projects;

SELECT *
FROM PM.Projects;

SELECT PRJNO, Title
FROM PM.Projects;

-- WHERE 
SELECT * FROM PM.Projects WHERE InitialCost >= 1000000;
SELECT * FROM PM.Projects WHERE NOT InitialCost >= 1000000;
SELECT * FROM PM.Projects WHERE InitialCost >= 1000000 AND StartDate >= '2022-03-01';
SELECT * FROM PM.Projects WHERE InitialCost >= 1000000 OR StartDate >= '2022-03-01';

-- LIKE (%, _)
 -- LIKE xx% starts with
 SELECT * FROM PM.Projects WHERE Title like 'C%'
  -- LIKE %xx ends with
 SELECT * FROM PM.Projects WHERE Title like '%P'
   -- LIKE %xx% contains 
 SELECT * FROM PM.Projects WHERE Title like '%DESK%'
   -- LIKE _R%
    SELECT * FROM PM.Projects WHERE Title like '_R_';
    SELECT * FROM PM.Projects WHERE InitialCost like '_5%';

-- TOP
   SELECT TOP 3 * From PM.Projects
   SELECT TOP 2 PERCENT *  From PM.Projects

-- ORDER BY
SELECT * FROM PM.Projects ORDER BY StartDate;
SELECT * FROM PM.Projects ORDER BY StartDate DESC;
SELECT * FROM PM.Projects ORDER BY InitialCost, StartDate DESC;

-- GROUP BY

SELECT Title, COUNT(*)  FROM PM.Projects GROUP BY Title;

SELECT ManagerId, COUNT(*) 
     FROM PM.Projects
	  WHERE Parked = 0 
	 GROUP BY ManagerId 
	  HAVING COUNT(*) >= 2;
 
 -- DISTINT 
 SELECT DISTINCT Title  FROM PM.Projects
  SELECT DISTINCT InitialCost  FROM PM.Projects

-- Tables JOIN

SELECT * FROM PM.Projects;
SELECT * FROM PM.Managers;

-- PRJNO,  TITLE, Manager_Email
SELECT * FROM PM.Projects, PM.Managers;
SELECT PRJNO, Title, Email FROM PM.Projects, PM.Managers; -- Cartisian Product
SELECT PRJNO, Title, Email, PM.Managers.Id, PM.Projects.ManagerId FROM PM.Projects, PM.Managers 
WHERE PM.Projects.ManagerId = PM.Managers.Id;

-- INNET JOIN Match in two tables


SELECT 
  (P.PRJNO) AS N'رقم المشروع'
, (P.Title) AS N'عنوان المشروع'
, (M.Email) AS N'البريد الالكتروني لمدير المشروع' FROM 
PM.Projects AS P INNER JOIN PM.Managers AS M 
ON P.ManagerId = M.Id;

-- LEFT JOIN ( ALL ROWS FROM LEFT TABLE EVEN NO MATCH

SELECT * FROM PM.COMPANIES;
SELECT * FROM PM.Projects;

SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
PM.Projects AS P LEFT JOIN PM.Companies AS C 
ON P.CRNNO = C.CRNNO;

SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CRNNO)
, (C.CompanyName) FROM 
 PM.Companies AS C LEFT JOIN  PM.Projects AS P
ON P.CRNNO = C.CRNNO;

-- LEFT JOIN ( ALL ROWS FROM RIGHT TABLE EVEN NO MATCH
SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
PM.Projects AS P RIGHT JOIN PM.Companies AS C 
ON P.CRNNO = C.CRNNO;

-- LEFT JOIN ( ALL ROWS FROM RIGHT TABLE EVEN NO MATCH
SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
PM.Projects AS P FULL JOIN PM.Companies AS C 
ON P.CRNNO = C.CRNNO;


-- UPDATE
UPDATE PM.Projects 
SET StartDate = '2022-07-10'
WHERE PRJNO = 407;

-- DELETE 

DELETE FROM PM.Projects WHERE PRJNO = 406;

DROP TABLE PM.PROJECTS;
TRUNCATE TABLE PM.PROJECTS;

-- SUBQUERY
SELECT * FROM PM.Projects;
SELECT * FROM PM.ProjectTechnologies;
SELECT * FROM PM.Technologies;


UPDATE PM.Projects SET InitialCost = InitialCost * 1.05 
WHERE 
PRJNO IN ( SELECT PRJNO FROM PM.ProjectTechnologies 
WHERE TechnologyId = (SELECT Id FROM PM.Technologies WHERE Name = 'ORACLE'));