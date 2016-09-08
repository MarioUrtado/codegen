xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/LegacyWrapper/Aux/Common";
(:: import schema at "../../../XSD/LegacyWrapper_Common.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $CorrelationGroup as element() external;

declare function local:get_RaDetails_ByCorrelationGroup($CorrelationGroup as element()) as element() (:: schema-element(ns1:RaDetails) ::) {
    
    let $RaMemberDetails := $CorrelationGroup/*[1]/*[@ns2:memberType="GroupController"]
    return

      <ns1:RaDetails 
        name="{$RaMemberDetails/@ns2:memberName}" 
        addr="{$RaMemberDetails/@ns2:memberAddress}" 
        corrID="{$RaMemberDetails/@ns2:memberCorrID}"/>
};

local:get_RaDetails_ByCorrelationGroup($CorrelationGroup)
