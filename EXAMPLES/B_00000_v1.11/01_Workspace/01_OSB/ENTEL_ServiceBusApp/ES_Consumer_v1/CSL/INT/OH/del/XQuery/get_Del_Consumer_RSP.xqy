xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/INT-AS400-CLI/ClientDelete/v1";
(:: import schema at "../../../../../../DC_RA_INT-AS400_v1/ResourceAdapters/INT-AS400-CLI_ClientDelete_RA_v1/CSC/INT-AS400-CLI_ClientDelete_v1_CSM.xsd" ::)

declare namespace ns2="http://www.entel.cl/EBM/Consumer/del/v1";
(:: import schema at "../../../../../ESC/Primary/del_Consumer_v1_EBM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns6 = "http://www.entel.cl/EBO/Consumer/v1";

declare namespace ns7="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)


declare variable $INT-AS400-CLI_ClientDelete_RSP as element() (:: schema-element(ns1:INT-AS400-CLI_ClientDelete_RSP) ::) external;
declare variable $RequestHeader as element() (:: schema-element(ns7:RequestHeader) ::) external;


declare function local:get_Del_Consumer_RSP($INT-AS400-CLI_ClientDelete_RSP as element() (:: schema-element(ns1:INT-AS400-CLI_ClientDelete_RSP) ::), $RequestHeader as element() (:: schema-element(ns7:RequestHeader) ::)) as element() (:: schema-element(ns2:Del_Consumer_RSP) ::) {
    <ns2:Del_Consumer_RSP>
        <ns7:ResponseHeader>
        {$RequestHeader/*}
        {$INT-AS400-CLI_ClientDelete_RSP/*[1]}
        </ns7:ResponseHeader>
        <ns2:Body>
        </ns2:Body>
    </ns2:Del_Consumer_RSP>
};

local:get_Del_Consumer_RSP($INT-AS400-CLI_ClientDelete_RSP, $RequestHeader)
