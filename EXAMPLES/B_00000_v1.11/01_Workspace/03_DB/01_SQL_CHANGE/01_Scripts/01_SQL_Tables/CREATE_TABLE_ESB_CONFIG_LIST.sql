----------------------------------------------------------  DDL for Table ESB_CONFIG_LIST--------------------------------------------------------    CREATE TABLE "ESB_CONFIG_LIST"    (	"CONFIG_ID" NUMBER NOT NULL, 	"PROPERTY_ID" NUMBER NOT NULL, 	"VALUE" VARCHAR2(255 BYTE), 	"RCD_STATUS" NUMBER(1,0) DEFAULT 1 NOT NULL, 	"CREATIONDATE" DATE DEFAULT CURRENT_DATE,	CONSTRAINT "ESB_CONFIG_LIST_PK" PRIMARY KEY ("CONFIG_ID", "PROPERTY_ID"),	CONSTRAINT "CONFIG_LIST_PROPERTY_FK" FOREIGN KEY ("PROPERTY_ID")			REFERENCES "ESB_CONFIG_PROPERTY" ("ID"), 	 CONSTRAINT "CONFIG_LIST_CONFIG_FK" FOREIGN KEY ("CONFIG_ID")			REFERENCES "ESB_CONFIG" ("ID"),	 CONSTRAINT "ESB_CONFIG_LIST_STATUS_CK" CHECK ("RCD_STATUS" IN(0,1))   );   COMMENT ON COLUMN "ESB_CONFIG_LIST"."RCD_STATUS" IS '1=ACTIVE, 0=INACTIVE';