xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/RA/INT-AS400-CLI/ClientDelete/v1";
(:: import schema at "../../../../../../DC_RA_INT-AS400_v1/ResourceAdapters/INT-AS400-CLI_ClientDelete_RA_v1/CSC/INT-AS400-CLI_ClientDelete_v1_CSM.xsd" ::)
declare namespace ns1="http://www.entel.cl/EBM/Consumer/del/v1";
(:: import schema at "../../../../../ESC/Primary/del_Consumer_v1_EBM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns6 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $Del_Consumer_REQ as element() (:: schema-element(ns1:Del_Consumer_REQ) ::) external;
declare variable $ConsumerType as xs:string external;


declare function local:INT-AS400-CLI_ClientObtain_REQ($Del_Consumer_REQ as element() (:: schema-element(ns1:Del_Consumer_REQ) ::), $ConsumerType as xs:string) as element() (:: schema-element(ns2:INT-AS400-CLI_ClientDelete_REQ) ::) {
    <ns2:INT-AS400-CLI_ClientDelete_REQ>
        {$Del_Consumer_REQ/*[1]}
        <ns2:Body>
            <ns6:ConsumerID>{fn:data($Del_Consumer_REQ/ns1:Body/ns6:ConsumerID)}</ns6:ConsumerID>
            <ns6:ConsumerType>{$ConsumerType}</ns6:ConsumerType>
        </ns2:Body>
    </ns2:INT-AS400-CLI_ClientDelete_REQ>
};

local:INT-AS400-CLI_ClientObtain_REQ($Del_Consumer_REQ, $ConsumerType)
