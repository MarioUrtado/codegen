xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/registryTransaction";
(:: import schema at "../JCA/registryTransaction/registryTransaction_sp.xsd" ::)

declare variable $eventID as xs:string external;
declare variable $processID as xs:string external;
declare variable $clientReqTimestamp as xs:dateTime external;
declare variable $capabilityID as xs:int external;
declare variable $conversationID as xs:string external;
declare variable $correlationID as xs:string external;

(: Example dateTime 2015-12-17T09:30:47+04:00  result 2015-12-17 09:30:47 +04:00:)
declare function local:parseDateTimeToString($fechaHoraTz as xs:dateTime) as xs:string {
  let $date := fn:substring( xs:string($fechaHoraTz) , 1, 10)
  let $time := fn:substring( xs:string($fechaHoraTz) , 12, 8)
  let $tz := local:timezone-from-duration(fn:timezone-from-dateTime($fechaHoraTz))
  return concat($date, ' ', $time, ' ', $tz)
};

declare function local:timezone-from-duration
  ( $duration as xs:dayTimeDuration )  as xs:string {

   if (string($duration) = ('PT0S','-PT0S'))
   then 'Z'
   else if (matches(string($duration),'-PT[1-9]H'))
   then replace(string($duration),'PT([1-9])H','0$1:00')
   else if (matches(string($duration),'PT[1-9]H'))
   then replace(string($duration),'PT([1-9])H','+0$1:00')
   else if (matches(string($duration),'-PT1[0-4]H'))
   then replace(string($duration),'PT(1[0-4])H','$1:00')
   else if (matches(string($duration),'PT1[0-4]H'))
   then replace(string($duration),'PT(1[0-4])H','+$1:00')
   else ''
};
 
declare function local:registryTransactionREQ($eventID as xs:string, 
                                              $processID as xs:string, 
                                              $clientReqTimestamp as xs:dateTime, 
                                              $capabilityID as xs:int,
                                              $conversationID as xs:string,
                                              $correlationID as xs:string) 
                                              as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_EVENT_ID>{fn:data($eventID)}</ns1:P_EVENT_ID>
        <ns1:P_PROC_ID>{fn:data($processID)}</ns1:P_PROC_ID>
        <ns1:P_CLIENT_REQ_TIMESTAMP>{local:parseDateTimeToString($clientReqTimestamp)}</ns1:P_CLIENT_REQ_TIMESTAMP>
        <ns1:P_CAPABILITY_ID>{fn:data($capabilityID)}</ns1:P_CAPABILITY_ID>
        <ns1:P_CONVERSATION_ID>{fn:data($conversationID)}</ns1:P_CONVERSATION_ID>
        <ns1:p_CORRELATION_ID>{fn:data($correlationID)}</ns1:p_CORRELATION_ID>
    </ns1:InputParameters>
};

local:registryTransactionREQ($eventID, $processID, $clientReqTimestamp, $capabilityID, $conversationID, $correlationID)
