xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns1="http://www.entel.cl/SC/MessageManager/checkIN/v1";

declare namespace ns2 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns3="http://www.entel.cl/ESO/EnterpriseService/v1";
(:: import schema at "../../../XSD/ESO/EnterpriseService_v1_ESO.xsd" ::)

declare variable $RequestedServiceOperation as xs:string external;
declare variable $ESArchitecture as element() (:: schema-element(ns3:EnterpriseService) ::) external;
declare variable $ServiceMessage as element() external;

declare function local:get_checkINREQ_v2( $RequestedServiceOperation,
                                          $ESArchitecture as element() (:: schema-element(ns3:EnterpriseService) ::), 
                                          $ServiceMessage as element()) 
                                      as element() {
    
    
    
    <ns1:checkINREQ>
      <ns2:Service code="{data($ESArchitecture/@code)}" name="{data($ESArchitecture/@name)}" operation="{$RequestedServiceOperation}"/>
      <ns1:Message>{$ServiceMessage}</ns1:Message>
    </ns1:checkINREQ>
};

local:get_checkINREQ_v2($RequestedServiceOperation, $ESArchitecture, $ServiceMessage)
