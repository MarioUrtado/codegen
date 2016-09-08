xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ErrorManager";
(:: import schema at "../JCA/errorManagerAdapter/ErrorManager_sp.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $InputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($InputParameters as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:Result) ::) {
    <ns2:Result status="{data($InputParameters/ns1:P_RESULT_STATUS)}" description="{data($InputParameters/ns1:P_RESULT_DESCRIPTION)}">
        <ns3:CanonicalError code="{data($InputParameters/ns1:P_CANONICAL_ERROR_CODE)}" description="{data($InputParameters/ns1:P_CANONICAL_ERROR_DESCRIPTION)}" type="{data($InputParameters/ns1:P_CANONICAL_ERROR_TYPE)}">
        </ns3:CanonicalError>
    </ns2:Result>
};

local:func($InputParameters)
