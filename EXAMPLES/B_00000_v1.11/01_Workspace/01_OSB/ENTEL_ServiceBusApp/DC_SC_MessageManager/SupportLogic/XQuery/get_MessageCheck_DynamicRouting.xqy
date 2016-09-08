xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/MessageManager/CheckExecutorHelper/v1";
(:: import schema at "../XSD/CheckExecutorHelper.xsd" ::)

declare variable $CheckExecutorHelperREQ as element() (:: schema-element(ns1:checkExecutorHelperREQ) ::) external;

declare function local:get_MessageCheck_DynamicRouting($CheckExecutorHelperREQ as element() (:: schema-element(ns1:checkExecutorHelperREQ) ::)) as element() {
    
   
    <ctx:route xmlns:ctx='http://www.bea.com/wli/sb/context'>
      <ctx:pipeline isProxy="false">DC_SC_MessageManager/SupportLogic/Pipeline/MessageChecks/{data($CheckExecutorHelperREQ/@name)}_CheckPipeline</ctx:pipeline>
    </ctx:route>
};

local:get_MessageCheck_DynamicRouting($CheckExecutorHelperREQ)