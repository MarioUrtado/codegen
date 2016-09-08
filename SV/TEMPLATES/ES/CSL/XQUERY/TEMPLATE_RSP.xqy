xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/%SYSTEM_API%/%OPERATION%/v1";
(:: import schema at "../../../../../../DC_RA_%SYSTEM%_v1/ResourceAdapters/%SYSTEM_API%_%OPERATION%_RA_v1/CSC/%SYSTEM_API%_%OPERATION%_v1_CSM.xsd" ::)

declare namespace ns2="http://www.entel.cl/EBM/%SERVICE_NAME%/%CAPABILITY_NAME%/v1";
(:: import schema at "../../../../../ESC/Primary/%CAPABILITY_NAME%_%SERVICE_NAME%_v1_EBM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns7="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)


declare variable $%SYSTEM_API%_%OPERATION%_RSP as element() (:: schema-element(ns1:%SYSTEM_API%_%OPERATION%_RSP) ::) external;
declare variable $RequestHeader as element() (:: schema-element(ns7:RequestHeader) ::) external;


declare function local:get_%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_RSP($%SYSTEM_API%_%OPERATION%_RSP as element() (:: schema-element(ns1:%SYSTEM_API%_%OPERATION%_RSP) ::), $RequestHeader as element() (:: schema-element(ns7:RequestHeader) ::)) as element() (:: schema-element(ns2:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_RSP) ::) {
    <ns2:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_RSP>
        <ns7:ResponseHeader>
        {$RequestHeader/*}
        {$%SYSTEM_API%_%OPERATION%_RSP/*[1]}	
        </ns7:ResponseHeader>
        <ns2:Body>
        </ns2:Body>
    </ns2:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_RSP>
};

local:get_%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_RSP($%SYSTEM_API%_%OPERATION%_RSP, $RequestHeader)
