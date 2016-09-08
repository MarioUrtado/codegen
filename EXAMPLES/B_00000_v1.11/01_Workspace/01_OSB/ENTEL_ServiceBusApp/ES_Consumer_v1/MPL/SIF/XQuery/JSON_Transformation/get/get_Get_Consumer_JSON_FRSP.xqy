xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/EBM/Consumer/get/JSON/v1";
(:: import schema at "../../../../../ESC/Secondary/get_Consumer_JSON_v1_EBM.xsd" ::)
declare namespace ns1="http://www.entel.cl/EBM/Consumer/get/v1";
(:: import schema at "../../../../../ESC/Primary/get_Consumer_v1_EBM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns6 = "http://www.entel.cl/ESO/Error/v1";

declare variable $Get_Consumer_FRSP as element() (:: schema-element(ns1:Get_Consumer_FRSP) ::) external;
declare variable $faultcode as xs:string external;
declare variable $faultstring as xs:string external;


declare function local:func($Get_Consumer_FRSP as element() (:: schema-element(ns1:Get_Consumer_FRSP) ::),
                            $faultcode as xs:string ,
                            $faultstring as xs:string 
                            ) as element() (:: schema-element(ns2:Fault) ::) {
  <ns2:Fault>
       <ns2:faultcode>{fn:data($faultcode)}</ns2:faultcode>
       <ns2:faultstring>{fn:data($faultstring)}</ns2:faultstring>
       <ns2:detail>
           <ns2:Get_Consumer_FRSP>
               <ns3:ResponseHeader>
                   <ns3:Consumer>
                       <ns3:sysCode>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Consumer/@sysCode)}</ns3:sysCode>
                       <ns3:enterpriseCode>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Consumer/@enterpriseCode)}</ns3:enterpriseCode>
                       <ns3:countryCode>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Consumer/@countryCode)}</ns3:countryCode>
                   </ns3:Consumer>
                   <ns3:Trace>
                       <ns3:clientReqTimestamp>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@clientReqTimestamp)}</ns3:clientReqTimestamp>
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@reqTimestamp)
                           then <ns3:reqTimestamp>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@reqTimestamp)}</ns3:reqTimestamp>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@rspTimestamp)
                           then <ns3:rspTimestamp>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@rspTimestamp)}</ns3:rspTimestamp>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@processID)
                           then <ns3:processID>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@processID)}</ns3:processID>
                           else ()
                       }
                       <ns3:eventID>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@eventID)}</ns3:eventID>
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@sourceID)
                           then <ns3:sourceID>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@sourceID)}</ns3:sourceID>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@correlationEventID)
                           then <ns3:correlationEventID>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@correlationEventID)}</ns3:correlationEventID>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@conversationID)
                           then <ns3:conversationID>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@conversationID)}</ns3:conversationID>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@correlationID)
                           then <ns3:correlationID>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/@correlationID)}</ns3:correlationID>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/ns4:Service)
                           then <ns3:Service>
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/ns4:Service/@code)
                                   then <ns3:code>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/ns4:Service/@code)}</ns3:code>
                                   else ()
                               }
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/ns4:Service/@name)
                                   then <ns3:name>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/ns4:Service/@name)}</ns3:name>
                                   else ()
                               }
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/ns4:Service/@operation)
                                   then <ns3:operation>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Trace/ns4:Service/@operation)}</ns3:operation>
                                   else ()
                               }</ns3:Service>
                           else ()
                       }
                   </ns3:Trace>
                   {
                       if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Channel)
                       then <ns3:Channel>
                           {
                               if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Channel/@name)
                               then <ns3:name>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Channel/@name)}</ns3:name>
                               else ()
                           }
                           {
                               if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Channel/@mode)
                               then <ns3:mode>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns4:Channel/@mode)}</ns3:mode>
                               else ()
                           }</ns3:Channel>
                       else ()
                   }
                   <ns3:Result>
                       <ns3:status>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/@status)}</ns3:status>
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/@description)
                           then <ns3:description>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/@description)}</ns3:description>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:CanonicalError)
                           then <ns3:CanonicalError>
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:CanonicalError/@type)
                                   then <ns3:type>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:CanonicalError/@type)}</ns3:type>
                                   else ()
                               }
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:CanonicalError/@code)
                                   then <ns3:code>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:CanonicalError/@code)}</ns3:code>
                                   else ()
                               }
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:CanonicalError/@description)
                                   then <ns3:description>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:CanonicalError/@description)}</ns3:description>
                                   else ()
                               }</ns3:CanonicalError>
                           else ()
                       }
                       {
                           if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError)
                           then <ns3:SourceError>
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/@code)
                                   then <ns3:code>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/@code)}</ns3:code>
                                   else ()
                               }
                               {
                                   if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/@description)
                                   then <ns3:description>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/@description)}</ns3:description>
                                   else ()
                               }
                               <ns3:ErrorSourceDetails>
                                   {
                                       if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)
                                       then <ns3:source>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)}</ns3:source>
                                       else ()
                                   }
                                   {
                                       if ($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@details)
                                       then <ns3:details>{fn:data($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@details)}</ns3:details>
                                       else ()
                                   }</ns3:ErrorSourceDetails>
                               <ns3:SourceFault>{fn-bea:serialize($Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns6:SourceError/ns6:SourceFault)}</ns3:SourceFault></ns3:SourceError>
                           else ()
                       }
                       <ns3:CorrelativeErrors>
                           {
                               for $SourceError in $Get_Consumer_FRSP/ns4:ResponseHeader/ns5:Result/ns5:CorrelativeErrors/ns6:SourceError
                               return 
                               <ns3:SourceError>
                                   {
                                       if ($SourceError/@code)
                                       then <ns3:code>{fn:data($SourceError/@code)}</ns3:code>
                                       else ()
                                   }
                                   {
                                       if ($SourceError/@description)
                                       then <ns3:description>{fn:data($SourceError/@description)}</ns3:description>
                                       else ()
                                   }
                                   <ns3:ErrorSourceDetails>
                                       {
                                           if ($SourceError/ns6:ErrorSourceDetails/@source)
                                           then <ns3:source>{fn:data($SourceError/ns6:ErrorSourceDetails/@source)}</ns3:source>
                                           else ()
                                       }
                                       {
                                           if ($SourceError/ns6:ErrorSourceDetails/@details)
                                           then <ns3:details>{fn:data($SourceError/ns6:ErrorSourceDetails/@details)}</ns3:details>
                                           else ()
                                       }
                                   </ns3:ErrorSourceDetails>
                                   <ns3:SourceFault>{fn-bea:serialize($SourceError/ns6:SourceFault)}</ns3:SourceFault>
                                 </ns3:SourceError>
                                   
                           }</ns3:CorrelativeErrors>
                   </ns3:Result>
               </ns3:ResponseHeader>
               <ns2:Body></ns2:Body>
           </ns2:Get_Consumer_FRSP>
       </ns2:detail>
 </ns2:Fault>
};

local:func($Get_Consumer_FRSP, $faultcode, $faultstring )
