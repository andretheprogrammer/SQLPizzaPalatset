# SQLPizzaPalatset 2020

Projektarbete för Grupp 3 PizzaPalatset (Skolprojektarbete).
Ett .Net program med en GUI gjort i Winform ( .NET standard 2.0 )

Programmet är baserat på en relativt normaliserad i databas med DAPPER som avbildare mot en MSSQL 2019 databas.
Programmet fungerar även med PostGres som databas p.g.a "Repository pattern" används vid översättning av rader-till-objekt.

-------------------------------------------------------

## Installations guide: 

# 1: Klona projektet.

# A) Importera MSSQL databasfilen G3Systems.SQL
- Copy-pasta all text i textfilen som en Query i SQL Server. 
- Nu har du en databas G3Systems

# B) Importera PostGres Databasfilen:
- Ladda ner databasfilen Alpha6.tar
- Importera den i PGAdmin

# C) I solutions: Konfigurera App.config 
- Skriv in server detaljer för sqlserver
- Skriv in server detaljer för pgadmin
- Välj npgsqlBackend value="true" om du vill köra med postgres databasen. 


-------------------------------------------------------

## Innehåller: 
dynamisk och responsiv GUI för : Login, Kundköp, Administration, Kassörska, Infoskärm och Bagare.

## Funktionalitet: 
Det är mycket enkelt att utvidga programmet för fler typer av stationer, typer av anstälda, produkter, produkttyper, restriktioner av pålägg osv. 

## Dependencies: 
Dapper 
.Net Framework 4.7 (för GUI)
Standard 2.0 
SQL Server 2018
PostGres v.12
