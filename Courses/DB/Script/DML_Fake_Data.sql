---=================== INSERTS ==================================


INSERT INTO dbo.Department(DepartmentName) 
VALUES 
('Development'),
('Design'),
('Languages'),
('IT & Software'),
('Marketing'),
('Finance & Accounting'),
('Health & Fitness'),
('Business');

GO

INSERT INTO dbo.Country(CountryID,CountryName) 
VALUES 
('MEX','México'),
('ARG','Argentina'),
('COL','Colombia'),
('ESP','España'),
('VEN','Venezuela'),
('PER','Perú'),
('BRA','Brazil'),
('BOL','Bolivía'),
('CHL','Chile'),
('ECU','Ecuador'),
('CUB','Cuba'),
('GTM','Guatemala'),
('HND','Honduras'),
('NIC','Nicaragua'),
('PRY','Paraguay'),
('URY','Uruguay'),
('DEU','Alemania'),
('CAN','Canada'),
('CHN','China'),
('SLV','El Salvador'),
('USA','Estados Unidos'),
('PHL','Philipinas'),
('FRA','Francia'),
('HKG','Hong Kong'),
('IND','India'),
('JPN','Japon'),
('PRI','Puerto Rico')


GO

INSERT INTO Language
VALUES
('ENG', 'English'),
('ESP', 'Spanish'),
('FRA', 'French'),
('ZHO', 'Chino'),
('ITA', 'Italian'),
('DEU', 'German')


GO

INSERT INTO dbo.Student(FirstName,LastName,PhoneNumber,Email,Age,Gender,CountryID) 
VALUES 
('Guillermo','Morán','6143045678','moran@xmail.com',49,'M','MEX'),
('Fany','Avilés','2345684930','avi@testmail.com',24,'F','MEX'),
('Alvaro','Lopez','5554567892','loopez@testmail.com', 28, 'M','ECU'),
('Brandon', 'Morán','4553412237','brandi@xmail.com',20,'M','BOL'),
('Giddiani','Gonzalez','3339283746','giddi@xmail.com',30,'M','DEU'),
('Jorge','Betancourt','5629988776','beta@testmail.com',27,'M','HKG'),
('Paola','Jimenez','3221234567','jime@xmail.com',19,'F','MEX'),
('Eduardo','Santamarina','4921234567','santa@xmail.com',50,'M','GTM'),
('Jimena','Jimenez','3220004567','jiji@xmail.com',43,'F','ESP'),
('Maria','Soto','5671234987','maso@xmail.com',35,'F','IND'),
('Héctor','Sánchez','1111234000','toto@xmail.com',79,'M','COL'),
('Irma','Dorantes','2231256767','dora@testmail.com',30,'F','CHL'),
('Dolores','García','6137654321','lolina@xmail.com',18,'F','DEU'),
('Alexandro','Del Barrio','2297373735','delbalex@xmail.com',19,'M','HND'),
('Yolanda','Avilés','3221234569','yoli@xmail.com',29,'F','HND'),
('Jose Luis','Estuardo','6661235557','estu@testmail.com',56,'M','FRA'),
('Sandra','Jurado','5671230987','sandia@xmail.com',19,'F','ESP'),
('Mariana','Yapor','2221234305','yapor@xmail.com',23,'F','MEX'),
('Lorena','Ladron de Guevara','9879874567','milore@xmail.com',28,'F','MEX'),
('Rosa Luz','Ponce','1231234123','rosita@xmail.com',40,'F','FRA'),
('Ernesto','Laguardia','4561090567','neto@testmail.com',19,'M','GTM'),
('Luis Miguel','Gallego','9001288867','elsol@xmail.com',29,'M','CUB'),
('Mario','Santana','5006004567','marsan@xmail.com',37,'M','CAN'),
('Mario','Santana','3219874567','santos@xmail.com',37,'M','COL'),
('Felipe','Rivera','9711234234','jelipe@xmail.com',18,'M','GTM'),
('Benancio','Machuca','9098134567','machuca@xmail.com',18,'M','CAN'),
('Carolina','Carballo','3221232093','karito@xmail.com',47,'F','ESP');

GO


INSERT INTO dbo.Instructor(FirstName,LastName,Email,DepartmentID) 
VALUES 
('Ramiro','Ortega','ramort@test.com',1),
('Evencio','De la Rosa','dona@test.com',1),
('Victor','Sisiniega','elvic@test.com',1),
('Claudia','Ortega','ortega@test.com',1),
('Rosario','Dominguez','dguez@test.com',1),
('Benito','Juarez','beni2021@test.com',2),
('Lucia','Garcia','lugar@test.com',2),
('Sandra','Perez','sanpe@test.com',3),
('Leopoldo','Juarez','leoj@test.com',3),
('Andres','Garcia','andyg@test.com',3),
('Jorge','Campos','georgy@test.com',4),
('Saila','Santana','saila@test.com',4),
('Luz','Ponce','lucecita@test.com',4),
('Rebeca','Alva','rebe@test.com',5),
('Lorena','Herrera','loreh@test.com',5),
('Silvia','Santos','ssantos@test.com',6),
('Felipe','Contreras','felicon@test.com',6),
('Lucila','Mariscal','lulu@test.com',7),
('Maria','Utrera','utrera@test.com',7),
('Leobardo','Fuentes','leo@test.com',8)

GO

INSERT INTO dbo.Category(CategoryName)
VALUES
('Web Development'),
('Mobile Development'),
('Programming Languages'),
('Game DEvelopment'),
('Data Science'),
('Databases'),
('Entrepreneurship'),
('Communication'),
('Management'),
('Sales'),
('Accounting & Bookkeeping'),
('Cryptocurrency & Blockchain'),
('Finance'),
('IT Certifications'),
('Network & Security'),
('Operating Systems & Servers'),
('English'),
('Italian'),
('German'),
('Chinese'),
('Web Design'),
('Game Design'),
('Graphic Design & Illustration'),
('Digital Marketing'),
('Social Media Marketing'),
('Brading'),
('General Health'),
('Yoga'),
('Mental Health')


GO

INSERT INTO dbo.Course(CourseName,Credits,CourseCode,Price,CategoryID,LanguageID,InstructorID)
VALUES
('Angular - The Complete Guide',10,'ANG01',127.00,1,'ENG',1),
('Angular Fundamentals',10,'ANG02',127.00,1,'ENG',1),
('Angular Desde Cero',10,'ANG03',127.00,1,'ESP',2),
('Reactive X',15,'RxJS01',150.00,1,'ENG',2),
('Data Structures And Algorithms',25,'DS01',200.00,5,'ENG',3),
('Mastering Data Structures And Algorithms',25,'DS02',127.00,5,'ENG',3),
('Dominando las Estructuras de Datos',20,'DS03',127.00,5,'ESP',4),
('JavaScript Dynamic',10,'JS01',127.00,3,'ENG',1),
('C# Fundamentos',10,'C#01',127.00,3,'ESP',4),
('Android Java Masterclass',10,'ANDR01',127.00,2,'ESP',2),
('Build Your First iPhone App',30,'iOS01',127.00,2,'ENG',2),
('SQL Bootcamp',10,'SQL01',127.00,6,'ESP',5),
('SQL For Beginners',10,'SQL02',127.00,6,'ENG',3),
('An Entire MBA in 1 Course:Award Winning Business School Prof',20,'ENTRE01',150.00,9,'ENG',5 ),
('MBA in a Box: Business Lessons from a CEO',20,'ENTRE02',150.00,13,'ENG',5 ),
('The Complete Financial Analyst Course 2021',20,'BUSE01',200.00,11,'ENG',6 ),
('Beginner to Pro in Excel: Financial Modeling and Valuation',20,'BUS02',150.00,11,'ENG',6 ),
('The Complete Digital Marketing Course - 12 Courses in 1',20,'MARK01',150.00,10,'ENG',7 ),
('Ultimate Google Ads Training 2020: Profit with Pay Per Click',30,'ENTRE02',300.00,10,'ENG',7 )


GO

INSERT INTO dbo.Enrolment(EnrolmentDate,StudentID)
VALUES
('2020/12/01',1),
('2020/01/12',2),
('2019/10/04',3),
('2019/10/04',4),
('2020/09/27',5),
('2020/01/01',6),
('2021/12/29',7),
('2020/11/18',8),
('2021/02/23',9),
('2020/12/25',10),
('2020/03/30',11),
('2020/01/05',12),
('2020/08/13',13),
('2021/07/23',14),
('2021/07/23',15),
('2020/11/23',16),
('2020/12/31',17),
('2019/06/06',18),
('2019/01/01',19),
('2019/07/23',20),
('2019/07/23',21),
('2020/12/31',22),
('2018/04/23',23),
('2017/11/02',24),
('2017/12/20',25),
('2020/10/10',26),
('2020/10/10',27)


GO 


INSERT INTO dbo.CourseEnrolment(EnrolmentID,CourseID)
VALUES
(1,4),
(2,1),
(3,3),
(4,2),
(5,4),
(6,5),
(7,1),
(8,2),
(9,3),
(10,3),
(11,1),
(12,5),
(13,5),
(14,4),
(15,2),
(16,2),
(17,1),
(18,3),
(19,3),
(20,5),
(21,5),
(22,2),
(23,4),
(24,4),
(25,1),
(26,2),
(27,3),
(1,6),
(2,7),
(3,8),
(4,9),
(5,10),
(6,11),
(7,6),
(8,7),
(9,8),
(10,9),
(11,10),
(12,11),
(13,6),
(14,7),
(15,8),
(16,9),
(17,10),
(18,11),
(19,6),
(20,7),
(21,8),
(22,9),
(23,10),
(24,11),
(25,6),
(26,7),
(27,8),
(1,7),
(2,6),
(3,9),
(4,8),
(5,11),
(6,10),
(7,7),
(8,6),
(9,9),
(10,8),
(11,11),
(12,10),
(13,7),
(14,6),
(15,9),
(16,8),
(17,11),
(18,9),
(19,8),
(20,8),
(21,6),
(22,5),
(23,12),
(24,13),
(25,7),
(26,8),
(27,4)
GO





