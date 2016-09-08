xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/get/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/get_CacheManager_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/CacheManager/put/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/put_CacheManager_v1_CSM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EDD/Dictionary/v1";

declare variable $PutREQ as element() (:: schema-element(ns2:PutREQ) ::) external;

declare function local:getRSP_Adapter($PutREQ as element() (:: schema-element(ns2:PutREQ) ::)) as element() (:: schema-element(ns1:GetRSP) ::) {
    <ns1:GetRSP>
      {
        if (fn:exists($PutREQ/ns2:Key)) then
          <ns1:Item>
              {
                  attribute key {
                    fn:concat(
                    fn:data($PutREQ/ns2:Key/@source),'|',
                    fn:data($PutREQ/ns2:Key/@category),'|',
                    fn:data($PutREQ/ns2:Key/@instance)) }
              }
              <ns3:Value>{ 
                if(exists($PutREQ/ns2:Value/*)) then
                  $PutREQ/ns2:Value/*
                else if (data($PutREQ/ns2:Value) != "") then
                  data($PutREQ/ns2:Value)
                else ""
              }</ns3:Value>
          </ns1:Item>
        else ()
      }
    </ns1:GetRSP>
};

local:getRSP_Adapter($PutREQ)
