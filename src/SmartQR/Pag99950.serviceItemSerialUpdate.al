page 99950 serviceItemSerialUpdate
{
    APIGroup = 'smartqr';
    APIPublisher = 'brw';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'serviceItemSerialUpdate';
    DelayedInsert = true;
    EntityName = 'serviceItemSerialUpdate';
    EntitySetName = 'serviceItemSerialUpdate';
    PageType = API;
    Permissions = tabledata "Service Item" = rimd;
    SourceTable = "Serv. Item Serial Update";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(invoiceNumber; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field(itemNumber; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(serialNumber; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        ServiceItemsRec: Record "Service Item";
        InputValidationErr: Label 'Invoice Number and Item Number must be provided.';
        NoServiceItemFoundErr: Label 'Service Item with Invoice No. %1 and Item No. %2 not found.';
        AllItemsAssignedErr: Label 'All Service Items with Invoice No. %1 and Item No. %2 have been assigned a serial number.';
        UpdateFailedErr: Label 'Failed to update Service Item with Invoice No. %1 and Item No. %2.';
    begin
        if (Rec."Invoice No." = '') or (Rec."Item No." = '') then
            Error(InputValidationErr);

        ServiceItemsRec.Reset();
        ServiceItemsRec.SetRange("Invoice No.", Rec."Invoice No.");
        ServiceItemsRec.SetRange("Item No.", Rec."Item No.");

        if not ServiceItemsRec.FindSet() then
            Error(NoServiceItemFoundErr, Rec."Invoice No.", Rec."Item No.");

        ServiceItemsRec.SetRange("Serial No.", '');
        if not ServiceItemsRec.FindFirst() then
            Error(AllItemsAssignedErr, Rec."Invoice No.", Rec."Item No.");

        if ServiceItemsRec.FindFirst() then
            if not UpdateServiceItem(ServiceItemsRec) then
                Error(UpdateFailedErr, Rec."Invoice No.", Rec."Item No.");

        exit(true);
    end;

    [TryFunction]
    local procedure UpdateServiceItem(var ServiceItemsRec: Record "Service Item")
    begin
        ServiceItemsRec.Validate("Serial No.", Rec."Serial No.");
        ServiceItemsRec.Modify();
    end;
}