xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/LegacyWrapper/v1";
(:: import schema at "../../../XSD/CSM/LegacyWrapper_v1_CSM.xsd" ::)

declare variable $TargetProvider as xs:string external;
declare variable $TargetAPI as xs:string external;
declare variable $LwVersion as xs:string external;

declare function local:get_LW_APIH_DynamicRouting($TargetProvider as xs:string, $TargetAPI as xs:string, $LwVersion as xs:string) as element() {


    <ctx:route xmlns:ctx='http://www.bea.com/wli/sb/context'>
      <ctx:pipeline isProxy="false">DC_LW_{$TargetProvider}_v{$LwVersion}/APIWs/{$TargetAPI}/{$TargetAPI}_APIW</ctx:pipeline>
    </ctx:route>
};

local:get_LW_APIH_DynamicRouting($TargetProvider,$TargetAPI,$LwVersion)