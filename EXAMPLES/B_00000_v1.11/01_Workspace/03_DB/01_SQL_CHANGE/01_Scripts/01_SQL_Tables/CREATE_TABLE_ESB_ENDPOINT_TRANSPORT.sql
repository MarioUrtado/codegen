----------------------------------------------------------  DDL for Table ESB_ENDPOINT_TRANSPORT--------------------------------------------------------    CREATE TABLE "ESB_ENDPOINT_TRANSPORT"    (	"ID" NUMBER NOT NULL ENABLE, 	"NAME" VARCHAR2(10 BYTE) NOT NULL ENABLE, 	"RCD_STATUS" NUMBER(1,0) DEFAULT 1 NOT NULL ENABLE, 	"CREATIONDATE" DATE DEFAULT CURRENT_DATE,	 CONSTRAINT "ESB_ENDPOINT_TRANSPORT_PK" PRIMARY KEY ("ID"),  	 CONSTRAINT "ESB_ENDPOINT_TRANSPORT_UK" UNIQUE ("NAME"),	 CONSTRAINT "ESB_ENDPOINT_TRANSPORT_CK" CHECK ("RCD_STATUS" IN(0,1))   );   COMMENT ON COLUMN "ESB_ENDPOINT_TRANSPORT"."RCD_STATUS" IS '1=ACTIVE, 0=INACTIVE';