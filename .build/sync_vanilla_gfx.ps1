# Variantes del mod 3834419159 (Warhammer Fantasy) alineadas con el CK3 base.
# - Retratos: sistema vanilla de CK3 (sin meshes low poly).
# - Unidades: WH Units Redux.
#
# Uso: powershell -NoProfile -ExecutionPolicy Bypass -File .build\sync_vanilla_gfx.ps1

$ErrorActionPreference = "Stop"
$root = "C:\Users\Francisco Aranda\Documents\GitHub\CK-The-Old-World"
$we = Join-Path $root "3834419159"
$dst = $root

Push-Location $dst
try {
    # 1) Etnias vanilla para todas las culturas (regenera common/ethnicities/zz_ckow_vanilla_ethnicities.txt)
    & "powershell" -NoProfile -ExecutionPolicy Bypass -File (Join-Path $dst ".build\gen_ethnicities.ps1")

    # 2) Regalia low poly -> rasgos invisibles sin efecto en el retrato
    $lp = Get-Content (Join-Path $we "common\traits\zz_we_low_poly.txt") -Raw
    $traitNames = [regex]::Matches($lp, '(?m)^([a-z0-9_]+) = \{') | ForEach-Object { $_.Groups[1].Value }

    $out = New-Object System.Collections.Generic.List[string]
    $out.Add("# Rasgos de regalía heredados del sistema low poly. Sin efectos ni retratos:")
    $out.Add("# los retratos usan el sistema vanilla de CK3.")
    $out.Add("")
    foreach ($t in $traitNames) {
        $out.Add("$t = {")
        $out.Add("`tname = trait_$t")
        $out.Add("`tdesc = trait_${t}_desc")
        $out.Add("`ticon = we_species_human.dds")
        $out.Add("`tinheritable = no")
        $out.Add("`tlevel = 0")
        $out.Add("`tfertility = 0")
        $out.Add("`thealth = 0")
        $out.Add("`tdiplomacy = 0")
        $out.Add("`tmartial = 0")
        $out.Add("`tstewardship = 0")
        $out.Add("`tintrigue = 0")
        $out.Add("`tlearning = 0")
        $out.Add("`tai_rationality = 0")
        $out.Add("`tai_energy = 0")
        $out.Add("`tai_boldness = 0")
        $out.Add("`tai_compassion = 0")
        $out.Add("`tai_greed = 0")
        $out.Add("`tai_honor = 0")
        $out.Add("`tai_zeal = 0")
        $out.Add("`tai_sociability = 0")
        $out.Add("`tai_vengefulness = 0")
        $out.Add("}")
        $out.Add("")
    }
    Set-Content -Path (Join-Path $dst "common\traits\zz_we_low_poly.txt") -Value $out -Encoding UTF8
    Write-Host "Regalia sin efecto: $($traitNames.Count) rasgos"

    # 3) Desactivar arte low poly (mantiene los archivos por si se quiere revertir)
    $renames = @(
        @("common\genes\zz_we_racial_genes.txt", "common\genes\zz_we_racial_genes.txt.disabled"),
        @("gfx\portraits\portrait_modifiers\zz_we_racial_appearance.txt", "gfx\portraits\portrait_modifiers\zz_we_racial_appearance.txt.disabled"),
        @("gfx\portraits\accessories\zz_we_low_poly.txt", "gfx\portraits\accessories\zz_we_low_poly.txt.disabled"),
        @("gfx\portraits\accessories\zz_we_low_poly_females.txt", "gfx\portraits\accessories\zz_we_low_poly_females.txt.disabled"),
        @("gfx\models\portraits\we_low_poly", "gfx\models\portraits\we_low_poly.disabled")
    )
    foreach ($r in $renames) {
        $from = Join-Path $dst $r[0]
        if (Test-Path $from) { Rename-Item -Path $from -NewName ((Split-Path $r[1] -Leaf)) ; Write-Host "Desactivado: $($r[0])" }
    }

    # 4) Unidades de WH Units Redux
    $units = "WH Units Redux"
    Copy-Item -Path (Join-Path $root "$units\common\men_at_arms_types\*") -Destination (Join-Path $dst "common\men_at_arms_types") -Force
    Copy-Item -Path (Join-Path $root "$units\gfx\coat_of_arms\*")        -Destination (Join-Path $dst "gfx\coat_of_arms") -Recurse -Force
    Copy-Item -Path (Join-Path $root "$units\gfx\interface\illustrations\*") -Destination (Join-Path $dst "gfx\interface\illustrations") -Recurse -Force
    Copy-Item -Path (Join-Path $root "$units\localization\english\*.yml") -Destination (Join-Path $dst "localization\english") -Force
    Write-Host "Unidades importadas desde WH Units Redux"

    # 5) Comprobaciones
    $bad = @("common/genes", "gfx/portraits", "gfx/models/portraits")
    foreach ($b in $bad) {
        $p = Join-Path $dst $b
        $active = Get-ChildItem $p -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".txt", ".asset") }
        Write-Host "Archivos activos low poly en ${b}: $($active.Count)"
    }
}
finally {
    Pop-Location
}