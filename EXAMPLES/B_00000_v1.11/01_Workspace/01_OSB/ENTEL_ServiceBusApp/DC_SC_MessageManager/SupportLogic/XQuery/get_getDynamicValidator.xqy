xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $operation as xs:string external;

declare function local:getDynamicValidator($operation as xs:string) as element() {
  <validate xmlns="http://www.bea.com/wli/sb/context">
    <schema>SR_Commons/XSD/ESO/MessageHeader_v1_ESO</schema>
    <schemaElement>
      <namespaceURI>http://www.entel.cl/ESO/MessageHeader/v1</namespaceURI>
      {
      if ($operation = "checkIN")
      then <localname>RequestHeader</localname>
      else if ($operation = "checkOUT")
      then <localname>ResponseHeader</localname>
      else ()
      }
    </schemaElement>
  </validate>
};

local:getDynamicValidator($operation)
