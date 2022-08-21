
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

<!-- ![](https://user-images.githubusercontent.com/1825120/185740368-56effb61-a3c1-4534-bd49-ad42951f2fd7.png) -->

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

<!-- ![](https://user-images.githubusercontent.com/1825120/185741429-fabb3183-bcbe-4bd9-8396-dff4a533d55d.png) -->

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

The CID contains detailed data on London’s cycle infrastructure, divided
into the following tables (see the
[example_data](https://github.com/acteng/schema/tree/main/example_data)
folder for examples):

| Table              | Geometry |
|:-------------------|:---------|
| Advanced Stop Line | Line     |
| Crossing           | Line     |
| Cycle lane/track   | Line     |
| Restricted Route   | Line     |
| Cycle Parking      | Point    |
| Restricted Point   | Point    |
| Signage            | Point    |
| Signal             | Point    |
| Traffic Calming    | Point    |

The CID’s data has a rather verbose schema in which many attributes such
as cycleway type are converted into a series of boolean (TRUE/FALSE)
expressions. Converted into a dataset in the Arrow format, the column
names and associated data types, example values, asset types and labels
are as follows, for the Cycle lane/track table, for example:

    #>  [1]  1  2  3  4  5  6  7  8  9 10
    #>  [1] 10  9  8  7  6  5  4  3  2  1

In a future schema, many of the variables in the schema above could be
replaced by a well-defined ‘type’ column that accepts values including
On Road Advisory Cycle Lane, Dedicated Cycle Track and Stepped Cycle
Track (covering columns 3 to 5 in the above table). See the repo
<https://github.com/PublicHealthDataGeek/CycleInfraLnd/> and associated
paper (Tait et al.,
[2022](https://www.sciencedirect.com/science/article/pii/S221414052200041X))
for further details on the CID.

### Ordnance Survey Schemas

### OSM’s unstructured approach

### The OpenInfra project
