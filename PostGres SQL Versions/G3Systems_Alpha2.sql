--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

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

DROP DATABASE "G3Systems";
--
-- Name: G3Systems; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "G3Systems" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Sweden.1252' LC_CTYPE = 'English_Sweden.1252';


ALTER DATABASE "G3Systems" OWNER TO postgres;

\connect "G3Systems"

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
-- Name: ShowDrinksByID(integer); Type: FUNCTION; Schema: public; Owner: grupp3
--

CREATE FUNCTION public."ShowDrinksByID"("inId" integer) RETURNS TABLE(id integer, name character varying, price integer)
    LANGUAGE plpgsql
    AS $$BEGIN
RETURN QUERY
select *
from "Drink"
Where "ID"=inId;
END;$$;


ALTER FUNCTION public."ShowDrinksByID"("inId" integer) OWNER TO grupp3;

--
-- Name: proc_deleteproducttype(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_deleteproducttype(producttypeid integer) OWNER TO grupp3;

--
-- Name: proc_getassignedstation(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_getassignedstation(employeeid integer) OWNER TO grupp3;

--
-- Name: proc_getemployeelogin(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.proc_getemployeelogin(p_username character varying, p_password character varying) RETURNS TABLE(employeeid integer, username character varying, password character varying, loggedin boolean, activated boolean, visible boolean, assignedtostation integer)
    LANGUAGE plpgsql
    AS $$

        begin
        return query
            SELECT * FROM employees WHERE
            employees.Username = p_Username 
            AND employees.Password = p_Password;
        end;
$$;


ALTER FUNCTION public.proc_getemployeelogin(p_username character varying, p_password character varying) OWNER TO postgres;

--
-- Name: proc_getpossiblestationsforemployee(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_getpossiblestationsforemployee(employeeid integer) OWNER TO grupp3;

--
-- Name: proc_getproductinfofrompo(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_getproductinfofrompo(productorderid integer) OWNER TO grupp3;

--
-- Name: proc_getproducttypes(); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_getproducttypes() OWNER TO grupp3;

--
-- Name: proc_getstuffings(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_getstuffings(productorderid integer) OWNER TO grupp3;

--
-- Name: proc_ingredientsetcreate(integer, character varying, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_ingredientsetcreate(ingredientid integer, ingredientname character varying, price integer, activated integer, visible integer) OWNER TO grupp3;

--
-- Name: proc_leftcolumninfoscreen(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_leftcolumninfoscreen(buildingid integer) OWNER TO grupp3;

--
-- Name: proc_openorders(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_openorders(buildingid integer) OWNER TO grupp3;

--
-- Name: proc_orderssetcreate(integer, integer, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_orderssetcreate(orderid integer, byterminal integer, paid boolean, canceled boolean, pickedup boolean, showonscreen boolean, happycustomer boolean, returned boolean, activated boolean, visible boolean) OWNER TO grupp3;

--
-- Name: proc_polockedbystation(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_polockedbystation(stationid integer) OWNER TO grupp3;

--
-- Name: proc_producthasingredients(integer); Type: PROCEDURE; Schema: public; Owner: grupp3
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


ALTER PROCEDURE public.proc_producthasingredients(integer) OWNER TO grupp3;

--
-- Name: proc_productorderssetcreate(integer, integer, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_productorderssetcreate(productorderid integer, productid integer, orderid boolean, lockedbystation boolean, processed boolean, activated boolean, visible boolean) OWNER TO grupp3;

--
-- Name: proc_productsetcreate(integer, integer, character varying, character varying, integer, integer, boolean, boolean); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_productsetcreate(productid integer, producttypeid integer, productname character varying, description character varying, preptime integer, baseprice integer, activated boolean, visible boolean) OWNER TO grupp3;

--
-- Name: proc_producttypesetcreate(integer, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_producttypesetcreate(producttypeid integer, producttypename character varying, activated integer, visible integer) OWNER TO grupp3;

--
-- Name: proc_rightcolumninfoscreen(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_rightcolumninfoscreen(buildingid integer) OWNER TO grupp3;

--
-- Name: proc_setemployeetostation(integer, integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_setemployeetostation(employeeid integer, stationid integer) OWNER TO grupp3;

--
-- Name: proc_setlockedbystation(integer, integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_setlockedbystation(productorderid integer, stationid integer) OWNER TO grupp3;

--
-- Name: proc_setprocessed(integer, boolean); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.proc_setprocessed(productorderid integer, processed boolean) OWNER TO grupp3;

--
-- Name: setpickedup(integer, boolean); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.setpickedup(orderid integer, pickedup boolean) OWNER TO grupp3;

--
-- Name: showOrderByID(); Type: FUNCTION; Schema: public; Owner: grupp3
--

CREATE FUNCTION public."showOrderByID"() RETURNS TABLE(id integer, status integer, employeeid integer)
    LANGUAGE plpgsql
    AS $$BEGIN
return query
select *
from "Order"
order by "ID";
END;$$;


ALTER FUNCTION public."showOrderByID"() OWNER TO grupp3;

--
-- Name: spgetproductingredients(integer); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.spgetproductingredients(productid integer) OWNER TO grupp3;

--
-- Name: spverifylogin(character varying, character varying); Type: FUNCTION; Schema: public; Owner: grupp3
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


ALTER FUNCTION public.spverifylogin(p_username character varying, p_password character varying) OWNER TO grupp3;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.buildings (
    buildingid integer NOT NULL,
    buildingname character varying(50) NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.buildings OWNER TO grupp3;

--
-- Name: choices; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.choices (
    id integer NOT NULL,
    issubto integer,
    stringrep character varying(100) DEFAULT 'unnamed choice'::character varying,
    description character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.choices OWNER TO grupp3;

--
-- Name: choices_id_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: employees; Type: TABLE; Schema: public; Owner: grupp3
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


ALTER TABLE public.employees OWNER TO grupp3;

--
-- Name: employeesareemployeetypes; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.employeesareemployeetypes (
    employeeid integer NOT NULL,
    employeetypeid integer NOT NULL
);


ALTER TABLE public.employeesareemployeetypes OWNER TO grupp3;

--
-- Name: employeeshaveproductorderslockedinstations; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.employeeshaveproductorderslockedinstations (
    employeeid integer NOT NULL,
    productorderid integer NOT NULL,
    stationid integer NOT NULL
);


ALTER TABLE public.employeeshaveproductorderslockedinstations OWNER TO grupp3;

--
-- Name: employeetypecanworkinstationtype; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.employeetypecanworkinstationtype (
    employeetypeid integer NOT NULL,
    stationtypeid integer NOT NULL
);


ALTER TABLE public.employeetypecanworkinstationtype OWNER TO grupp3;

--
-- Name: employeetypes; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.employeetypes (
    employeetypeid integer NOT NULL,
    employeetypename character varying(50) DEFAULT 'unnamed'::character varying NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.employeetypes OWNER TO grupp3;

--
-- Name: employeetypes_employeetypeid_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: infoscreens; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.infoscreens (
    id integer NOT NULL,
    buildingid integer NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.infoscreens OWNER TO grupp3;

--
-- Name: infoscreens_id_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: ingredients; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.ingredients (
    ingredientid integer NOT NULL,
    ingredientname character varying DEFAULT 'unnamed'::character varying NOT NULL,
    price integer DEFAULT 5 NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.ingredients OWNER TO grupp3;

--
-- Name: ingedients_ingredientid_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: orders; Type: TABLE; Schema: public; Owner: grupp3
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


ALTER TABLE public.orders OWNER TO grupp3;

--
-- Name: orderwastreatedbyemployeeatstation; Type: TABLE; Schema: public; Owner: grupp3
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


ALTER TABLE public.orderwastreatedbyemployeeatstation OWNER TO grupp3;

--
-- Name: orderwastreatedbyemployeeatstation_treatment_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: possiblecommandsinstationtype; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.possiblecommandsinstationtype (
    methodsignature integer NOT NULL,
    stationtypeid integer NOT NULL,
    choice integer NOT NULL,
    connectedprocedure integer
);


ALTER TABLE public.possiblecommandsinstationtype OWNER TO grupp3;

--
-- Name: possiblecommandsinstationtype_methodsignature_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: productcanhaveingredients; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.productcanhaveingredients (
    reference integer NOT NULL,
    productid integer NOT NULL,
    ingredientid integer NOT NULL
);


ALTER TABLE public.productcanhaveingredients OWNER TO grupp3;

--
-- Name: productcanhaveingredients_reference_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: producthaveingredients; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.producthaveingredients (
    reference integer NOT NULL,
    productid integer NOT NULL,
    ingredientid integer NOT NULL
);


ALTER TABLE public.producthaveingredients OWNER TO grupp3;

--
-- Name: producthaveingredients_reference_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: productorders; Type: TABLE; Schema: public; Owner: grupp3
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


ALTER TABLE public.productorders OWNER TO grupp3;

--
-- Name: products; Type: TABLE; Schema: public; Owner: grupp3
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


ALTER TABLE public.products OWNER TO grupp3;

--
-- Name: products_productid_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: producttypes; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.producttypes (
    producttypeid integer NOT NULL,
    producttypename character varying DEFAULT 'unnamed'::character varying NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.producttypes OWNER TO grupp3;

--
-- Name: producttypes_producttypeid_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: stations; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.stations (
    stationid integer NOT NULL,
    stationname character varying(50) DEFAULT 'unnamed'::character varying NOT NULL,
    stationtypeid integer,
    inbuilding integer,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.stations OWNER TO grupp3;

--
-- Name: stationtypes; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.stationtypes (
    stationtypeid integer NOT NULL,
    stationtypename character varying(50),
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    dangerlevel integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.stationtypes OWNER TO grupp3;

--
-- Name: stuffings; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.stuffings (
    "Lump" integer NOT NULL,
    productorderid integer NOT NULL,
    ingredientid integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.stuffings OWNER TO grupp3;

--
-- Name: terminals; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.terminals (
    terminalid integer NOT NULL,
    terminalname character varying NOT NULL,
    buildingid integer,
    activated boolean DEFAULT true NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    available boolean DEFAULT true NOT NULL
);


ALTER TABLE public.terminals OWNER TO grupp3;

--
-- Name: typecanhaveingredients; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.typecanhaveingredients (
    approvedingredient integer NOT NULL,
    producttypeid integer NOT NULL,
    ingredientid integer NOT NULL,
    isdemanded boolean DEFAULT false NOT NULL,
    maxunits integer DEFAULT 3 NOT NULL
);


ALTER TABLE public.typecanhaveingredients OWNER TO grupp3;

--
-- Name: typecanhaveingredients_approvedingredient_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Name: typeismadeinstationtype; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.typeismadeinstationtype (
    producttypeid integer NOT NULL,
    stationtypeid integer NOT NULL
);


ALTER TABLE public.typeismadeinstationtype OWNER TO grupp3;

--
-- Name: typerestrictions; Type: TABLE; Schema: public; Owner: grupp3
--

CREATE TABLE public.typerestrictions (
    restriction integer NOT NULL,
    producttypeid integer NOT NULL,
    approvedingredient integer NOT NULL,
    cannotmixwith integer NOT NULL
);


ALTER TABLE public.typerestrictions OWNER TO grupp3;

--
-- Name: typerestrictions_restriction_seq; Type: SEQUENCE; Schema: public; Owner: grupp3
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
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.buildings (buildingid, buildingname, activated, visible) VALUES (1, 'TonysMainPizzaHouse', true, true);
INSERT INTO public.buildings (buildingid, buildingname, activated, visible) VALUES (2, 'Tonys UnderGroundPizza', false, true);


--
-- Data for Name: choices; Type: TABLE DATA; Schema: public; Owner: grupp3
--



--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.employees (employeeid, username, password, loggedin, activated, visible, assignedtostation) VALUES (1, 'Admin', 'tja', false, true, true, 2);
INSERT INTO public.employees (employeeid, username, password, loggedin, activated, visible, assignedtostation) VALUES (2, 'LisaCashier', '0', false, true, true, 3);
INSERT INTO public.employees (employeeid, username, password, loggedin, activated, visible, assignedtostation) VALUES (3, 'BageyTheBaker', '0', false, true, true, 4);
INSERT INTO public.employees (employeeid, username, password, loggedin, activated, visible, assignedtostation) VALUES (4, 'IceyTheIceman', '0', false, true, true, 5);


--
-- Data for Name: employeesareemployeetypes; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.employeesareemployeetypes (employeeid, employeetypeid) VALUES (1, 4);
INSERT INTO public.employeesareemployeetypes (employeeid, employeetypeid) VALUES (2, 3);
INSERT INTO public.employeesareemployeetypes (employeeid, employeetypeid) VALUES (3, 2);
INSERT INTO public.employeesareemployeetypes (employeeid, employeetypeid) VALUES (4, 1);


--
-- Data for Name: employeeshaveproductorderslockedinstations; Type: TABLE DATA; Schema: public; Owner: grupp3
--



--
-- Data for Name: employeetypecanworkinstationtype; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.employeetypecanworkinstationtype (employeetypeid, stationtypeid) VALUES (1, 1);
INSERT INTO public.employeetypecanworkinstationtype (employeetypeid, stationtypeid) VALUES (1, 2);
INSERT INTO public.employeetypecanworkinstationtype (employeetypeid, stationtypeid) VALUES (1, 3);
INSERT INTO public.employeetypecanworkinstationtype (employeetypeid, stationtypeid) VALUES (1, 4);
INSERT INTO public.employeetypecanworkinstationtype (employeetypeid, stationtypeid) VALUES (2, 2);
INSERT INTO public.employeetypecanworkinstationtype (employeetypeid, stationtypeid) VALUES (3, 4);
INSERT INTO public.employeetypecanworkinstationtype (employeetypeid, stationtypeid) VALUES (4, 5);


--
-- Data for Name: employeetypes; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.employeetypes (employeetypeid, employeetypename, activated, visible) VALUES (1, 'Chef', true, true);
INSERT INTO public.employeetypes (employeetypeid, employeetypename, activated, visible) VALUES (2, 'Pizzabaker', true, true);
INSERT INTO public.employeetypes (employeetypeid, employeetypename, activated, visible) VALUES (3, 'Cashier', true, true);
INSERT INTO public.employeetypes (employeetypeid, employeetypename, activated, visible) VALUES (4, 'Administrator', true, true);
INSERT INTO public.employeetypes (employeetypeid, employeetypename, activated, visible) VALUES (5, 'Incompetent', true, true);


--
-- Data for Name: infoscreens; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.infoscreens (id, buildingid, activated, visible) VALUES (1, 1, true, true);


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (1, 'Salami', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (2, 'Kebabkött', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (3, 'Cheddar', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (4, 'Mozarella', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (5, 'Fefferoni', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (6, 'Gräddost', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (7, 'Amerikansk Deg', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (8, 'Italiensk Deg', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (9, 'Extra Snabb Tillagning', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (10, 'Kycklingfilé', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (11, 'Ostkub', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (12, 'KoktPasta', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (13, 'Bulgur', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (14, 'Snuspåse', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (15, 'Oliver', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (16, 'Ananas', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (17, 'Tonfisk', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (18, 'Gul Lök', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (19, 'Championer', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (20, 'Tomatsås', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (21, 'Skinka', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (22, 'Ruccola', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (23, 'Tacosås', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (24, 'Gräddfil', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (25, 'Avocado', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (26, 'Paprika', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (27, 'Köttfärs', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (28, 'Chilisås', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (29, 'Isbergssallad', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (30, 'Röd Lök', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (31, 'Rhode Island dressing', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (32, 'Vinägrett', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (33, 'Vitlöksdressing', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (34, 'Vitlökssås', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (35, 'Bearnaise', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (36, 'Vitlök', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (37, 'Persilja', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (38, 'Ceasardressing', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (39, 'Räkor', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (40, 'Ägg', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (41, 'Spenat', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (42, 'Kronärtskocka', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (43, 'Fetaost', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (44, 'Musslor', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (45, 'Bacon', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (46, 'Parmaskinka', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (47, 'Parmesanost', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (48, 'Gurka', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (49, 'Färska Tomater', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (50, 'Grön Chili', 5, true, true);
INSERT INTO public.ingredients (ingredientid, ingredientname, price, activated, visible) VALUES (51, 'TacoMix', 5, true, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (78, 2, true, false, true, true, true, false, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (79, 2, false, true, false, true, true, false, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (80, 2, true, false, false, true, true, true, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (81, 2, true, false, false, true, true, false, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (82, 2, true, false, false, true, true, false, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (83, 2, false, false, false, true, true, false, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (84, 2, false, true, false, true, true, false, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (85, 2, true, false, false, true, true, false, true, true);
INSERT INTO public.orders (orderid, byterminal, paid, canceled, pickedup, showonscreen, happycustomer, returned, activated, visible) VALUES (86, 2, true, false, false, true, true, false, true, true);


--
-- Data for Name: orderwastreatedbyemployeeatstation; Type: TABLE DATA; Schema: public; Owner: grupp3
--



--
-- Data for Name: possiblecommandsinstationtype; Type: TABLE DATA; Schema: public; Owner: grupp3
--



--
-- Data for Name: productcanhaveingredients; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (11, 1, 35);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (12, 1, 2);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (13, 1, 3);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (14, 1, 4);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (15, 1, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (16, 1, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (17, 1, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (18, 1, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (19, 1, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (20, 1, 15);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (21, 1, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (22, 1, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (23, 1, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (24, 1, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (25, 1, 26);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (26, 1, 28);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (27, 1, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (28, 2, 2);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (29, 2, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (30, 2, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (31, 2, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (32, 2, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (33, 2, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (34, 2, 15);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (35, 2, 16);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (36, 2, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (37, 2, 19);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (38, 2, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (39, 2, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (40, 2, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (41, 2, 23);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (42, 2, 24);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (43, 2, 25);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (44, 2, 26);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (45, 2, 28);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (46, 2, 29);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (47, 2, 30);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (48, 2, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (49, 2, 35);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (50, 2, 36);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (51, 3, 3);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (52, 3, 4);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (53, 3, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (54, 3, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (55, 3, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (56, 3, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (57, 3, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (58, 3, 15);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (59, 3, 16);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (60, 3, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (61, 3, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (62, 3, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (63, 3, 26);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (64, 3, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (65, 3, 35);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (66, 4, 4);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (67, 4, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (68, 4, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (69, 4, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (70, 4, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (71, 4, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (72, 4, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (73, 4, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (74, 4, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (75, 4, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (76, 4, 23);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (77, 4, 24);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (78, 4, 25);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (79, 4, 26);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (80, 4, 27);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (81, 4, 28);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (82, 4, 30);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (83, 4, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (84, 4, 36);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (85, 4, 37);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (86, 11, 4);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (87, 11, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (88, 11, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (89, 11, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (90, 11, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (91, 11, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (92, 11, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (93, 11, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (94, 11, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (95, 11, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (96, 11, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (97, 11, 35);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (98, 11, 36);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (99, 11, 37);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (100, 11, 39);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (101, 11, 41);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (102, 11, 44);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (103, 11, 47);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (104, 9, 3);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (105, 9, 4);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (106, 9, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (107, 9, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (108, 9, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (109, 9, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (110, 9, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (111, 9, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (112, 7, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (113, 7, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (114, 7, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (115, 7, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (116, 7, 15);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (117, 7, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (118, 7, 19);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (119, 7, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (120, 7, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (121, 7, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (122, 7, 23);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (123, 7, 24);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (124, 7, 25);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (125, 7, 26);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (126, 7, 27);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (127, 7, 28);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (128, 7, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (129, 7, 35);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (130, 7, 36);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (131, 7, 45);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (132, 7, 46);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (133, 10, 1);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (134, 10, 2);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (135, 10, 3);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (136, 10, 4);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (137, 10, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (138, 10, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (139, 10, 7);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (140, 10, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (141, 10, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (142, 10, 15);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (143, 10, 19);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (144, 10, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (145, 10, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (146, 10, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (147, 10, 23);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (148, 10, 27);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (149, 10, 28);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (150, 10, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (151, 10, 35);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (152, 10, 45);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (153, 10, 46);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (154, 10, 47);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (155, 8, 6);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (156, 8, 8);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (157, 8, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (158, 8, 19);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (159, 8, 20);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (160, 8, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (161, 8, 28);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (162, 8, 34);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (163, 8, 35);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (164, 5, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (165, 5, 10);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (166, 5, 11);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (167, 5, 12);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (168, 5, 13);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (169, 5, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (170, 5, 19);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (171, 5, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (172, 5, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (173, 5, 25);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (174, 5, 26);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (175, 5, 29);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (176, 5, 30);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (177, 5, 31);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (178, 5, 32);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (179, 5, 33);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (180, 5, 36);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (181, 5, 37);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (182, 5, 47);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (183, 6, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (184, 6, 10);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (185, 6, 11);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (186, 6, 12);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (187, 6, 13);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (188, 6, 15);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (189, 6, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (190, 6, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (191, 6, 25);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (192, 6, 29);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (193, 6, 30);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (194, 6, 31);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (195, 6, 32);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (196, 6, 33);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (197, 6, 36);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (198, 6, 37);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (199, 6, 38);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (200, 6, 39);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (201, 6, 40);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (202, 6, 45);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (203, 6, 47);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (204, 12, 4);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (205, 12, 5);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (206, 12, 9);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (207, 12, 10);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (208, 12, 12);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (209, 12, 13);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (210, 12, 15);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (211, 12, 17);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (212, 12, 18);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (213, 12, 21);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (214, 12, 22);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (215, 12, 25);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (216, 12, 29);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (217, 12, 30);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (218, 12, 31);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (219, 12, 32);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (220, 12, 33);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (221, 12, 39);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (222, 12, 40);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (223, 12, 41);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (224, 12, 42);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (225, 12, 43);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (226, 12, 46);
INSERT INTO public.productcanhaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (227, 1, 10);


--
-- Data for Name: producthaveingredients; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (4, 1, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (5, 1, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (6, 1, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (7, 1, 21);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (8, 2, 2);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (9, 2, 5);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (10, 2, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (11, 2, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (12, 2, 34);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (13, 2, 49);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (14, 3, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (15, 3, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (16, 3, 19);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (17, 3, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (18, 3, 21);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (19, 4, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (20, 4, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (21, 4, 18);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (22, 4, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (23, 4, 23);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (24, 4, 27);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (25, 4, 50);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (26, 4, 51);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (27, 7, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (28, 7, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (29, 7, 18);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (30, 7, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (31, 7, 27);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (32, 7, 40);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (33, 8, 4);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (34, 8, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (35, 8, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (36, 8, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (37, 8, 21);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (38, 9, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (39, 9, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (40, 9, 16);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (41, 9, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (42, 9, 21);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (43, 10, 3);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (44, 10, 4);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (45, 10, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (46, 10, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (47, 10, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (48, 10, 47);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (49, 11, 6);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (50, 11, 8);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (51, 11, 20);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (52, 11, 39);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (53, 11, 44);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (54, 5, 10);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (55, 5, 11);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (56, 5, 12);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (57, 5, 22);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (58, 5, 25);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (59, 5, 29);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (60, 5, 30);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (61, 5, 31);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (62, 5, 45);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (63, 5, 47);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (64, 5, 48);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (65, 6, 10);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (66, 6, 18);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (67, 6, 29);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (68, 6, 30);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (69, 6, 38);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (70, 6, 45);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (71, 6, 47);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (72, 6, 48);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (73, 6, 49);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (74, 12, 13);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (75, 12, 22);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (76, 12, 25);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (77, 12, 26);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (78, 12, 29);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (79, 12, 30);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (80, 12, 31);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (81, 11, 41);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (82, 11, 42);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (83, 11, 43);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (84, 11, 48);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (85, 11, 49);
INSERT INTO public.producthaveingredients (reference, productid, ingredientid) OVERRIDING SYSTEM VALUE VALUES (87, 1, 10);


--
-- Data for Name: productorders; Type: TABLE DATA; Schema: public; Owner: grupp3
--



--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (1, 1, 'Vesuvio', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (2, 1, 'KebabPizza', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (3, 1, 'Capricosa', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (4, 1, 'Mexicana', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (5, 2, 'ChickenSalad', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (6, 2, 'CeasarSalad', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (7, 1, 'Bolognese', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (8, 1, 'Calzone', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (9, 1, 'Hawaii', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (10, 1, 'QuattroFormaggio', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (11, 1, 'Marinara', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (12, 2, 'FetaSalad', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (13, 5, 'CocaCola', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (14, 5, 'Sprite', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (15, 5, 'Fanta', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (16, 5, 'Red Bull', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (17, 6, 'PommesFrites', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (18, 6, 'FriedChicken', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (19, 3, 'Magnum Almond', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (20, 3, 'Sandwich', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (21, 3, 'Solero', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (22, 3, 'Twister', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (23, 3, 'Igloo', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (24, 4, 'OrangeJuice', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (25, 4, 'AppleJuice', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (26, 4, 'GamerJuice', 'no description', 500, 100, true, true);
INSERT INTO public.products (productid, producttypeid, productname, description, preptime, baseprice, activated, visible) VALUES (27, 5, 'CocaCola Strawberrytaste', 'no description', 500, 100, false, true);


--
-- Data for Name: producttypes; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.producttypes (producttypeid, producttypename, activated, visible) OVERRIDING SYSTEM VALUE VALUES (1, 'Pizza', true, true);
INSERT INTO public.producttypes (producttypeid, producttypename, activated, visible) OVERRIDING SYSTEM VALUE VALUES (2, 'Sallad', true, true);
INSERT INTO public.producttypes (producttypeid, producttypename, activated, visible) OVERRIDING SYSTEM VALUE VALUES (3, 'IceCream', true, true);
INSERT INTO public.producttypes (producttypeid, producttypename, activated, visible) OVERRIDING SYSTEM VALUE VALUES (4, 'Fresh Juice', true, true);
INSERT INTO public.producttypes (producttypeid, producttypename, activated, visible) OVERRIDING SYSTEM VALUE VALUES (5, 'Drinks', true, true);
INSERT INTO public.producttypes (producttypeid, producttypename, activated, visible) OVERRIDING SYSTEM VALUE VALUES (6, 'Extras', true, true);
INSERT INTO public.producttypes (producttypeid, producttypename, activated, visible) OVERRIDING SYSTEM VALUE VALUES (7, 'bildäck', true, true);


--
-- Data for Name: stations; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.stations (stationid, stationname, stationtypeid, inbuilding, activated, visible) VALUES (2, 'Mini SaladBar', 1, NULL, true, true);
INSERT INTO public.stations (stationid, stationname, stationtypeid, inbuilding, activated, visible) VALUES (3, 'Corner PizzaStation', 1, NULL, true, true);
INSERT INTO public.stations (stationid, stationname, stationtypeid, inbuilding, activated, visible) VALUES (4, 'Quick IceCreamBar', 1, NULL, true, true);
INSERT INTO public.stations (stationid, stationname, stationtypeid, inbuilding, activated, visible) VALUES (5, 'Cashier 1', 1, NULL, true, true);
INSERT INTO public.stations (stationid, stationname, stationtypeid, inbuilding, activated, visible) VALUES (6, 'Cashier 2', 1, NULL, true, true);
INSERT INTO public.stations (stationid, stationname, stationtypeid, inbuilding, activated, visible) VALUES (7, 'Cashier 3', 1, NULL, true, true);
INSERT INTO public.stations (stationid, stationname, stationtypeid, inbuilding, activated, visible) VALUES (8, 'First Office', 1, NULL, true, true);


--
-- Data for Name: stationtypes; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.stationtypes (stationtypeid, stationtypename, activated, visible, dangerlevel) VALUES (1, 'Salladsbar', true, true, 0);
INSERT INTO public.stationtypes (stationtypeid, stationtypename, activated, visible, dangerlevel) VALUES (2, 'BigPizzaStation', true, true, 0);
INSERT INTO public.stationtypes (stationtypeid, stationtypename, activated, visible, dangerlevel) VALUES (3, 'IceCreamBar', true, true, 0);
INSERT INTO public.stationtypes (stationtypeid, stationtypename, activated, visible, dangerlevel) VALUES (4, 'Cashier', true, true, 0);
INSERT INTO public.stationtypes (stationtypeid, stationtypename, activated, visible, dangerlevel) VALUES (5, 'Office', true, true, 0);


--
-- Data for Name: stuffings; Type: TABLE DATA; Schema: public; Owner: grupp3
--



--
-- Data for Name: terminals; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.terminals (terminalid, terminalname, buildingid, activated, visible, available) VALUES (1, 'klas', 1, true, true, true);
INSERT INTO public.terminals (terminalid, terminalname, buildingid, activated, visible, available) VALUES (2, 'lasse', 1, true, true, true);
INSERT INTO public.terminals (terminalid, terminalname, buildingid, activated, visible, available) VALUES (3, 'unnamed', 1, true, true, true);


--
-- Data for Name: typecanhaveingredients; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (11, 1, 1, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (14, 1, 2, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (15, 1, 3, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (16, 1, 4, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (17, 1, 5, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (18, 1, 6, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (19, 1, 7, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (20, 1, 8, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (21, 1, 9, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (22, 1, 15, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (23, 1, 16, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (24, 1, 17, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (25, 1, 18, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (26, 1, 19, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (27, 1, 20, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (28, 1, 21, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (29, 1, 22, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (30, 1, 23, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (31, 1, 24, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (32, 1, 25, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (33, 1, 26, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (34, 1, 27, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (35, 1, 28, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (36, 1, 30, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (37, 1, 34, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (38, 1, 35, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (39, 1, 36, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (40, 1, 37, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (41, 1, 39, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (42, 1, 40, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (43, 1, 41, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (44, 1, 42, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (45, 1, 43, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (46, 1, 44, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (47, 1, 45, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (48, 1, 46, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (49, 1, 47, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (50, 1, 49, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (51, 1, 50, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (52, 1, 51, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (56, 2, 2, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (57, 2, 4, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (58, 2, 5, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (59, 2, 9, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (60, 2, 10, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (61, 2, 11, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (62, 2, 12, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (63, 2, 13, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (64, 2, 15, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (65, 2, 16, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (66, 2, 17, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (67, 2, 18, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (68, 2, 19, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (69, 2, 21, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (70, 2, 22, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (71, 2, 25, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (72, 2, 26, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (73, 2, 29, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (74, 2, 30, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (75, 2, 31, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (76, 2, 32, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (77, 2, 33, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (78, 2, 36, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (79, 2, 37, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (80, 2, 38, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (81, 2, 39, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (82, 2, 40, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (83, 2, 41, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (84, 2, 42, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (85, 2, 43, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (86, 2, 45, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (87, 2, 46, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (88, 2, 48, false, 3);
INSERT INTO public.typecanhaveingredients (approvedingredient, producttypeid, ingredientid, isdemanded, maxunits) OVERRIDING SYSTEM VALUE VALUES (89, 2, 49, false, 3);


--
-- Data for Name: typeismadeinstationtype; Type: TABLE DATA; Schema: public; Owner: grupp3
--

INSERT INTO public.typeismadeinstationtype (producttypeid, stationtypeid) VALUES (1, 2);
INSERT INTO public.typeismadeinstationtype (producttypeid, stationtypeid) VALUES (2, 1);
INSERT INTO public.typeismadeinstationtype (producttypeid, stationtypeid) VALUES (3, 3);
INSERT INTO public.typeismadeinstationtype (producttypeid, stationtypeid) VALUES (4, 3);
INSERT INTO public.typeismadeinstationtype (producttypeid, stationtypeid) VALUES (5, 5);
INSERT INTO public.typeismadeinstationtype (producttypeid, stationtypeid) VALUES (6, 5);


--
-- Data for Name: typerestrictions; Type: TABLE DATA; Schema: public; Owner: grupp3
--



--
-- Name: choices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.choices_id_seq', 1, false);


--
-- Name: employeetypes_employeetypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.employeetypes_employeetypeid_seq', 1, false);


--
-- Name: infoscreens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.infoscreens_id_seq', 1, false);


--
-- Name: ingedients_ingredientid_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.ingedients_ingredientid_seq', 1, false);


--
-- Name: orderwastreatedbyemployeeatstation_treatment_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.orderwastreatedbyemployeeatstation_treatment_seq', 1, false);


--
-- Name: possiblecommandsinstationtype_methodsignature_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.possiblecommandsinstationtype_methodsignature_seq', 1, false);


--
-- Name: productcanhaveingredients_reference_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.productcanhaveingredients_reference_seq', 227, true);


--
-- Name: producthaveingredients_reference_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.producthaveingredients_reference_seq', 87, true);


--
-- Name: products_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.products_productid_seq', 53, true);


--
-- Name: producttypes_producttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.producttypes_producttypeid_seq', 8, true);


--
-- Name: typecanhaveingredients_approvedingredient_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.typecanhaveingredients_approvedingredient_seq', 89, true);


--
-- Name: typerestrictions_restriction_seq; Type: SEQUENCE SET; Schema: public; Owner: grupp3
--

SELECT pg_catalog.setval('public.typerestrictions_restriction_seq', 1, true);


--
-- Name: stuffings UC_POIngredient; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT "UC_POIngredient" UNIQUE (productorderid) INCLUDE (ingredientid);


--
-- Name: productorders UC_ProductOrders_ID; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "UC_ProductOrders_ID" UNIQUE (productorderid);


--
-- Name: productorders UC_ProductOrders_LockedByStation; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "UC_ProductOrders_LockedByStation" UNIQUE (lockedbystation);


--
-- Name: products UC_Products_NameTypeCombo; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "UC_Products_NameTypeCombo" UNIQUE (productname) INCLUDE (producttypeid);


--
-- Name: typerestrictions UC_TypeINGTypeRestriction_Ingred; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "UC_TypeINGTypeRestriction_Ingred" UNIQUE (cannotmixwith);


--
-- Name: typerestrictions UC_TypeINGTypeRestriction_Ingredient; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "UC_TypeINGTypeRestriction_Ingredient" UNIQUE (producttypeid) INCLUDE (approvedingredient);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (buildingid);


--
-- Name: choices choices_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.choices
    ADD CONSTRAINT choices_pkey PRIMARY KEY (id);


--
-- Name: employeesareemployeetypes employeesareemployeetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeesareemployeetypes
    ADD CONSTRAINT employeesareemployeetypes_pkey PRIMARY KEY (employeeid, employeetypeid);


--
-- Name: employeeshaveproductorderslockedinstations employeeshaveproductorderslockedinstations_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT employeeshaveproductorderslockedinstations_pkey PRIMARY KEY (employeeid, productorderid, stationid);


--
-- Name: employeetypecanworkinstationtype employeetypecanworkinstationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeetypecanworkinstationtype
    ADD CONSTRAINT employeetypecanworkinstationtype_pkey PRIMARY KEY (employeetypeid, stationtypeid);


--
-- Name: employeetypes employeetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeetypes
    ADD CONSTRAINT employeetypes_pkey PRIMARY KEY (employeetypeid);


--
-- Name: employees empoyees_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT empoyees_pkey PRIMARY KEY (employeeid);


--
-- Name: infoscreens infoscreens_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.infoscreens
    ADD CONSTRAINT infoscreens_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingedients_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingedients_pkey PRIMARY KEY (ingredientid);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderid);


--
-- Name: orderwastreatedbyemployeeatstation orderwastreatedbyemployeeatstation_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT orderwastreatedbyemployeeatstation_pkey PRIMARY KEY (treatment);


--
-- Name: possiblecommandsinstationtype possiblecommandsinstationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.possiblecommandsinstationtype
    ADD CONSTRAINT possiblecommandsinstationtype_pkey PRIMARY KEY (choice, stationtypeid);


--
-- Name: productcanhaveingredients productcanhaveingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productcanhaveingredients
    ADD CONSTRAINT productcanhaveingredients_pkey PRIMARY KEY (reference);


--
-- Name: producthaveingredients producthaveingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.producthaveingredients
    ADD CONSTRAINT producthaveingredients_pkey PRIMARY KEY (reference);


--
-- Name: productorders productorders_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT productorders_pkey PRIMARY KEY (productorderid, productid);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- Name: producttypes producttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.producttypes
    ADD CONSTRAINT producttypes_pkey PRIMARY KEY (producttypeid);


--
-- Name: stations stations_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (stationid);


--
-- Name: stationtypes stationtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stationtypes
    ADD CONSTRAINT stationtypes_pkey PRIMARY KEY (stationtypeid);


--
-- Name: stuffings stuffings_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT stuffings_pkey PRIMARY KEY ("Lump");


--
-- Name: terminals terminals_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.terminals
    ADD CONSTRAINT terminals_pkey PRIMARY KEY (terminalid);


--
-- Name: typecanhaveingredients typecanhaveingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typecanhaveingredients
    ADD CONSTRAINT typecanhaveingredients_pkey PRIMARY KEY (approvedingredient);


--
-- Name: typeismadeinstationtype typeismadeinstationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typeismadeinstationtype
    ADD CONSTRAINT typeismadeinstationtype_pkey PRIMARY KEY (producttypeid, stationtypeid);


--
-- Name: typerestrictions typerestrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT typerestrictions_pkey PRIMARY KEY (restriction);


--
-- Name: possiblecommandsinstationtype Choices(ID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.possiblecommandsinstationtype
    ADD CONSTRAINT "Choices(ID)_FK" FOREIGN KEY (choice) REFERENCES public.choices(id);


--
-- Name: employeesareemployeetypes EmployeeTypes(EmployeeTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeesareemployeetypes
    ADD CONSTRAINT "EmployeeTypes(EmployeeTypeID)_FK" FOREIGN KEY (employeetypeid) REFERENCES public.employeetypes(employeetypeid);


--
-- Name: employeetypecanworkinstationtype EmployeeTypes(EmployeeTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeetypecanworkinstationtype
    ADD CONSTRAINT "EmployeeTypes(EmployeeTypeID)_FK" FOREIGN KEY (employeetypeid) REFERENCES public.employeetypes(employeetypeid);


--
-- Name: employeeshaveproductorderslockedinstations Employees(EmployeeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT "Employees(EmployeeID)_FK" FOREIGN KEY (employeeid) REFERENCES public.employees(employeeid);


--
-- Name: choices FK_Choices(ID); Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.choices
    ADD CONSTRAINT "FK_Choices(ID)" FOREIGN KEY (issubto) REFERENCES public.choices(id) NOT VALID;


--
-- Name: orderwastreatedbyemployeeatstation FK_Employees(EmployeeID); Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT "FK_Employees(EmployeeID)" FOREIGN KEY (employeeid) REFERENCES public.employees(employeeid);


--
-- Name: orderwastreatedbyemployeeatstation FK_Orders(OrderID); Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT "FK_Orders(OrderID)" FOREIGN KEY (orderid) REFERENCES public.orders(orderid);


--
-- Name: productorders FK_ProdctOrders_Orders; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "FK_ProdctOrders_Orders" FOREIGN KEY (orderid) REFERENCES public.orders(orderid);


--
-- Name: productorders FK_ProductOrders_Product; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "FK_ProductOrders_Product" FOREIGN KEY (productid) REFERENCES public.products(productid);


--
-- Name: productorders FK_ProductOrders_Station; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productorders
    ADD CONSTRAINT "FK_ProductOrders_Station" FOREIGN KEY (lockedbystation) REFERENCES public.stations(stationid);


--
-- Name: typeismadeinstationtype FK_ProductTypes(ProductTypeID); Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typeismadeinstationtype
    ADD CONSTRAINT "FK_ProductTypes(ProductTypeID)" FOREIGN KEY (producttypeid) REFERENCES public.producttypes(producttypeid);


--
-- Name: typeismadeinstationtype FK_StationTypes(StationTypeID); Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typeismadeinstationtype
    ADD CONSTRAINT "FK_StationTypes(StationTypeID)" FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- Name: orderwastreatedbyemployeeatstation FK_Stations(StationID); Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.orderwastreatedbyemployeeatstation
    ADD CONSTRAINT "FK_Stations(StationID)" FOREIGN KEY (stationid) REFERENCES public.stations(stationid);


--
-- Name: stuffings FK_Stuffings_ProductOrder_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT "FK_Stuffings_ProductOrder_FK" FOREIGN KEY (productorderid) REFERENCES public.productorders(productorderid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: typerestrictions FK_TypeRestrictions_ApprovedIngredient; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "FK_TypeRestrictions_ApprovedIngredient" FOREIGN KEY (approvedingredient) REFERENCES public.typecanhaveingredients(approvedingredient) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: typerestrictions FK_TypeRestrictions_CannotMixwithIngredient; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "FK_TypeRestrictions_CannotMixwithIngredient" FOREIGN KEY (cannotmixwith) REFERENCES public.typecanhaveingredients(approvedingredient);


--
-- Name: typerestrictions FK_TypeRestrictions_ProductType; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typerestrictions
    ADD CONSTRAINT "FK_TypeRestrictions_ProductType" FOREIGN KEY (producttypeid) REFERENCES public.producttypes(producttypeid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stuffings Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stuffings
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: typecanhaveingredients Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typecanhaveingredients
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: producthaveingredients Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.producthaveingredients
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: productcanhaveingredients Ingredients(IngredientID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productcanhaveingredients
    ADD CONSTRAINT "Ingredients(IngredientID)_FK" FOREIGN KEY (ingredientid) REFERENCES public.ingredients(ingredientid);


--
-- Name: employeeshaveproductorderslockedinstations ProductOrders(ProductOrderID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT "ProductOrders(ProductOrderID)_FK" FOREIGN KEY (productorderid) REFERENCES public.productorders(productorderid);


--
-- Name: typecanhaveingredients ProductTypes(ProductTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.typecanhaveingredients
    ADD CONSTRAINT "ProductTypes(ProductTypeID)_FK" FOREIGN KEY (producttypeid) REFERENCES public.producttypes(producttypeid);


--
-- Name: productcanhaveingredients Products(ProductID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.productcanhaveingredients
    ADD CONSTRAINT "Products(ProductID)_FK" FOREIGN KEY (productid) REFERENCES public.products(productid) NOT VALID;


--
-- Name: producthaveingredients Products(ProductID)_FK2; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.producthaveingredients
    ADD CONSTRAINT "Products(ProductID)_FK2" FOREIGN KEY (productid) REFERENCES public.products(productid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: employeetypecanworkinstationtype StationTypes(StationTypeID); Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeetypecanworkinstationtype
    ADD CONSTRAINT "StationTypes(StationTypeID)" FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- Name: possiblecommandsinstationtype StationTypes(StationTypeID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.possiblecommandsinstationtype
    ADD CONSTRAINT "StationTypes(StationTypeID)_FK" FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- Name: employeeshaveproductorderslockedinstations Stations(StationID)_FK; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeeshaveproductorderslockedinstations
    ADD CONSTRAINT "Stations(StationID)_FK" FOREIGN KEY (stationid) REFERENCES public.stations(stationid);


--
-- Name: employees assignedtostation_station_fkey; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT assignedtostation_station_fkey FOREIGN KEY (assignedtostation) REFERENCES public.stations(stationid) NOT VALID;


--
-- Name: terminals buildingid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.terminals
    ADD CONSTRAINT buildingid_fkey FOREIGN KEY (buildingid) REFERENCES public.buildings(buildingid) NOT VALID;


--
-- Name: infoscreens buildingid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.infoscreens
    ADD CONSTRAINT buildingid_fkey FOREIGN KEY (buildingid) REFERENCES public.buildings(buildingid) NOT VALID;


--
-- Name: orders byterminal_terminalid_fk; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT byterminal_terminalid_fk FOREIGN KEY (byterminal) REFERENCES public.terminals(terminalid);


--
-- Name: employeesareemployeetypes employeeid_employee_fk; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.employeesareemployeetypes
    ADD CONSTRAINT employeeid_employee_fk FOREIGN KEY (employeeid) REFERENCES public.employees(employeeid);


--
-- Name: stations fk_station_building; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT fk_station_building FOREIGN KEY (inbuilding) REFERENCES public.buildings(buildingid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: stations stationtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: grupp3
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stationtypeid_fkey FOREIGN KEY (stationtypeid) REFERENCES public.stationtypes(stationtypeid);


--
-- PostgreSQL database dump complete
--

