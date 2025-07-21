codeunit 99950 ServiceItemCreation
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServItemManagement, 'OnCreateServItemOnSalesLineShpt', '', true, true)]
    local procedure OnCreateServItemOnSalesLineShpt(var ServiceItem: Record "Service Item"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    begin
        ServiceItem.Validate("Invoice No.", SalesHeader."Posting No.");
    end;
}
