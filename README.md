
<!-- README.md is generated from README.Rmd. Please edit that file -->

# schema

<!-- badges: start -->
<!-- badges: end -->

The goal of this repo is to provide a shared, comprehensive and,
eventually, authoritative set of categories and datasets to map existing
and planned infrastructure for active travel planning. Eventually, the
intention is for this repo to also contain associated tools and
code/documentation to make schemas defining active travel datasets
useful for everyone wanting to map active travel infrastructure in a
consistent way that is friendly and as useful as possible for people
using the data.

## Introduction

Database schemas define the fields contained within datasets and the
values that are allowed. They are often visualised in [database
diagrams](https://learn.microsoft.com/en-us/sql/ssms/visual-db-tools/design-database-diagrams-visual-database-tools?view=sql-server-ver16).

<!-- ![](https://user-images.githubusercontent.com/1825120/185740368-56effb61-a3c1-4534-bd49-ad42951f2fd7.png) -->

Advantages of well-designed and used schemas include:

- Consistency between different users (local authorities, researchers,
  consultancies, other users)
- Supporting people generating new plans to think about the data they
  may need to collect
- Future-proofness: an evolving schema with empty fields that may become
  useful encourages datasets to be kept up-to-date

<!-- ## An example schema -->
<!-- A basic example of a schema for active travel infrastructure is shown below. -->
<!-- ![](https://user-images.githubusercontent.com/1825120/185741429-fabb3183-bcbe-4bd9-8396-dff4a533d55d.png) -->
<!-- In this schema, there are three tables representing neteworks, routes and ways. -->
<!-- The ways represent the individual segments that, in combination, form routes. -->
<!-- In turn, many routes can add-up to represent a network. -->
<!-- Networks could cover an entire city or be small, e.g. to represent the travel network in a particular neighbourhood. -->
<!-- ## Schema versioning -->

Just like software used to process data, data formats, and the
underlying schemas that define them, should evolve over time.
<!-- To extend the schema above we can add more fields such as MinWidth and MaxWidth and add another table, representing point features on the network. -->
<!-- This updated schema is illustrated below. -->

<!-- ![](https://user-images.githubusercontent.com/1825120/185744446-0896f9e8-de0b-43d9-ac9e-21735762017f.png) -->
<!-- In the future the schema could evolve further. -->

Versioning the schema will ensure backwards compatibility and encourage
innovation.

## Existing active travel infrastructure schemas

### TfL’s Cycling Infrastructure Database (CID)

The CID contains detailed data on London’s cycle infrastructure, divided
into the following tables (see the
[example_data](https://github.com/acteng/schema/tree/main/example_data)
folder for examples):

| Table              | Geometry |   Rows | Columns | Names                                                                                                                                                                                                                                                                                                                                                                                   |
|:-------------------|:---------|-------:|--------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Advanced Stop Line | Line     |   3775 |      12 | FEATURE_ID, SVDATE, ASL_FDR, ASL_FDRLFT, ASL_FDCENT, ASL_FDRIGH, ASL_SHARED, ASL_COLOUR, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                                                                                                                                                      |
| Crossing           | Line     |   1687 |      11 | FEATURE_ID, SVDATE, CRS_SIGNAL, CRS_SEGREG, CRS_CYGAP, CRS_PEDEST, CRS_LEVEL, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                                                                                                                                                                 |
| Cycle lane/track   | Line     |  24976 |      23 | FEATURE_ID, SVDATE, CLT_CARR, CLT_SEGREG, CLT_STEPP, CLT_PARSEG, CLT_SHARED, CLT_MANDAT, CLT_ADVIS, CLT_PRIORI, CLT_CONTRA, CLT_BIDIRE, CLT_CBYPAS, CLT_BBYPAS, CLT_PARKR, CLT_WATERR, CLT_PTIME, CLT_ACCESS, CLT_COLOUR, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                     |
| Restricted Route   | Line     |   1378 |      11 | FEATURE_ID, SVDATE, RES_PEDEST, RES_BRIDGE, RES_TUNNEL, RES_STEPS, RES_LIFT, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                                                                                                                                                                  |
| Cycle Parking      | Point    |  23758 |      22 | FEATURE_ID, SVDATE, PRK_CARR, PRK_COVER, PRK_SECURE, PRK_LOCKER, PRK_SHEFF, PRK_MSTAND, PRK_PSTAND, PRK_HOOP, PRK_POST, PRK_BUTERF, PRK_WHEEL, PRK_HANGAR, PRK_TIER, PRK_OTHER, PRK_PROVIS, PRK_CPT, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                                          |
| Restricted Point   | Point    |  23758 |      22 | FEATURE_ID, SVDATE, PRK_CARR, PRK_COVER, PRK_SECURE, PRK_LOCKER, PRK_SHEFF, PRK_MSTAND, PRK_PSTAND, PRK_HOOP, PRK_POST, PRK_BUTERF, PRK_WHEEL, PRK_HANGAR, PRK_TIER, PRK_OTHER, PRK_PROVIS, PRK_CPT, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                                          |
| Signage            | Point    | 118834 |      37 | FEATURE_ID, SVDATE, SS_ROAD, SS_PATCH, SS_FACING, SS_NOCYC, SS_NOVEH, SS_CIRC, SS_EXEMPT, SS_NOLEFT, SS_NORIGH, SS_LEFT, SS_RIGHT, SS_NOEXCE, SS_DISMOU, SS_END, SS_CYCSMB, SS_PEDSMB, SS_BUSSMB, SS_SMB, SS_LNSIGN, SS_ARROW, SS_NRCOL, SS_NCN, SS_LCN, SS_SUPERH, SS_QUIETW, SS_GREENW, SS_ROUTEN, SS_DESTN, SS_ACCESS, SS_NAME, SS_COLOUR, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry |
| Signal             | Point    |    443 |      11 | FEATURE_ID, SVDATE, SIG_HEAD, SIG_SEPARA, SIG_EARLY, SIG_TWOSTG, SIG_GATE, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                                                                                                                                                                    |
| Traffic Calming    | Point    |  58565 |      14 | FEATURE_ID, SVDATE, TRF_RAISED, TRF_ENTRY, TRF_CUSHI, TRF_HUMP, TRF_SINUSO, TRF_BARIER, TRF_NAROW, TRF_CALM, BOROUGH, PHOTO1_URL, PHOTO2_URL, geometry                                                                                                                                                                                                                                  |

The CID’s data has a rather verbose schema in which many attributes such
as cycleway type are converted into a series of boolean (TRUE/FALSE)
expressions. Converted into a dataset in the Arrow format, the column
names and associated data types, example values, asset types and labels
are as follows, for the Cycle lane/track table, for example:

Many of the columns in the schema outlined above have been replaced in
schemas in this repo by ‘type’ keys that accept values including
Advisory lane, Full separation and Stepped separation for motor traffic.
See the [cid](cid.md) example, [TfL’s schema
document](https://cycling.data.tfl.gov.uk/CyclingInfrastructure/documentation/cid_database_schema.xlsx),
the repo <https://github.com/PublicHealthDataGeek/CycleInfraLnd/> and
associated paper (Tait et al.,
[2022](https://www.sciencedirect.com/science/article/pii/S221414052200041X))
for further details on the CID.

### Ordnance Survey Schemas

TBC.

### OSM

TBC.

### The OpenInfra project

TBC.
