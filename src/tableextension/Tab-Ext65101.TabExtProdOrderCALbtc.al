tableextension 65101 "TabExtProdOrder_CAL_btc" extends "Production Order"
{
    fields
    {
        field(65200; UsuarioOPLanzadaCAL_BTC; Code[50])
        {
            Caption = 'Usuario creacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(65201; DatetimeOPLanzadaCAL_BTC; DateTime)
        {
            Caption = 'Datetime OP Lanzada';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
        }
        field(65202; UsuarioOPTerminadaCAL_BTC; Code[50])
        {
            Caption = 'Usuario creacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(65203; DatetimeOPTerminadaCAL_BTC; DateTime)
        {
            Caption = 'Datetime OP Terminada';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
        }
        field(65304; "EstadoRevisiónVisualCAL_BTC"; Option)
        {
            CalcFormula = Lookup("Lot No. Information".EstadoRevisionVisualCAL_BTC WHERE("Item No." = FIELD("Source No."), "Lot No." = FIELD(NoLoteCAL_BTC)));
            Caption = 'Estado revisión visual';
            Description = 'CAL1.00';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Pendiente,Visado,Revisado,No Obligatorio';
            OptionMembers = Pendiente,Visado,Revisado,"No Obligatorio";
        }
        field(65305; "No.RelatedOrderCAL_BTC"; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released | Finished));
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                RelatedOrder: Record "Production Order";
                opRelacionada: Boolean;
            begin
                if "No.RelatedOrderCAL_BTC" = "No." then Error('Atención: La orden relacionada no puede ser la misma');
                RelatedOrder.Init();
                opRelacionada := false;
                if "No.RelatedOrderCAL_BTC" <> '' then begin
                    if RelatedOrder.Get(Rec.Status, "No.RelatedOrderCAL_BTC") then begin
                        Validate(DescriptionRelatedOrderCAL_BTC, RelatedOrder.Description);
                        Validate(NoLoteCAL_BTC, RelatedOrder.NoLoteCAL_BTC);
                        opRelacionada := true;
                    end;
                end
                else begin
                    Clear(DescriptionRelatedOrderCAL_BTC);
                    Clear(NoLoteCAL_BTC);
                end;
            end;
        }
        field(65306; DescriptionRelatedOrderCAL_BTC; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
        }
        field(65307; NoLoteCAL_BTC; Code[20])
        {
            Caption = 'Nº Lote';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
        field(65308; PrioridadCAL_BTC; Option)
        {
            Caption = 'Prioridad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            OptionCaption = ' ,A,B,C,D,E';
            OptionMembers = " ",A,B,C,D,E;
        }
    }
}
