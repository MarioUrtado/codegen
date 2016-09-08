--------------------------------------------------------
--  DDL for Table ESB_CORRELATION_MEMBER_TYPE
--------------------------------------------------------
  
  CREATE TABLE "ESB_CORRELATION_MEMBER_TYPE" 
  (	
	"ID" NUMBER NOT NULL, 
	"NAME" VARCHAR2(30) NOT NULL, 
	"DESCRIPTION" VARCHAR2(255), 
	"RCD_STATUS" NUMBER(1,0) DEFAULT 1 NOT NULL, 
	"CREATIONDATE" DATE DEFAULT CURRENT_DATE,
	CONSTRAINT "ESB_CORRELATION_MEMBER_TYPE_PK" PRIMARY KEY ("ID")
  );
  COMMENT ON COLUMN "ESB_CORRELATION_MEMBER_TYPE"."RCD_STATUS" IS '1=ACTIVE, 0=INACTIVE';