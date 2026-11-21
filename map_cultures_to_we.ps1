# Mapeo de culturas wh_culture_X (antes lemur) a culturas we_* funcionales de 3834419159
# y reemplazo de todas las referencias en el mod principal

$ErrorActionPreference = "Continue"

# Mapeo: numero de cultura -> ID we_* equivalente
$cultureMap = @{
    1  = 'we_amazon_culture';        # Maui
    2  = 'we_medean_arabyan';        # Estalian
    3  = 'we_medean_arabyan';        # Tilean
    4  = 'we_albionise';             # Bretonnian (no hay bretón exacto)
    5  = 'we_colonial_asur';         # Elven (Altos Elfos) - verificar que existe
    6  = 'we_norse_dwarf';           # Norscan
    7  = 'we_albionise';             # Albion
    8  = 'we_imperial_cathayan';     # Imperial (usar humano más cercano)
    9  = 'we_gospodar';              # Kislevite
    10 = 'we_darklands_hobgoblin';   # Borderlands
    11 = 'we_colonial_asur';         # Ulthuan (Altos Elfos)
    12 = 'we_darklands_hobgoblin';   # Hobgoblin
    13 = 'we_central_cathayan';      # Cathay
    14 = 'we_north_nipponese_c';     # Nippon
    15 = 'we_east_indish_c';         # Ind
    16 = 'we_khureshi_snakefolk';    # Khuresh
    17 = 'we_medean_arabyan';        # Araby
    18 = 'we_nehekharan_culture';    # Nehekhara
    19 = 'we_naggaroth_beastmen';    # Naggaroth
    20 = 'we_lustrian_lizardmen';    # Lizardmen
    21 = 'we_forest_goblin';         # Greenskin
    22 = 'we_chaos_dwarf';           # Chaos-Dwarven
    23 = 'we_common_dwarf';          # Dwarven
    24 = 'we_lahmian';               # Vampire
    25 = 'we_ogre_main';             # Ogre
    26 = 'we_troll';                 # Troll (usar ogre como fallback)
    27 = 'we_sartosan';              # Sartossan
    28 = 'we_amazon_lizardmen';      # Skegak (Skinks)
    29 = 'we_common_goblin';         # Gnoblar
    30 = 'we_amazon_culture';        # Sheora (Amazonas)
    31 = 'we_common_skaven';         # Skaven
    32 = 'we_amazon_culture';        # Southlandic
    33 = 'we_chaos_dwarf';           # Chaos
}

$modRoot = "."
$filesToProcess = @(
    "common/bookmarks/bookmarks/00_bookmarks.txt",
    "common/bookmarks/bookmarks/OgBookma.txt",
    "history/characters/00_lemur_characters.txt",
    "history/characters/00_name_lists.txt",
    "common/culture/name_lists/00_name_lists.txt"
) + (Get-ChildItem -Path "history/provinces" -Recurse -File | ForEach-Object { $_.FullName })

$totalReplacements = 0
foreach ($file in $filesToProcess) {
    if (-not (Test-Path $file)) { continue }
    $content = Get-Content $file -Raw -Encoding UTF8
    $original = $content
    $fileReplacements = 0

    foreach ($num in $cultureMap.Keys) {
        $oldId = "wh_culture_$num"
        $newId = $cultureMap[$num]
        # Contar cuántas se reemplazan
        $before = $content
        $content = $content -replace [regex]::Escape($oldId), $newId
        if ($content -ne $before) {
            $count = ($before.Split($oldId).Count - 1)
            $fileReplacements += $count
        }
    }

    if ($content -ne $original) {
        Set-Content $file -Value $content -Encoding UTF8
        $totalReplacements += $fileReplacements
        Write-Host "OK: $file ($fileReplacements reemplazos)"
    }
}

Write-Host "`nTotal reemplazos: $totalReplacements"
Write-Host "`n=== MAPEO DE CULTURAS COMPLETADO ==="