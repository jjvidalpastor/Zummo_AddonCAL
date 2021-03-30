pageextension 65103 "PagExtItemCard_CAL_btc" extends "Item Card"
{
    layout
    {
        addafter(InventoryGrp)
        {
            group(Calidad_)
            {
                Caption = 'Quality', comment = 'ESP="Calidad"';

                group(Calidad)
                {
                    Caption = 'Quality', comment = 'ESP="Calidad"';

                    field(ActivarGestionCalidadCAL_BTC; ActivarGestionCalidadCAL_BTC)
                    {
                        ApplicationArea = All;
                        Caption = 'Subject to quality management', comment = 'ESP="Sujeto a gestión de calidad"';
                        ToolTip = 'Indicates that the item is subject to quality control', comment = 'ESP="Indica que el producto está sometido a control de calidad"';
                        Visible = true;
                    }
                    field(ControlVisuObligatorioCAL_BTC; ControlVisuObligatorioCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(CodPlantillaRecepCAL_BTC; CodPlantillaRecepCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(CodPlantillaAlmacenCAL_BTC; CodPlantillaAlmacenCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(CodPlantillaFabricacCAL_BTC; CodPlantillaFabricacCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(CodPlantillaEnvioCAL_BTC; CodPlantillaEnvioCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(CodPlantillaDevoCAL_BTC; CodPlantillaDevoCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(CalidadConcertadaCAL_BTC; CalidadConcertadaCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(CertificCalidadConcertCAL_BTC; CertificCalidadConcertCAL_BTC)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
            }
        }
    }
    actions
    {
    }
}
