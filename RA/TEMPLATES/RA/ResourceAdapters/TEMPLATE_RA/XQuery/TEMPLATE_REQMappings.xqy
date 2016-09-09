xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/%SYSTEM_API%/%OPERATION%/v1";
(:: import schema at "../CSC/%SYSTEM_API%_%OPERATION%_v1_CSM.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns5 = "http://www.entel.cl/SC/ParameterManager/getMapping/v1";
(:: import schema at "../../../../DC_SC_ParameterManager/SupportAPI/XSD/CSM/getMapping_ParameterManager_v1_CSM.xsd" ::)

declare variable $RaREQ as element() (:: schema-element(ns1:%SYSTEM_API%_%OPERATION%_REQ) ::) external;
declare variable $GetMappingRSP as element() (:: schema-element(ns5:GetMappingRSP) ::) external;

declare function local:get_%SYSTEM_API%_%OPERATION%_REQMappings($RaREQ as element() (:: schema-element(ns1:%SYSTEM_API%_%OPERATION%_REQ) ::), 
                                                                 $GetMappingRSP as element()(:: schema-element(ns5:GetMappingRSP) ::)) 
                                                                 as element() (:: schema-element(ns1:%SYSTEM_API%_%OPERATION%_REQ) ::) {
    <ns1:%SYSTEM_API%_%OPERATION%_REQ>
    (: 
      The Request Header is not required at this point, as it is assumed to be saved on a local variable within the 
      RA Pipeline. This reduces the size of the $body variable, and avoids further XPATH queries to be performed.
      As it is a good practice to use positional XPATH, the element is maintained to avoid possible mistakes when applying
      that type of XPATH over the RA Request, after it was modified by this XQ
    :)
        (: Delete STUB element :)
        <STUB>{$RaREQ}{$GetMappingRSP}</STUB>

        <ns1:Body>
        </ns1:Body>
    </ns1:%SYSTEM_API%_%OPERATION%_REQ>
};

local:get_%SYSTEM_API%_%OPERATION%_REQMappings($RaREQ, $GetMappingRSP)