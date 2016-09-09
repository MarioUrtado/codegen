xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/RA/%SYSTEM_API%/%OPERATION%/v1";
(:: import schema at "../CSC/%SYSTEM_API%_%OPERATION%_v1_CSM.xsd" ::)

(: replace with reference to legacy's contract :)
declare namespace ns1="http://www.legacy.provider.com/anyURL";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $LegacyRSP as element()  external;
declare variable $Result as element() (:: schema-element(ns3:Result) ::) external;


declare function local:get_%SYSTEM_API%_%OPERATION%_AdapterRSP_OK($LegacyRSP as element() , $Result as element() (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:%SYSTEM_API%_%OPERATION%_RSP) ::) {
    <ns2:%SYSTEM_API%_%OPERATION%_RSP>
        {$Result}
        <ns2:Body>

        	(: Delete STUB element :)
        	<STUB>{$LegacyRSP}</STUB>

        </ns2:Body>
    </ns2:%SYSTEM_API%_%OPERATION%_RSP>
};

local:get_%SYSTEM_API%_%OPERATION%_AdapterRSP_OK($LegacyRSP, $Result)