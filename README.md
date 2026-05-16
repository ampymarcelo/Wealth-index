# 📊 Calcul de l'Indice de Bien-être Économique par Quintile

## Description

Ce script **Stata** construit un **indice composite de bien-être économique** des ménages à partir de leurs conditions de logement et de leurs biens durables, en utilisant une **Analyse en Composantes Principales (ACP)**. Il classe ensuite les ménages en **5 quintiles de niveau de vie**.

---

## Méthodologie

### 1. Construction des variables de logement

Chaque variable est recodée en **variable binaire (0/1)** selon les critères suivants :

| Variable | Description | Condition pour = 1 (favorable) |
|---|---|---|
| `maison` | Type de logement | Logement en dur (C1 = 1) |
| `Propmaison` | Propriété du logement | Propriétaire (C3 = 1) |
| `Mur` | Matériau des murs | Murs en dur (C4 = 1 ou 2) |
| `Toit` | Matériau du toit | Toit en tôle (C5 = 2) |
| `dallage` | Type de sol | Sol carrelé (C6 = 6) |
| `electricite` | Accès à l'électricité | Raccordé au réseau (C7 = 1) |
| `eau` | Source d'eau potable | Source améliorée (C8 = 1–6, 8) |
| `toilet` | Type de toilettes | Toilettes améliorées (C10 = 1 ou 2) |

> ⚠️ Les valeurs manquantes (`.`) et les codes non applicables (`77`) sont traités comme des valeurs manquantes.

### 2. Biens durables du ménage

Les variables `D1` à `D29` (possession de biens durables) sont recodées :

- `2 → 0` (ne possède pas)
- `1` (possède) — inchangé

### 3. Analyse en Composantes Principales (ACP)

```stata
fac maison toilet eau dallage electricite Toit Mur Propmaison maison D1-D29
```

- La **première composante principale** (`fac1`) est utilisée comme indice de richesse
- Le test **KMO** (`estat kmo`) vérifie l'adéquation des données à l'ACP

### 4. Classement en quintiles

```stata
xtile Niveau_quintile = quintile, nq(5)
```

| Quintile | Label |
|---|---|
| 1 | Plus pauvre |
| 2 | Pauvre |
| 3 | Moyen |
| 4 | Riche |
| 5 | Plus riche |

---

## Variables produites

| Variable | Description |
|---|---|
| `asset_index` | Quintile brut basé sur `fac1` |
| `quintile` | Score continu de la première composante principale |
| `Niveau_quintile` | Quintile de niveau de vie (1 à 5, labellisé) |

---

- **Données d'entrée :** Variables `C1`–`C10` et `D1`–`D29` présentes dans le jeu de données

---


---

## Référence méthodologique

Cette approche s'inspire de la méthode de **Filmer & Pritchett (2001)** qui utilise l'ACP sur les biens du ménage pour construire un proxy de richesse en l'absence de données de revenus ou de consommation.

> Filmer, D., & Pritchett, L. H. (2001). *Estimating wealth effects without expenditure data — or tears.* **Demography**, 38(1), 115–132.

---

## Auteur

**AMPY Davidson** — Calcul de l'indice de bien-être économique de ménage
