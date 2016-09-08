--------------------------------------------------------
--  DDL for Table ESB_CORRELATION
--------------------------------------------------------
  
  CREATE TABLE "ESB_CORRELATION" 
  (	
	"ID" NUMBER NOT NULL, 
	"GROUP_INSTANCE" NUMBER NOT NULL, 
	"MEMBER_INSTANCE" NUMBER NOT NULL,
	"TYPE_MEMBER" NUMBER NOT NULL, 
	"RCD_STATUS" NUMBER(1,0) DEFAULT 1 NOT NULL, 
	"CREATIONDATE" DATE DEFAULT CURRENT_DATE,
	CONSTRAINT "ESB_CORRELATION_PK" PRIMARY KEY ("ID"), 
	CONSTRAINT "GROUP_INSTANCE_FK" FOREIGN KEY ("GROUP_INSTANCE")
	REFERENCES "ESB_CORRELATION_GROUP" ("ID"), 
	CONSTRAINT "MEMBER_INSTANCE_FK" FOREIGN KEY ("MEMBER_INSTANCE")
	REFERENCES "ESB_CORRELATION_INSTANCE" ("ID") ON DELETE CASCADE,
	CONSTRAINT "TYPE_MEMBER_FK" FOREIGN KEY ("TYPE_MEMBER")
	REFERENCES "ESB_CORRELATION_MEMBER_TYPE" ("ID")
  );
	COMMENT ON COLUMN "ESB_CORRELATION"."RCD_STATUS" IS '1=ACTIVE, 0=INACTIVE';