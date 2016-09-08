----------------------------------------------------------  DDL for Table ESB_ERROR_STATUS_TYPE--------------------------------------------------------
  
  CREATE TABLE "ESB_ERROR_STATUS_TYPE"    (	"ID" NUMBER NOT NULL, 	"NAME" VARCHAR2(50 BYTE) NOT NULL, 	"DESCRIPTION" VARCHAR2(255 BYTE), 	"RCD_STATUS" NUMBER(1,0) DEFAULT 1 NOT NULL, 	"CREATIONDATE" DATE DEFAULT CURRENT_DATE, 	 CONSTRAINT "ESB_ERROR_STATUS_TYPE_PK" PRIMARY KEY ("ID"),	 CONSTRAINT "ESB_ERROR_STATUS_TYPE_CK1" CHECK ("RCD_STATUS" IN(0,1))   );   COMMENT ON COLUMN "ESB_ERROR_STATUS_TYPE"."RCD_STATUS" IS '1=ACTIVE, 0=INACTIVE';