xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationManager/getCorrelation/v1";
declare namespace ns3="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $GroupName as xs:string external;
declare variable $MemberName as xs:string external;
declare variable $MemberType as xs:string external;
declare variable $MemberCorrID as xs:string external;

declare function local:get_GetCorrelationREQ($RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::), 
                                             $GroupName as xs:string, 
                                             $MemberName as xs:string, 
                                             $MemberType as xs:string, 
                                             $MemberCorrID as xs:string) 
                                             as element() {
    <ns2:GetCorrelationREQ>
      {$RequestHeader}
      <ns3:GroupName>{$GroupName}</ns3:GroupName>
      <ns3:MemberName>{$MemberName}</ns3:MemberName>
      <ns3:MemberType>{$MemberType}</ns3:MemberType>
      <ns3:MemberCorrID>{$MemberCorrID}</ns3:MemberCorrID>
    </ns2:GetCorrelationREQ>
  
};

local:get_GetCorrelationREQ($RequestHeader, $GroupName, $MemberName, $MemberType, $MemberCorrID)
