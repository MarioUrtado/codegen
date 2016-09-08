SPOOL salida_CREATE_ALL_DB.txt

------------------------- TABLES -------------------------
@.\01_Scripts\01_SQL_Tables\CREATE_ALL_TABLES.sql
@.\01_Scripts\01_SQL_Tables\ALTERS_TABLES.sql
----------------------------------------------------------

------------------------- TYPES --------------------------
@.\01_Scripts\02_SQL_Types\CREATE_ALL_TYPES.sql
@.\01_Scripts\02_SQL_Types\ALTER_ALL_TYPES_COMPILE.sql
----------------------------------------------------------

------------------------- SEQUENCES ----------------------
@.\01_Scripts\03_SQL_Sequences\CREATE_ALL_SEQUENCES.sql
----------------------------------------------------------

------------------------- PACKAGES ----------------------
@.\01_Scripts\04_SQL_Packages\CREATE_ALL_PACKAGES.sql
@.\01_Scripts\04_SQL_Packages\ALTERS_ALL_PACKAGES.sql
---------------------------------------------------------

------------------------- TRIGGERS ----------------------
@.\01_Scripts\05_SQL_Triggers\CREATE_ALL_TRIGGERS.sql
@.\01_Scripts\05_SQL_Triggers\ALTERS_ALL_TRIGGERS.sql
---------------------------------------------------------

--------------------------- DATA ------------------------

--> Requiered INSERTS for the Framework Components to work.
@.\01_Scripts\06_SQL_Data\FRW_CoreData\INSERTS_ALL_TABLES.sql

/* 
--> Requiered INSERTS for the Service Templates to work.
	The service templates are used to test in the framework
	within a real functional context. 
*/
@.\01_Scripts\06_SQL_Data\FRW_TestData\INSERTS_ALL_TABLES.sql
---------------------------------------------------------

SPOOL OFF;