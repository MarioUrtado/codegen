xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns2="http://www.entel.cl/SC/ParameterManager/getMapping/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";
declare namespace ns4 = "http://www.entel.cl/ESO/Result/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::) external;
declare variable $REQ_Maps as element() external;

declare function local:func1( $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::), 
                              $REQ_Maps as element()
                             ) as element() {
    <ns2:GetMappingREQ>
        {$RequestHeader}
        <ns2:Maps>
            { for $Map in $REQ_Maps/* return
              <ns2:Map 
                sCode="{$Map/@sCode}" 
                context="{$Map/@context}" 
                entity="{$Map/@entity}" 
                field="{$Map/@field}" 
                dSys="{$Map/@dSys}" 
                sSys="{$Map/@sSys}"/>
             }
        </ns2:Maps>
    </ns2:GetMappingREQ>
};

local:func1($RequestHeader,$REQ_Maps)
