xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";

declare variable $Username as xs:string external;
declare variable $Password as xs:string external;

declare function local:get_WS-Security1.1_UsernameToken($Username as xs:string, 
                                                        $Password as xs:string) 
                                                        as element() {
    <wsse:Security>
	<wsse:UsernameToken>
		<wsse:Username>{$Username}</wsse:Username>
		<wsse:Password>{$Password}</wsse:Password>
	</wsse:UsernameToken>
    </wsse:Security>
};

local:get_WS-Security1.1_UsernameToken($Username, $Password)
