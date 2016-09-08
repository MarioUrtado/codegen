xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $CorrelationGroup as element() external;

declare function local:get_SubscriberAddr($CorrelationGroup as element()) as xs:string {
    data($CorrelationGroup/*[1]/*[@ns2:memberType="GroupOwner"]/@ns2:memberAddress)
};

local:get_SubscriberAddr($CorrelationGroup)
