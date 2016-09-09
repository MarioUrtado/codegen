xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/%SYSTEM_API%/%OPERATION%/v1";
(:: import schema at "../CSC/%SYSTEM_API%_%OPERATION%_v1_CSM.xsd" ::)

(: replace with reference to legacy's contract :)
declare namespace ns2="http://www.legacy.provider.com/anyURL";


declare variable $RaREQ as element() external;

declare function local:get_%SYSTEM_API%_%OPERATION%_LegacyREQ(
  $RaREQ as element() (:: schema-element(ns1:%SYSTEM_API%_%OPERATION%_REQ) ::)
  ) as element() {

  	(: Delete STUB element:)
    <STUB>{$RaREQ}</STUB>
};

local:get_%SYSTEM_API%_%OPERATION%_LegacyREQ($RaREQ)