xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $Username as xs:string external;
declare variable $Password as xs:string external;

declare function local:get_UsernameTokenSiebel.xqy($Username as xs:string, 
                                                   $Password as xs:string) 
                                                   as element() {
<wsse:Security xmlns:wsse="http://schemas.xmlsoap.org/ws/2002/07/secext">
	<wsse:UsernameToken xmlns:wsu="http://schemas.xmlsoap.org/ws/2002/07/utility">
		<wsse:Username>{$Username}</wsse:Username>
		<wsse:Password Type="wsse:PasswordText">{$Password}</wsse:Password>
	</wsse:UsernameToken>
</wsse:Security>
};

local:get_UsernameTokenSiebel.xqy($Username, $Password)
