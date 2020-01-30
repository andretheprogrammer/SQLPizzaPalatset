------------------------------------------------
	--------- G3 SYSTEMS ---------------------------
	------------------------------------------------
	-----SKAPAT AV HARIZ@KTH.se 2020 ---------------
	---- NEWTONS YRKESHÖGSKOLA ---------------------
	---- PROJEKTARBETE TILL DATABASKURSEN-----------
	------------------------------------------------
	------------------------------------------------
	-- Updaterat 2020 28 januari - av Hariz Hasecic
------------------------------------------------------------------------
	-----KVAR ATT GÖRA------------------------------------------------------
	-- Kolla ifall alla Entity tabeller finns
	-- kolla ifall alla Sambands Tabeller finns
	-- Sätt cascade överallt

	---Sätt in alla Nycklar i nyckelraden
	-- Sätt in alla referensattribut i referensattributraden, Så det blir snyggt uppdelat

	-- Skapa dom viktigaste viewsen . Dvs maintabellerna (tabell+aggregatkolonner. Tex Total cash i building)
	-- Skriv om allt till engelska
	------------------------------------------------------------------------
------------------------------------------------------------------------
----Datatyper: (Använder alltid value som nyckelord)
--------------------------------------------------------------------------
--------------------------------------------------------------------------
	--CREATE TYPE PINT AS INT 
		--	default 0,
		--	CHECK(value >= 0);
	--CREATE TYPE VARCHAR(50) NOT NULL DEFAULT 'UNNAMED' AS varchar(50)  --Slipper kopiera villkor för namn
		--	default "Unnamed",
		--	CHECK (value NOT NULL);
	--CREATE TYPE BIT NOT NULL DEFAULT 1 AS bit  -- Default True
		--	default 1,
		--	CHECK (value NOT NULL);
	--CREATE TYPE BIT NOT NULL DEFAULT 1FALSE AS bit  -- Default FALSE
		--	default 0,
		--	CHECK (value NOT NULL);
	--CREATE TYPE PERCENT AS INT  -- Default True
		--	default 0,
		--	CHECK (value =< 100 AND value >=0);
	----Potentiel inkapsling av ID-typer
		--	--CREATE DOMAIN IDTYPE AS INT  -- Default True
		--	--	CHECK (value NOT NULL),
		--	--	constraint UNIQUE (value);



------------------------------------------------------------------------
--- SQL DEFINITIONSFILE ------------------------------------------------
------------------------------------------------------------------------
CREATE TABLE Buildings(
	Building INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	BuildingName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	--Nycklar:
	-- 
	-- Beräknade attribut nedan
	--TotalCash INT NOT NULL, (SUM aggregat av alla betalda ordrar)

	--Referensattribut nedan
	-- 
	--Extra Begränsningar nedan
	--
	);
CREATE TABLE Terminals(
	Terminal INT IDENTITY(1,1)  NOT NULL PRIMARY KEY,
	TerminalName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	Building INT FOREIGN KEY REFERENCES Buildings(Building),
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	--Nycklar:

	-- Beräknade attribut nedan
	--
	Ledig BIT NOT NULL DEFAULT 1,
	-- Referensattribut nedan
	--
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Infoscreens(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	InBuilding INT FOREIGN KEY REFERENCES Buildings(Building),

	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	--Nycklar:

	-- Beräknade attribut nedan
	--
	-- Referensattribut nedan
	--
	-- Extra Begränsningar nedan
	--
	);
-- CREATE TABLE InfoScreenIsInBuilding(
	-- 	Reference INT PRIMARY KEY NOT NULL,
	-- 	InfoScreen INT FOREIGN KEY REFERENCES InfoScreens(Id),

	-- 	--Nycklar

	-- 	-- INFOSCREEN
	-- 	-- BUILDING
	-- 	--Beräknade attribut nedan
	-- 	-- 
	-- 	--Referensattribut nedan
	-- 	--Extra Begränsningar nedan
	-- 	--
	-- 	);
	--CREATE TABLE QueuesShowsInInfoscreens(
		--	Reference INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		--	QueueNumbers INT FOREIGN KEY REFERENCES QueueNumbers(QueueNumber),

		--	InfoScreen INT FOREIGN KEY REFERENCES InfoScreens(InfoScreen),

		--	--Nycklar
		--	-- BUILDING ??
		--	--Beräknade attribut nedan
		--	-- 
		--	--Referensattribut nedan
		--	--Extra Begränsningar nedan
		--	--
	--	)
CREATE TABLE StationTypes(
	StationType INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	StationTypeName VARCHAR(50) ,
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	DangerLevel INT NOT NULL DEFAULT 0

	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Stations(
	Station INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	StationName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	HasStationType INT FOREIGN KEY REFERENCES StationTypes(StationType),
	InBuilding INT,
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	
	--Nycklar:

	--Beräknade attribut nedan
	--
	--Referensattribut nedan
	-- STATIONTYPE: references stationtype-table
	-- INBUILDING: references building-table
	    CONSTRAINT FK_Stations_Buildings FOREIGN KEY (InBuilding)
    		REFERENCES Buildings(Building)
    		ON DELETE CASCADE
    		ON UPDATE CASCADE,
	--Extra Begränsningar nedan
	--
	);
-- CREATE TABLE Persons
	-- (
	-- 	Person INT NOT NULL

	-- 	Wallet INT NOT NULL,
	--  NAME VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	--  AGE INT NOT NULL,
	--  HP INT ,
	--		CHECK (HP >= 0 AND HP <= 100) 

	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	    --WEAPON --Kommer kräva en Product+ProductType för detta

	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- )
-- CREATE TABLE Customers(
	-- 	Customer INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	-- 	Wallet INT NOT NULL DEFAULT 1000,

	-- 	--Nycklar
	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan

	-- 	-- Extra Begränsningar nedan
	-- );
CREATE TABLE Employees(
	Employee INT IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Username VARCHAR(20) NOT NULL,
	Password VARCHAR(20) NOT NULL DEFAULT ROUND(RAND() * 1000000000000000000, 0), 
	
	LoggedIn bit NOT NULL DEFAULT 0, 
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	AssignedToStation INT FOREIGN KEY REFERENCES Stations(Station)
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
		--#Todo
			-- Check ( 
			-- 		((LoggedIn =1 AND AssignedToStation IS NOT Null ) OR 
			-- 		(LoggedIn =0 AND AssignedToStation IS Null) )
			-- 		AND
			-- 			-- Bara tillåtna kombinationer av Loggedin, Activated och assigned till station ska anges här
			-- 		--(Man får ej vara Icke-Activated och inloggad) (hur skriva dettA?)
			-- 	  )
	--
	);
CREATE TABLE EmployeeTypes(
	EmployeeType INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	EmployeeTypeName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',

	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
-- CREATE TABLE EmployeesWorkInStationAndBuilding
	-- (
	-- 	Id INT NOT NULL -- Trippelsamband har bara "Id" som kolumnheader 

	-- 	Employee INT NOT NULL FOREIGN KEY Employees(Employee),
	-- 	Station INT NOT NULL FOREIGN KEY Employees(Employee),
	-- 	Employee INT NOT NULL FOREIGN KEY Employees(Employee),

		
	-- 	--Nycklar:

	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- )
CREATE TABLE Orders(
	OrderId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	--Betald bit NOT NULL DEFAULT 0,
	--Avbruten bit NOT NULL DEFAULT 0,
	ByTerminal INT NOT NULL FOREIGN KEY REFERENCES Terminals(Terminal),

	Activated BIT NOT NULL DEFAULT 1, --I princip alltid 1
	Visible BIT NOT NULL DEFAULT 1,  -- I princip alltid 1

	Paid bit NOT NULL DEFAULT 0,
	Canceled bit NOT NULL DEFAULT 0,
	PickedUp bit NOT NULL DEFAULT 0,
	ShowOnScreen bit NOT NULL DEFAULT 1,
	Paused bit NOT NULL DEFAULT 0,
	HappyCustomer bit NOT NULL DEFAULT 1,
	Returned bit NOT NULL DEFAULT 0,
	HasSpit bit NOT NULL DEFAULT 0,
	DeliveredByCompany bit NOT NULL DEFAULT 0, 
	

	--Beräknade attribut nedan
		-- Status PERCENT,  - Beräknas genom ProduktOrder. % på antal färdiga produktordrar kopplade till denna order
		-- PriceTotal - Beräknas med hjälp av View som joinas in i tabellen
	-- Referensattribut nedan:		
		-- CONSTRAINT FK_QueueOrder FOREIGN KEY (QueueNr) REFERENCES QueueNumbers(QueueNumber) -- MÖJLIGT VIS SKRÄP #TODO
	
	-- Extra Begränsningar nedan
		--Validerar
		CONSTRAINT CHK_ORDERS_OrderValidering   
	    	CHECK 
	    		(
					(PickedUp 	=0 or (Paid=1 AND Canceled =0 AND Paused=0 AND Returned=0))
					AND
					(Paid 		=0 or (Canceled=0) )
					AND
					(Canceled 	=0 OR (PickedUp=0 AND Paused =0 AND Returned=0) )
					AND
					(Paused 	=0 OR (PickedUp=0 AND Returned=0 AND Canceled=0 AND Paid=1) )
					AND
					(Returned 	=0 OR (PickedUp=0) )
									
				)
	);
-- CREATE TABLE QueueNumbers(
	-- 	QueueNumber INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	-- 	OrderId INT NOT NULL,
	-- 	--Terminal INT REFERENCES  - Behövs ej, Terminal ges av ORDERID (dvs är fb)
		
	-- 	--Nycklar:

	-- 	--Beräknade attribut nedan
	-- 	QueueMod100 INT NOT NULL,   --Kommer vara id mod100. Dvs beräknad

	-- 	-- Visible BIT NOT NULL DEFAULT 1, 			 --Beräknas utifrån "Order Färdig,betald "
	-- 								 	 --Blir false då order blir Upphämtad

	-- 	-- Referensattribut nedan
	--     	CONSTRAINT FK_QueueOrder FOREIGN KEY (OrderId)
	--     		REFERENCES Orders(OrderId)
	--     		ON DELETE CASCADE
	--     		ON UPDATE CASCADE,

	--     	--DENNA ForeignKey kommer antagligen aldrig att användas. Ta bort snarast och koppla kund mot Order bara. #TODO
	--     	-- - kommer sättas som "null" då en kund tas bort från databasen.
	--     	CONSTRAINT FK_Queue_Customer FOREIGN KEY (Customer)
	--     		REFERENCES Customers(Customer)
	--     		ON DELETE SET NULL
	--     		ON UPDATE CASCADE,

	-- 		CONSTRAINT FK_Queue_InfoScrn FOREIGN KEY (InfoScreen)
	-- 			REFERENCES InfoScreens(Id)
	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- 	);
CREATE TABLE EmployeesAreEmployeeTypes(
	--Reference INT IDENTITY(1,1) NOT NULL,  -- N-N samband har "Reference" som kolumnheader istället för "Id"
	Employee INT NOT NULL FOREIGN KEY REFERENCES Employees(Employee),
	EmployeeType INT NOT NULL FOREIGN KEY REFERENCES EmployeeTypes(EmployeeType) ,

	--Nycklar
	PRIMARY KEY (Employee, EmployeeType)
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE EmployeeTypeCanWorkInStationType(
	--Glöm inte bort att ha använda assert i källtabellen
	--Id INT NOT NULL IDENTIFIER(1,1) , 			--Onödigt skrot men standard att ha id.
	EmployeeType INT NOT NULL FOREIGN KEY REFERENCES EmployeeTypes(EmployeeType),
	StationType INT FOREIGN KEY REFERENCES StationTypes(StationType)


	--Nycklar
	PRIMARY KEY (EmployeeType,StationType)

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE EmployeesHasOrdersInStations(
	--Id INT IDENTIFIER(1,1) NOT NULL, 			--Onödigt skrot men standard att ha id.
	Employee INT NOT NULL FOREIGN KEY REFERENCES Employees(Employee),
	OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderID),
	Station INT NOT NULL FOREIGN KEY REFERENCES Stations(Station),

	
	--Nycklar
	PRIMARY KEY (Employee, OrderID,Station),
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE ProductTypes(
	ProductType INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	ProductTypeName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Products(
	Product INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ProductType INT NOT NULL,

	ProductName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED', 
	Description varchar(500) DEFAULT 'No Description',
	Tillagningstid INT NOT NULL DEFAULT 500,  -- I sekunder
	BasPrice INT NOT NULL DEFAULT 100,
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	--Nycklar
	--Beräknade attribut nedan
	--AckumuleratPrice INT NOT NULL,
	
	-- Referensattribut nedan
	CONSTRAINT FK_Products_ProductTypes FOREIGN KEY (ProductType) 
		REFERENCES ProductTypes(ProductType),
	-- Extra Begränsningar nedan
	CONSTRAINT  UC_Products_NameTypeCombo UNIQUE (ProductName,ProductType) --"Högst en unnamed per type."

	--
	);
CREATE TABLE TypeIsMadeInStationType(    -- Kommentar: type Pizza tillverkas ej i Glassbar
	--Glöm inte att använda Assert i andra tabeller nu.
	-- Reference INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,

	ProductType INT NOT NULL FOREIGN KEY REFERENCES ProductTypes(ProductType),
	StationType INT FOREIGN KEY REFERENCES StationTypes(StationType),
	--Nycklar
	PRIMARY KEY (ProductType,StationType)
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Ingredients(
	Ingredient INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IngredientName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	
	Price INT NOT NULL DEFAULT 5, 
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	
	-- Nycklar :

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE OrderWasTreatedByEmployeeAtStation(
	--Fungerar som en logger för närvarande. Kommer senare integreras eller rensas bort för integritet. #TODO
	
	Treatment INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Employee INT FOREIGN KEY REFERENCES Employees(Employee),
	Station Int FOREIGN KEY REFERENCES Stations(Station),
	OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),

	TreatmentTime DateTime,
	
	
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
-- CREATE TABLE CustomerOrderedOrderInTerminal
	-- 	(
	-- 	Id INT NOT NULL,

	-- 	--QueueNumber INT FOREIGN KEY REFERENCES QueueNumbers(QueueNumber),
		
	-- 	--Nycklar:

	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- 	);
CREATE TABLE ProductOrders
	(
	ProductOrder INT IDENTITY(1,1) NOT NULL,
	Product Int NOT NULL, 											--FK
	OrderId INT NOT NULL, 											--FK
	LockedByStation Int FOREIGN KEY REFERENCES Stations(Station),   --FK
	
	Behandlad BIT DEFAULT 1, 

	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	Betald BIT NOT NULL DEFAULT 1,
	
	--Nycklar
		primary key (ProductOrder, Product),
	--Beräknade attribut nedan
	-- ProductType Int -- joinas fram med ProductType tabellen för att ge ytterliggare en kolonn. Fås med view.
	-- Specialisering Int --Joinas fram. Visar om den har annorlunda ingredienser än vad Produkt brukar ha.

	-- Referensattribut nedan
    	CONSTRAINT FK_ProductOrders_Product FOREIGN KEY (Product)
    		REFERENCES Products(Product),

    	CONSTRAINT FK_ProdctOrders_Orders FOREIGN KEY (OrderId)
    		REFERENCES Orders(OrderId),

    	CONSTRAINT FK_ProductOrders_Station FOREIGN KEY (LockedByStation)
    		REFERENCES Stations(Station),

	-- Extra Begränsningar nedan
		--An order can be locked by one station at the time.
		CONSTRAINT UC_ProductOrders_LockedByStation UNIQUE(LockedByStation),
		CONSTRAINT UC_ProductOrders_ID UNIQUE(ProductOrder)
	--
	);

-- EXTREMT SANNOLIKT ONÖDIG. - FIXA PRODUCTORDER-Tabellen istället, ty ProductOrder (N-1) Product	
-- CREATE TABLE ProductOrdersHaveProducts 
	-- 	(
	-- 	ProductOrder INT NOT NULL FOREIGN KEY REFERENCES ProductOrders(ProductOrder),
	-- 	Product INT NOT NULL FOREIGN KEY REFERENCES Products(Product)



	-- 	--Nycklar:

	-- 		CONSTRAINT PK_Person PRIMARY KEY (ProductOrder,Product); 
	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- 	);
-- CREATE TABLE CustomerHasQueueNumberInInfoScreen
	-- (
	-- 	Id INT NOT NULL

	-- 	--Nycklar:

	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- );
CREATE TABLE Stuffings(
	Lump INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Dvs , id, dvs objektet "en klump av ingredienser"

	ProductOrder INT NOT NULL,
	Ingredient INT FOREIGN KEY REFERENCES Ingredients(Ingredient),
	Antal INT NOT NULL,  						--Checka att den är >1 #TODO

	--Nycklar:
		CONSTRAINT FK_Stuffings_ProductOrder FOREIGN KEY (ProductOrder)
			REFERENCES ProductOrders(ProductOrder) 
			ON DELETE CASCADE, --weak entity är ON DELETE CASCADE
	
	--Beräknade attribut nedan
	-- ProductType 									-- Ska fås direkt från (Produkten i) produktordern.
	-- Locked BIT,				--Blir låst när Dens Order är låst (aggregat)

	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	CONSTRAINT UC_POIngredient UNIQUE(ProductOrder,Ingredient)
	--
	);
CREATE TABLE TypeCanHaveIngredients(
	ApprovedIngredient INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	
	ProductType INT NOT NULL FOREIGN KEY REFERENCES ProductTypes(ProductType),
	Ingredient INT NOT NULL FOREIGN KEY REFERENCES Ingredients(Ingredient),

	IsDemanded BIT NOT NULL DEFAULT 0,
	MaxUnits INT NOT NULL DEFAULT 3, 

	--Nycklar:
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
		CONSTRAINT UC_TypeCanHaveIngredients UNIQUE (ProductType,Ingredient), --Kandidatnyckel

	--
	);
CREATE TABLE TypeRestrictions(   --Kommentar: OtillåtnaBladningar

	Restriction INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	ProductType INT NOT NULL,
	ApprovedIngredient INT NOT NULL,
	CanotMixwith INT NOT NULL,

	--Nycklar:
		--
	--Beräknade attribut nedan
		--
	-- Referensattribut nedan

		---denna entitetstyp är weak entity
	    CONSTRAINT FK_TypeRestrictions_ApprovedIngredient FOREIGN KEY (ApprovedIngredient)
    		REFERENCES TypeCanHaveIngredients(ApprovedIngredient)
    		ON DELETE CASCADE
    		ON UPDATE CASCADE,

   		CONSTRAINT FK_TypeRestrictions_CanotMixwithIngredient FOREIGN KEY (CanotMixwith)
    		REFERENCES TypeCanHaveIngredients(ApprovedIngredient),

   		CONSTRAINT FK_TypeRestrictions_ProductType FOREIGN KEY (ProductType)
    		REFERENCES ProductTypes(ProductType)
    		ON DELETE CASCADE
    		ON UPDATE CASCADE,
	
	-- Extra Begränsningar nedan
		CONSTRAINT UC_TypeINGTypeRestriction_Ingredient UNIQUE (ProductType,ApprovedIngredient,CanotMixwith), --Kandidatnyckel
		--CONSTRAINT UC_TypeINGTypeRestriction_Ingredient21 UNIQUE (ProductType,Ingredient2,Ingredient1) --kommutativ Kandidatnyckel? Funkar detta?
	
	--CONSTRAINT UC_Approval (Approval) --Osäkert

	-- BEHÖVS EN CONSTRAINT FÖR ATT KOLLA KOMMUTATIVITET mellan I1 och I2 ! TODO
	--
	);

--Dessa två nedan är buggiga
CREATE TABLE ProductHaveIngredients(
	Reference INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	Product INT NOT NULL FOREIGN KEY REFERENCES Products(Product),
	Ingredient INT FOREIGN KEY REFERENCES Ingredients(Ingredient),
	
	-- Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	CONSTRAINT UC_OnePair_HAVEINGREDIENT UNIQUE (Product,Ingredient)

	-- -- SKA BEGRÄNSAS AV VILKA ingredienser den FÅR ha från ProductCanHave. Hur fixa detta? TODO
	-- 	CHECK ( Kolla ifall Ingredient finns i ProductCanHaveIngredients, ANNARS REJECT (dvs kolla ifall != ) )
	--
	);
CREATE TABLE ProductCanHaveIngredients(
	Reference INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	Product INT NOT NULL FOREIGN KEY REFERENCES Products(Product),
	Ingredient INT FOREIGN KEY REFERENCES Ingredients(Ingredient),	
	
	--Nycklar:
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
		CONSTRAINT UC_OnePair_CANHAVEINCREDIENT UNIQUE (Product,Ingredient)

	-- CHECK ( Finns Ingredient med i TypeCanHaveIngredient?
	-- 		)

	-- CHECK (Finns (Ingredient,X) med i TypeRestrictions? ISF REJECTA (dvs checka att != gäller ) )
	-- 		      -------------
	-- 		      Är tupler av alla möjliga kombinationer mellan Ingredient och övriga ingredients för denna Produkt)
	-- SKA BEGRÄNSAS AV VILKA ingredienser den FÅR ha från TypeRestriction. Hur fixa detta? TODO
	--
	);

------------------------------------------------------------------------
CREATE TABLE Choices(  --Hierarkisk struktur , Ger förhoppningsvis "menyträd"
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IsParentTo INT FOREIGN KEY REFERENCES Choices(id),
	IsSubTo INT FOREIGN KEY REFERENCES Choices(id),
	StringRep VARCHAR(20) NOT NULL DEFAULT 'UNNAMED-CHOICE',
	
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan

		CONSTRAINT  UC_edge UNIQUE (IsParentTo,IsSubTo)

	--
	);
CREATE TABLE PossibleCommandsInStationType( -- Bygger upp Choices med funktionalitet. Kopplar en Stored procedure/funktion till en choice (om det behövs)  

	MethodSignature INT IDENTITY(1,1) NOT NULL, -- ID

	StationType INT FOREIGN KEY REFERENCES StationTypes(StationType),
	Choice INT FOREIGN KEY REFERENCES Choices(Id),	
	ConnectedProcedure INT DEFAULT NULL, --blir en gÖR DEFAULT till 1, Stored Procedures ska länkas från en tabell.
	--Nycklar
		PRIMARY KEY (Choice,StationType)
		--
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);



------------------------------------------------------------------------
--------------------- HÅRDKODAT ----------------------------------------
------------FÖRSLAG TILL VIEWS, PROCEDURES OCH TRIGGERS-----------------


	--VIEWS - KOMIHÅG EXISTS, ALL (tuplekalkylens Existenskvantifikator)

	-- View för att se alla Orders - inklusive några beräknade kolonner
	-- View för att se alla 100 senaste ordrar.

	-- View för att "se alla rader i PRODUKTordrar" för en viss Order
	-- View för att se stuffings för en särskilt PRODUKTordrer
	-- View för att se alla PRODUKTordrar som är "Behandlade"
	-- View för att se alla PRODUKTordrar where "Låstavstation = null"


	-- View för att se alla Produkter för en viss produkttyp
	-- View för att se alla Employees av en viss type
	-- View för att se Stuffings i en särskild Produkt

	-- View för att se alla ingredienser som är tillåtna för en särskild produkt"
	-- View för att se alla ingredienser som är tillåtna för en särskild produkttyp"
	-- View för att se alla ingredienser som en produkt HAR"


	-- View Över alla byggnader
	-- View för att see alla stations i en viss Building
	-- View för att se alla stations för en viss stationtype
	-- View för att se alla customers i en viss building
	-- View för att se alla ordrar [PÅGÅENDE | FÄRDIGA] (och betalda) för infoscreen/köscreen
	-- En-Rads-VIew för att se Kvitto för en särskild order, med all viktig kvittoinfo.

	-- View för att se "ProduktOrder med Stuffingsklump" för särskild Station enligt Stationtypens krav.

	-- View över alla employees som jobbar i särskild station S
	-- View över alla employees som är inloggade
	-- View över alla Activatede/AvActivatede stationer

	-- Choices views
	-- View över en "Subs" för särskild "menynod".
	-- View över "Parents" för särskild "menynod"
------------------------------------------------------------------------
--Procedure

	--Procedures för att läggatill (eller tabort) whatever.. (en procedure för varje entitetstyp)
	-- Kan bli hur många som helst här...

	-------------ORDER PROCEDURES
	-- Procedure för att Skapa en ny tom order
	-- Procedure för att lägga in en produkt i en order.
	-- Procedure för att Ta bort ingrediens i en produktorder
	-- Procedure för att Lägga till Ingrediens i en produktorder.
	-- Procedure för att skapa en ny ..etc etc

	--många av dessa behövs inte då DATAGRID i winform kan användas istället, och uppdatera hela tabeller.

	------------ Management procedures
	-- För att lägga till användare (+en procedure för att ta bort)
	-- För att lägga till building
	-- För att lägga till station
	-- För att lägga till stationtype
	-- För att lägga till terminal
	-- För att lägga till produktype
	-- För att lägga till ingrediens
	--Kanske blir smartare med att bara använda DATAGRIDS på ett smart sätt. 
	------------------------------------------------------------------------

	-- Funktioner som räknar ut saker
	--Funktion som räknar ut värdet av alla betalda ordrar

------------------------------------------------------------------------
--Triggers
	-- Triggers Som kollar ifall Ingredient par redan finns Otillåtna blandningar
	-- Trigger som kollar ifall Employee Får jobba i station
	--etc

------------------------------------------------------------------------
--------------------------Alla INSERTS nedan ---------------------------
	--
	--

-- USE [G3Systems]
	-- GO

	-- INSERT INTO [dbo].[Buildings] ([Building] ,[BuildingName] ,[Activated] ,[Visible])
	--      VALUES(1,TonysPizzeria Huvud Pizzerian,1,1)
	-- GO

	-- INSERT INTO [dbo].[Buildings] ([Building] ,[BuildingName] ,[Activated] ,[Visible])
	--      VALUES(2,TonysPizzeria Östermalm,1,1)
	-- GO
	-- INSERT INTO [dbo].[Buildings] ([Building] ,[BuildingName] ,[Activated] ,[Visible])
	--      VALUES(3,TonysPizzeria Göteborg,1,1)
	-- GO


----------------------------------ROOT NODE---------------------------------------
GO
INSERT INTO Buildings (Building, BuildingNAme) VALUES (1,'TonysMainPizzaHouse');
----------------------------------------------------------------------------------

INSERT INTO Buildings (Building, BuildingNAme,Activated) VALUES (2,'Tonys UnderGroundPizza',0);
INSERT INTO Terminal (Building) VALUES (1);
INSERT INTO Terminal (Building) VALUES (1);
INSERT INTO Terminal (Building) VALUES (1);
INSERT INTO InfoScreen (Building) VALUES (1);
Go

INSERT INTO StationTypes (StationType, StationTypeName) VALUES (1,'Salladsbar');
INSERT INTO StationTypes (StationType, StationTypeName) VALUES (2,'BigPizzaStation');
INSERT INTO StationTypes (StationType, StationTypeName) VALUES (3,'IceCreamBar');
INSERT INTO StationTypes (StationType, StationTypeName) VALUES (4,'Cashier');
INSERT INTO StationTypes (StationType, StationTypeName) VALUES (5,'Office');
GO

INSERT INTO Station (StationType, Name, InBuilding) VALUES (1,'Mini Salladsbar',1);
INSERT INTO Station (StationType, Name, InBuilding) VALUES (2,'Corner PizzaStation',1);
INSERT INTO Station (StationType, Name, InBuilding) VALUES (3,'Quick IceCreamBar',1);
INSERT INTO Station (StationType, Name, InBuilding) VALUES (4,'Cashier 1',1);
INSERT INTO Station (StationType, Name, InBuilding) VALUES (4,'Cashier 2',1);
INSERT INTO Station (StationType, Name, InBuilding) VALUES (4,'Cashier 3',1);
INSERT INTO Station (StationType, Name, InBuilding) VALUES (5,'First Office',1);



INSERT INTO EmployeeTypes (EmployeeType, EmployeeTypeName) VALUES (1,'Kock');
INSERT INTO EmployeeTypes (EmployeeType, EmployeeTypeName) VALUES (2,'Pizzabaker');
INSERT INTO EmployeeTypes (EmployeeType, EmployeeTypeName) VALUES (3,'Cashier');
INSERT INTO EmployeeTypes (EmployeeType, EmployeeTypeName) VALUES (4,'Administrator');
GO


INSERT INTO Employees (Employee,Username) VALUES (1, 'GregTheadminGuy');
INSERT INTO Employees (Employee,Username) VALUES (2, 'LisaSimpson');
INSERT INTO Employees (Employee,Username) VALUES (3, 'BageyTheBaker');
INSERT INTO Employees (Employee,Username) VALUES (4, 'IceCreamExpert');
GO

INSERT INTO ProductTypes (ProductType, name) VALUES (1,'Pizza');
INSERT INTO ProductTypes (ProductType, name) VALUES (2,'Sallad');
INSERT INTO ProductTypes (ProductType, name) VALUES (3,'IceCream');
INSERT INTO ProductTypes (ProductType, name) VALUES (4,'Fresh Juice');
GO

INSERT INTO Products(ProductType, ProductName) VALUES (2,'Vesuvio');
INSERT INTO Products(ProductType, ProductName) VALUES (2,'KebabPizza');
INSERT INTO Products(ProductType, ProductName) VALUES (2,'Capricosa');
INSERT INTO Products(ProductType, ProductName) VALUES (1,'Kycklingsallad');
INSERT INTO Products(ProductType, ProductName) VALUES (1,'Ceasarsallad');


INSERT INTO Ingredients(IngredientName) VALUES ('Tomatsås');
INSERT INTO Ingredients(IngredientName) VALUES ('Salami');
INSERT INTO Ingredients(IngredientName) VALUES ('Kebabkött');
INSERT INTO Ingredients(IngredientName) VALUES ('Cheddar');
INSERT INTO Ingredients(IngredientName) VALUES ('Mozarella');
INSERT INTO Ingredients(IngredientName) VALUES ('Fefferoni');
INSERT INTO Ingredients(IngredientName) VALUES ('Ost');
INSERT INTO Ingredients(IngredientName) VALUES ('Ost');
