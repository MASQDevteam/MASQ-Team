//FQ MASQ Start
page 70177 "RecordLinkList"
/* created this page and web service to extract the BLOB of notes from the system */
{
    PageType = List;
    SourceTable = "Record Link";
    Caption = 'Record Links and Notes';
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    /*     PageType = API;
        APIGroup = 'MASQ';
        APIPublisher = 'MASQ';
        APIVersion = 'beta';
        EntityName = 'note';
        EntitySetName = 'notes'; 
    ODataKeyFields = SystemId; */


    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(LinkId; Rec."Link ID")
                {
                    Caption = 'Link ID';
                }
                field(RecordId; Rec."Record ID")
                {
                    Caption = 'Record ID';
                }
                field(Company; Rec."Company")
                {
                    Caption = 'Company';
                }
                field(Type; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(Description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(SourceTable; ParseRecordId(Rec."Record ID", 'Table', ':', ','))
                {
                    Caption = 'Source Table';
                }
                field(PrimaryKey; ParseRecordId(Rec."Record ID", 'Primary Key', ':', ','))
                {
                    Caption = 'Primary Key';
                }
                field(NoteText; GetNoteText())
                {
                    Caption = 'Note Text';
                }
                field(systemid; Rec."SystemId")
                {
                }
                field(systemcreatedat; Rec."SystemCreatedAt")
                {
                }
                field(systemcreatedby; Rec."SystemCreatedBy")
                {
                }
                field(systemmodifiedat; Rec."SystemModifiedAt")
                {
                }
                field(systemmodifiedby; Rec."SystemModifiedBy")
                {
                }

            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }

    local procedure GetNoteText(): Text[1024]
    /* get the note from using built in codeunit */
    var
        RecordLinkMgt: Codeunit "Record Link Management";
    begin
        if Rec.Type = Rec.Type::Note then begin
            Rec.CalcFields(Note); // Load the Note BLOB field
            exit(RecordLinkMgt.ReadNote(Rec))
        end;

        exit(''); // Return an empty string if no note or invalid type
    end;

    local procedure ParseRecordId(record_id: RecordId; recType: Text[20]; recordIdDelimiter: Text[1]; pkDelimiter: Text[2]): Text[250]
    // take in the record id, parse the table and the primary key(s) from it and return
    var
        formattedRecordId: Text[250];
        tableName: Text[250];
        pkName: Text[250];
    begin
        // Convert RecordId to a readable text format
        formattedRecordId := Format(record_id);

        // Extract the table name and primary key components
        tableName := CopyStr(formattedRecordId, 1, StrPos(formattedRecordId, recordIdDelimiter) - 1);
        pkName := CopyStr(formattedRecordId, StrPos(formattedRecordId, recordIdDelimiter) + 2);

        if recType = 'Table' then begin
            // Return the table name. This is prob over complicated but w/e... may be smarter to split this procuedure into two or more functions
            exit(tableName);
        end else begin
            exit(pkName); // Return the full primary key string if no parsing is needed
        end;

        exit(pkName);
    end;

}  //FQ MASQ End