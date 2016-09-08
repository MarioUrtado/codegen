xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $SubAddr as xs:string external;

declare function local:get_SubAddrRouting($SubAddr as xs:string) as element() {
    
    let $protocol:= tokenize($SubAddr,'://')[1]
    let $location:= 'DC_SC_ConversationManager/SupportLogic/Business/'
    
    return
    <ctx:route xmlns:ctx='http://www.bea.com/wli/sb/context'>
      <ctx:service isProxy="false">{concat($location,$protocol, '_PublishResult')}</ctx:service>
    </ctx:route>
};

local:get_SubAddrRouting($SubAddr)