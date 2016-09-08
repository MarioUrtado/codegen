xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/ParameterManager/get/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/get_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getParameterManagerAdapter";
(:: import schema at "../JCA/getParameterManagerAdapter/getParameterManagerAdapter_sp.xsd" ::)
declare namespace ns3="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare variable $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $Result as element()? (:: schema-element(ns3:Result) ::) external;

declare function local:getRSP_Adapter($OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::),
                                      $Result as element()? (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:GetRSP) ::) {
    <ns2:GetRSP xmlns:ns3="http://www.entel.cl/EDD/Dictionary/v1">
    {
      if ($OutputParameters/ns1:P_KEYVALUES/ns1:P_KEYVALUES_Row)
      then
        <ns2:Values>
            {
                for $P_KEYVALUES_Row in $OutputParameters/ns1:P_KEYVALUES/ns1:P_KEYVALUES_Row
                return 
                <ns3:Item>
                {
                    attribute key {fn:data($P_KEYVALUES_Row/ns1:KEY)}
                }
                {
                    attribute value {fn:data($P_KEYVALUES_Row/ns1:VALUE)}
                }
                </ns3:Item>
            }
        </ns2:Values>
      else ()
    }
    {
      $Result
    }
    </ns2:GetRSP>
};

local:getRSP_Adapter($OutputParameters, $Result)
