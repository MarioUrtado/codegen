xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/Exception/JSON/v1";
(:: import schema at "../../../XSD/ESO/Exception_JSON_v1_ESO.xsd" ::)
declare namespace ns1="http://www.entel.cl/ESO/Exception/v1";
(:: import schema at "../../../XSD/ESO/Exception_v1_ESO.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns6 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns7 = "http://www.entel.cl/EBO/Consumer/v1";

declare function local:getResult( $result as element(ns5:Result)  ) as element(ns3:Result) {
  <ns3:Result>
      <ns3:status>{fn:data($result/@status)}</ns3:status>
      {
          if ($result/@description)
          then <ns3:description>{fn:data($result/@description)}</ns3:description>
          else ()
      }
      {
          if ($result/ns6:CanonicalError)
          then <ns3:CanonicalError>
              {
                  if ($result/ns6:CanonicalError/@type)
                  then <ns3:type>{fn:data($result/ns6:CanonicalError/@type)}</ns3:type>
                  else ()
              }
              {
                  if ($result/ns6:CanonicalError/@code)
                  then <ns3:code>{fn:data($result/ns6:CanonicalError/@code)}</ns3:code>
                  else ()
              }
              {
                  if ($result/ns6:CanonicalError/@description)
                  then <ns3:description>{fn:data($result/ns6:CanonicalError/@description)}</ns3:description>
                  else ()
              }</ns3:CanonicalError>
          else ()
      }
      {
          if ($result/ns6:SourceError)
          then <ns3:SourceError>
              {
                  if ($result/ns6:SourceError/@code)
                  then <ns3:code>{fn:data($result/ns6:SourceError/@code)}</ns3:code>
                  else ()
              }
              {
                  if ($result/ns6:SourceError/@description)
                  then <ns3:description>{fn:data($result/ns6:SourceError/@description)}</ns3:description>
                  else ()
              }
              <ns3:ErrorSourceDetails>
                  {
                      if ($result/ns6:SourceError/ns6:ErrorSourceDetails/@source)
                      then <ns3:source>{fn:data($result/ns6:SourceError/ns6:ErrorSourceDetails/@source)}</ns3:source>
                      else ()
                  }
                  <ns3:details></ns3:details>
              </ns3:ErrorSourceDetails>
              <ns3:SourceFault>{fn-bea:serialize($result/ns6:SourceError/ns6:SourceFault/*[1])}</ns3:SourceFault></ns3:SourceError>
          else ()
      }
      <ns3:CorrelativeErrors>
          {
              for $SourceError in $result/ns5:CorrelativeErrors/ns6:SourceError
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
                  <ns3:SourceFault>{fn-bea:serialize($SourceError/ns6:SourceFault)}</ns3:SourceFault></ns3:SourceError>
          }</ns3:CorrelativeErrors>
  </ns3:Result>
};

declare function local:getResponseHeader( $responseHeader as element(ns4:ResponseHeader) ) as element(ns3:ResponseHeader){
  <ns3:ResponseHeader>
      <ns3:Consumer>
          <ns3:sysCode>{fn:data($responseHeader/ns4:Consumer/@sysCode)}</ns3:sysCode>
          <ns3:enterpriseCode>{fn:data($responseHeader/ns4:Consumer/@enterpriseCode)}</ns3:enterpriseCode>
          <ns3:countryCode>{fn:data($responseHeader/ns4:Consumer/@countryCode)}</ns3:countryCode>
      </ns3:Consumer>
      <ns3:Trace>
          <ns3:clientReqTimestamp>{fn:data($responseHeader/ns4:Trace/@clientReqTimestamp)}</ns3:clientReqTimestamp>
          {
              if ($responseHeader/ns4:Trace/@reqTimestamp)
              then <ns3:reqTimestamp>{fn:data($responseHeader/ns4:Trace/@reqTimestamp)}</ns3:reqTimestamp>
              else ()
          }
          {
              if ($responseHeader/ns4:Trace/@rspTimestamp)
              then <ns3:rspTimestamp>{fn:data($responseHeader/ns4:Trace/@rspTimestamp)}</ns3:rspTimestamp>
              else ()
          }
          {
              if ($responseHeader/ns4:Trace/@processID)
              then <ns3:processID>{fn:data($responseHeader/ns4:Trace/@processID)}</ns3:processID>
              else ()
          }
          <ns3:eventID>{fn:data($responseHeader/ns4:Trace/@eventID)}</ns3:eventID>
          {
              if ($responseHeader/ns4:Trace/@sourceID)
              then <ns3:sourceID>{fn:data($responseHeader/ns4:Trace/@sourceID)}</ns3:sourceID>
              else ()
          }
          {
              if ($responseHeader/ns4:Trace/@correlationEventID)
              then <ns3:correlationEventID>{fn:data($responseHeader/ns4:Trace/@correlationEventID)}</ns3:correlationEventID>
              else ()
          }
          {
              if ($responseHeader/ns4:Trace/@conversationID)
              then <ns3:conversationID>{fn:data($responseHeader/ns4:Trace/@conversationID)}</ns3:conversationID>
              else ()
          }
          {
              if ($responseHeader/ns4:Trace/@correlationID)
              then <ns3:correlationID>{fn:data($responseHeader/ns4:Trace/@correlationID)}</ns3:correlationID>
              else ()
          }
          {
              if ($responseHeader/ns4:Trace/ns4:Service)
              then <ns3:Service>
                  {
                      if ($responseHeader/ns4:Trace/ns4:Service/@code)
                      then <ns3:code>{fn:data($responseHeader/ns4:Trace/ns4:Service/@code)}</ns3:code>
                      else ()
                  }
                  {
                      if ($responseHeader/ns4:Trace/ns4:Service/@name)
                      then <ns3:name>{fn:data($responseHeader/ns4:Trace/ns4:Service/@name)}</ns3:name>
                      else ()
                  }
                  {
                      if ($responseHeader/ns4:Trace/ns4:Service/@operation)
                      then <ns3:operation>{fn:data($responseHeader/ns4:Trace/ns4:Service/@operation)}</ns3:operation>
                      else ()
                  }</ns3:Service>
              else ()
          }
      </ns3:Trace>
      {
          if ($responseHeader/ns4:Channel)
          then <ns3:Channel>
              {
                  if ($responseHeader/ns4:Channel/@name)
                  then <ns3:name>{fn:data($responseHeader/ns4:Channel/@name)}</ns3:name>
                  else ()
              }
              {
                  if ($responseHeader/ns4:Channel/@mode)
                  then <ns3:mode>{fn:data($responseHeader/ns4:Channel/@mode)}</ns3:mode>
                  else ()
              }</ns3:Channel>
          else ()
      }
      { local:getResult( $responseHeader/ns5:Result ) }
  </ns3:ResponseHeader>
};

declare variable $unexpectedErrorException as element() external;
declare variable $faultstring as xs:string external;
declare variable $faultcode as xs:string external;

declare function local:func($faultstring as xs:string, $faultcode as xs:string, $detail as element()) as element()  {
  <ns2:Fault>
      <ns2:faultcode>{fn:data($faultcode)}</ns2:faultcode>
      <ns2:faultstring>{fn:data($faultstring)}</ns2:faultstring>
      <ns2:detail>
         {
           if ( $detail/ns5:Result )
           then (
             local:getResult($detail/ns5:Result)
           )
           else (
             <ns2:UnexpectedErrorException>
              <ns2:exceptionDetail>{fn:data($detail/ns1:UnexpectedErrorException/@exceptionDetail)}</ns2:exceptionDetail>
              {
                if ( $detail/ns1:UnexpectedErrorException/ns4:ResponseHeader )
                then (
                  local:getResponseHeader( $detail/ns1:UnexpectedErrorException/ns4:ResponseHeader )
                )
                else (
                   local:getResult($detail/ns1:UnexpectedErrorException/ns5:Result)
                )
              }
            </ns2:UnexpectedErrorException>
           )
         }
      </ns2:detail>
  </ns2:Fault>
};

local:func($faultstring, $faultcode ,$unexpectedErrorException)