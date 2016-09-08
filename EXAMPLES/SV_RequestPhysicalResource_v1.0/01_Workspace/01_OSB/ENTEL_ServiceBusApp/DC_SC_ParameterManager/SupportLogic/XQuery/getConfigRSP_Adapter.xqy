xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/ParameterManager/getConfig/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getConfig_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getConfigParameterManagerAdapter";
(:: import schema at "../JCA/getConfigParameterManagerAdapter/getConfigParameterManagerAdapter_sp.xsd" ::)
declare namespace ns3="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare variable $outputParametersDB as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $Result as element()? (:: schema-element(ns3:Result) ::) external;

declare function local:getConfigResp_Adapter($outputParametersDB as element() (:: schema-element(ns1:OutputParameters) ::),
                                             $Result as element()? (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:GetConfigRSP) ::) {
    <ns2:GetConfigRSP xmlns:ns3 = "http://www.entel.cl/EDD/Dictionary/v1">
    {
      if ($outputParametersDB/ns1:P_CONFIG/ns1:P_CONFIG_Row) then
        <ns2:Config>
            {
                for $P_CONFIG_Row in $outputParametersDB/ns1:P_CONFIG/ns1:P_CONFIG_Row
                return 
                <ns3:Item key="{fn:data($P_CONFIG_Row/ns1:KEY)}">
                      <ns3:Value>{fn:data($P_CONFIG_Row/ns1:VALUE)}</ns3:Value>
                </ns3:Item>
            }
        </ns2:Config>
      else ()
    }
        {$Result}
    </ns2:GetConfigRSP>
};

local:getConfigResp_Adapter($outputParametersDB, $Result)
