xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationManager/getCorrelation/v1";
declare namespace ns3="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $TwName as xs:string external;
declare variable $LegacyCorrID as xs:string external;

declare function local:get_GetCorrelationREQ($TwName as xs:string, 
                                             $LegacyCorrID as xs:string) 
                                             as element() {
    <ns2:GetCorrelationREQ>
      <ns3:GroupName>{$TwName}</ns3:GroupName>
      <ns3:MemberName>{$TwName}</ns3:MemberName>
      <ns3:MemberType>GroupOwner</ns3:MemberType>
      <ns3:MemberCorrID>{$LegacyCorrID}</ns3:MemberCorrID>
    </ns2:GetCorrelationREQ>
  
};

local:get_GetCorrelationREQ($TwName, $LegacyCorrID)
