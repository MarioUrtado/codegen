xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/INT-AS400-CLI/ClientDelete/v1";
(:: import schema at "../CSC/INT-AS400-CLI_ClientDelete_v1_CSM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EBO/Consumer/v1";
declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare variable $RaREQ as element() (:: schema-element(ns1:INT-AS400-CLI_ClientDelete_REQ) ::) external;
declare variable $GetMappingRSP as element() external;

declare function local:get_INT-AS400-CLI_ClientDelete_REQMappings($RaREQ as element() (:: schema-element(ns1:INT-AS400-CLI_ClientDelete_REQ) ::), 
                                                                 $GetMappingRSP as element()) 
                                                                 as element() (:: schema-element(ns1:INT-AS400-CLI_ClientDelete_REQ) ::) {
    <ns1:INT-AS400-CLI_ClientDelete_REQ>
    (: 
      The Request Header is not required at this point, as it is assumed to be saved on a local variable within the 
      RA Pipeline. This reduces the size of the $body variable, and avoids further XPATH queries to be performed.
      As it is a good practice to use positional XPATH, the element is maintained to avoid possible mistakes when applying
      that type of XPATH over the RA Request, after it was modified by this XQ
    :)
        <ns4:RequestHeader></ns4:RequestHeader>
        <ns1:Body>
          {$RaREQ/*[2]/*:ConsumerID}
          <ns3:ConsumerType>{data($GetMappingRSP/*[1]/*[1][@entity="Client" and @field="Type"]/@dCode)}</ns3:ConsumerType>
        </ns1:Body>
    </ns1:INT-AS400-CLI_ClientDelete_REQ>
};

local:get_INT-AS400-CLI_ClientDelete_REQMappings($RaREQ, $GetMappingRSP)