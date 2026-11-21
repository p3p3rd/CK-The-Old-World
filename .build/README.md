# CKOW - Retratos vanilla de CK3 + unidades de WH Units Redux
#
# Base: mod 3834419159 (Warhammer Fantasy CK3), con:
#   * Retratos vanilla de CK3 (sin meshes ni arte low poly)
#   * Todas las culturas con etnias vanilla (common/ethnicities/zz_ckow_vanilla_ethnicities.txt)
#   * Unidades militares de WH Units Redux (men-at-arms, iconos, ilustraciones, localización)
#
# Scripts (ejecutar desde la raíz del repo):
#   powershell -NoProfile -ExecutionPolicy Bypass -File .build\gen_ethnicities.ps1    # regenera las etnias vanilla
#   powershell -NoProfile -ExecutionPolicy Bypass -File .build\sync_vanilla_gfx.ps1   # desactiva low poly + importa unidades
#
# Los archivos low poly originales se conservan con extensión .disabled para poder revertir.

## Estado

### Retratos (vanilla CK3)
| Elemento | Estado |
| --- | --- |
| `common/genes/zz_we_racial_genes.txt` | desactivado |
| `common/genes/0X_genes_special_accessories_*.txt` | desactivados |
| `gfx/portraits/portrait_modifiers/zz_we_racial_appearance.txt` | desactivado |
| `gfx/portraits/accessories/zz_we_low_poly*.txt` | desactivados |
| `gfx/models/portraits/we_low_poly/` | desactivado |
| `common/ethnicities/zz_we_racial_ethnicities.txt` | sin uso (definiciones de etnias low poly) |
| `common/ethnicities/00_lemur_ethnicities.txt` | desactivado (templates inexistentes) |
| `common/ethnicities/zz_ckow_vanilla_ethnicities.txt` | activo: 264 culturas -> plantillas vanilla |
| `gfx/portraits/portrait_modifiers/zz_we_trait_appearance.txt` | vacío (solo grupo base) |
| `common/traits/zz_we_low_poly.txt` | regalías sin efectos ni genes |

### Unidades (WH Units Redux)
- `common/men_at_arms_types/WH_regiment_types.txt` (46 regimientos)
- `gfx/coat_of_arms/textured_emblems/` (95 emblemas)
- `gfx/interface/illustrations/men_at_arms_small/` (iconos de regimiento)
- `gfx/coat_of_arms/coat_of_arms/` (heráldica de órdenes sagradas y títulos)
- `localization/english/wh_redux_units_l_english.yml`, `wh_redux_holy_orders_l_english.yml`

## Notas
- Las culturas usan ropa, edificios y unidades vanilla de CK3 (ver `clothing_gfx` en `common/culture/cultures`).
- Las pegatinas de personajes de los bookmarks se ven con el sistema de retratos vanilla.