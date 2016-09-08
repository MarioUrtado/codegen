xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/LoggerManager/error/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/error_LoggerManager_v2_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/ENTEL01/ESB_LOGGERMANAGER_PKG/ERROR/";
(:: import schema at "../JCA/errorLoggerManagerAdapter/errorLoggerManagerAdapter_sp.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns5 = "http://www.entel.cl/ESO/Tracer/v1";

declare namespace ns6 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare variable $errorREQ as element() (:: schema-element(ns1:ErrorREQ) ::) external;

declare function local:parseDateTimeToString($fechaHoraTz as xs:dateTime) as xs:string {
  
  let $auxTokenizedDate := tokenize(xs:string($fechaHoraTz),'T')
  
  let $date := $auxTokenizedDate[1]
  
  (: *************************************************** :)
  (: 
  
  Los milisegundos pueden o pueden no ser informados.
  Por esta razon, junto a la falta de una funcion xQuery
  nativa que obtenga los milisegundos dede un dateTime,
  debemos investigar los distintos casos sobre la fecha 
  recibida como parametro para identificar la manera mas
  efectiva de obtener los milisegundos en cada caso :
  
  1 - Timezone "Z"
  2 - Timezone "[+/-] HH:MM"
  
  A  - Con Milisegundos, distintos a 0 (**.143 por ejemplo)
  A* - Con Milisegundos, iguales a 0 (**.0 por ejemplo)
  B  - Sin Milisegundos (Y por ende sin el ".")
  
  :)
  (: *************************************************** :)
  let $time := $auxTokenizedDate[2]
  
  (: 
   En el siguiente caso realizamos la separacion del Time
   y el Timezone, considerando todas las combinaciones 
   posibles; segun el messageTimeStamp_SType @ Dictionary_v1_EDD
   :)
  let $time := 
      if (contains($time,'Z')) then (: Para Timezone "Z":)
        tokenize($time,'Z')[1]
      else 
          if (contains($time,'+')) then (: Para Timezone "+ HH:MM":)
               tokenize($time,'\+')[1]
            else
              if (contains($time,'-')) then (: Para Timezone "- HH:MM":)
                tokenize($time,'\-')[1]
              else
                $time (: Sin Timezone, caso que debiera ser inexistente :)
  
  (: 
   En el siguiente caso validamos las distintas combinaciones de
   milisegundos que pudieran ser informados en la fecha recibida
   por parametro. De no tener milisegundos, se agrega manualmente
   el ".0" en pos de evitar errores de interpretacion en la DB.
   La DB espera siempre milisegundos; se consideran "0" milisegundos
   en caso de no recibir ninguno para la fecha siendo tratada.
  :)
  let $time := if (contains($time,'.')) then 
                $time  (: El Timezone fue informado y no es '.0**' :)
               else
                concat($time,'.0') (: El Timezone no fue informado :)

  (:let $time := fn:substring( xs:string($fechaHoraTz) , 12, 12):)
  
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

declare function local:get_errorLoggerManagerAdapterREQ($errorREQ as element() (:: schema-element(ns1:ErrorREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:ERRORREQ>
            <ns2:HEADERTRACER_>
                <ns2:COMPONENT_>{fn:data($errorREQ/*[1]/@component)}</ns2:COMPONENT_>
                <ns2:OPERATION_>{ if(exists($errorREQ/*[1]/@operation)) then fn:data($errorREQ/*[1]/@operation) else ()}</ns2:OPERATION_>
                <ns2:HEADER_>
                    <ns2:CONSUMER_>
                        <ns2:SYSCODE_>{fn:data($errorREQ/*[1]/*[1]/*[1]/@sysCode)}</ns2:SYSCODE_>
                        <ns2:ENTERPRISECODE_>{fn:data($errorREQ/*[1]/*[1]/*[1]/@enterpriseCode)}</ns2:ENTERPRISECODE_>
                        <ns2:COUNTRYCODE_>{fn:data($errorREQ/*[1]/*[1]/*[1]/@countryCode)}</ns2:COUNTRYCODE_>
                    </ns2:CONSUMER_>
                    <ns2:TRACE_>
                        <ns2:CLIENTREQTIMESTAMP_>{local:parseDateTimeToString(fn:data($errorREQ/*[1]/*[1]/*[2]/@clientReqTimestamp))}</ns2:CLIENTREQTIMESTAMP_>
                        <ns2:REQTIMESTAMP_>{if(exists($errorREQ/*[1]/*[1]/*[2]/@reqTimestamp)) 
                                    then local:parseDateTimeToString(fn:data($errorREQ/*[1]/*[1]/*[2]/@reqTimestamp))
                                    else()}</ns2:REQTIMESTAMP_>
                        <ns2:RSPTIMESTAMP_>{if(fn:exists($errorREQ/*[1]/*[1]/*[2]/@rspTimestamp)) then
                                              local:parseDateTimeToString(fn:data($errorREQ/*[1]/*[1]/*[2]/@rspTimestamp))
                                            else()}</ns2:RSPTIMESTAMP_>
                        <ns2:PROCESSID_>{if(fn:exists($errorREQ/*[1]/*[1]/*[2]/@processID)) then 
                                            fn:data($errorREQ/*[1]/*[1]/*[2]/@processID)
                                         else()}</ns2:PROCESSID_>
                        <ns2:EVENTID_>{fn:data($errorREQ/*[1]/*[1]/*[2]/@eventID)}</ns2:EVENTID_>
                        <ns2:SOURCEID_>{if(fn:exists($errorREQ/*[1]/*[1]/*[2]/@sourceID)) then
                                          fn:data($errorREQ/*[1]/*[1]/*[2]/@sourceID)
                                        else()}</ns2:SOURCEID_>
                        <ns2:CORRELATIONEVENTID_>{if(exists($errorREQ/*[1]/*[1]/*[2]/@correlationEventID)) then
                                        fn:data($errorREQ/*[1]/*[1]/*[2]/@correlationEventID)
                                        else ()}</ns2:CORRELATIONEVENTID_>
                        <ns2:CONVERSATIONID_>{fn:data($errorREQ/*[1]/*[1]/*[2]/@conversationID)}</ns2:CONVERSATIONID_>
                        <ns2:CORRELATIONID_>{if(fn:exists($errorREQ/*[1]/*[1]/*[2]/@correlationID)) then
                                        fn:data($errorREQ/*[1]/*[1]/*[2]/@correlationID)
                                        else()}</ns2:CORRELATIONID_>
                        <ns2:SERVICE_>
                            <ns2:CODE_>{fn:data($errorREQ/*[1]/*[1]/*[2]/ns6:Service[1]/@code)}</ns2:CODE_>
                            <ns2:NAME_>{fn:data($errorREQ/*[1]/*[1]/*[2]/ns6:Service[1]/@name)}</ns2:NAME_>
                            <ns2:OPERATION_>{fn:data($errorREQ/*[1]/*[1]/*[2]/ns6:Service[1]/@operation)}</ns2:OPERATION_>                        
                        </ns2:SERVICE_>
                    </ns2:TRACE_>
                    <ns2:CHANNEL_>
                        <ns2:NAME_>{fn:data($errorREQ/*[1]/*[1]/*[3]/@name)}</ns2:NAME_>
                        <ns2:MODE_>{fn:data($errorREQ/*[1]/*[1]/*[3]/@mode)}</ns2:MODE_>
                    </ns2:CHANNEL_>
                </ns2:HEADER_>
            </ns2:HEADERTRACER_>
            <ns2:RESULT_>
                <ns2:STATUS_>{fn:data($errorREQ/*[2]/@status)}</ns2:STATUS_>
                <ns2:DESCRIPTION_>{substring(fn:data($errorREQ/*[2]/@description),0,254)}</ns2:DESCRIPTION_>
                <ns2:CANONICALERROR_>
                    <ns2:CODE_>{fn:data($errorREQ/*[2]/*[1]/@code)}</ns2:CODE_>
                    <ns2:DESCRIPTION_>{substring(fn:data($errorREQ/*[2]/*[1]/@description),0,254)}</ns2:DESCRIPTION_>
                    <ns2:TYPE_>{fn:data($errorREQ/*[2]/*[1]/@type)}</ns2:TYPE_>
                </ns2:CANONICALERROR_>
                <ns2:SOURCEERROR_>
                    <ns2:CODE_>{fn:data($errorREQ/*[2]/*[2]/@code)}</ns2:CODE_>
                    <ns2:DESCRIPTION_>{substring(fn:data($errorREQ/*[2]/*[2]/@description),0,254)}</ns2:DESCRIPTION_>
                    <ns2:ERRORSOURCEDETAILS_>
                        <ns2:SOURCE_>{fn:data($errorREQ/*[2]/*[2]/ns3:ErrorSourceDetails[1]/@source)}</ns2:SOURCE_>
                        <ns2:DETAILS>{substring(fn:data($errorREQ/*[2]/*[2]/ns3:ErrorSourceDetails[1]/@details),0,254)}</ns2:DETAILS>
                    </ns2:ERRORSOURCEDETAILS_>
                    <ns2:SOURCEFAULT_>{$errorREQ/*[2]/*[2]/ns3:SourceFault[1]}</ns2:SOURCEFAULT_>
                </ns2:SOURCEERROR_>
                <ns2:CORRELATIVEERRORS_/>
            </ns2:RESULT_>
            <ns2:ERRORINDEX_>
                <ns2:MODULE_>{fn:data($errorREQ/*[3]/@module)}</ns2:MODULE_>
                <ns2:SUBMODULE_>{fn:data($errorREQ/*[3]/@subModule)}</ns2:SUBMODULE_>
            </ns2:ERRORINDEX_>
            <ns2:ERRORPLACEHOLDER_>
                <ns2:TIME_>{local:parseDateTimeToString(fn:data($errorREQ/*[4]/@time))}</ns2:TIME_>
                <ns2:PLACE_>{fn:data($errorREQ/*[4]/@place)}</ns2:PLACE_>
            </ns2:ERRORPLACEHOLDER_>
        </ns2:ERRORREQ>
        <ns2:REGISTERTIME>{fn:data($errorREQ/*[4]/@time)}</ns2:REGISTERTIME>
    </ns2:InputParameters>
};

local:get_errorLoggerManagerAdapterREQ($errorREQ)
