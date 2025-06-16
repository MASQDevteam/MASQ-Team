page 70103 "Travel Requests Form"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Travel Request";
    CardPageId = "Travel Request Form";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                }

                field("Traveler's Name"; Rec."Traveler's Name")
                {
                    ToolTip = 'Specifies the value of the Traveler''s Name field.', Comment = '%';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.', Comment = '%';
                }
                field(Departure; Rec.Departure)
                {
                    ToolTip = 'Specifies the value of the Departure field.', Comment = '%';
                }
                field(Return; Rec.Return)
                {
                    ToolTip = 'Specifies the value of the Return field.', Comment = '%';
                }
                field("Travel Advance Required"; Rec."Travel Advance Required")
                {
                    ToolTip = 'Specifies the value of the Travel Advance Required field.', Comment = '%';
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                }
                field("No of Worked Holidays&Weekends"; Rec."No of Worked Holidays&Weekends")
                {
                    ToolTip = 'Specifies the value of the No of Worked Holidays&Weekends field.', Comment = '%';
                }
                field("Approved By Manager"; Rec."Approved By Manager")
                {
                    ToolTip = 'Specifies the value of the Approved By Manager field.', Comment = '%';
                }
                field("Approved By Project Manager"; Rec."Approved By Project Manager")
                {
                    ToolTip = 'Specifies the value of the Approved By Project Manager field.', Comment = '%';
                }
                field("Approved By Finance"; Rec."Approved By Finance")
                {
                    ToolTip = 'Specifies the value of the Approved By Finance field.', Comment = '%';
                }
                field("Traveling by Air"; Rec."Traveling by Air")
                {
                    ToolTip = 'Specifies the value of the Traveling by Air field.', Comment = '%';
                }
                field("Traveling by Road"; Rec."Traveling by Road")
                {
                    ToolTip = 'Specifies the value of the Traveling by Road field.', Comment = '%';
                }
                field("Traveling Both"; Rec."Traveling Both")
                {
                    ToolTip = 'Specifies the value of the Traveling Both field.', Comment = '%';
                }
                field(Airline; Rec.Airline)
                {
                    ToolTip = 'Specifies the value of the Airline field.', Comment = '%';
                }
                field("Time of Departure"; Rec."Time of Departure")
                {
                    ToolTip = 'Specifies the value of the Time of Departure field.', Comment = '%';
                }
                field("Time of Return"; Rec."Time of Return")
                {
                    ToolTip = 'Specifies the value of the Time of Return field.', Comment = '%';
                }
                field("Reason for Travel"; Rec."Reason for Travel")
                {
                    ToolTip = 'Specifies the value of the Reason for Travel field.', Comment = '%';
                }
                field("Specific Requests"; Rec."Specific Requests")
                {
                    ToolTip = 'Specifies the value of the Specific Requests field.', Comment = '%';
                }

                field("Approval Entries"; Rec."Approval Entries")
                {
                    ToolTip = 'Specifies the value of the Approval Entries field.', Comment = '%';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ApprovalEntries: Record "Approval Entry";
                    begin
                        Clear(ApprovalEntries);
                        ApprovalEntries.SetRange("Document No.", Rec.Number);
                        page.Run(page::"Approval Entries", ApprovalEntries);
                    end;

                    trigger OnDrillDown()
                    var

                        ApprovalEntries: Record "Approval Entry";
                    begin
                        Clear(ApprovalEntries);
                        ApprovalEntries.SetRange("Document No.", Rec.Number);
                        page.Run(page::"Approval Entries", ApprovalEntries);

                    end;
                }
            }
        }
        area(Factboxes)
        {
            //AN 03/11/25+
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Travel Request"),
                             "No." = field(Number);
                // "Document Type" = field("Document Type");
            }
            systempart(TRNotes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Travel Request Report")
            {
                ApplicationArea = All;
                Image = Report;
                RunObject = report "Travel Request";


                trigger OnAction()
                begin

                end;
            }
        }
    }
}