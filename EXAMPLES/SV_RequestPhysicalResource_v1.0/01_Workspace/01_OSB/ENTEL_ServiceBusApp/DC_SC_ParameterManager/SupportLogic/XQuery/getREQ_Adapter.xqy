xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ParameterManager/get/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/get_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getParameterManagerAdapter";
(:: import schema at "../JCA/getParameterManagerAdapter/getParameterManagerAdapter_sp.xsd" ::)

declare variable $getREQ as element() (:: schema-element(ns1:GetREQ) ::) external;

declare function local:getREQ_Adapter($getREQ as element() (:: schema-element(ns1:GetREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
            <ns2:P_KEYS>
                {
                    for $Key in $getREQ/ns1:Keys/ns1:Key
                    order by $Key/text()
                    return 
                    <ns2:P_KEYS_ITEM>{fn:data($Key)}</ns2:P_KEYS_ITEM>
                }
        </ns2:P_KEYS>
    </ns2:InputParameters>
};

local:getREQ_Adapter($getREQ)
