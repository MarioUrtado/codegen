xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $body as element() external;

declare function local:get_HasResultInBody($body as element()) as xs:boolean {
    
    
    (: 
    
      This is takes the assumption of recieving erros from
      standard discrete components and other service component,
      from which Result elements are always sent on the exact same
      position within an error Response. This is the most probable
      case of all Result element ocurrances.
    :)
  
    if(local-name($body/*[1]/*[1])='Result') then fn:true() else
      
      (: 
        
          This is takes the assumption of recieving erros from
          standard OH called by their associated PIF, from which the actual
          Service response is the standardized FRSP response element. 
          All FRSP response messages are standardized to the point
          from which the position of the Result element can be assumed
          as it is done here.
        :)
      
      if ( local-name($body/*[1]/*[1]/*[4])='Result') then fn:true() else
      
        (: 
        
          This is takes the assumption of recieving erros from
          standard Enterprise Service endpoints, from which the actual
          Service response is within the soap Fault Details element. 
          All service response messages are standardized to the point
          from which the position of the Result element can be assumed
          as it is done here.
        :)
      if ( local-name($body/*[3]/*[1]/*[1]/*[4])='Result') then fn:true() else
      
      
        (: 
          This is takes the assumption of recieving erros that must
          be taken as processed/treated errors, hence having a
          Result element as the first element of the SourceError; 
          but that werent processed/recieved as part of an standardized 
          error response. This allows custom error handling from any 
          component that shuold depend on the ErrorManager, and could 
          have processed/treated errors that didnt came from standard 
          sources, or were made/received through exceptional bodies of logic.
        :)
      
        if (local-name($body/*[1])='Result') then fn:true() else

        (: 
          This would be the final action to ensure that no result is being informed on the body.
          If a ResultElement is not found by this approach, it is assumed that no Result exists.
          
          Update : It is disabled for now, as every Result element that is sent by any 
          standard component should exist in one of the aforemetioned standard positions.
          
        :)

        (: if (local-name($sourceError//*:Result)='Result') then fn:true() else :)

       fn:false()
      
};

local:get_HasResultInBody($body)