xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns2="http://www.entel.cl/SC/CorrelationMember/registerGroup/v1";
declare namespace ns3="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";


declare variable $Endpoint as element() external;

declare function local:get_TWName($Endpoint as element()) 
                                              as xs:string {
                                              
    let $APIName := data($Endpoint/*[2]/@api)
    let $InstanceName := data($Endpoint/*[1]/@instance)
    let $TransportName := 
      if (data($InstanceName) != '') then
        concat(local-name($Endpoint/*[1]/*[1]),'_',$InstanceName)
        else
        local-name($Endpoint/*[1]/*[1])
    
    return 
    
      concat($APIName,'_',$TransportName,'_TW')
  
};

local:get_TWName($Endpoint)
