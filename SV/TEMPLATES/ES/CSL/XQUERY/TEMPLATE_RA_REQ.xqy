xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/RA/%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%/%LEGACY_OPERATION%/v1";
(:: import schema at "../../../../../../DC_RA_%LEGACY_COUNTRY%-%LEGACY_SYSTEM%_v1/ResourceAdapters/%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%_%LEGACY_OPERATION%_RA_v1/CSC/%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%_%LEGACY_OPERATION%_v1_CSM.xsd" ::)
declare namespace ns1="http://www.entel.cl/EBM/%SERVICE_NAME%/%CAPABILITY%/v1";
(:: import schema at "../../../../../ESC/Primary/%CAPABILITY%_%SERVICE_NAME%_v1_EBM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns6 = "http://www.entel.cl/EBO/%SERVICE_NAME%/v1";

declare variable $Get_%SERVICE_NAME%_REQ as element() (:: schema-element(ns1:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_REQ) ::) external;

declare function local:%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%_%LEGACY_OPERATION%_REQ($%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_REQ as element() (:: schema-element(ns1:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_REQ) ::)) as element() (:: schema-element(ns2:%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%_%LEGACY_OPERATION%_REQ) ::) {
    <ns2:%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%_%LEGACY_OPERATION%_REQ>
        {$%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_REQ/*[1]}
        <ns2:Body>
        </ns2:Body>
    </ns2:%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%_%LEGACY_OPERATION%_REQ>
};

local:%LEGACY_COUNTRY%-%LEGACY_SYSTEM%-%LEGACY_API%_%LEGACY_OPERATION%_REQ($%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_REQ)
