--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1 (Debian 12.1-1.pgdg100+1)
-- Dumped by pg_dump version 12.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE grupp3;
--
-- Name: grupp3; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE grupp3 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


\connect grupp3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ShowDrinksByID(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."ShowDrinksByID"("inId" integer) RETURNS TABLE(id integer, name character varying, price integer)
    LANGUAGE plpgsql
    AS $$BEGIN
RETURN QUERY
select *
from "Drink"
Where "ID"=inId;
END;$$;


--
-- Name: proc_deleteproducttype(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_deleteproducttype(producttypeid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
	DELETE 
			FROM ProductTypes 
			WHERE producttypes.ProductTypeID = proc_deleteproducttype.producttypeID;
	END;
	$$;


--
-- Name: proc_getassignedstation(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_getassignedstation(employeeid integer) RETURNS TABLE(stationid integer, stationname character varying, stationtypeid integer, inbuilding integer, activated boolean, visible boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN 
RETURN QUERY
			SELECT *
	FROM Stations
	WHERE 
		Stations.StationID in
			(SELECT AssignedToStation 
			FROM Employees
			WHERE employees.employeeid = proc_getassignedstation.employeeid);
		END;
		$$;


--
-- Name: proc_getpossiblestationsforemployee(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_getpossiblestationsforemployee(employeeid integer) RETURNS TABLE(stationid integer, stationname character varying)
    LANGUAGE plpgsql
    AS $$
		BEGIN 
		RETURN QUERY
		SELECT stations.StationID, stations.StationName
	FROM Stations
	WHERE stations.StationID in (			
		(SELECT 
		StationTypeID 
		FROM EmployeeTypeCanWorkInStationType AS a
		WHERE 
			a.EmployeeTypeID in 
			(SELECT ET.EmployeeTypeID
			FROM Employees AS E, EmployeeTypes as ET, EmployeesAreEmployeeTypes as ErET
			WHERE E.EmployeeID = ErET.EmployeeID and ErET.EmployeeTypeID =
			 ET.EmployeeTypeID and E.EmployeeID = proc_getpossiblestationsforemployee.EmployeeID )));
		END;
		$$;


--
-- Name: proc_getproductinfofrompo(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_getproductinfofrompo(productorderid integer) RETURNS TABLE(productid integer, producttypeid integer, productname character varying, description character varying, preptime integer, baseprice integer, activated boolean, visible boolean)
    LANGUAGE plpgsql
    AS $$

BEGIN 
RETURN QUERY
		SELECT *
		FROM Products
		WHERE
			products.ProductID in
			(
			SELECT productorders.ProductID
			FROM ProductOrders
			WHERE ProductOrders.ProductOrderID= proc_getproductinfofrompo.ProductOrderID
			);
		END;
		$$;


--
-- Name: proc_getproducttypes(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_getproducttypes() RETURNS TABLE(producttypeid integer, producttypename character varying, activated boolean, visible boolean)
    LANGUAGE plpgsql
    AS $$
	BEGIN
	RETURN QUERY
	SELECT *
			FROM ProductTypes
			WHERE producttypes.ProductTypeID = proc_getproducttypes.producttypeid;
	END;
	$$;


--
-- Name: proc_getstuffings(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_getstuffings(productorderid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
		BEGIN 
			Select *
		FROM Ingredients 

		WHERE IngredientID IN
			(SELECT Stuffings.IngredientID
			FROM ProductOrders, Stuffings
			Where ProductOrders.ProductOrderID = ProductOrderID
				and
				ProductOrders.ProductOrderID = Proc_GetStuffings.ProductOrderID);
		END;
		$$;


--
-- Name: proc_ingredientsetcreate(integer, character varying, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_ingredientsetcreate(ingredientid integer, ingredientname character varying, price integer, activated integer, visible integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
IF IngredientID = NULL THEN
    
	BEGIN
    INSERT INTO 
			Ingredients(IngredientID, IngredientName,Price,Activated, Visible) 
				VALUES(IngredientID,IngredientName,Price,Activated,Visible);
    END;
    ELSE 
        BEGIN
            UPDATE Ingredients
			SET 
			IngredientName = IngredientName,
			Price = Price,
			Activated = Activated,
			Visible = Visible
			WHERE IngredientID = IngredientID;
		END;
END IF;
END;
$$;


--
-- Name: proc_leftcolumninfoscreen(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_leftcolumninfoscreen(buildingid integer) RETURNS TABLE(orderid integer)
    LANGUAGE plpgsql
    AS $$
	BEGIN
	RETURN QUERY
	SELECT orders.orderid 
	FROM orders
	WHERE        orders.pickedUp =false and
	            orders.canceled = false and
	            orders.returned = false and
	            orders.paid = true

	            and  
	            orders.orderid IN 			 
	                (SELECT productorders.orderID
	                FROM productorders 
	                WHERE productorders.processed = false) 

	            and
	            orders.byterminal in 
	            (SELECT terminalid
	            FROM terminals
	            WHERE terminals."buildingid" = proc_leftcolumninfoscreen.buildingid);
	END;
	$$;


--
-- Name: proc_openorders(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_openorders(buildingid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
		BEGIN 
			SELECT ProductOrderID, ProductName,PrepTime
	FROM (SELECT ProductOrderID, ProductID
		 FROM ProductOrders
		 WHERE LockedByStation IS NULL and
				Processed =0 and
				Activated=true and
				Visible=true and

		 OrderID in ( SELECT OrderID 
				FROM Orders
				WHERE Orders.Paid = true and
						Orders.Canceled=false and
						Orders.Activated=true and
						Orders.Visible=true and
						Orders.PickedUp=false and
						Orders.Returned=false and

						Orders.ByTerminal IN 
							(SELECT TerminalID
							FROM Terminals
							WHERE Terminals.BuildingID = BuildingID)
					 )) as POProds JOIN Products on Products.ProductID=POProds.ProductID;
		END;
		$$;


--
-- Name: proc_orderssetcreate(integer, integer, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_orderssetcreate(orderid integer, byterminal integer, paid boolean, canceled boolean, pickedup boolean, showonscreen boolean, happycustomer boolean, returned boolean, activated boolean, visible boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
IF OrderID IS NULL THEN
    
	BEGIN
    INSERT INTO 
			Orders( OrderTypeID,  ByTerminal, Paid, Canceled,  PickedUp , ShowOnScreen,  HappyCustomer,  Returned,  Activated, Visible) 
			VALUES(OrderTypeID ,ByTerminal,Paid,Canceled, PickedUp ,ShowOnScreen, HappyCustomer, Returned, Activated,Visible);
    END;
    ELSE 
            BEGIN
			UPDATE Orders
			SET 
			OrderTypeID = OrderTypeID,
		  	ByTerminal =	ByTerminal,
		  	Paid =	Paid,
		  	Canceled =	Canceled,
		  	PickedUp =	PickedUp,
		  	ShowOnScreen =	ShowOnScreen,
		  	HappyCustomer =	HappyCustomer,
		  	Returned = Returned,
		  	Activated = Activated,
		  	Visible = Visible
			WHERE Orders.OrderID = OrderID;
		END;
END IF;
END;
$$;


--
-- Name: proc_polockedbystation(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_polockedbystation(stationid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
		BEGIN 
			SELECT *
		FROM ProductOrders
		WHERE LockedByStation = StationID;
		END;
		$$;


--
-- Name: proc_producthasingredients(integer); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.proc_producthasingredients(integer)
    LANGUAGE plpgsql
    AS $_$
    BEGIN
    SELECT *
    FROM Ingredients
    WHERE IngredientID in
            (SELECT IngredientID
            FROM ProductHaveIngredients
            WHERE ProductID = $1
            );
         COMMIT;
    END;
$_$;


--
-- Name: proc_productorderssetcreate(integer, integer, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_productorderssetcreate(productorderid integer, productid integer, orderid boolean, lockedbystation boolean, processed boolean, activated boolean, visible boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
IF ProductOrderID IS NULL THEN
    
	BEGIN
    INSERT INTO 
            ProductOrders( ProductOrderTypeID , ProductID ,  OrderID , 
                          LockedByStation ,  Processed,  Activated,  Visible) 
            VALUES(ProductOrderTypeID ,       ProductID,OrderID,LockedByStation, 
                   Processed ,Activated, Visible);
    END;
    ELSE 
        BEGIN
            UPDATE ProductOrders
            SET 
            ProductOrderTypeID = ProductOrderTypeID,
              ProductID =    ProductID,
              OrderID = OrderID,
              LockedByStation =    LockedByStation,
              Processed =    Processed,
              Activated =    Activated,
              Visible =    Visible
            WHERE ProductOrders.ProductOrderID = ProductOrderID;
		END;
END IF;
END;
$$;


--
-- Name: proc_productsetcreate(integer, integer, character varying, character varying, integer, integer, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_productsetcreate(productid integer, producttypeid integer, productname character varying, description character varying, preptime integer, baseprice integer, activated boolean, visible boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
IF ProductID is null THEN
    
	
    INSERT INTO 
			Products(ProductTypeID, ProductName, Description, preptime, baseprice, activated, visible) 
				VALUES(ProductTypeID ,ProductName,Description,preptime, baseprice ,activated, visible);
    ELSE 
        
            UPDATE Products
			SET 
			ProductTypeID = proc_productsetcreate.ProductTypeID,
		  	ProductName =	proc_productsetcreate.ProductName,
		  	Description =	proc_productsetcreate.Description,
		  	preptime =	proc_productsetcreate.preptime,
		  	baseprice =	proc_productsetcreate.baseprice,
		  	activated =	proc_productsetcreate.activated,
		  	visible =	proc_productsetcreate.visible
			WHERE Products.ProductID = proc_productsetcreate.ProductID;
		
END IF;
END;
$$;


--
-- Name: proc_producttypesetcreate(integer, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_producttypesetcreate(producttypeid integer, producttypename character varying, activated integer, visible integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
IF ProductTypeID = NULL THEN
    
	BEGIN
    INSERT INTO 
			Ingredients(ProductTypeID, ProductTypeNAme, Activated, Visible) 
				VALUES(ProductTypeID, ProductTypeName, Activated, Visible);
    END;
    ELSE 
        
            BEGIN
			UPDATE Ingredients
			SET 
			IngredientName = ProductTypeName,
			Activated = Activated,
			Visible = Visible
			WHERE ProductTypeID = ProductTypeID;
		END;
END IF;
END;
$$;


--
-- Name: proc_rightcolumninfoscreen(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_rightcolumninfoscreen(buildingid integer) RETURNS TABLE(orderid integer)
    LANGUAGE plpgsql
    AS $$
	BEGIN
	RETURN QUERY
	SELECT orders.orderid
	FROM orders
	WHERE        Orders.PickedUp =false and
	            Orders.Canceled = false and
	            Orders.Returned = false and
	            Orders.Paid = true
	            
	            and  
	            Orders.OrderID IN 			
	                (SELECT ProductOrders.OrderID
	                FROM ProductOrders 
	                WHERE ProductOrders.Processed = true) 

	            and 
	            Orders.orderID not in 		
	                (    SELECT ProductOrders.OrderID
	                    FROM ProductOrders 
	                    WHERE ProductOrders.Processed = false
	                )
	            
	            and
	            Orders.ByTerminal in 
	            (SELECT TerminalID
	            FROM Terminals
	            WHERE Terminals.BuildingID = proc_rightcolumninfoscreen.buildingID);
				END;
	$$;


--
-- Name: proc_setemployeetostation(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_setemployeetostation(employeeid integer, stationid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
		BEGIN 
			UPDATE Employees
		SET AssignedToStation = StationID
		WHERE EmployeeID = EmployeeID;
		END;
		$$;


--
-- Name: proc_setlockedbystation(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_setlockedbystation(productorderid integer, stationid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
		BEGIN 
			if(StationID =0) then
				UPDATE ProductOrders
				SET LockedByStation = NULL
				WHERE ProductOrderID = ProductOrderID;
			ELSE
				UPDATE ProductOrders
				SET LockedByStation = StationID
				WHERE ProductOrderID = ProductOrderID;
			END IF;
		END;
		$$;


--
-- Name: proc_setprocessed(integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.proc_setprocessed(productorderid integer, processed boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
		BEGIN 
			UPDATE ProductOrders
			SET Processed = Processed
			WHERE ProductOrderID = ProductOrderID;
		END;
		$$;


--
-- Name: setpickedup(integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.setpickedup(orderid integer, pickedup boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
		BEGIN 
			UPDATE Orders
			SET PickedUp = PickedUp
			WHERE OrderID = OrderID;
		END;
		$$;


--
-- Name: showOrderByID(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."showOrderByID"() RETURNS TABLE(id integer, status integer, employeeid integer)
    LANGUAGE plpgsql
    AS $$BEGIN
return query
select *
from "Order"
order by "ID";
END;$$;


--
-- Name: spgetproductingredients(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.spgetproductingredients(productid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
	SELECT * FROM Ingredients as I
			JOIN ProductHaveIngredients as PHI
			ON PHI.IngredientID = I.IngredientID
			WHERE PHI.ProductID = p_ProductID;
	END;
	$$;


--
-- Name: spverifylogin(character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.spverifylogin(p_username character varying, p_password character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

		begin
			SELECT EmployeeID, Username FROM Employees WHERE
			CAST(Username as bytea) = CAST(p_Username as bytea)
			AND CAST(Password as bytea) = CAST(p_Password as bytea)
			AND Username = p_Username 
			AND Password = p_Password;
		end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buildings (
    buildingid integer NOT NULL,
    buildingname character varying(50) NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: choices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.choices (
    id integer NOT NULL,
    issubto integer,
    stringrep character varying(100) DEFAULT 'unnamed choice'::character varying,
    description character varying(500) DEFAULT NULL::character varying
);


--
-- Name: choices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.choices ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    employeeid integer NOT NULL,
    username character varying(20) NOT NULL,
    password character varying(20) DEFAULT 0 NOT NULL,
    loggedin boolean DEFAULT false NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    assignedtostation integer DEFAULT 1 NOT NULL
);


--
-- Name: employeesareemployeetypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employeesareemployeetypes (
    employeeid integer NOT NULL,
    employeetypeid integer NOT NULL
);


--
-- Name: employeeshaveproductorderslockedinstations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employeeshaveproductorderslockedinstations (
    employeeid integer NOT NULL,
    productorderid integer NOT NULL,
    stationid integer NOT NULL
);


--
-- Name: employeetypecanworkinstationtype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employeetypecanworkinstationtype (
    employeetypeid integer NOT NULL,
    stationtypeid integer NOT NULL
);


--
-- Name: employeetypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employeetypes (
    employeetypeid integer NOT NULL,
    employeetypename character varying(50) DEFAULT 'unnamed'::character varying NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: employeetypes_employeetypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.employeetypes ALTER COLUMN employeetypeid ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.employeetypes_employeetypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: infoscreens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.infoscreens (
    id integer NOT NULL,
    buildingid integer NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: infoscreens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.infoscreens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.infoscreens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredients (
    ingredientid integer NOT NULL,
    ingredientname character varying DEFAULT 'unnamed'::character varying NOT NULL,
    price integer DEFAULT 5 NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: ingedients_ingredientid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ingredients ALTER COLUMN ingredientid ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ingedients_ingredientid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    orderid integer NOT NULL,
    byterminal integer NOT NULL,
    paid boolean DEFAULT false NOT NULL,
    canceled boolean DEFAULT false NOT NULL,
    pickedup boolean DEFAULT false NOT NULL,
    showonscreen boolean DEFAULT true NOT NULL,
    happycustomer boolean DEFAULT true NOT NULL,
    returned boolean DEFAULT false NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: orderwastreatedbyemployeeatstation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orderwastreatedbyemployeeatstation (
    treatment integer NOT NULL,
    employeeid integer,
    stationid integer,
    orderid integer,
    treatmenttime timestamp without time zone,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: orderwastreatedbyemployeeatstation_treatment_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.orderwastreatedbyemployeeatstation ALTER COLUMN treatment ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orderwastreatedbyemployeeatstation_treatment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: possiblecommandsinstationtype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.possiblecommandsinstationtype (
    methodsignature integer NOT NULL,
    stationtypeid integer NOT NULL,
    choice integer NOT NULL,
    connectedprocedure integer
);


--
-- Name: possiblecommandsinstationtype_methodsignature_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.possiblecommandsinstationtype ALTER COLUMN methodsignature ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.possiblecommandsinstationtype_methodsignature_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: productcanhaveingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.productcanhaveingredients (
    reference integer NOT NULL,
    productid integer NOT NULL,
    ingredientid integer NOT NULL
);


--
-- Name: productcanhaveingredients_reference_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.productcanhaveingredients ALTER COLUMN reference ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.productcanhaveingredients_reference_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: producthaveingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.producthaveingredients (
    reference integer NOT NULL,
    productid integer NOT NULL,
    ingredientid integer
);


--
-- Name: producthaveingredients_reference_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.producthaveingredients ALTER COLUMN reference ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.producthaveingredients_reference_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: productorders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.productorders (
    productorderid integer NOT NULL,
    productid integer NOT NULL,
    orderid integer NOT NULL,
    lockedbystation integer,
    processed boolean DEFAULT false NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    productid integer NOT NULL,
    producttypeid integer NOT NULL,
    productname character varying(50) DEFAULT 'unnamed'::character varying NOT NULL,
    description character varying(500) DEFAULT 'no description'::character varying,
    preptime integer DEFAULT 500 NOT NULL,
    baseprice integer DEFAULT 100 NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: products_productid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.products ALTER COLUMN productid ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.products_productid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: producttypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.producttypes (
    producttypeid integer NOT NULL,
    producttypename character varying DEFAULT 'unnamed'::character varying NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: producttypes_producttypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.producttypes ALTER COLUMN producttypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.producttypes_producttypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: stations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stations (
    stationid integer NOT NULL,
    stationname character varying(50) DEFAULT 'unnamed'::character varying NOT NULL,
    stationtypeid integer,
    inbuilding integer,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: stationtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stationtypes (
    stationtypeid integer NOT NULL,
    stationtypename character varying(50),
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    dangerlevel integer DEFAULT 0 NOT NULL
);


--
-- Name: stuffings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stuffings (
    "Lump" integer NOT NULL,
    productorderid integer NOT NULL,
    ingredientid integer NOT NULL,
    quantity integer NOT NULL
);


--
-- Name: terminals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.terminals (
    terminalid integer NOT NULL,
    terminalname character varying NOT NULL,
    buildingid integer,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    available boolean DEFAULT true NOT NULL
);


--
-- Name: typecanhaveingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typecanhaveingredients (
    approvedingredient integer NOT NULL,
    producttypeid integer NOT NULL,
    ingredientid integer NOT NULL,
    isdemanded boolean DEFAULT false NOT NULL,
    maxunits integer DEFAULT 3 NOT NULL
);


--
-- Name: typecanhaveingredients_approvedingredient_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.typecanhaveingredients ALTER COLUMN approvedingredient ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.typecanhaveingredients_approvedingredient_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: typeismadeinstationtype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typeismadeinstationtype (
    producttypeid integer NOT NULL,
    stationtypeid integer NOT NULL
);


--
-- Name: typerestrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typerestrictions (
    restriction integer NOT NULL,
    producttypeid integer NOT NULL,
    approvedingredient integer NOT NULL,
    cannotmixwith integer NOT NULL
);


--
-- Name: typerestrictions_restriction_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.typerestrictions ALTER COLUMN restriction ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.typerestrictions_restriction_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3190.dat

--
-- Data for Name: choices; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3222.dat

--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3196.dat

--
-- Data for Name: employeesareemployeetypes; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3200.dat

--
-- Data for Name: employeeshaveproductorderslockedinstations; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3213.dat

--
-- Data for Name: employeetypecanworkinstationtype; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3201.dat

--
-- Data for Name: employeetypes; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3197.dat

--
-- Data for Name: infoscreens; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3193.dat

--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3207.dat

--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3199.dat

--
-- Data for Name: orderwastreatedbyemployeeatstation; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3209.dat

--
-- Data for Name: possiblecommandsinstationtype; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3224.dat

--
-- Data for Name: productcanhaveingredients; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3220.dat

--
-- Data for Name: producthaveingredients; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3218.dat

--
-- Data for Name: productorders; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3211.dat

--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3204.dat

--
-- Data for Name: producttypes; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3202.dat

--
-- Data for Name: stations; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3195.dat

--
-- Data for Name: stationtypes; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3194.dat

--
-- Data for Name: stuffings; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3212.dat

--
-- Data for Name: terminals; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3191.dat

--
-- Data for Name: typecanhaveingredients; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3214.dat

--
-- Data for Name: typeismadeinstationtype; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3206.dat

--
-- Data for Name: typerestrictions; Type: TABLE DATA; Schema: public; Owner: -
--

\i $$PATH$$/3216.dat

--
-- Name: choices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.choices_id_seq', 1, false);


--
-- Name: employeetypes_employeetypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employeetypes_employeetypeid_seq', 1, false);


--
-- Name: infoscreens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.infoscreens_id_seq', 1, false);


--
-- Name: ingedients_ingredientid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingedients_ingredientid_seq', 1, false);


--
-- Name: orderwastreatedbyemployeeatstation_treatment_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orderwastreatedbyemployeeatstation_treatment_seq', 1, false);


--
-- Name: possiblecommandsinstationtype_methodsignature_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.possiblecommandsinstationtype_methodsignature_seq', 1, false);


--
-- Name: productcanhaveingredients_reference_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.productcanhaveingredients_reference_seq', 226, true);


--
-- Name: producthaveingredients_reference_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.producthaveingredients_reference_seq', 85, true);


--
-- Name: products_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_productid_seq', 53, true);


--
-- Name: producttypes_producttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.producttypes_producttypeid_seq', 8, true);


--
-- Name: typecanhaveingredients_approvedingredient_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.typecanhaveingredients_approvedingredient_seq', 89, true);


--
-- Name: typerestrictions_restriction_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.typerestrictions_restriction_seq', 1, true);


--
-- Name: stuffings UC_POIngredient; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT "UC_POIngredient" UNIQUE (productorderid) INCLUDE (ingredientid);


--
-- Name: productorders UC_ProductOrders_ID; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "UC_ProductOrders_ID" UNIQUE (productorderid);


--
-- Name: productorders UC_ProductOrders_LockedByStation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "UC_ProductOrders_LockedByStation" UNIQUE (lockedbystation);


--
-- Name: products UC_Products_NameTypeCombo; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "UC_Products_NameTypeCombo" UNIQUE (productname) INCLUDE (producttypeid);


--
-- Name: typerestrictions UC_TypeINGTypeRestriction_Ingred; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "UC_TypeINGTypeRestriction_Ingred" UNIQUE (cannotmixwith);


--
-- Name: typerestrictions UC_TypeINGTypeRestriction_Ingredient; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "UC_TypeINGTypeRestriction_Ingredient" UNIQUE (producttypeid) INCLUDE (approvedingredient);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (buildingid);


--
-- Name: choices choices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.choices
    ADD CONSTRAINT choices_pkey PRIMARY KEY (id);


--
-- Name: employeesareemployeetypes employeesareemployeetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeesareemployeetypes
    ADD CONSTRAINT employeesareemployeetypes_pkey PRIMARY KEY (employeeid, employeetypeid);


--
-- Name: employeeshaveproductorderslockedinstations employeeshaveproductorderslockedinstations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT employeeshaveproductorderslockedinstations_pkey PRIMARY KEY (employeeid, productorderid, stationid);


--
-- Name: employeetypecanworkinstationtype employeetypecanworkinstationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeetypecanworkinstationtype
    ADD CONSTRAINT employeetypecanworkinstationtype_pkey PRIMARY KEY (employeetypeid, stationtypeid);


--
-- Name: employeetypes employeetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeetypes
    ADD CONSTRAINT employeetypes_pkey PRIMARY KEY (employeetypeid);


--
-- Name: employees empoyees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT empoyees_pkey PRIMARY KEY (employeeid);


--
-- Name: infoscreens infoscreens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.infoscreens
    ADD CONSTRAINT infoscreens_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingedients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingedients_pkey PRIMARY KEY (ingredientid);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderid);


--
-- Name: orderwastreatedbyemployeeatstation orderwastreatedbyemployeeatstation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT orderwastreatedbyemployeeatstation_pkey PRIMARY KEY (treatment);


--
-- Name: possiblecommandsinstationtype possiblecommandsinstationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possiblecommandsinstationtype
    ADD CONSTRAINT possiblecommandsinstationtype_pkey PRIMARY KEY (choice, stationtypeid);


--
-- Name: productcanhaveingredients productcanhaveingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productcanhaveingredients
    ADD CONSTRAINT productcanhaveingredients_pkey PRIMARY KEY (reference);


--
-- Name: producthaveingredients producthaveingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producthaveingredients
    ADD CONSTRAINT producthaveingredients_pkey PRIMARY KEY (reference);


--
-- Name: productorders productorders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT productorders_pkey PRIMARY KEY (productorderid, productid);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- Name: producttypes producttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producttypes
    ADD CONSTRAINT producttypes_pkey PRIMARY KEY (producttypeid);


--
-- Name: stations stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (stationid);


--
-- Name: stationtypes stationtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stationtypes
    ADD CONSTRAINT stationtypes_pkey PRIMARY KEY (stationtypeid);


--
-- Name: stuffings stuffings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT stuffings_pkey PRIMARY KEY ("Lump");


--
-- Name: terminals terminals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.terminals
    ADD CONSTRAINT terminals_pkey PRIMARY KEY (terminalid);


--
-- Name: typecanhaveingredients typecanhaveingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typecanhaveingredients
    ADD CONSTRAINT typecanhaveingredients_pkey PRIMARY KEY (approvedingredient);


--
-- Name: typeismadeinstationtype typeismadeinstationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typeismadeinstationtype
    ADD CONSTRAINT typeismadeinstationtype_pkey PRIMARY KEY (producttypeid, stationtypeid);


--
-- Name: typerestrictions typerestrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT typerestrictions_pkey PRIMARY KEY (restriction);


--
-- Name: possiblecommandsinstationtype Choices(ID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possiblecommandsinstationtype
    ADD CONSTRAINT "Choices(ID)_FK" FOREIGN KEY (choice) REFERENCES public.choices(id);


--
-- Name: employeesareemployeetypes EmployeeTypes(EmployeeTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeesareemployeetypes
    ADD CONSTRAINT "EmployeeTypes(EmployeeTypeID)_FK" FOREIGN KEY (employeetypeid) REFERENCES public.employeetypes(employeetypeid);


--
-- Name: employeetypecanworkinstationtype EmployeeTypes(EmployeeTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeetypecanworkinstationtype
    ADD CONSTRAINT "EmployeeTypes(EmployeeTypeID)_FK" FOREIGN KEY (employeetypeid) REFERENCES public.employeetypes(employeetypeid);


--
-- Name: employeeshaveproductorderslockedinstations Employees(EmployeeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT "Employees(EmployeeID)_FK" FOREIGN KEY (employeeid) REFERENCES public.employees(employeeid);


--
-- Name: choices FK_Choices(ID); Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.choices
    ADD CONSTRAINT "FK_Choices(ID)" FOREIGN KEY (issubto) REFERENCES public.choices(id) NOT VALID;


--
-- Name: orderwastreatedbyemployeeatstation FK_Employees(EmployeeID); Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT "FK_Employees(EmployeeID)" FOREIGN KEY (employeeid) REFERENCES public.employees(employeeid);


--
-- Name: orderwastreatedbyemployeeatstation FK_Orders(OrderID); Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT "FK_Orders(OrderID)" FOREIGN KEY (orderid) REFERENCES public.orders(orderid);


--
-- Name: productorders FK_ProdctOrders_Orders; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "FK_ProdctOrders_Orders" FOREIGN KEY (orderid) REFERENCES public.orders(orderid);


--
-- Name: productorders FK_ProductOrders_Product; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "FK_ProductOrders_Product" FOREIGN KEY (productid) REFERENCES public.products(productid);


--
-- Name: productorders FK_ProductOrders_Station; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "FK_ProductOrders_Station" FOREIGN KEY (lockedbystation) REFERENCES public.stations(stationid);


--
-- Name: typeismadeinstationtype FK_ProductTypes(ProductTypeID); Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typeismadeinstationtype
    ADD CONSTRAINT "FK_ProductTypes(ProductTypeID)" FOREIGN KEY (producttypeid) REFERENCES public.producttypes(producttypeid);


--
-- Name: typeismadeinstationtype FK_StationTypes(StationTypeID); Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typeismadeinstationtype
    ADD CONSTRAINT "FK_StationTypes(StationTypeID)" FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- Name: orderwastreatedbyemployeeatstation FK_Stations(StationID); Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT "FK_Stations(StationID)" FOREIGN KEY (stationid) REFERENCES public.stations(stationid);


--
-- Name: stuffings FK_Stuffings_ProductOrder_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT "FK_Stuffings_ProductOrder_FK" FOREIGN KEY (productorderid) REFERENCES public.productorders(productorderid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: typerestrictions FK_TypeRestrictions_ApprovedIngredient; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "FK_TypeRestrictions_ApprovedIngredient" FOREIGN KEY (approvedingredient) REFERENCES public.typecanhaveingredients(approvedingredient) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: typerestrictions FK_TypeRestrictions_CannotMixwithIngredient; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "FK_TypeRestrictions_CannotMixwithIngredient" FOREIGN KEY (cannotmixwith) REFERENCES public.typecanhaveingredients(approvedingredient);


--
-- Name: typerestrictions FK_TypeRestrictions_ProductType; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "FK_TypeRestrictions_ProductType" FOREIGN KEY (producttypeid) REFERENCES public.producttypes(producttypeid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stuffings Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: typecanhaveingredients Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typecanhaveingredients
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: producthaveingredients Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producthaveingredients
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: productcanhaveingredients Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productcanhaveingredients
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: employeeshaveproductorderslockedinstations ProductOrders(ProductOrderID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT "ProductOrders(ProductOrderID)_FK" FOREIGN KEY (productorderid) REFERENCES public.productorders(productorderid);


--
-- Name: typecanhaveingredients ProductTypes(ProductTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typecanhaveingredients
    ADD CONSTRAINT "ProductTypes(ProductTypeID)_FK" FOREIGN KEY (producttypeid) REFERENCES public.producttypes(producttypeid);


--
-- Name: employeetypecanworkinstationtype StationTypes(StationTypeID); Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeetypecanworkinstationtype
    ADD CONSTRAINT "StationTypes(StationTypeID)" FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- Name: possiblecommandsinstationtype StationTypes(StationTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possiblecommandsinstationtype
    ADD CONSTRAINT "StationTypes(StationTypeID)_FK" FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- Name: employeeshaveproductorderslockedinstations Stations(StationID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT "Stations(StationID)_FK" FOREIGN KEY (stationid) REFERENCES public.stations(stationid);


--
-- Name: employees assignedtostation_station_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT assignedtostation_station_fkey FOREIGN KEY (assignedtostation) REFERENCES public.stations(stationid) NOT VALID;


--
-- Name: terminals buildingid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.terminals
    ADD CONSTRAINT buildingid_fkey FOREIGN KEY (buildingid) REFERENCES public.buildings(buildingid) NOT VALID;


--
-- Name: infoscreens buildingid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.infoscreens
    ADD CONSTRAINT buildingid_fkey FOREIGN KEY (buildingid) REFERENCES public.buildings(buildingid) NOT VALID;


--
-- Name: orders byterminal_terminalid_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT byterminal_terminalid_fk FOREIGN KEY (byterminal) REFERENCES public.terminals(terminalid);


--
-- Name: employeesareemployeetypes employeeid_employee_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeesareemployeetypes
    ADD CONSTRAINT employeeid_employee_fk FOREIGN KEY (employeeid) REFERENCES public.employees(employeeid);


--
-- Name: stations fk_station_building; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT fk_station_building FOREIGN KEY (inbuilding) REFERENCES public.buildings(buildingid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: stations stationtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stationtypeid_fkey FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- PostgreSQL database dump complete
--

