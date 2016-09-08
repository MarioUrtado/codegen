xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CorrelationManager/getCorrelation/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getCorrelation_CorrelationManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getCorrelationMemberAdapter";
(:: import schema at "../JCA/getCorrelationMemberAdapter/getCorrelationMemberAdapter_sp.xsd" ::)

declare namespace cor = "http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $GetCorrelationREQ as element() (:: schema-element(ns1:GetCorrelationREQ) ::) external;

declare function local:func($GetCorrelationREQ as element() (:: schema-element(ns1:GetCorrelationREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:GROUP_NAME>{fn:data($GetCorrelationREQ/cor:GroupName)}</ns2:GROUP_NAME>
        <ns2:MEMBER_TYPES>
            <ns2:MEMBER_NAME_>{fn:data($GetCorrelationREQ/cor:MemberName)}</ns2:MEMBER_NAME_>
            <ns2:TYPE_MEMBER_>{fn:data($GetCorrelationREQ/cor:MemberType)}</ns2:TYPE_MEMBER_>
            <ns2:CORRELATION_ID_>{fn:data($GetCorrelationREQ/cor:MemberCorrID)}</ns2:CORRELATION_ID_>
      
        </ns2:MEMBER_TYPES>
    </ns2:InputParameters>
};

local:func($GetCorrelationREQ)
