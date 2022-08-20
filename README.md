
<!-- README.md is generated from README.Rmd. Please edit that file -->

# schema

<!-- badges: start -->
<!-- badges: end -->

The goal of schema is to provide a basis for prototyping and a schema to
map existing and planned infrastructure for active travel planning.
Eventually, the intention is for this repo to also contain associated
tools and code/documentation to make the schema easy to use for everyone
wanting to map active travel infrastructure in a consistent way that is
friendly for data providers and as useful as possible for people using
the data.

## Introduction

Database schemas define the ‘shape’ that series of datasets can take.
They are often visualised in database diagrams such as the image below.

![](https://user-images.githubusercontent.com/1825120/185740368-56effb61-a3c1-4534-bd49-ad42951f2fd7.png)

Having such a schema offers advantages:

-   Consistency between different users (local authorities, researchers,
    consultancies, other users)
-   Supporting people generating new plans to think about the data they
    may need to collect
-   Future-proofness: an evolving schema with empty fields that may
    become useful encourages datasets to be kept up-to-date

## An example schema

A basic example of a schema for active travel infrastructure is shown
below.

![](https://user-images.githubusercontent.com/1825120/185741429-fabb3183-bcbe-4bd9-8396-dff4a533d55d.png)

In this schema, there are three tables representing neteworks, routes
and ways. The ways represent the individual segments that, in
combination, form routes. In turn, many routes can add-up to represent a
network. Networks could cover an entire city or be small, e.g. to
represent the travel network in a particular neighbourhood.

## Schema versioning

Just like software used to process data, data formats, and the
underlying schemas that define them, should evolve over time. To extend
the schema above we can add more fields such as MinWidth and MaxWidth
and add another table, representing point features on the network. This
updated schema is illustrated below.

![](https://user-images.githubusercontent.com/1825120/185744446-0896f9e8-de0b-43d9-ac9e-21735762017f.png)

In the future the schema could evolve further. Versioning the schema
will ensure backwards compatibility and encourage innovation.

## Existing active travel infrastructure schemas

### TfL’s Cycling Infrastructure Database (CID)

The CID’s data has a rather verbose schema in which many attributes such
as cycleway type are converted into a series of boolean (TRUE/FALSE)
expressions. Converted into a dataset in the Arrow format, the column
names and associated data types, example values, asset types and labels
are as follows, for the cycleway table:

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
Track (covering columns 3 to 5 in the above table).

### Ordnance Survey Schemas

### OSM’s unstructured approach

### The OpenInfra project
