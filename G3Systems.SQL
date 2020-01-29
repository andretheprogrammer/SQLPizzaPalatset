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
------------------------------------------------------------------------
CREATE TYPE PINT FROM INT 
	default 0,
	CHECK(value >= 0);
CREATE TYPE DEFAULTNAMETYPE FROM varchar(50)  --Slipper kopiera villkor för namn
	default "Unnamed",
	CHECK (value NOT NULL);
CREATE TYPE STRICTBOOL FROM bit  -- Default True
	default 1,
	CHECK (value NOT NULL);
CREATE TYPE STRICTBOOLFALSE FROM bit  -- Default FALSE
	default 0,
	CHECK (value NOT NULL);
CREATE TYPE PERCENT FROM INT  -- Default True
	default 0,
	CHECK (value =< 100 AND value >=0);
--Potentiel inkapsling av ID-typer
	--CREATE DOMAIN IDTYPE AS INT  -- Default True
	--	CHECK (value NOT NULL),
	--	constraint UNIQUE (value);


BUGGG THIS TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

BUGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG


------------------------------------------------------------------------
--- SQL DEFINITIONSFILE ------------------------------------------------
------------------------------------------------------------------------
CREATE TABLE Buildings(
	Building INT NOT NULL, 
	BuildingName DEFAULTNAMETYPE,
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,

	--Nycklar:
	-- 
	-- Beräknade attribut nedan
	--TotalCash PINT, (SUM aggregat av alla betalda ordrar)

	--Referensattribut nedan
	-- 
	--Extra Begränsningar nedan
	--
	);


CREATE TABLE Terminals(
	Terminal INT NOT NULL,
	TerminalName DEFAULTNAMETYPE,
	Building INT FOREIGN KEY REFERENCES Buildings(Building),
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,

	--Nycklar:

	-- Beräknade attribut nedan
	--
	Ledig STRICTBOOL,
	-- Referensattribut nedan
	--
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Infoscreens(
	Id INT NOT NULL

	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,

	--Nycklar:

	-- Beräknade attribut nedan
	--
	-- Referensattribut nedan
	--
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE InfoScreenIsInBuilding(
	Reference INT NOT NULL,
	InfoScreen INT FOREIGN KEY REFERENCES InfoScreens(InfoScreen),
	Building INT FOREIGN KEY REFERENCES Buildings(Building),

	--Nycklar:

	-- INFOSCREEN
	-- BUILDING
	--Beräknade attribut nedan
	-- 
	--Referensattribut nedan
	--Extra Begränsningar nedan
	--
	);
CREATE TABLE QueuesShowsInInfoscreens(
	Reference INT NOT NULL
	QueueNumbers INT FOREIGN KEY REFERENCES QueueNumbers(Queue),

	InfoScreen INT FOREIGN KEY REFERENCES InfoScreens(InfoScreen),

	--Nycklar:
	-- BUILDING ??
	--Beräknade attribut nedan
	-- 
	--Referensattribut nedan
	--Extra Begränsningar nedan
	--
	)
CREATE TABLE Stations(
	Station INT NOT NULL
	StationName DEFAULTNAMETYPE,
	HasStationType INT FOREIGN KEY REFERENCES StationTypes(StationType),
	InBuilding INT,
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,
	
	--Nycklar:

	--Beräknade attribut nedan
	--
	--Referensattribut nedan
	-- STATIONTYPE: references stationtype-table
	-- INBUILDING: references building-table
	    CONSTRAINT FK_Building FOREIGN KEY (InBuilding)
    		REFERENCES Buildings(Building)
    		ON DELETE CASCADE
    		ON UPDATE CASCADE,
	--Extra Begränsningar nedan
	--
	);
CREATE TABLE StationTypes(
	StationType INT NOT NULL,
	StationTypeName ,
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,
	DangerLevel PINT

	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);

-- CREATE TABLE Persons
	-- (
	-- 	Person INT NOT NULL

	-- 	Wallet PINT,
	--  NAME DEFAULTNAMETYPE,
	--  AGE PINT,
	--  HP INT ,
	--		CHECK (HP >= 0 AND HP <= 100) 

	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	    --WEAPON --Kommer kräva en Product+ProductType för detta

	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- )
CREATE TABLE Customers(
	Customer INT NOT NULL,
	Wallet INT NOT NULL DEFAULT 1000,

	--Nycklar:
		PRIMARY KEY (Customer)

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan

	-- Extra Begränsningar nedan
	--);
CREATE TABLE Employees(
	Employee INT NOT NULL,
	LoggedIn bit NOT NULL DEFAULT 0, 
	
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,
	AssignedToStation INT FOREIGN KEY REFERENCES Stations(Station)
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE EmployeeType(
	EmployeeType INT NOT NULL
	EmployeeTypeName DEFAULTNAMETYPE,

	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,
	
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

CREATE TABLE EmployeesAreEmployeeTypes(
	Reference INT NOT NULL PRIMARY KEY,  -- N-N samband har "Reference" som kolumnheader istället för "Id"
	Employee INT NOT NULL FOREIGN KEY Employees(Employee),
	EmployeeType INT NOT NULL FOREIGN KEY EmployeeTypes(EmployeeType),

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE EmployeeTypeCanWorkInStationType(
	Id INT NOT NULL

	Employee INT NOT NULL FOREIGN KEY Employees(Employee),
	EmployeeType INT NOT NULL FOREIGN KEY EmployeeTypes(EmployeeType),
	StationType INT FOREIGN KEY REFERENCES StationTypes(StationType)

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE EmployeesHasOrdersInStations(
	Id INT NOT NULL


	

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);


CREATE TABLE Products(
	Product INT NOT NULL

	ProductName DEFAULTNAMETYPE, 
	ProductType INT NOT NULL,
	Description uchar(500),
	Tillagningstid PINT,  -- I sekunder

	BasPris PINT,

	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,

	--Nycklar
	PRIMARY KEY(Product),

	--Beräknade attribut nedan
	AckumuleratPris PINT,
	
	-- Referensattribut nedan
	FOREIGN KEY(ProductType) 
		REFERENCES ProductTypes(ProductType)
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE ProductTypes(
	ProductType INT NOT NULL
	ProductTypeName DEFAULTNAMETYPE,
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,

	
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE TypeIsMadeInStationType(    -- Kommentar: type Pizza tillverkas ej i Glassbar
	Reference INT NOT NULL


	--Nycklar
	
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Ingredients(
	Ingredient INT NOT NULL,
	IngredientName DEFAULTNAMETYPE,
	Pris PINT, 

	
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,

	
	-- Nycklar :

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE OrderTreatedByEmployeeAt(
	Treatment INT NOT NULL PRIMARY KEY,
	Employee INT FOREIGN KEY REFERENCES Employees(Employee),
	Station Int FOREIGN KEY REFERENCES Stations(Station),
	Order INT FOREIGN KEY REFERENCES Orders(Order),

	TreatmentTime DateTime,
	
	
	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,

	
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Orders
	(
	Order INT NOT NULL,
	--
	Betald bit NOT NULL DEFAULT 0,
	Avbruten bit NOT NULL DEFAULT 0,

	Aktiverad STRICTBOOL, --I princip alltid 1
	Synlig STRICTBOOL,  -- I princip alltid 1

	
	--Nycklar:
		PRIMARY KEY(Order),

	--Beräknade attribut nedan
	-- Status PERCENT,  - Beräknas genom ProduktOrder. % på antal färdiga produktordrar kopplade till denna order
	-- PriceTotal - Beräknas med hjälp av View som joinas in i tabellen
	
	-- Referensattribut nedan		
		QueueNR int FOREIGN KEY (QueueNr) REFERENCES QueueNumbers(Queue)
    	CONSTRAINT FK_QueueOrder 

	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE CustomerOrderedOrderInTerminal
	(
	Id INT NOT NULL,

	QueueNumber INT FOREIGN KEY QueueNumbers(QueueNumber),
	
	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE ProductOrders
	(
	ProductOrder INT NOT NULL
	Product Int,
	Order INT,
	LockedByStation Int FOREIGN KEY REFERENCES Stations(Station),
	
	Behandlad STRICTBOOL, 

	Aktiverad STRICTBOOL,
	Synlig STRICTBOOL,
	Betald STRICTBOOL,
	
	--Nycklar:

	--Beräknade attribut nedan
	-- ProductType Int -- joinas fram med ProductType tabellen för att ge ytterliggare en kolonn. Fås med view.
	-- Specialisering Int --Joinas fram. Visar om den har annorlunda ingredienser än vad Produkt brukar ha.

	-- Referensattribut nedan
    	CONSTRAINT FK_Product FOREIGN KEY (Product)
    		REFERENCES Products(Product),

    	CONSTRAINT FK_Order FOREIGN KEY (Order)
    		REFERENCES Orders(Order),

    	CONSTRAINT FK_Station FOREIGN KEY (LockedByStation)
    		REFERENCES Stations(Station),

	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE ProductOrdersHaveProducts 
	(
	ProductOrder INT NOT NULL


	--Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE QueueNumbers(
	Queue INT NOT NULL PRIMARY KEY,
	Order INT,
	Customer INT,
	--Nycklar:

	--Beräknade attribut nedan
	-- QueueMod100 INT NOT NULL,   --Kommer vara id mod100. Dvs beräknad

	-- Synlig STRICTBOOL, 			 --Beräknas utifrån "Order Färdig,betald "
								 	 --Blir false då order blir Upphämtad

	-- Referensattribut nedan
    	CONSTRAINT FK_Order FOREIGN KEY (Order)
    		REFERENCES Orders(Order)
    		ON DELETE CASCADE,
    		ON UPDATE CASCADE,
    	CONSTRAINT FK_Customer FOREIGN KEY (Customer)
    		REFERENCES Customers(Customer)
    		ON DELETE SET NULL,
    		ON UPDATE CASCADE,
	-- Extra Begränsningar nedan
	--
	);

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
	Lump INT NOT NULL PRIMARY KEY, -- Dvs , id, dvs objektet "en klump av ingredienser"

	ProductOrder INT NOT NULL,
	Ingredient FOREIGN KEY REFERENCES Ingredients(Ingredient),
	Antal INT NOT NULL,
	Locked STRICTBOOL,

	--Nycklar:
		CONSTRAINT FK_ProductOrder FOREIGN KEY REFERENCES ProductOrders(ProductOrder) 
		ON DELETE CASCADE, --weak entity är ON DELETE CASCADE
	
	--Beräknade attribut nedan
	-- 	ProductType - Ska fås direkt från (Produkten i) produktordern.
	
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	CONSTRAINT UC_POIngredient (ProductOrder,Ingredient)
	--
	);
CREATE TABLE TypeRestrictions(   --Kommentar: OtillåtnaBladningar

	Restriction INT NOT NULL PRIMARY KEY,

	Ingredient1 INT FOREIGN KEY REFERENCES Ingredients(Ingredient),
	Ingredient2 INT FOREIGN KEY REFERENCES Ingredients(Ingredient),

	-- Approval INT, 
	--Nycklar:
		--Osäkert
		--CONSTRAINT FK_CanHave FOREIGN KEY (Approval)
			--REFERENCES TypeCanHaveIngredients(Approval) 
			--ON DELETE CASCADE  --weak entity har alltid CASCADE
			--ON UPDATE CASCADE,
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	CONSTRAINT UC_TypeIngredient UNIQUE (Ingredient1,Ingredient2)
	--CONSTRAINT UC_Approval (Approval) --Osäkert

	-- BEHÖVS EN CONSTRAINT FÖR ATT KOLLA KOMMUTATIVITET mellan I1 och I2 ! TODO
	--
	);
CREATE TABLE TypeCanHaveIngredients(
	Approval INT NOT NULL PRIMARY KEY,
	ProductType INT NOT NULL FOREIGN KEY REFERENCES ProducTypes(ProductType),
	Ingredient INT FOREIGN KEY REFERENCES Ingredients(Ingredient),

	IsDemanded STRICTBOOL,
	MaxUnits PINT, 

	--Nycklar:
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);

--Dessa två nedan är buggiga
CREATE TABLE ProductHaveIngredients(
	Reference INT NOT NULL PRIMARY KEY,

	Product INT NOT NULL FOREIGN KEY REFERENCES Products(Product),
	Ingredient INT FOREIGN KEY REFERENCES Ingredients(Ingredient),
	
	-- Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
		CONSTRAINT UC_OnePair UNIQUE (Product,Ingredient)

	-- SKA BEGRÄNSAS AV VILKA ingredienser den FÅR ha från ProductCanHave. Hur fixa detta? TODO
	--
	);
CREATE TABLE ProductCanHaveIngredients(
	Reference INT NOT NULL PRIMARY KEY,

	Product INT NOT NULL FOREIGN KEY REFERENCES Products(Product),
	Ingredient INT FOREIGN KEY REFERENCES Ingredients(Ingredient),	
	
	--Nycklar:
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	CONSTRAINT UC_OnePair UNIQUE (Product,Ingredient)

	-- SKA BEGRÄNSAS AV VILKA ingredienser den FÅR ha från TypeRestriction. Hur fixa detta? TODO
	--
	);


------------------------------------------------------------------------

CREATE TABLE Choices(  --Hierarkisk struktur , Ger förhoppningsvis "menyträd"
	Id INT NOT NULL,
	IsParentTo FOREIGN KEY REFERENCES Choices(id),
	IsSubTo FOREIGN KEY REFERENCES Choices(id),
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan

		CONSTRAINT  UC_edge UNIQUE (IsParentTo,IsSubTo)

	--
	);
CREATE TABLE PossibleCommandsInStationType( -- Bygger upp Choices med funktionalitet. Kopplar en Stored procedure/funktion till en choice (om det behövs)  

	Method Int NOT NULL -- ID

	StationType INT FOREIGN KEY REFERENCES StationTypes(StationType),
	Choice INT FOREIGN KEY REFERENCES Choices(Choice),	

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
	-- View över alla aktiverade/Avaktiverade stationer

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
	--
