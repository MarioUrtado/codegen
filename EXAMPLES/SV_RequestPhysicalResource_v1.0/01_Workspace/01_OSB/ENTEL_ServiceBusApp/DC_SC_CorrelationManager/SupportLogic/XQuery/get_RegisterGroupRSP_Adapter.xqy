xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationMember/registerGroup/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/registerGroup_CorrelationManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/registerCorrelationMemberAdapter";
(:: import schema at "../JCA/registerCorrelationMemberAdapter/registerCorrelationMemberAdapter_sp.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace cor = "http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $Result as element() (:: schema-element(ns3:Result) ::)  external;

declare function local:getCodError($cod as xs:string) as xs:string {
     if (xs:int($cod) = 0)
       then 'OK'
       else (if (xs:int($cod) = 1)
            then "WARNING"
             else    "ERROR")
};



declare function local:func($OutputParameters as element()? (:: schema-element(ns1:OutputParameters) ::),$Result as element() (:: schema-element(ns3:Result) ::)  ) as element() (:: schema-element(ns2:RegisterGroupRSP) ::) {
    <ns2:RegisterGroupRSP>
         {
          $Result
         }
       
    </ns2:RegisterGroupRSP>
};

local:func($OutputParameters,$Result)
