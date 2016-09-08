xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/InvalidMessage/JSON/v1";
(:: import schema at "../../../XSD/ESO/InvalidMessage_JSON_v1_ESO.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns6 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns7 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $invalidHeader as element() external;

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


declare function local:func($invalidHeader as element()) as element() (:: schema-element(ns1:InvalidHeader_RSP) ::) {
  <ns1:InvalidHeader_RSP>
      <ns1:InvalidHeader>
          {local:getResult( $invalidHeader/*:Result[1] )}
      </ns1:InvalidHeader>
  </ns1:InvalidHeader_RSP>
};

local:func($invalidHeader)