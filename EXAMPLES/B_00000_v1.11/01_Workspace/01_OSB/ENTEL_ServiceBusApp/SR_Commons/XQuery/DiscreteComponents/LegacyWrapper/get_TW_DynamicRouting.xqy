xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ParameterManager/getEndpoint/v1";

declare variable $GetEndpointRSP as element() external;
declare variable $LwVersion as xs:string external;


declare function local:get_LW_APIH_DynamicRouting($GetEndpointRSP as element(),$LwVersion as xs:string) as element() {
    
    let $LegacyName := data($GetEndpointRSP/*[1]/*[2]/@provider)
    let $APIName := data($GetEndpointRSP/*[1]/*[2]/@api)
    let $InstanceName := data($GetEndpointRSP/*[1]/*[1]/@instance)
    let $TransportName := 
      if (data($InstanceName) != '') then
        concat(local-name($GetEndpointRSP/*[1]/*[1]/*[1]),'_',$InstanceName)
        else
        local-name($GetEndpointRSP/*[1]/*[1]/*[1])
    
    
    
    return
    
    <ctx:route xmlns:ctx='http://www.bea.com/wli/sb/context'>
      <ctx:pipeline isProxy="false">DC_LW_{$LegacyName}_v{$LwVersion}/APIWs/{$APIName}/TW/{$TransportName}/{$APIName}_{$TransportName}_TW</ctx:pipeline>
  </ctx:route>
};

local:get_LW_APIH_DynamicRouting($GetEndpointRSP, $LwVersion)
