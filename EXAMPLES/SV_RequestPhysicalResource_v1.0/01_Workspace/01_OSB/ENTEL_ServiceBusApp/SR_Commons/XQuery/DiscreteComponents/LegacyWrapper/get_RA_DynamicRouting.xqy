xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/LegacyWrapper/v1";
(:: import schema at "../../../XSD/CSM/LegacyWrapper_v1_CSM.xsd" ::)

declare variable $RaDetails as element() external;
declare function local:get_Ra_DynamicRouting($RaDetails as element()) as element() {

    <ctx:route xmlns:ctx='http://www.bea.com/wli/sb/context'>
      <ctx:service isProxy="true">{data($RaDetails/@addr)}</ctx:service>
    </ctx:route>
};

local:get_Ra_DynamicRouting($RaDetails)