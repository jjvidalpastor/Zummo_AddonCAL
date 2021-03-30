tableextension 65113 "TabExtItem_CAL_btc" extends Item
{
    fields
    {
        field(65100; ActivarGestionCalidadCAL_BTC; Boolean)
        {
            Caption = 'Activar gestion de la calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';

            trigger OnValidate()
            begin
                if ActivarGestionCalidadCAL_BTC = true then
                    Validate(ControlVisuObligatorioCAL_BTC, true)
                else
                    Validate(ControlVisuObligatorioCAL_BTC, false);
            end;
        }
        field(65101; CodPlantillaRecepCAL_BTC; Code[20])
        {
            Caption = 'Cod. plantilla recepcion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            /*
                    TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = FILTER ("Recepción" | "Mat.Gráfico"),
                                                                          Estado = CONST (Certificada));
                    */
            //TODO: Revisar relación plantilla envaluación Producto-(Recepción, Mat. Gráfico)
        }
        field(65102; CodPlantillaAlmacenCAL_BTC; Code[20])
        {
            Caption = 'Cod. plantilla almacen';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            /*
                    TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Almacén"),
                                                                          Estado = CONST (Certificada));
                    */
            //TODO: Revisar relación plantilla envaluación Producto-Almacén
        }
        field(65103; CodPlantillaFabricacCAL_BTC; Code[20])
        {
            Caption = 'Cod. plantilla fabricacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            /*
                    TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Fabricación"),
                                                                          Estado = CONST (Certificada));
                    */
            //TODO: Revisar relación plantilla envaluación Producto-Fabricación
        }
        field(65104; CodPlantillaEnvioCAL_BTC; Code[20])
        {
            Caption = 'Cod. plantilla envio';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            /*
                    TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Envío"),
                                                                          Estado = CONST (Certificada));
                    */
            //TODO: Revisar relación plantilla envaluación Producto-Envío
        }
        field(65105; CodPlantillaDevoCAL_BTC; Code[20])
        {
            Caption = 'Cod. plantilla devolucion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            /*
                    TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Devolución"),
                                                                          Estado = CONST (Certificada));
                    */
            //TODO: Revisar relación plantilla envaluación Producto-Devolución
        }
        field(65106; CalidadConcertadaCAL_BTC; Boolean)
        {
            Caption = 'Calidad concertada';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65107; CertificCalidadConcertCAL_BTC; Code[20])
        {
            Caption = 'Certificado calidad concertada';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65108; ControlVisuObligatorioCAL_BTC; Boolean)
        {
            Caption = 'Control visual obligatorio';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65200; AlmacenProdCAL_BTC; Code[10])
        {
            Caption = 'Production Warehouse';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            TableRelation = Location;
        }
        field(65210; AlmacenPreferCAL_BTC; Code[10])
        {
            Caption = 'Preferred Warehouse';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            TableRelation = Location;
        }
        field(65220; UbicacionPreferenteCAL_BTC; Code[20])
        {
            Caption = 'Preferred Location';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
    }
}
