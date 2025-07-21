table 99950 "Serv. Item Serial Update"
{
    Caption = 'Service Item Serial Update';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Invoice No."; Code[500])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Item No."; Code[500])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Serial No."; Code[500])
        {
            Caption = 'Serial No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Invoice No.", "Item No.", "Serial No.")
        {
            Clustered = true;
        }
    }
}
