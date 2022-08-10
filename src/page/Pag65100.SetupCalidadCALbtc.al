page 65100 "Setup Calidad_CAL_btc"
{
    Caption = 'Quality Setup', comment = 'ESP="Configuración de calidad"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Setup Calidad_CAL_btc";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Activar gestión de la calidad"; "Activar gestión de la calidad")
                {
                    ApplicationArea = All;
                }
                field("Activar doble confirmacion"; "Activar doble confirmacion")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar triple confirmacion LM"; "Activar triple confirmacion LM")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(AlmacenInpeccion; AlmacenInpeccion) //BTC FSD 03.02.2020 Creo este campo, aunque ya hay uno para
                                                          //Para hacer transferencia al almacen no conformidad que nos indiquen.
                {
                    ApplicationArea = All;
                }
                field("Cód. almacén no conformes"; "Cód. almacén no conformes")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; "Journal Template Name") //BTC FSD 04.02.2020 Creo este campo, para no hardcodear el diario.
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; "Journal Batch Name") //BTC FSD 04.02.2020 Creo este campo, para no hardcodear el diario.
                {
                    ApplicationArea = All;
                }
                field("Journal Template No conforme"; "Journal Template No conforme")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch No conforme"; "Journal Batch No conforme")
                {
                    ApplicationArea = all;
                }
            }
            group(Plantillas)
            {
                Visible = false;

                field("Cód. plantilla recepción pred"; "Cód. plantilla recepción pred")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla almacén pred"; "Cód. plantilla almacén pred")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla fabricación pre"; "Cód. plantilla fabricación pre")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla envio predeter"; "Cód. plantilla envio predeter")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla devolución pred"; "Cód. plantilla devolución pred")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla procesos pred"; "Cód. plantilla procesos pred")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla evaluación pred"; "Cód. plantilla evaluación pred")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla reclamación pre"; "Cód. plantilla reclamación pre")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla muestras predet"; "Cód. plantilla muestras predet")
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla mat. graph pred"; "Cód. plantilla mat. graph pred")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering', Comment = 'ESP="Nº Series"';

                field("No. serie insp. recepcion"; "No. serie insp. recepcion")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. fabricación"; "No. serie insp. fabricación")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. envío"; "No. serie insp. envío")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. procesos"; "No. serie insp. procesos")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. almacén"; "No. serie insp. almacén")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. devolución"; "No. serie insp. devolución")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. evaluación"; "No. serie insp. evaluación")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. reclamación"; "No. serie insp. reclamación")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. muestras"; "No. serie insp. muestras")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie insp. mat. graph"; "No. serie insp. mat. graph")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. serie Cab. Inspección"; "No. serie Cab. Inspección")
                {
                    ApplicationArea = All;
                }
                field("No. serie no conformidades"; "No. serie no conformidades")
                {
                    ApplicationArea = All;
                }
            }
            group(Almacenes)
            {
                Visible = false;

                field("Cód. almacén inspeccion cal."; "Cód. almacén inspeccion cal.")
                {
                    ApplicationArea = All;
                }
                field("Cód. almacén cuarentena cal."; "Cód. almacén cuarentena cal.")
                {
                    ApplicationArea = All;
                }
                // field("Cód. almacén no conformes"; "Cód. almacén no conformes")
                // {
                //     ApplicationArea = All;
                // }
                field("Cód. almacén devolución a prov"; "Cód. almacén devolución a prov")
                {
                    ApplicationArea = All;
                }
                field("Cód. almacén prod. a reclasifi"; "Cód. almacén prod. a reclasifi")
                {
                    ApplicationArea = All;
                }
                field("Cód. almacén prod. a reproces."; "Cód. almacén prod. a reproces.")
                {
                    ApplicationArea = All;
                }
                field("Cód. almacén prod. a reciclar"; "Cód. almacén prod. a reciclar")
                {
                    ApplicationArea = All;
                }
                field("Cód. almacén prod. a rechazar"; "Cód. almacén prod. a rechazar")
                {
                    ApplicationArea = All;
                }
            }
            group("Doble confirmación")
            {
                Visible = false;

                field("Receptores DC Calidad"; "Receptores DC Calidad")
                {
                    ApplicationArea = All;
                }
                field("Receptores DC Fabricacion"; "Receptores DC Fabricacion")
                {
                    ApplicationArea = All;
                }
                field("Receptores DC Formulacion"; "Receptores DC Formulacion")
                {
                    ApplicationArea = All;
                }
                field("Receptores DC Control Visual R"; "Receptores DC Control Visual R")
                {
                    ApplicationArea = All;
                }
                field("Receptores DC Control Visual F"; "Receptores DC Control Visual F")
                {
                    ApplicationArea = All;
                }
                field("Receptores DC Mat.Graph"; "Receptores DC Mat.Graph")
                {
                    ApplicationArea = All;
                }
            }
            group(Avisos)
            {
                field("Activar aviso apertura inspecc"; "Activar aviso apertura inspecc")
                {
                    ApplicationArea = All;
                }
                field("Activar aviso apert insp graph"; "Activar aviso apert insp graph")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar aviso recepcion produc"; "Activar aviso recepcion produc")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar aviso fabricacion prod"; "Activar aviso fabricacion prod")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar aviso recepcion graph"; "Activar aviso recepcion graph")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar aviso cert. insp. rec."; "Activar aviso cert. insp. rec.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar aviso cert. insp. fab."; "Activar aviso cert. insp. fab.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar aviso cert. insp. grap"; "Activar aviso cert. insp. grap")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Activar aviso apertura noconf"; "Activar aviso apertura noconf")
                {
                    ApplicationArea = All;
                }
                field("Activar aviso mensajes emisor"; "Activar aviso mensajes emisor")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Apertura Inspeccion"; "Receptores Apertura Inspeccion")
                {
                    ApplicationArea = All;
                }
                field("Receptores Apertura Insp Graph"; "Receptores Apertura Insp Graph")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Recepcion Producto"; "Receptores Recepcion Producto")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Fabricacion Produc"; "Receptores Fabricacion Produc")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Recep Mat.Graph"; "Receptores Recep Mat.Graph")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Cert. Insp. Recep."; "Receptores Cert. Insp. Recep.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Cert. Insp. Fabrica"; "Receptores Cert. Insp. Fabrica")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Cert. Insp. Mat.Gra"; "Receptores Cert. Insp. Mat.Gra")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Receptores Apertura No Confor"; "Receptores Apertura No Confor")
                {
                    ApplicationArea = All;
                }
            }
            group(Varios)
            {
                Visible = false;

                field("Item Category Code Graph"; "Item Category Code Graph")
                {
                    ApplicationArea = All;
                }
                field("Almacén depósito para muestras"; "Almacén depósito para muestras")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}
