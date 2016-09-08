xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/ParameterManager/getEndpoint/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getEndpoint_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getEndpointParameterManagerAdapter";
(:: import schema at "../JCA/getEndpointParameterManagerAdapter/getEndpointParameterManagerAdapter_sp.xsd" ::)
declare namespace ns3="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns5="http://www.entel.cl/ESO/EndpointConfiguration/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/EndpointConfiguration_v1_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare variable $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $Result as element()? (:: schema-element(ns3:Result) ::) external;

declare function local:getEndpointResp_Adapter($OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::),
                                               $Result as element()? (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:GetEndpointRSP) ::) {
    <ns2:GetEndpointRSP>
      <ns5:Endpoint>
          <ns5:Configuration>
          {
            if ($OutputParameters/ns1:P_ENDPINSTANCE != '') then
              attribute instance {data($OutputParameters/ns1:P_ENDPINSTANCE)}
            else
              ()
          }
          { if(fn:data($OutputParameters/ns1:P_ENDPTYPE)) then
              let $strOption := fn:data($OutputParameters/ns1:P_ENDPTYPE)
              let $option:= element {$strOption} {}
                                    
              return 
                                    
              element {local-name($option)} { 
                for $property in $OutputParameters/ns1:P_ENDPOINT/ns1:P_ENDPOINT_Row
                  return  
                    attribute{data($property/*[1])} {$property/*[2]}
             }
             else
              ()
             }
           </ns5:Configuration>
           <ns5:Target 
            operation="{fn:data($OutputParameters/ns1:P_TARGET/ns1:OPERATION_)}" 
            provider="{fn:data($OutputParameters/ns1:P_TARGET/ns1:PROVIDER_)}"
            api="{fn:data($OutputParameters/ns1:P_TARGET/ns1:API_)}"
            version="{fn:data($OutputParameters/ns1:P_TARGET/ns1:VERSION_)}">
            </ns5:Target>
         </ns5:Endpoint>
         {
          $Result
         }
        
    </ns2:GetEndpointRSP>
};

local:getEndpointResp_Adapter($OutputParameters, $Result)
