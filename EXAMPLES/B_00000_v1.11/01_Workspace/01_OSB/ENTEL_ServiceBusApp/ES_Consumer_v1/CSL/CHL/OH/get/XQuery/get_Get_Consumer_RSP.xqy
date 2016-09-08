xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/CHL-SALESFORCE-CRM/ClientObtain/v1";
(:: import schema at "../../../../../../DC_RA_CHL-SALESFORCE_v1/ResourceAdapters/CHL-SALESFORCE-CRM_ClientObtain_RA_v1/CSC/CHL-SALESFORCE-CRM_ClientObtain_v1_CSM.xsd" ::)

declare namespace ns2="http://www.entel.cl/EBM/Consumer/get/v1";
(:: import schema at "../../../../../ESC/Primary/get_Consumer_v1_EBM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns6 = "http://www.entel.cl/EBO/Consumer/v1";

declare namespace ns7="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)


declare variable $CHL-SALESFORCE-CRM_ClientObtain_RSP as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_ClientObtain_RSP) ::) external;
declare variable $RequestHeader as element() (:: schema-element(ns7:RequestHeader) ::) external;


declare function local:get_Get_Consumer_RSP($CHL-SALESFORCE-CRM_ClientObtain_RSP as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_ClientObtain_RSP) ::), $RequestHeader as element() (:: schema-element(ns7:RequestHeader) ::)) as element() (:: schema-element(ns2:Get_Consumer_RSP) ::) {
    <ns2:Get_Consumer_RSP>
        <ns7:ResponseHeader>
        {$RequestHeader/*}
        {$CHL-SALESFORCE-CRM_ClientObtain_RSP/*[1]}
        </ns7:ResponseHeader>
        <ns2:Body>
            <ns6:Consumer>
                <ns6:ConsumerName>{fn:data($CHL-SALESFORCE-CRM_ClientObtain_RSP/*[2]/*[1]/*:ConsumerName)}</ns6:ConsumerName>
                <ns6:ConsumerSurename>{fn:data($CHL-SALESFORCE-CRM_ClientObtain_RSP/*[2]/*[1]/*:ConsumerSurename)}</ns6:ConsumerSurename>
                {
                    if ($CHL-SALESFORCE-CRM_ClientObtain_RSP/*[2]/*[1]/*:ConsumerAge)
                    then <ns6:ConsumerAge>{fn:data($CHL-SALESFORCE-CRM_ClientObtain_RSP/*[2]/*[1]/*:ConsumerAge)}</ns6:ConsumerAge>
                    else ()
                }
                <ns6:ConsumerStatus>{fn:data($CHL-SALESFORCE-CRM_ClientObtain_RSP/*[2]/*[1]/*:ConsumerStatus)}</ns6:ConsumerStatus>
                {
                    if ($CHL-SALESFORCE-CRM_ClientObtain_RSP/*[2]/*[1]/*:ConsumerLegalType)
                    then <ns6:ConsumerLegalType>{fn:data($CHL-SALESFORCE-CRM_ClientObtain_RSP/*[2]/*[1]/*:ConsumerLegalType)}</ns6:ConsumerLegalType>
                    else ()
                }
                
            </ns6:Consumer>
        </ns2:Body>
    </ns2:Get_Consumer_RSP>
};

local:get_Get_Consumer_RSP($CHL-SALESFORCE-CRM_ClientObtain_RSP, $RequestHeader)
