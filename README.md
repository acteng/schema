
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

    #> Simple feature collection with 3 features and 22 fields
    #> Geometry type: MULTILINESTRING
    #> Dimension:     XY
    #> Bounding box:  xmin: -0.1049912 ymin: 51.51207 xmax: -0.1021697 ymax: 51.51534
    #> Geodetic CRS:  WGS 84
    #> # A tibble: 3 × 23
    #>   FEATURE_ID SVDATE     CLT_CARR CLT_S…¹ CLT_S…² CLT_P…³ CLT_S…⁴ CLT_M…⁵ CLT_A…⁶
    #>   <chr>      <date>     <chr>    <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
    #> 1 RWG066500  2017-07-01 TRUE     TRUE    FALSE   FALSE   FALSE   FALSE   FALSE  
    #> 2 RWG066522  2017-07-03 TRUE     TRUE    FALSE   FALSE   FALSE   FALSE   FALSE  
    #> 3 RWG066722  2017-09-06 TRUE     FALSE   FALSE   FALSE   FALSE   FALSE   FALSE  
    #> # … with 14 more variables: CLT_PRIORI <chr>, CLT_CONTRA <chr>,
    #> #   CLT_BIDIRE <chr>, CLT_CBYPAS <chr>, CLT_BBYPAS <chr>, CLT_PARKR <chr>,
    #> #   CLT_WATERR <chr>, CLT_PTIME <chr>, CLT_ACCESS <chr>, CLT_COLOUR <chr>,
    #> #   BOROUGH <chr>, PHOTO1_URL <chr>, PHOTO2_URL <chr>,
    #> #   geometry <MULTILINESTRING [°]>, and abbreviated variable names ¹​CLT_SEGREG,
    #> #   ²​CLT_STEPP, ³​CLT_PARSEG, ⁴​CLT_SHARED, ⁵​CLT_MANDAT, ⁶​CLT_ADVIS

### Ordnance Survey Schemas

### OSM’s unstructured approach

### The OpenInfra project
