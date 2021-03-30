page 65128 "Calidad Role Center"
{
    PageType = RoleCenter;
    Caption = 'Calidad Role Center', Comment = 'ESP="PERFIL ADDON CALIDAD"';

    layout
    {
        area(RoleCenter)
        {
            group(Actividades)
            {
                part(Part1; InspeccionCue)
                {
                    ApplicationArea = All;
                }
            }
            group("NoConformidad")
            {
                part(Part2; NoConformidadCue)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
