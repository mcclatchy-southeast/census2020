# Preparing for Census 2020
On Aug. 12, the U.S. Census Bureau will release the [2020 redistricting data summary (P.L. 94-171)](https://www.census.gov/programs-surveys/decennial-census/about/rdo/summary-files.html), its nationwide file created for use by state legislatures to in their decennial redraw of congressional and legislative lines.

Accept where noted below, the following information is specific to data for North Carolina.

*NOTE: The data below is preliminary and for planning purposes.*

## Data files

For more details on the data and related methodology, [check out the readme file](https://github.com/mcclatchy-southeast/census2020/tree/main/data).

[**NC block assignment file, with weights**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_baf_2010_2010_weighted.csv) Used to remap 2010 population counts to the redrawn 2020 block for aggregation up to the tract level. Weights are calculated using the intersection of each 2010 block with the 2020 block divided by the total area of the 2010 block ( `AREALAND_INT` / `AREALAND_2010` ).

[**2010 race and ethnicity, weighted to 2020 blocks**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_blocks_2010_rc_eth_weighted.csv) Select columns from 2010 population counts of race and ethnicity, remapped to 2020 block shapes using land area weights from the block assignment file. Used for aggregation up to large geographies. *NOTE: The U.S. Census Bureau advises that [due to noise in the block-level values](https://www.census.gov/newsroom/blogs/director/2021/07/redistricting-data.html), data should be aggregated to higher levels, like block groups or tracts.*

[**2010 race and ethnicity, weighted/aggregated to 2020 tracts**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_tracts_2010_rc_eth_weighted.csv) Select columns from 2010 population counts of race and ethnicity, remapped to 2020 block shapes using land area weights from the block assignment file and aggregated up to 2020 tracts.

[**2010 race and ethnicity, by county**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_county_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the county summary level. *NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file.*

[**2010 race and ethnicity, by place**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_places_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the place summary level. *NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file.*

**2010 diversity index, weighted/aggregated to 2020 tracts** *COMING SOON*

**2010 diversity index, by county** *COMING SOON*

**2010 diversity index, by place** *COMING SOON*

## Quick reference

### NC population change over time
| Year | Population | % change
|:---|---:|---:|
| 1990 | 6,628,637 | -- |
| 2000 | 8,049,313 | 21.4 |
| 2010 | 9,535,483 | 18.5 |
| 2020 | 10,439,388 | 9.5 |

Resident population according to apportionment Census apportionment results from [2020](https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html), [2010](https://www.census.gov/data/tables/2010/dec/2010-apportionment-data.html), [2000](https://www.census.gov/data/tables/2000/dec/2000-apportionment-data.html) and [1990](https://www.census.gov/data/tables/1990/dec/1990-apportionment-data.html).

### Geographic area changes over time
| Geography | 2000 count | 2010 count | 2020 count |
|:--|--:|--:|--:|
| county | 100 | 100 | 100 |
| tracts | 1,563 | 2,195 | 2,672 |
| blocks | 232,403 | 288,987 | 236,638 |

More detail on basic Census geographies, counts and other NC-specific information [here](https://www.census.gov/geographies/reference-files/2010/geo/state-local-geo-guides-2010/north-carolina.html) and [here](https://www.census.gov/geographies/reference-files/time-series/geo/tallies.2000.html).

### Frequently used summary levels
| Area type | summary level code |
|:--|:--|
| County | 050 |
| Consolidated city | 170 |
| Place | 160 |
| Census tract | 140 |
| Block | 750 |
| Congressional district | 500 |
| NC Senate district | 610 |
| NC House district | 620 |

### Geographic identifiers
The Census uses [geographic identifiers](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html), or GEOIDs, for each of its geographic shapes.  The position of the number in every ID corresponds to a specific subdivision of a shape (think nesting dolls).

| 37 | 183 | 052404 | 1017 |
|:--|:--|:--|:--|
| State | County | Tract | Block |

### File locations
| File name | File type | Data dictionary |
|:--|:--|:--|
| [2000 redistricting file](https://www2.census.gov/census_2000/datasets/redistricting_file--pl_94-171/) | fixed-width and comma-delimited txt files | [Technical documentation](https://www.census.gov/prod/cen2000/doc/pl-00-1.pdf#page=61) |
| [2010 redistricting file](https://www2.census.gov/census_2010/01-Redistricting_File--PL_94-171/)| fixed-width and comma-delimited txt files | [Technical documentation](https://www2.census.gov/programs-surveys/decennial/rdo/about/2010-census-programs/2010Census_pl94-171_techdoc.pdf#page=40) |
| [2020 redistricting file](https://www2.census.gov/programs-surveys/decennial/2020/data/01-Redistricting_File--PL_94-171/)| pipe-delimted txt files | [Technical documentation](https://www2.census.gov/programs-surveys/decennial/2020/technical-documentation/complete-tech-docs/summary-file/2020Census_PL94_171Redistricting_StatesTechDoc_English.pdf#page=99) |
| [2010/2020 block shapefile](https://www.census.gov/cgi-bin/geo/shapefiles/index.php?year=2020&layergroup=Blocks%20%282020%29)| ESRI shapefile | [Notes](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html) |
| [Block assignment files](https://www.census.gov/geographies/reference-files/time-series/geo/block-assignment-files.html)| pipe-delimited txt files | [File record layout](https://www.census.gov/programs-surveys/geography/technical-documentation/records-layout/2020-census-block-record-layout.html) |
| [2010 Name lookup tables](https://www.census.gov/geographies/reference-files/time-series/geo/name-lookup-tables.2010.html) | pipe-delimited txt files | [File record layout](https://www.census.gov/programs-surveys/geography/technical-documentation/records-layout/nlt-record-layouts.html) |
| [2020 Name lookup tables](https://www.census.gov/geographies/reference-files/time-series/geo/name-lookup-tables.2020.html) | pipe-delimited txt files | [File record layout](https://www.census.gov/programs-surveys/geography/technical-documentation/records-layout/nlt-record-layouts.html) |

## Other states
Resources for other newsrooms in McClatchty Southeast.

**2010 Mississippi race and ethnicity, by county** *COMING SOON*

**2010 Georgia race and ethnicity, by county** *COMING SOON*

**2010 South Carolina race and ethnicity, by county** *COMING SOON*

**2010 Alabama race and ethnicity, by county** *COMING SOON*