xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ErrorManager/ErrorDictionary/v1";
(:: import schema at "../XSD/ErrorDictionary.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ErrorManager";
(:: import schema at "../JCA/errorManagerAdapter/ErrorManager_sp.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $entrada as element() (:: schema-element(ns1:ErrDicREQ) ::) external;

declare function local:errorManager_db_REQ($entrada as element() (:: schema-element(ns1:ErrDicREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($entrada/*[2]/@module)
            then <ns2:P_MODULE>{fn:data($entrada/*[2]/@module)}</ns2:P_MODULE>
            else ()
        }
        {
            if ($entrada/*[2]/@subModule)
            then <ns2:P_SUB_MODULE>{fn:data($entrada/*[2]/@subModule)}</ns2:P_SUB_MODULE>
            else ()
        }
        {
            if ($entrada/*[1]/@code)
            then <ns2:P_RAW_CODE>{fn:data($entrada/*[1]/@code)}</ns2:P_RAW_CODE>
            else ()
        }

        {
            if ($entrada/*[3]/@source)
            then <ns2:p_ERROR_DETAILS_SOURCE>{fn:data($entrada/*[3]/@source)}</ns2:p_ERROR_DETAILS_SOURCE>
            else ()
        }
    </ns2:InputParameters>
};

local:errorManager_db_REQ($entrada)
