SPOOL salida_DELETE_ALL_DB.txt

--------------------------- DATA ------------------------

/* 
--> Requiered INSERTS for the Service Templates to work.
	The service templates are used to test in the framework
	within a real functional context. 
*/
@.\01_Scripts\06_SQL_Data\FRW_TestData\DELETES_ALL_TABLES.sql

--> Requiered INSERTS for the Framework Components to work.
@.\01_Scripts\06_SQL_Data\FRW_CoreData\DELETES_ALL_TABLES.sql

---------------------------------------------------------

------------------------- TRIGGERS ----------------------
@.\01_Scripts\05_SQL_Triggers\DROP_ALL_TRIGGERS.sql
---------------------------------------------------------

------------------------- PACKAGES ----------------------
@.\01_Scripts\04_SQL_Packages\DROP_ALL_PACKAGES.sql
---------------------------------------------------------

------------------------- SEQUENCES ----------------------
@.\01_Scripts\03_SQL_Sequences\DROP_ALL_SEQUENCES.sql
----------------------------------------------------------

------------------------- TYPES --------------------------
@.\01_Scripts\02_SQL_Types\DROP_ALL_TYPES.sql
----------------------------------------------------------

------------------------- TABLES -------------------------
@.\01_Scripts\01_SQL_Tables\DROP_ALL_TABLES.sql
----------------------------------------------------------

SPOOL OFF;

