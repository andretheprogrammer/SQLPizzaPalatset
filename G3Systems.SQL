------------------------------------------------
--------- G3 SYSTEMS ---------------------------
	------------------------------------------------
	-----SKAPAT AV HARIZ@KTH.se 2020 ---------------
	---- NEWTONS YRKESHÖGSKOLA ---------------------
	---- PROJEKTARBETE TILL DATABASKURSEN-----------
	------------------------------------------------
	------------------------------------------------

------------------------------------------------------------------------
	-----KVAR ATT GÖRA------------------------------------------------------
	-- Sätt cascade överallt

	---Sätt in alla Nycklar i nyckelraden
	-- Sätt in alla referensattribut i referensattributraden, Så det blir snyggt uppdelat

	-- Skapa dom viktigaste viewsen . Dvs maintabellerna (tabell+aggregatkolonner. Tex Total cash i BuildingID)
	------------------------------------------------------------------------
------------------------------------------------------------------------

------------------------------------------------------------------------
--- SQL DEFINITIONSFILE ------------------------------------------------
------------------------------------------------------------------------


--------------- WARNING
-- DENNA FIL TAR BORT DATABAS SOM HETER G3Systems- 
	USE [master]
	GO
	ALTER DATABASE [G3Systems] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
	GO
	USE [master]
	GO
	DROP DATABASE [G3Systems]
	GO
	----------- WARNING

	--Skapas en helt ny Tom G3Systems Databas.
	GO 
	USE [master]
	GO
	Create Database G3Systems
	GO
	USE G3Systems
	GO

CREATE TABLE Buildings(
	BuildingID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
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
	TerminalID INT IDENTITY(1,1)  NOT NULL PRIMARY KEY,
	TerminalName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	BuildingID INT FOREIGN KEY REFERENCES Buildings(BuildingID),
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	--Nycklar:

	-- Beräknade attribut nedan
	--
	Available BIT NOT NULL DEFAULT 1,
	-- Referensattribut nedan
	--
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Infoscreens(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	BuildingID INT FOREIGN KEY REFERENCES Buildings(BuildingID),

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
CREATE TABLE StationTypes(
	StationTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
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
	StationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	StationName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED',
	StationTypeID INT FOREIGN KEY REFERENCES StationTypes(StationTypeID),
	InBuilding INT,
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	
	--Nycklar:

	--Beräknade attribut nedan
	--
	--Referensattribut nedan
	-- StationTypeID: references StationTypeID-table
	-- INBUILDING: references BuildingID-table
	    CONSTRAINT FK_Stations_Buildings FOREIGN KEY (InBuilding)
    		REFERENCES Buildings(BuildingID)
    		ON DELETE CASCADE
    		ON UPDATE CASCADE,
	--Extra Begränsningar nedan
	--
	);
CREATE TABLE Employees(
	EmployeeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Username VARCHAR(20) NOT NULL,
	[Password] VARCHAR(20) NOT NULL DEFAULT ROUND(RAND() * 100000, 0), 
	
	LoggedIn bit NOT NULL DEFAULT 0, 
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	AssignedToStation INT NOT NULL DEFAULT 1 FOREIGN KEY REFERENCES Stations(StationID),
	--Nycklar:
		CONSTRAINT UC_EmployeeUsername UNIQUE Username, --Kandidatnyckel

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
		--#Todo
			-- Check ( 
			-- 		((LoggedIn =1 AND AssignedToStation IS NOT Null ) OR 
			-- 		(LoggedIn =0 AND AssignedToStation IS Null) )
			-- 		AND
			-- 			-- Bara tillåtna kombinationer av Loggedin, Activated och assigned till StationID ska anges här
			-- 		--(Man får ej vara Icke-Activated och inloggad) (hur skriva dettA?)
			-- 	  )
	--
	);
CREATE TABLE EmployeeTypes(
	EmployeeTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
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
-- CREATE TABLE EmployeesAreWorkingInStation
	-- (

	-- 	EmployeeID INT NOT NULL FOREIGN KEY Employees(EmployeeID),
	-- 	StationID INT NOT NULL FOREIGN KEY Employees(EmployeeID),

		
	-- 	--Nycklar:

	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- )
CREATE TABLE Orders(
	OrderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ByTerminal INT NOT NULL FOREIGN KEY REFERENCES Terminals(TerminalID),

	Paid bit NOT NULL DEFAULT 0,
	Canceled bit NOT NULL DEFAULT 0,
	PickedUp bit NOT NULL DEFAULT 0,
	ShowOnScreen bit NOT NULL DEFAULT 1,
	HappyCustomer bit NOT NULL DEFAULT 1,
	Returned bit NOT NULL DEFAULT 0,
	
	Activated BIT NOT NULL DEFAULT 1, --I princip alltid 1
	Visible BIT NOT NULL DEFAULT 1,  -- I princip alltid 1

	--Beräknade attribut nedan
		-- Status PERCENT,  - Beräknas genom ProduktOrder. % på Quantity färdiga produktordrar kopplade till denna order
		-- PriceTotal - Beräknas med hjälp av View som joinas in i tabellen
	-- Referensattribut nedan:		
		-- CONSTRAINT FK_QueueOrder FOREIGN KEY (QueueNr) REFERENCES QueueNumbers(QueueNumber) -- MÖJLIGT VIS SKRÄP #TODO
	
	-- Extra Begränsningar nedan
		--Validerar
		CONSTRAINT CHK_ORDERS_OrderValidering   
	    	CHECK 
	    		(
					(PickedUp 	=0 or (Paid=1 AND Canceled =0 AND Returned=0))
					AND
					(Paid 		=0 or (Canceled=0) )
					AND
					(Canceled 	=0 OR (PickedUp=0 AND Returned=0) )
					AND
					(Returned 	=0 OR (PickedUp=0) )
									
				)
	);
CREATE TABLE EmployeesAreEmployeeTypes(
	--Reference INT IDENTITY(1,1) NOT NULL,  -- N-N samband har "Reference" som kolumnheader istället för "ID"
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employees(EmployeeID),
	EmployeeTypeID INT NOT NULL FOREIGN KEY REFERENCES EmployeeTypes(EmployeeTypeID) ,

	--Nycklar
	PRIMARY KEY (EmployeeID, EmployeeTypeID)
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE EmployeeTypeCanWorkInStationType(
	--Glöm inte bort att ha använda assert i källtabellen
	--ID INT NOT NULL IDENTIFIER(1,1) , 			--Onödigt skrot men standard att ha ID.
	EmployeeTypeID INT NOT NULL FOREIGN KEY REFERENCES EmployeeTypes(EmployeeTypeID),
	StationTypeID INT FOREIGN KEY REFERENCES StationTypes(StationTypeID)


	--Nycklar
	PRIMARY KEY (EmployeeTypeID,StationTypeID)

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE ProductTypes(
	ProductTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
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
	ProductID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ProductTypeID INT NOT NULL,

	ProductName VARCHAR(50) NOT NULL DEFAULT 'UNNAMED', 
	[Description] varchar(500) DEFAULT 'No Description',
	PrepTime INT NOT NULL DEFAULT 500,  -- I sekunder
	BasePrice INT NOT NULL DEFAULT 100,
	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,

	--Nycklar
	--Beräknade attribut nedan
	--AckumuleratPrice INT NOT NULL,
	
	-- Referensattribut nedan
	CONSTRAINT FK_Products_ProductTypes FOREIGN KEY (ProductTypeID) 
		REFERENCES ProductTypes(ProductTypeID),
	-- Extra Begränsningar nedan
	CONSTRAINT  UC_Products_NameTypeCombo UNIQUE (ProductName,ProductTypeID) --"Högst en unnamed per type."

	--
	);
CREATE TABLE TypeIsMadeInStationType(    -- Kommentar: type Pizza tillverkas ej i Glassbar
	--Glöm inte att använda Assert i andra tabeller nu.
	-- Reference INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,

	ProductTypeID INT NOT NULL FOREIGN KEY REFERENCES ProductTypes(ProductTypeID),
	StationTypeID INT FOREIGN KEY REFERENCES StationTypes(StationTypeID),
	--Nycklar
	PRIMARY KEY (ProductTypeID,StationTypeID)
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);
CREATE TABLE Ingredients(
	IngredientID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
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
	EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
	StationID Int FOREIGN KEY REFERENCES Stations(StationID),
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),

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
CREATE TABLE ProductOrders
	(
	ProductOrderID INT IDENTITY(1,1) NOT NULL,
	ProductID Int NOT NULL, 											--FK
	OrderID INT NOT NULL, 											--FK
	LockedByStation Int,    --FK
	
	Processed BIT DEFAULT 0 NOT NULL, 

	Activated BIT NOT NULL DEFAULT 1,
	Visible BIT NOT NULL DEFAULT 1,
	
	--Nycklar
		primary key (ProductOrderID, ProductID),
	--Beräknade attribut nedan
	-- ProductTypeID Int -- joinas fram med ProductTypeID tabellen för att ge ytterliggare en kolonn. Fås med view.
	-- Specialisering Int --Joinas fram. Visar om den har annorlunda ingredienser än vad Produkt brukar ha.

	-- Referensattribut nedan
    	CONSTRAINT FK_ProductOrders_Product FOREIGN KEY (ProductID)
    		REFERENCES Products(ProductID),

    	CONSTRAINT FK_ProdctOrders_Orders FOREIGN KEY (OrderID)
    		REFERENCES Orders(OrderID),

    	CONSTRAINT FK_ProductOrders_Station FOREIGN KEY (LockedByStation)
    		REFERENCES Stations(StationID),

	-- Extra Begränsningar nedan
		--An order can be locked by one StationID at the time.
		--CONSTRAINT UC_ProductOrders_LockedByStation UNIQUE(LockedByStation),
		CONSTRAINT UC_ProductOrders_ID UNIQUE(ProductOrderID)
	--
	);
CREATE UNIQUE INDEX  UC_ProductOrders_LockedByStation ON ProductOrders(LockedByStation) WHERE LockedByStation IS NOT NULL;
-- EXTREMT SANNOLIKT ONÖDIG. - FIXA ProductOrderID-Tabellen istället, ty ProductOrderID (N-1) ProductID	
-- CREATE TABLE ProductOrdersHaveProducts 
	-- 	(
	-- 	ProductOrderID INT NOT NULL FOREIGN KEY REFERENCES ProductOrders(ProductOrderID),
	-- 	ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID)



	-- 	--Nycklar:

	-- 		CONSTRAINT PK_Person PRIMARY KEY (ProductOrderID,ProductID); 
	-- 	--Beräknade attribut nedan
	-- 	--
	-- 	-- Referensattribut nedan
	-- 	-- Extra Begränsningar nedan
	-- 	--
	-- 	);

CREATE TABLE Stuffings(
	Lump INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Dvs , ID, dvs objektet "en klump av ingredienser"

	ProductOrderID INT NOT NULL,
	IngredientID INT FOREIGN KEY REFERENCES Ingredients(IngredientID),
	Quantity INT NOT NULL,  						--Checka att den är >1 #TODO

	--Nycklar:
		CONSTRAINT FK_Stuffings_ProductOrder FOREIGN KEY (ProductOrderID)
			REFERENCES ProductOrders(ProductOrderID) 
			ON DELETE CASCADE, --weak entity är ON DELETE CASCADE
	
	--Beräknade attribut nedan
	-- ProductTypeID 									-- Ska fås direkt från (Produkten i) produktordern.
	-- Locked BIT,				--Blir låst när Dens Order är låst (aggregat)

	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	CONSTRAINT UC_POIngredient UNIQUE(ProductOrderID,IngredientID)
	--
	);

--TA BORT DENNA???
CREATE TABLE EmployeesHaveProductOrdersLockedInStations(
	--ID INT IDENTIFIER(1,1) NOT NULL, 			--Onödigt skrot men standard att ha ID.
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employees(EmployeeID),
	ProductOrderID INT NOT NULL FOREIGN KEY REFERENCES ProductOrders(ProductOrderID),
	StationID INT NOT NULL FOREIGN KEY REFERENCES Stations(StationID),

	
	--Nycklar
	PRIMARY KEY (EmployeeID, ProductOrderID,StationID),
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	--
	);

CREATE TABLE TypeCanHaveIngredients(
	ApprovedIngredient INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ProductTypeID INT NOT NULL FOREIGN KEY REFERENCES ProductTypes(ProductTypeID),
	IngredientID INT NOT NULL FOREIGN KEY REFERENCES Ingredients(IngredientID),
	IsDemanded BIT NOT NULL DEFAULT 0,
	MaxUnits INT NOT NULL DEFAULT 3, 

	--Nycklar:
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
		CONSTRAINT UC_TypeCanHaveIngredients UNIQUE (ProductTypeID,IngredientID), --Kandidatnyckel

	--
	);
--Ej normaliserat 3e nivån. Produkttypen behölls här för att bevara min sanity. (Ty Nyckeln i TypeCanHaveIngredient är delmängd i nyckel för TypeRestriction.)
CREATE TABLE TypeRestrictions(   --Kommentar: OtillåtnaBladningar

	Restriction INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	ProductTypeID INT NOT NULL,
	ApprovedIngredient INT NOT NULL,
	CannotMixwith INT NOT NULL,

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

   		CONSTRAINT FK_TypeRestrictions_CannotMixwithIngredient FOREIGN KEY (CannotMixwith)
    		REFERENCES TypeCanHaveIngredients(ApprovedIngredient),

   		CONSTRAINT FK_TypeRestrictions_ProductType FOREIGN KEY (ProductTypeID)
    		REFERENCES ProductTypes(ProductTypeID)
    		ON DELETE CASCADE
    		ON UPDATE CASCADE,
	
	-- Extra Begränsningar nedan
		CONSTRAINT UC_TypeINGTypeRestriction_Ingredient UNIQUE (ProductTypeID,ApprovedIngredient,CannotMixwith), --Kandidatnyckel
		--CONSTRAINT UC_TypeINGTypeRestriction_Ingredient21 UNIQUE (ProductTypeID,Ingredient2,Ingredient1) --kommutativ Kandidatnyckel? Funkar detta?
	
	--CONSTRAINT UC_Approval (Approval) --Osäkert

	-- BEHÖVS EN CONSTRAINT FÖR ATT KOLLA KOMMUTATIVITET mellan I1 och I2 ! TODO
	--
	);
--Dessa två nedan är buggiga
CREATE TABLE ProductHaveIngredients(
	Reference INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
	IngredientID INT FOREIGN KEY REFERENCES Ingredients(IngredientID),
	
	-- Nycklar:

	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
	CONSTRAINT UC_OnePair_HAVEINGREDIENT UNIQUE (ProductID,IngredientID)

	-- -- SKA BEGRÄNSAS AV VILKA ingredienser den FÅR ha från ProductCanHave. Hur fixa detta? TODO
	-- 	CHECK ( Kolla ifall IngredientID finns i ProductCanHaveIngredients, ANNARS REJECT (dvs kolla ifall != ) )
	--
	);
CREATE TABLE ProductCanHaveIngredients(
	Reference INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
	IngredientID INT FOREIGN KEY REFERENCES Ingredients(IngredientID),	
	
	--Nycklar:
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan
		CONSTRAINT UC_OnePair_CANHAVEINCREDIENT UNIQUE (ProductID,IngredientID)

	-- CHECK ( Finns IngredientID med i TypeCanHaveIngredient?
	-- 		)

	-- CHECK (Finns (IngredientID,X) med i TypeRestrictions? ISF REJECTA (dvs checka att != gäller ) )
	-- 		      -------------
	-- 		      Är tupler av alla möjliga kombinationer mellan IngredientID och övriga ingredients för denna Produkt)
	-- SKA BEGRÄNSAS AV VILKA ingredienser den FÅR ha från TypeRestriction. Hur fixa detta? TODO
	--
	);

------------------------------------------------------------------------
CREATE TABLE Choices(  --Hierarkisk struktur , Ger förhoppningsvis "menyträd"
	ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	--IsParentTo INT FOREIGN KEY REFERENCES Choices(ID),
	IsSubTo INT FOREIGN KEY REFERENCES Choices(ID),
	StringRep VARCHAR(100) DEFAULT 'UNNAMED-CHOICE',
	Description VARCHAR(500) DEFAULT NULL,
	
	--Beräknade attribut nedan
	--
	-- Referensattribut nedan
	-- Extra Begränsningar nedan

		--CONSTRAINT  UC_edge UNIQUE (IsSubTo)

	--
	);
CREATE TABLE PossibleCommandsInStationType( -- Bygger upp Choices med funktionalitet. Kopplar en Stored procedure/funktion till en choice (om det behövs)  

	MethodSignature INT IDENTITY(1,1) NOT NULL, -- ID

	StationTypeID INT FOREIGN KEY REFERENCES StationTypes(StationTypeID),
	Choice INT FOREIGN KEY REFERENCES Choices(ID),	
	ConnectedProcedure INT DEFAULT NULL, --blir en gÖR DEFAULT till 1, Stored Procedures ska länkas från en tabell.
	--Nycklar
		PRIMARY KEY (Choice,StationTypeID)
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
	-- View för att see alla stations i en viss BuildingID
	-- View för att se alla stations för en viss StationTypeID
	-- View för att se alla customers i en viss BuildingID
	-- View för att se alla ordrar [PÅGÅENDE | FÄRDIGA] (och betalda) för infoscreen/köscreen
	-- En-Rads-VIew för att se Kvitto för en särskild order, med all viktig kvittoinfo.

	-- View för att se "ProduktOrder med Stuffingsklump" för särskild StationID enligt Stationtypens krav.

	-- View över alla employees som jobbar i särskild StationID S
	-- View över alla employees som är inloggade
	-- View över alla Activatede/AvActivatede stationer

	-- Choices views
	-- View över en "Subs" för särskild "menynod".
	-- View över "Parents" för särskild "menynod"
------------------------------------------------------------------------
--Procedure

	--Employee login
		GO
		CREATE PROC Proc_VerifyLogin
			@Username varchar(20),
			@Password varchar(20)
		as
		begin
			SELECT EmployeeID, Username FROM Employees WHERE
			CAST(Username as varbinary(100)) = CAST(@Username as varbinary(100))
			AND CAST([Password] as varbinary(100)) = CAST(@Password as varbinary(100))
			AND Username = @Username 
			AND [Password] = @Password
		end
		GO

	--Update Employee
		Create Proc Proc_UpdateEmployeeStatus
			@EmployeeID int,
			@LoggedIn bit,
			@AssignedToStation int = null
		AS
		Begin
			Update Employees
			Set LoggedIn = @LoggedIn,
				AssignedToStation = @AssignedToStation
			Where EmployeeID = @EmployeeID;
		End
		GO

	--Product Ingredients
		Create proc Proc_GetProductHaveIngredients
			@ProductID int
		AS
		Begin
			SELECT * FROM Ingredients as I
			JOIN ProductHaveIngredients as PHI
			ON PHI.IngredientID = I.IngredientID
			WHERE PHI.ProductID = @ProductID
		End
		GO

		Create proc Proc_GetProductCanHaveIngredients
			@ProductID int
		AS
		Begin
			SELECT * FROM Ingredients as I
			JOIN ProductCanHaveIngredients as PCHI
			ON PCHI.IngredientID = I.IngredientID
			WHERE PCHI.ProductID = @ProductID
		End
		GO

	--Create Order
		CREATE Proc Proc_NewOrder
			@TerminalID int,
			@OrderID int = 0 OUTPUT
		AS
			Begin
				insert into Orders (ByTerminal)
				values (@TerminalID);
				set @OrderID = SCOPE_IDENTITY();
			End
		GO

		CREATE PROC Proc_InsertProductOrders
			@OrderID int,
			@ProductID int,
			@IngredientID int,
			@Quantity int
		AS
		Begin
			declare @ProductOrderID int;

			-- ProductOrder
			Select @ProductOrderID = P.ProductOrderID From ProductOrders AS P
			Where @OrderID = P.OrderID 
			AND @ProductID = P.ProductID
			AND NOT EXISTS(
				Select PO.* From Stuffings AS PO
				Where PO.ProductOrderID = P.ProductOrderID
				AND @IngredientID = PO.IngredientID);

			if @ProductOrderID is null
			Begin
				insert into ProductOrders(ProductID, OrderID)
				values (@ProductID, @OrderID);
				select @ProductOrderID = SCOPE_IDENTITY();
			End
						
			-- Stuffing
			if @IngredientID is not null
			Begin
				Begin
					insert into Stuffings(ProductOrderID, IngredientID, Quantity)
					values (@ProductOrderID, @IngredientID, @Quantity);
				End
			End
		End
		GO

	--Update order
		Create Proc Proc_UpdateOrderStatus
			@OrderID int,
			@Paid int = 0,
			@Canceled int = 0,
			@PickedUp int = 0,
			@Returned int = 0
		AS
		Begin
			Update Orders
			Set Paid = @Paid,
				Canceled = @Canceled,
				PickedUp = @PickedUp,
				Returned = @Returned
			Where OrderID = @OrderID;
		End
		GO

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
	-- För att lägga till BuildingID
	-- För att lägga till StationID
	-- För att lägga till StationTypeID
	-- För att lägga till TerminalID
	-- För att lägga till produktype
	-- För att lägga till ingrediens
	--Kanske blir smartare med att bara använda DATAGRIDS på ett smart sätt. 
	------------------------------------------------------------------------

	-- Funktioner som räknar ut saker
	--Funktion som räknar ut värdet av alla betalda ordrar

------------------------------------------------------------------------
--Triggers
	-- Triggers Som kollar ifall IngredientID par redan finns Otillåtna blandningar
	-- Trigger som kollar ifall EmployeeID Får jobba i StationID
	--etc

------------------------------------------------------------------------
--------------------------Alla INSERTS nedan ---------------------------
--Initials
	GO

	SET IDENTITY_INSERT Buildings ON
		INSERT INTO Buildings (BuildingID, BuildingNAme) VALUES (1,'TonysMainPizzaHouse');
		INSERT INTO Buildings (BuildingID, BuildingNAme, Activated) VALUES (2,'Tonys UnderGroundPizza',0);
	SET IDENTITY_INSERT Buildings OFF
	GO

	INSERT INTO Terminals(BuildingID) VALUES (1);
	INSERT INTO Terminals(BuildingID) VALUES (1);
	INSERT INTO Terminals(BuildingID) VALUES (1);
	INSERT INTO InfoScreens(BuildingID) VALUES (1);
	Go
------------------------------------------------------------------------
--Stationtypes
	SET IDENTITY_INSERT StationTypes ON
		INSERT INTO StationTypes (StationTypeID, StationTypeName) VALUES (1,'Salladsbar');
		INSERT INTO StationTypes (StationTypeID, StationTypeName) VALUES (2,'BigPizzaStation');
		INSERT INTO StationTypes (StationTypeID, StationTypeName) VALUES (3,'IceCreamBar');
		INSERT INTO StationTypes (StationTypeID, StationTypeName) VALUES (4,'Cashier');
		INSERT INTO StationTypes (StationTypeID, StationTypeName) VALUES (5,'Office');
	SET IDENTITY_INSERT StationTypes OFF

	GO
--Stations
		INSERT INTO Stations (StationTypeID, StationName, InBuilding) VALUES (1,'Mini SaladBar',1);
		INSERT INTO Stations (StationTypeID, StationName, InBuilding) VALUES (2,'Corner PizzaStation',1);
		INSERT INTO Stations (StationTypeID, StationName, InBuilding) VALUES (3,'Quick IceCreamBar',1);
		INSERT INTO Stations (StationTypeID, StationName, InBuilding) VALUES (4,'Cashier 1',1);
		INSERT INTO Stations (StationTypeID, StationName, InBuilding) VALUES (4,'Cashier 2',1);
		INSERT INTO Stations (StationTypeID, StationName, InBuilding) VALUES (4,'Cashier 3',1);
		INSERT INTO Stations (StationTypeID, StationName, InBuilding) VALUES (5,'First Office',1);
--EmployeeTypes
	SET IDENTITY_INSERT EmployeeTypes ON
		INSERT INTO EmployeeTypes (EmployeeTypeID, EmployeeTypeName) VALUES (1,'Chef');
		INSERT INTO EmployeeTypes (EmployeeTypeID, EmployeeTypeName) VALUES (2,'Pizzabaker');
		INSERT INTO EmployeeTypes (EmployeeTypeID, EmployeeTypeName) VALUES (3,'Cashier');
		INSERT INTO EmployeeTypes (EmployeeTypeID, EmployeeTypeName) VALUES (4,'Administrator');
		INSERT INTO EmployeeTypes (EmployeeTypeID, EmployeeTypeName) VALUES (5,'Incompetent');
	SET IDENTITY_INSERT EmployeeTypes OFF
	GO

	GO
--EType-2-StatType
	INSERT INTO EmployeeTypeCanWorkInStationType (EmployeeTypeID, StationTypeID) VALUES (1,1);
	INSERT INTO EmployeeTypeCanWorkInStationType (EmployeeTypeID, StationTypeID) VALUES (1,2);
	INSERT INTO EmployeeTypeCanWorkInStationType (EmployeeTypeID, StationTypeID) VALUES (1,3);
	INSERT INTO EmployeeTypeCanWorkInStationType (EmployeeTypeID, StationTypeID) VALUES (1,4);
	INSERT INTO EmployeeTypeCanWorkInStationType (EmployeeTypeID, StationTypeID) VALUES (2,2);
	INSERT INTO EmployeeTypeCanWorkInStationType (EmployeeTypeID, StationTypeID) VALUES (3,4);
	INSERT INTO EmployeeTypeCanWorkInStationType (EmployeeTypeID, StationTypeID) VALUES (4,5);
	GO
--Employees	
	SET IDENTITY_INSERT Employees on
		INSERT INTO Employees (EmployeeID,Username, [Password]) VALUES (1, 'Admin', 123);
		INSERT INTO Employees (EmployeeID,Username) VALUES (2, 'LisaCashier');
		INSERT INTO Employees (EmployeeID,Username) VALUES (3, 'BageyTheBaker');
		INSERT INTO Employees (EmployeeID,Username) VALUES (4, 'IceyTheIceman');
	SET IDENTITY_INSERT Employees OFF

	GO
--Emp-2-EmpType
	INSERT INTO EmployeesAreEmployeeTypes (EmployeeID,EmployeeTypeID) VALUES (1, 4);
	INSERT INTO EmployeesAreEmployeeTypes (EmployeeID,EmployeeTypeID) VALUES (2, 3);
	INSERT INTO EmployeesAreEmployeeTypes (EmployeeID,EmployeeTypeID) VALUES (3, 2);
	INSERT INTO EmployeesAreEmployeeTypes (EmployeeID,EmployeeTypeID) VALUES (4, 1);
	GO
--Producttypes
	SET IDENTITY_INSERT ProductTypes ON
		INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES (1,'Pizza');
		INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES (2,'Sallad');
		INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES (3,'IceCream');
		INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES (4,'Fresh Juice');
		INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES (5,'Drinks');
		INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES (6,'Extras');
	SET IDENTITY_INSERT ProductTypes OFF

	GO
--Products
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'Vesuvio'); --1
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'KebabPizza'); --2
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'Capricosa');--3
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'Mexicana');--4
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (2,'ChickenSalad');--5
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (2,'CeasarSalad'); --6
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'Bolognese');--7
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'Calzone');--8
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'Hawaii');--9
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'QuattroFormaggio');--10
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (1,'Marinara');--11
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (2,'FetaSalad');--12
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (5,'CocaCola');--13
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (5,'Sprite');--14
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (5,'Fanta');--15
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (5,'Red Bull');--16
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (6,'PommesFrites');--17
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (6,'FriedChicken');--18
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (3,'Magnum Almond'); --19
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (3,'Sandwich'); --20
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (3,'Solero'); --21
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (3,'Twister'); --22
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (3,'Igloo'); --23
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (4,'OrangeJuice'); --24
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (4,'AppleJuice'); --25
	INSERT INTO Products(ProductTypeID, ProductName) VALUES (4,'GamerJuice'); --26
	INSERT INTO Products(ProductTypeID, ProductName,Activated) VALUES (5,'CocaCola Strawberrytaste',0);--27

	GO
--PType-2-StatType
	INSERT INTO TypeIsMadeInStationType(ProductTypeID, StationTypeID) VALUES (1,2);
	INSERT INTO TypeIsMadeInStationType(ProductTypeID, StationTypeID) VALUES (2,1);
	INSERT INTO TypeIsMadeInStationType(ProductTypeID, StationTypeID) VALUES (3,3);
	INSERT INTO TypeIsMadeInStationType(ProductTypeID, StationTypeID) VALUES (4,3);
	INSERT INTO TypeIsMadeInStationType(ProductTypeID, StationTypeID) VALUES (5,5);
	INSERT INTO TypeIsMadeInStationType(ProductTypeID, StationTypeID) VALUES (6,5);
--Ingredienser
	SET IDENTITY_INSERT Ingredients ON
		
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (1,'Salami');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (2,'Kebabkött');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (3,'Cheddar');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (4,'Mozarella');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (5,'Fefferoni');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (6,'Gräddost');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (7,'Amerikansk Deg');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (8,'Italiensk Deg');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (9,'Extra Snabb Tillagning');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (10,'Kycklingfilé');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (11,'Ostkub');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (12,'KoktPasta');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (13,'Bulgur');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (14,'Snuspåse');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (15,'Oliver');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (16,'Ananas');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (17,'Tonfisk');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (18,'Gul Lök');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (19,'Championer');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (20,'Tomatsås');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (21,'Skinka');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (22,'Ruccola');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (23,'Tacosås');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (24,'Gräddfil');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (25,'Avocado');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (26,'Paprika');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (27,'Köttfärs');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (28,'Chilisås');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (29,'Isbergssallad');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (30,'Röd Lök');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (31,'Rhode Island dressing');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (32,'Vinägrett');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (33,'Vitlöksdressing');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (34,'Vitlökssås');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (35,'Bearnaise');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (36,'Vitlök');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (37,'Persilja');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (38,'Ceasardressing');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (39,'Räkor');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (40,'Ägg');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (41,'Spenat');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (42,'Kronärtskocka');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (43,'Fetaost');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (44,'Musslor');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (45,'Bacon');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (46,'Parmaskinka');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (47,'Parmesanost');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (48,'Gurka');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (49,'Färska Tomater');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (50,'Grön Chili');
		INSERT INTO Ingredients(IngredientID,IngredientName) VALUES (51,'TacoMix');




	SET IDENTITY_INSERT Ingredients OFF
	GO
--Pizza pålägg TILLÅTNA
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,1);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,2);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,3);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,4);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,5);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,6);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,7);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,8);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,9);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,15);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,16);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,17);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,18);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,19);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,20);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,21);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,22);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,23);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,24);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,25);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,26);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,27);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,28);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,30);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,34);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,35);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,36);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,37);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,39);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,40);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,41);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,42);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,43);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,44);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,45);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,46);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,47);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,49);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,50);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (1,51);
--SalladPålägg TILLÅTNA
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,2);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,4);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,5);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,9);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,10);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,11);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,12);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,13);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,15);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,16);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,17);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,18);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,19);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,21);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,22);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,25);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,26);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,29);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,30);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,31);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,32);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,33);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,36);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,37);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,38);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,39);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,40);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,41);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,42);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,43);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,45);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,46);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,48);
	INSERT INTO TypeCanHaveIngredients(ProductTypeID, IngredientID) VALUES (2,49);

--Ej Tillåtna blandningar på pizzor
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (1,1,2);  --salami och kebabkött
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (1,2,17); --kebabkött och tonfisk
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (1,7,8);  --Amerikanskdeg och Italienskdeg
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (2,31,32);
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (2,32,33);
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (2,38,32);
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (2,38,33);
	INSERT INTO TypeRestrictions(ProductTypeID, ApprovedIngredient, CannotMixWith) VALUES (2,44,10);
	

--Choices Tree (Kommer kanske komma till nytta någon gång)
	SET IDENTITY_INSERT Choices ON
		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (1,null,'root');
		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (2,1, 'Login Choices');
		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (3,2, 'Login Choices1');
		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (4,2, 'Login Choices2');
		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (5,2, 'Login Choices3');
		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (6,2, 'Login Choices4');


		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (7,1, 'CustomerMainChoices');
		

		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (8,1, 'CashierChoices');


		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (9,1, 'Administrator Choices');
		

		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (10,1, 'PizzaBaker MainChoices');
		

		INSERT INTO Choices(ID, IsSubTo, StringRep) VALUES (11,1, 'SalladMaker Choices');
	SET IDENTITY_INSERT Choices OFF



















---------------------------------------------------
---Andres Inserts---
---------Pizza Inserts och relaterade Indata------
--Möjliga ingredienser på Vesuvio
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,2);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,3);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,4);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,15);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,18);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,22);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,26);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,28);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (1,35);
--Möjliga Ingredienser i KebabPizza 
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,2);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,15);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,16);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,18);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,19);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,22);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,23);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,24);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,25);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,26);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,28);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,29);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,30);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,35);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (2,36);
--Möjliga ingredienser på Capricosa
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,3);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,4);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,15);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,16);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,22);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,26);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (3,35);
--Möjliga ingredienser på Mexicana
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,4);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,18);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,22);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,23);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,24);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,25);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,26);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,27);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,28);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,30);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,36);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (4,37);
--Möjliga ingredienser på Marinara
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,4);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,18);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,22);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,35);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,36);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,37);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,39);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,41);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,44);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (11,47);
--Möjliga ingredienser på Hawaii
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,3);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,4);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (9,20);
--Möjliga ingredienser på Bolognese
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,15);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,18);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,19);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,22);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,23);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,24);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,25);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,26);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,27);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,28);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,35);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,36);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,45);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (7,46);
--Möjliga ingredienser på Quattro Formaggio
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,1);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,2);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,3);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,4);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,5);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,7);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,15);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,19);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,22);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,23);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,27);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,28);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,35);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,45);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,46);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (10,47);
--Möjliga ingredienser på Calzone
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,6);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,8);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,9);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,19);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,20);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,21);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,28);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,34);
	INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (8,35);

------PizzaRecept 
	--Standard Vesuvio
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (1,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (1,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (1,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (1,21);
	--Standard Kebabpizza
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (2,2);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (2,5);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (2,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (2,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (2,34);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (2,49);
	--Standard Capricosa
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (3,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (3,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (3,19);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (3,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (3,21);
	--Standard Mexicana
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,18);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,23);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,27);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,50);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (4,51);
	--Standard Bolognese
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (7,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (7,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (7,18);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (7,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (7,27);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (7,40);
	--Standard Calzone
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (8,4);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (8,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (8,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (8,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (8,21);
	--Standard Hawaii
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (9,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (9,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (9,16);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (9,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (9,21);
	--Standard QuattroFormaggio
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (10,3);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (10,4);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (10,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (10,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (10,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (10,47);
	--Standard Marinara
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,6);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,8);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,20);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,39);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,44);

---------Möjliga ingredienser Sallad
	--Möjliga ingredienser på Kycklingsallad
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,9);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,10);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,11);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,12);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,13);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,18);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,19);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,21);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,22);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,25);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,26);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,29);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,30);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,31);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,32);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,33);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,36);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,37);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (5,47);
	--Möjliga ingredienser på Ceasarsallad
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,9);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,10);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,11);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,12);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,13);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,15);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,18);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,22);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,25);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,29);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,30);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,31);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,32);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,33);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,36);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,37);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,38);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,39);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,40);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,45);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (6,47);
	--Möjliga ingredienser på FetaostSallad 
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,4);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,5);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,9);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,10);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,12);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,13);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,15);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,17);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,18);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,21);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,22);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,25);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,29);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,30);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,31);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,32);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,33);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,39);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,40);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,41);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,42);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,43);
		INSERT INTO ProductCanHaveIngredients(ProductID, IngredientID) VALUES (12,46);
---------SalladRecept
	--Standard Kycklingsallad
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,10);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,11);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,12);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,22);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,25);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,29);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,30);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,31);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,45);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,47);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (5,48);
	--Standard CeasarSallad
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,10);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,18);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,29);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,30);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,38);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,45);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,47);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,48);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (6,49);
	--Standard FetaOstSallad
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (12,13);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (12,22);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (12,25);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (12,26);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (12,29);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (12,30);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (12,31);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,41);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,42);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,43);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,48);
		INSERT INTO ProductHaveIngredients(ProductID, IngredientID) VALUES (11,49);
--Skapa Sample orders. 
	GO

	--Order 1
		declare @TerminalID int;
		declare @OrderID int;
		declare @ProductOrderID int;

		select @TerminalID = TerminalID from Terminals where TerminalID = 2;
		Begin
		    insert into Orders(ByTerminal, Paid) values (@TerminalID, 1);
		    select @OrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into ProductOrders(ProductID, OrderID)
		    values (2, @OrderID);
		    select @ProductOrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 2, 1);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 4, 2);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 8, 1);
		End

		Begin
		    insert into ProductOrders(ProductID, OrderID)
		    values (3, @OrderID);
		    select @ProductOrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 6, 3);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 4, 2);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 7, 1);
		End
		GO

	--Order 2
		declare @TerminalID int;
		declare @OrderID int;
		declare @ProductOrderID int;

		select @TerminalID = TerminalID from Terminals where TerminalID = 2;
		Begin
		    insert into Orders (ByTerminal, Paid)
		    values (@TerminalID, 1);
		    select @OrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into ProductOrders(ProductID, OrderID)
		    values (3, @OrderID);
		    select @ProductOrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 3, 2);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 5, 2);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 9, 1);
		End

		Begin
		    insert into ProductOrders(ProductID, OrderID)
		    values (3, @OrderID);
		    select @ProductOrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 7, 3);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 5, 2);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 6, 1);
		End
		GO

	--Order 3
		declare @TerminalID int;
		declare @OrderID int;
		declare @ProductOrderID int;

		select @TerminalID = TerminalID from Terminals where TerminalID = 2;
		Begin
		    insert into Orders (ByTerminal, Paid)
		    values (@TerminalID, 0);
		    select @OrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into ProductOrders(ProductID, OrderID)
		    values (2, @OrderID);
		    select @ProductOrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 6, 1);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 7, 2);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 8, 1);
		End

		Begin
		    insert into ProductOrders(ProductID, OrderID)
		    values (3, @OrderID);
		    select @ProductOrderID = SCOPE_IDENTITY();
		End

		Begin
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 10, 3);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 3, 2);
		    insert into Stuffings(ProductOrderID, IngredientID, Quantity)
		    values (@ProductOrderID, 2, 1);
		End

--Sample Orders (några enklare orders utan stuffing details)
INSERT INTO Orders(ByTerminal, Paid, Canceled, PickedUp, Returned) VALUES(2, 1, 0,1,0); -- Order4
INSERT INTO Orders(ByTerminal, Paid, Canceled, PickedUp, Returned) VALUES(2, 0, 1,0,0); -- Order5
INSERT INTO Orders(ByTerminal, Paid, Canceled, PickedUp, Returned) VALUES(2, 1, 0,0,1); -- Order6
INSERT INTO Orders(ByTerminal, Paid, Canceled, PickedUp, Returned) VALUES(1, 1, 0,0,0); -- Order7
INSERT INTO Orders(ByTerminal, Paid, Canceled, PickedUp, Returned) VALUES(1, 1, 0,0,0); -- Order8


--OrderID4  (Paid, pickedup) (fully processed)
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(2, 4, 1);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(2, 4, 1);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(1, 4, 1);

--OrderID5 (Canceled) (not proceessed)
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(2, 5, 0);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(2, 5, 0);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(2, 5, 0);

--OrderID6 (Paid, returned) (fully processed)
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(2, 6, 1);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(1, 6, 1);

--Order7 (paid) (Fully Processed)
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(1, 7, 1);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(1, 7, 1);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(3, 7, 1);

--Order8 (paid) (partially processed)
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(1, 8, 1);
INSERT INTO ProductOrders(ProductID, OrderID,Processed) VALUES(1, 8, 0);
GO


------- Procedures för infoscreens
CREATE PROCEDURE Proc_LeftColumnInfoScreen  @BuildingID INT
	AS 												--Ska fungera bra. //hariz
	SELECT OrderID 
	FROM Orders
	WHERE        Orders.PickedUp =0 and
	            Orders.Canceled = 0 and
	            Orders.Returned = 0 and
	            Orders.Paid = 1

	            and  
	            Orders.OrderID IN 			  --är Element av 
	                (SELECT ProductOrders.OrderID
	                FROM ProductOrders 
	                WHERE ProductOrders.Processed = 0) 

	            and
	            Orders.ByTerminal in 
	            (SELECT TerminalID
	            FROM Terminals
	            WHERE Terminals.BuildingID = @BuildingID) --Parametrisera för att visa orders från din byggnad 

	GO

CREATE PROCEDURE Proc_RightColumnInfoScreen  @BuildingID INT
	AS
	SELECT OrderID
	FROM Orders
	WHERE        Orders.PickedUp =0 and
	            Orders.Canceled = 0 and
	            Orders.Returned = 0 and
	            Orders.Paid = 1
	            
	            and  
	            Orders.OrderID IN 			--är element av
	                (SELECT ProductOrders.OrderID
	                FROM ProductOrders 
	                WHERE ProductOrders.Processed = 1) 

	            and 
	            Orders.orderID not in 		--är inte element av
	                (    SELECT ProductOrders.OrderID
	                    FROM ProductOrders 
	                    WHERE ProductOrders.Processed = 0
	                )
	            
	            and
	            Orders.ByTerminal in 
	            (SELECT TerminalID
	            FROM Terminals
	            WHERE Terminals.BuildingID = @BuildingID) --Parametrisera för att visa orders från din byggnad 
	GO

--- Procedure för att sätta order som Picked Up:
CREATE PROCEDURE SetPickedUp (@OrderID Int, @PickedUp bit)
	AS
		BEGIN 
			UPDATE Orders
			SET PickedUp = @PickedUp
			WHERE OrderID = @OrderID;
		END
	GO

--- För Baker - Hämtar ingredients, dvs stuffings.
CREATE PROCEDURE Proc_GetStuffings (@ProductOrderID Int)
	AS
		BEGIN 
		Select *
		FROM Ingredients 

		WHERE IngredientID IN
			(SELECT Stuffings.IngredientID
			FROM ProductOrders, Stuffings
			Where ProductOrders.ProductOrderID = @ProductOrderID
				and
				ProductOrders.ProductOrderID = Stuffings.ProductOrderID)
		END
	GO

--ProductOrders som går att välja
--Bagarens vänstra lista.
--Filtreringsstrategi: Börja med den största mängden. Sålla sedan ner.
CREATE PROCEDURE Proc_OpenOrders  @BuildingID INT
	AS

	SELECT ProductOrderID, ProductName,PrepTime
	FROM (SELECT ProductOrderID, ProductID
		 FROM ProductOrders
		 WHERE LockedByStation IS NULL and
				Processed =0 and
				Activated=1 and
				Visible=1 and

		 OrderID in ( SELECT OrderID 
				FROM Orders
				WHERE Orders.Paid = 1 and
						Orders.Canceled=0 and
						Orders.Activated=1 and
						Orders.Visible=1 and
						Orders.PickedUp=0 and
						Orders.Returned=0 and

						Orders.ByTerminal IN 
							(SELECT TerminalID
							FROM Terminals
							WHERE Terminals.BuildingID = @BuildingID)
					 )) as POProds JOIN Products on Products.ProductID=POProds.ProductID
	GO

--Baker
--Låser upp med @stationid=0  . Ingen return tabell.
CREATE PROCEDURE Proc_SetLockedByStation (@ProductOrderID Int, @StationID Int)
	AS
		BEGIN 
			if(@StationID =0)

				BEGIN 
				UPDATE ProductOrders
				SET LockedByStation = NULL
				WHERE ProductOrderID = @ProductOrderID;
				END

			ELSE
				BEGIN
				UPDATE ProductOrders
				SET LockedByStation = @StationID
				WHERE ProductOrderID = @ProductOrderID;
				END
		END
	GO


--Baker
--Sätter PO till processed. returnar inget
CREATE PROCEDURE Proc_SetProcessed (@ProductOrderID Int, @Processed bit)
	AS
		BEGIN 
			UPDATE ProductOrders
			SET Processed = @Processed
			WHERE ProductOrderID = @ProductOrderID;
		END
	GO

--Baker
--Procedure to set employee to station - returnar inget.
CREATE PROCEDURE Proc_SetEmployeeToStation (@EmployeeID Int, @StationID int)
	AS
	BEGIN 
		UPDATE Employees
		SET AssignedToStation = @StationID
		WHERE EmployeeID = @EmployeeID;
	END
	GO

--to show productorder locked by station
--returnar tabell med en enda PO.  
CREATE PROCEDURE Proc_POLockedByStation @StationID int
	AS
	BEGIN
		SELECT *
		FROM ProductOrders
		WHERE LockedByStation = @StationID
	END
	GO

--Baker
--returnar en station
CREATE PROCEDURE Proc_GetAssignedStation @EmployeeID int
	AS
	SELECT *
	FROM Stations
	WHERE 
		Stations.StationID in
			(SELECT AssignedToStation 
			FROM Employees
			WHERE EmployeeID = @EmployeeID)
	GO

--baker
--Returnerar produktinfo från productorder
CREATE PROCEDURE Proc_GetProductInfoFromPO @ProductOrderID int
	AS
	BEGIN
		SELECT *
		FROM Products
		WHERE
			ProductID in
			(
			SELECT ProductID
			FROM ProductOrders
			WHERE ProductOrders.ProductOrderID= @ProductOrderID
			);
	END
	GO

--baker
--ger stations
CREATE PROCEDURE Proc_GetPossibleStationsForEmployee @EmployeeID INT
	AS
	BEGIN

	SELECT StationID, StationName
	FROM Stations
	WHERE StationID in (			
		(SELECT 
		a.StationTypeID 
		FROM EmployeeTypeCanWorkInStationType AS a
		WHERE 
			a.EmployeeTypeID in 
			(SELECT ET.EmployeeTypeID
			FROM Employees AS E, EmployeeTypes as ET, EmployeesAreEmployeeTypes as ErET
			WHERE E.EmployeeID = ErET.EmployeeID and ErET.EmployeeTypeID = ET.EmployeeTypeID and E.EmployeeID = @EmployeeID )))
	END
	GO		


--Product CRUD
CREATE PROCEDURE Proc_ProductSetCreate(
	@action varchar(10), 
	@ProductID int, 
	@ProductTypeID Int,
	@ProductName varchar(100),
	@Description varchar(100),
	@preptime int,
	@baseprice int,
	@activated bit,
	@visible bit)
	AS
	IF @action= 'create'
		BEGIN
		INSERT INTO 
			Products(ProductTypeID, ProductName, Description, preptime, baseprice, activated, visible) 
				VALUES(@ProductTypeID ,@ProductName,@Description,@preptime, @baseprice ,@activated, @visible)
		END
	ELSE IF @action ='set'
		BEGIN
			UPDATE Products
			SET 
			ProductTypeID = @ProductTypeID,
		  	ProductName =	@ProductName,
		  	Description =	@Description,
		  	preptime =	@preptime,
		  	baseprice =	@baseprice,
		  	activated =	@activated,
		  	visible =	@visible
			WHERE Products.ProductID = @ProductID
		END
	GO
CREATE PROCEDURE Proc_DeleteProduct(@ProductID int)
	AS
		BEGIN
			DELETE 
			FROM Products 
			WHERE Products.ProductID = @ProductID
		END
	GO
CREATE PROCEDURE Proc_GetProducts(@ProductID int)
	AS
		BEGIN
			SELECT *
			FROM Products
			WHERE Products.ProductID = @ProductID
		END

	GO

--Ingredient CRUD
CREATE PROCEDURE Proc_IngredientSetCreate(
	@action varchar(10), 
	@IngredientID int, 
	@IngredientName varchar(100),
	@Price int,
	@Activated int,
	@Visible int)
	AS
	IF @action= 'create'
		BEGIN
		INSERT INTO 
			Ingredients(IngredientID, IngredientName,Price,Activated, Visible) 
				VALUES(@IngredientID,@IngredientName,@Price,@Activated,@Visible)
		END
	ELSE IF @action ='set'
		BEGIN
			UPDATE Ingredients
			SET 
			IngredientName = @IngredientName,
			Price = @Price,
			Activated = @Activated,
			Visible = @Visible
			WHERE IngredientID = @IngredientID
		END
	GO
CREATE PROCEDURE Proc_GetIngredient @IngredientID int
	AS
		BEGIN
			DELETE 
			FROM Ingredients 
			WHERE IngredientID = @IngredientID
		END
	GO
CREATE PROCEDURE Proc_DeleteIngredient @IngredientID int
	AS
		BEGIN
			SELECT *
			FROM Ingredients
			WHERE IngredientID = @IngredientID
		END

	GO

--ProductType CRUD
CREATE PROCEDURE Proc_ProductTypeSetCreate(
	@action varchar(10), 
	@ProductTypeID int, 
	@ProductTypeName varchar(100),
	@Activated int,
	@Visible int)
	AS
	IF @action= 'create'
		BEGIN
		INSERT INTO 
			Ingredients(ProductTypeID, ProductTypeNAme, Activated, Visible) 
				VALUES(@ProductTypeID, @ProductTypeName, @Activated, @Visible)
		END
	ELSE IF @action ='set'
		BEGIN
			UPDATE Ingredients
			SET 
			IngredientName = @ProductTypeName,
			Activated = @Activated,
			Visible = @Visible
			WHERE ProductTypeID = @ProductTypeID
		END
	GO
CREATE PROCEDURE Proc_DeleteProductType (@ProductTypeID int)
	AS
		BEGIN
			DELETE 
			FROM ProductTypes 
			WHERE ProductTypeID = @ProductTypeID
		END
CREATE PROCEDURE Proc_GetProductTypes()
	AS
		BEGIN
			SELECT *
			FROM ProductTypes
			WHERE ProductTypeID = @ProductTypeID
		END

	GO


CREATE PROCEDURE Proc_OrdersSetCreate(
	@OrderID int, 
	@ByTerminal Int,
	@Paid bit,
	@Canceled bit,
	@PickedUp bit,
	@ShowOnScreen bit,
	@HappyCustomer bit,
	@Returned bit,
	@Activated bit,
	@Visible bit,
	)
	AS
	IF OrderID IS NULL
		BEGIN
		INSERT INTO 
			Orders( OrderTypeID,  ByTerminal, Paid, Canceled,  PickedUp , ShowOnScreen,  HappyCustomer,  Returned,  Activated, Visible) 
			VALUES(@OrderTypeID ,@ByTerminal,@Paid,@Canceled, @PickedUp ,@ShowOnScreen, @HappyCustomer, @Returned, @Activated,@Visible)
		END
	ELSE 
		BEGIN
			UPDATE Orders
			SET 
			OrderTypeID = @OrderTypeID,
		  	ByTerminal =	@ByTerminal,
		  	Paid =	@Paid,
		  	Canceled =	@Canceled,
		  	PickedUp =	@PickedUp,
		  	ShowOnScreen =	@ShowOnScreen,
		  	HappyCustomer =	@HappyCustomer,
		  	Returned = @Returned,
		  	Activated = @Activated,
		  	Visible = @Visible
			WHERE Orders.OrderID = @OrderID
		END
	GO

CREATE PROCEDURE Proc_ProductOrdersSetCreate(
	@ProductOrderID int, 
	@ProductID Int,
	@OrderID bit,
	@LockedByStation bit,
	@Processed bit,
	@Activated bit,
	@Visible bit,
	)
	AS
	IF ProductOrderID IS NULL
		BEGIN
		INSERT INTO 
			ProductOrders( ProductOrderTypeID, ProductID,  OrderID, LockedByStation,  Processed,  Activated,  Visible) 
			VALUES(@ProductOrderTypeID ,	   @ProductID,@OrderID,@LockedByStation, @Processed ,@Activated, @Visible,)
		END
	ELSE 
		BEGIN
			UPDATE ProductOrders
			SET 
			ProductOrderTypeID = @ProductOrderTypeID,
		  	ProductID =	@ProductID,
		  	OrderID =	@OrderID,
		  	LockedByStation =	@LockedByStation,
		  	Processed =	@Processed,
		  	Activated =	@Activated,
		  	Visible =	@Visible,
			WHERE ProductOrders.ProductOrderID = @ProductOrderID
		END
	GO

