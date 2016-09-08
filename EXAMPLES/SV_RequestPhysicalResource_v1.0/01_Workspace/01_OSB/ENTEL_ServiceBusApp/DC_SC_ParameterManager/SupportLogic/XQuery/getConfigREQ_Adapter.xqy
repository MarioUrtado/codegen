xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ParameterManager/getConfig/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getConfig_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getConfigParameterManagerAdapter";
(:: import schema at "../JCA/getConfigParameterManagerAdapter/getConfigParameterManagerAdapter_sp.xsd" ::)

declare variable $getConfigREQ as element() (:: schema-element(ns1:GetConfigREQ) ::) external;

declare function local:getConfigReq_Adapter($getConfigREQ as element() (:: schema-element(ns1:GetConfigREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_CONFIGNAME>{fn:data($getConfigREQ/ns1:Config)}</ns2:P_CONFIGNAME>
    </ns2:InputParameters>
};

local:getConfigReq_Adapter($getConfigREQ)
