xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.credits.com/entidades/xsd";
(:: import schema at "../WSDL/CreditsServices.wsdl" ::)
declare namespace ns1="http://www.entel.cl/EBM/Consumer/get/v1";
(:: import schema at "../../../../ES_Consumer_v1/ESC/Primary/get_Consumer_v1_EBM.xsd" ::)
declare namespace ns3="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $getConsumerREQ as element() (:: schema-element(ns2:getConsumerREQ) ::) external;
declare variable $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::) external;

declare function local:get_Get_Consumer_REQ($getConsumerREQ as element() (:: schema-element(ns2:getConsumerREQ) ::), 
                            $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::)) 
                            as element() (:: schema-element(ns1:Get_Consumer_REQ) ::) {
    <ns1:Get_Consumer_REQ>
        {$RequestHeader}
        <ns1:Body>
            <ns4:ConsumerID>{fn:data($getConsumerREQ/*[3])}</ns4:ConsumerID>
        </ns1:Body>
    </ns1:Get_Consumer_REQ>
};

local:get_Get_Consumer_REQ($getConsumerREQ, $RequestHeader)
