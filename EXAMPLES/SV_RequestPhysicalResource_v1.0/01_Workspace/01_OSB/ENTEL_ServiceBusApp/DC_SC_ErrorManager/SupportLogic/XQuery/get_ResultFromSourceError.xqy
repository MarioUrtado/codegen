xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $sourceError as element(*) external;

declare function local:get_ResultFromSourceError($sourceError as element(*)) as element() {
    
    (:
      
      COMMENT [A]
    
      This XQuery takes the responsability of checking whether the
      source error is a handled error or not. If it is handled, an
      Result element is expected somewhere. The difference relies
      on the possible error sources : either Discrete Components
      or Enterprise Service Endpoints (SOAP 1.2). Both have different
      way of throwing an exception, and both cases are taken into
      account within this XQuery.
      
      Attention : 
      
      -- This is not compatible with anything outside the 
      scope of standards components and design patterns stablished
      on the Reference Architecture documents.
      
      -- This is not compatible with other Protocols than SOAP 1.2
      which is the Standard Canonical Protocol for Enteprise Services.
      There is the Secondary Protocol (HTTP-REST-JSON) which will not
      be handled by this component. Inter-service dependencies will
      always have to be using the primary protocol; if at some point
      that must be done using the Secondary Protocol, custom 
      Error Handling should take place. Please see Comment [D] regarding
      this last.
    :)
    
    (: 
    
      COMMENT [B]
    
      This is takes the assumption of recieving erros from
      standard discrete components and other service component,
      from which Result elements are always sent on the exact same
      position within an error Response. This is the most probable
      case of all Result element ocurrances, and thats the reason
      why we make a variable here. Otherwise we would have call
      the XQuery engine twice.
    :)
    let $result := $sourceError/*[1]/*[1]
    return
  
    if(local-name($result)='Result') then ($result) else
      
      (: 
        
          COMMENT [C]
        
          This is takes the assumption of recieving erros from
          standard OH called by their associated PIF, from which the actual
          Service response is the standardized FRSP response element. 
          All FRSP response messages are standardized to the point
          from which the position of the Result element can be assumed
          as it is done here.
        :)
      
      if ( local-name($sourceError/*[1]/*[1]/*[4])='Result') then ($sourceError/*[1]/*[1]/*[4]) else
      
        (: 
        
          COMMENT [D]
        
          This is takes the assumption of recieving erros from
          standard Enterprise Service endpoints, from which the actual
          Service response is within the soap Fault Details element. 
          All service response messages are standardized to the point
          from which the position of the Result element can be assumed
          as it is done here.
        :)
      if ( local-name($sourceError/*[3]/*[1]/*[1]/*[4])='Result') then ($sourceError/*[3]/*[1]/*[1]/*[4]) else
      
      
      (: 
      
          COMMENT [E]
      
          This is takes the assumption of recieving erros that must
          be taken as processed/treated errors, hence having a
          Result element as the first element of the SourceError; 
          but that werent processed/recieved as part of an standardized 
          error response. This allows custom error handling from any 
          component that shuold depend on the ErrorManager, and could 
          have processed/treated errors that didnt came from standard 
          sources, or were made/received through exceptional bodies of logic.
        :)
      
        if (local-name($sourceError/*[1])='Result') then ($sourceError/*[1]) else
        
        (: 
      
          COMMENT [F]
      
          This is takes the assumption of recieving erros as part of a propagated ctx:fault element. 
          Within a standard ctx:fault element. This would be the case for errors propagated from a
          service callout activity, for which the outcome sent by the provider of such service callout
          is going to be added to the ErrorResponseDetail sub-element of the details element within the
          ctx:fault.
          
          In this case the Result would be within the first element of the source fault.
        :)
        
        
        if (local-name($sourceError/*[1]/*[3]/*:ErrorResponseDetail) = 'ErrorResponseDetail') then
        (
          
          let $ErrorResponseDetail := <ERD>{fn-bea:inlinedXML($sourceError/*[1]/*[3]/*:ErrorResponseDetail)}</ERD>
          
          return
          (: 
             In this case the Result would be within the first element of the source fault.
          :)
          if (local-name($ErrorResponseDetail/*[1]/*[1])='Result') then
            $ErrorResponseDetail/*[1]/*[1]
          else
          
                      
          (:               
            In this case the Result would be sent as within a Request/Response Header.
          :) 
          
          if (local-name($ErrorResponseDetail/*[1]/*[1]/*[4])='Result') then
            $ErrorResponseDetail/*[1]/*[1]/*[4]
          else
            
          (:               
            In this case the Result would be the first element of the source fault.
          :) 
                    
          if (local-name($ErrorResponseDetail/*[1])='Result') then
            $ErrorResponseDetail/*[1]
          else
          
          (: 
      
          COMMENT [H]
          
          In this case we seek for any XML Result Element within a serialized Source Fault, in any position.
          
          :) 
          
          if (local-name($ErrorResponseDetail//*:Result[1])='Result' ) then
            $ErrorResponseDetail//*:Result[1]
            else 
            (<UNK/>)
          )

        else
        
       (<UNK/>)
      
};

local:get_ResultFromSourceError($sourceError)