
# CID data types

Converted into a dataset in the Arrow format, the column names and
associated data types, example values, asset types and labels are as
follows, for the Cycle lane/track table, for example:

| Name       | Type    | Example                                                    | assettype        | label                                                  | description                                                                                                    |
|:-----------|:--------|:-----------------------------------------------------------|:-----------------|:-------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------|
| FEATURE_ID | Utf8    | RWG066500                                                  | NA               | Feature ID                                             | Unique ID for asset                                                                                            |
| SVDATE     | Date32  | 17348                                                      | NA               | Survey Date                                            | Date asset was surveyed                                                                                        |
| CLT_CARR   | Boolean | TRUE                                                       | Cycle Lane/Track | On-Carriageway (if true) or Off-Carriageway (if false) | True = On-carriageway False = Off-carriageway                                                                  |
| CLT_SEGREG | Boolean | TRUE                                                       | Cycle Lane/Track | Segregated Lane/Track                                  | True = Fully segregated lane (i.e. On carriageway) / track (i.e. Off carriageway) False = Not fully segregated |
| CLT_STEPP  | Boolean | FALSE                                                      | Cycle Lane/Track | Stepped Lane/Track                                     | True = Stepped lane/track False = Not a stepped lane/track                                                     |
| CLT_PARSEG | Boolean | FALSE                                                      | Cycle Lane/Track | Partially Segregated Lane/Track                        | True = Partially or light segregated lane/track False = Not a partially or light segregated lane/track         |
| CLT_SHARED | Boolean | FALSE                                                      | Cycle Lane/Track | Shared Lane or Footway                                 | True = Shared lane (eg bus lane) False = Shared footway or track                                               |
| CLT_MANDAT | Boolean | FALSE                                                      | Cycle Lane/Track | Mandatory Cycle Lane                                   | True = Mandatory lane False = Not a mandatory lane                                                             |
| CLT_ADVIS  | Boolean | FALSE                                                      | Cycle Lane/Track | Advisory Cycle Lane                                    | True = Advisory lane False = Not an advisory lane                                                              |
| CLT_PRIORI | Boolean | FALSE                                                      | Cycle Lane/Track | Cycle Lane/Track Priority                              | True = Cycles have priority, other traffic has to give way False = Cycles do not have priority                 |
| CLT_CONTRA | Boolean | TRUE                                                       | Cycle Lane/Track | Contraflow Lane/Track                                  | True = Contraflow lane/track (NOT if bi-directional) False = With flow                                         |
| CLT_BIDIRE | Boolean | FALSE                                                      | Cycle Lane/Track | Bi-directional                                         | True = Two way flow on lane/track/path False = Single direction lane/track/path                                |
| CLT_CBYPAS | Boolean | FALSE                                                      | Cycle Lane/Track | Cycle Bypass                                           | True = Bypass allowing turn without stopping at traffic signals False = Not a cycle bypass                     |
| CLT_BBYPAS | Boolean | FALSE                                                      | Cycle Lane/Track | Continuous Cycle Facilities at Bus Stop                | True = Cycle track carries on through the bus stop area False = Not a continious cycle facility                |
| CLT_PARKR  | Boolean | FALSE                                                      | Cycle Lane/Track | Park Route                                             | True = Road/lane/track through park False = Not a park route                                                   |
| CLT_WATERR | Boolean | FALSE                                                      | Cycle Lane/Track | Waterside Route                                        | True = Route beside river, canal or other watercourse False = Not a waterside route                            |
| CLT_PTIME  | Boolean | FALSE                                                      | Cycle Lane/Track | Part-time (if true) or Full-time (if false)            | True = Part-time False = Full-time                                                                             |
| CLT_ACCESS | Utf8    | NA                                                         | Cycle Lane/Track | Access Times                                           | Times route is accessible (either exact times or description)                                                  |
| CLT_COLOUR | Utf8    | NONE                                                       | Cycle Lane/Track | Colour                                                 | Colour of lane/track - Limited to only the following entries: None, Green, Red, Blue, Buff/Yellow, Other       |
| BOROUGH    | Utf8    | City of London                                             | NA               | Borough                                                | Borough in which asset is located                                                                              |
| PHOTO1_URL | Utf8    | <https://cycleassetimages.data.tfl.gov.uk/RWG066500_1.jpg> | NA               | Photo1 URL                                             | Asset photo 1                                                                                                  |
| PHOTO2_URL | Utf8    | <https://cycleassetimages.data.tfl.gov.uk/RWG066500_2.jpg> | NA               | Photo2 URL                                             | Asset photo 2                                                                                                  |

In a future schema, many of the variables in the schema above could be
replaced by a well-defined ‘type’ column that accepts values including
On Road Advisory Cycle Lane, Dedicated Cycle Track and Stepped Cycle
Track (covering columns 3 to 5 in the above table). See the repo
<https://github.com/PublicHealthDataGeek/CycleInfraLnd/> and associated
paper (Tait et al.,
[2022](https://www.sciencedirect.com/science/article/pii/S221414052200041X))
for further details on the CID.
