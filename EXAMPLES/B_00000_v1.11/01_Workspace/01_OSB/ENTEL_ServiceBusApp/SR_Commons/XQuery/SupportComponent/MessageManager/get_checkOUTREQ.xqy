xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/MessageManager/checkOUT/v1";

declare variable $serviceResponse as element() external;

declare function local:get_checkOUTREQ($serviceResponse as element()) as element() {
    <ns1:checkOUTREQ>
        <ns1:Message>{$serviceResponse}</ns1:Message>
    </ns1:checkOUTREQ>
};

local:get_checkOUTREQ($serviceResponse)
