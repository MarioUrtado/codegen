xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/RA/PER-EBS-INV-EBS-INV/PR-CREATEREQPHYRES/v1";
(:: import schema at "../../../../../../DC_RA_PER-EBS-INV_v1/ResourceAdapters/PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RA_v1/CSC/PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_v1_CSM.xsd" ::)
declare namespace ns1="http://www.entel.cl/EBM/RequestPhysicalResource/Create/v1";
(:: import schema at "../../../../../ESC/Primary/Create_RequestPhysicalResource_v1_EBM.xsd" ::)
declare namespace ns3="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare variable $PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RSP as element() (:: schema-element(ns2:PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RSP) ::) external;
declare variable $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::) external;

declare function local:get_Create_RequestPhysicalResource_RSP($PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RSP as element() (:: schema-element(ns2:PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RSP) ::), 
                                                              $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::)) 
                                                              as element() (:: schema-element(ns1:Create_RequestPhysicalResource_RSP) ::) {
    <ns1:Create_RequestPhysicalResource_RSP>
        <ns3:ResponseHeader>
            {$RequestHeader/*[1]}
            {$RequestHeader/*[2]}
            {$RequestHeader/*[3]}
            {$PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RSP/*[1]}
        </ns3:ResponseHeader>
        <ns1:Body></ns1:Body>
    </ns1:Create_RequestPhysicalResource_RSP>
};

local:get_Create_RequestPhysicalResource_RSP($PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RSP, $RequestHeader)
