xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CorrelationMember/registerGroup/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/registerGroup_CorrelationManager_v1_CSM.xsd" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/registerCorrelationMemberAdapter";
(:: import schema at "../JCA/registerCorrelationMemberAdapter/registerCorrelationMemberAdapter_sp.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace cor = "http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $RegisterCorrelationREQ as element() (:: schema-element(ns1:RegisterGroupREQ) ::) external;

declare function local:func($RegisterCorrelationREQ as element() (:: schema-element(ns1:RegisterGroupREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:GROUP_NAME>{fn:data($RegisterCorrelationREQ/cor:Group/@cor:groupName)}</ns2:GROUP_NAME>
        {
            if ($RegisterCorrelationREQ/cor:Group/@cor:groupDescription)
            then <ns2:GROUP_DESC>{fn:data($RegisterCorrelationREQ/cor:Group/@cor:groupDescription)}</ns2:GROUP_DESC>
            else ()
        }
        <ns2:GROUP_HEADER>{fn-bea:serialize($RegisterCorrelationREQ/*[1])}</ns2:GROUP_HEADER>
        <ns2:MEMBER_TYPES>
            {
                for $Member in $RegisterCorrelationREQ/*[2]/*[1]/*
                return 
                <ns2:MEMBER_TYPES_ITEM>
                    <ns2:MEMBER_NAME_>{fn:data($Member/@cor:memberName)}</ns2:MEMBER_NAME_>
                    <ns2:TYPE_MEMBER_>{fn:data($Member/@cor:memberType)}</ns2:TYPE_MEMBER_>
                    <ns2:CORRELATION_ID_>{fn:data($Member/@cor:memberCorrID)}</ns2:CORRELATION_ID_>
                    {
                        if ($Member/@cor:memberAddress)
                        then <ns2:MEMBER_ADDRESS_>{fn:data($Member/@cor:memberAddress)}</ns2:MEMBER_ADDRESS_>
                        else ()
                    }</ns2:MEMBER_TYPES_ITEM>
            }</ns2:MEMBER_TYPES>
    </ns2:InputParameters>
};

local:func($RegisterCorrelationREQ)
