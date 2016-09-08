xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/PER-EBS-INV-EBS-INV/PR-CREATEREQPHYRES/v1";
(:: import schema at "../../../../../../DC_RA_PER-EBS-INV_v1/ResourceAdapters/PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_RA_v1/CSC/PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/EBM/RequestPhysicalResource/Create/v1";
(:: import schema at "../../../../../ESC/Primary/Create_RequestPhysicalResource_v1_EBM.xsd" ::)

declare namespace ns6 = "http://www.entel.cl/EBO/StockTransaction/v1";

declare namespace ns5 = "http://www.entel.cl/EBO/PhysicalResourceSpec/v1";

declare namespace ns7 = "http://www.entel.cl/EBO/PartyRole/v1";

declare namespace ns4 = "http://www.entel.cl/EBO/PhysicalResource/v1";

declare namespace ns3 = "http://www.entel.cl/EBO/FreightInvoiceItem/v1";

declare variable $Create_RequestPhysicalResource_REQ as element() (:: schema-element(ns2:Create_RequestPhysicalResource_REQ) ::) external;

declare function local:get_PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_REQ($Create_RequestPhysicalResource_REQ as element() (:: schema-element(ns2:Create_RequestPhysicalResource_REQ) ::)) as element() (:: schema-element(ns1:PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_REQ) ::) {
    <ns1:PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_REQ>
        {$Create_RequestPhysicalResource_REQ/*[1]}
        <ns1:Body>
            <ns1:FreightInvoice>
                {
                    for $FreightInvoiceItem in $Create_RequestPhysicalResource_REQ/*[2]/*[1]/ns2:FreightInvoiceItem
                    return 
                    <ns1:FreightInvoiceItem>
                        <ns3:needDate>{fn:data($FreightInvoiceItem/ns3:needDate)}</ns3:needDate>
                        <ns3:quantity>{fn:data($FreightInvoiceItem/ns3:quantity)}</ns3:quantity>
                        <ns1:PhysicalResource>
                            {
                                if ($FreightInvoiceItem/ns2:PhysicalResource/ns4:serialNumber)
                                then <ns4:serialNumber>{fn:data($FreightInvoiceItem/ns2:PhysicalResource/ns4:serialNumber)}</ns4:serialNumber>
                                else ()
                            }
                            <ns1:PhysicalResourceSpec>
                                <ns5:skuNumber>{fn:data($FreightInvoiceItem/ns2:PhysicalResource/ns2:PhysicalResourceSpec/ns5:skuNumber)}</ns5:skuNumber>
                            </ns1:PhysicalResourceSpec>
                        </ns1:PhysicalResource>
                        <ns1:StockTransaction>
                            <ns6:ID>{fn:data($FreightInvoiceItem/ns2:StockTransaction/ns6:ID)}</ns6:ID>
                        </ns1:StockTransaction>
                    </ns1:FreightInvoiceItem>
                }
                <ns1:IssuingCompany>
                    <ns1:partyRole>
                        <ns7:ID>{fn:data($Create_RequestPhysicalResource_REQ/ns2:Body/ns2:FreightInvoice/ns2:IssuingCompany/ns2:partyRole/ns7:ID)}</ns7:ID>
                    </ns1:partyRole>
                </ns1:IssuingCompany>
            </ns1:FreightInvoice>
        </ns1:Body>
    </ns1:PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_REQ>
};

local:get_PER-EBS-INV-EBS-INV_PR-CREATEREQPHYRES_REQ($Create_RequestPhysicalResource_REQ)
