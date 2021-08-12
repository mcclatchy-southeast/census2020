# Preparing for Census 2020
![Tract-level map of population changes between 2010 and 2020, according to census data released Aug. 12, 2021.](https://github.com/mcclatchy-southeast/census2020/blob/main/images/nc_tract_change.png)
On Aug. 12, the U.S. Census Bureau will release the [2020 redistricting data summary (P.L. 94-171)](https://www.census.gov/programs-surveys/decennial-census/about/rdo/summary-files.html), its nationwide file created for use by state legislatures in their decennial redraw of congressional and legislative lines.

Accept where noted below, the following information is specific to data for North Carolina.

*NOTE: The data below is preliminary and for planning purposes.*

## Data files

For more details on the data and related methodology, [check out the readme file](https://github.com/mcclatchy-southeast/census2020/tree/main/data).

[**NC block assignment file, with weights**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_baf_2010_2010_weighted.csv) Used to remap 2010 population counts to the redrawn 2020 block for aggregation up to the tract level. Weights are calculated using the intersection of each 2010 block with the 2020 block divided by the total area of the 2010 block ( `AREALAND_INT` / `AREALAND_2010` ) for all 2010 blocks split into parts ( `BLOCK_PART_FLAG_O == 'p'` ). *NOTE: NHGIS on Aug. 9 [published identical figures](https://www.nhgis.org/nhgis-news#crosswalks-2021-08a) used to translate 2010 blocks to 2020 blocks here (free with signup).*

[**2010 race and ethnicity, weighted to 2020 blocks**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_blocks_2010_rc_eth_weighted.csv) Select columns from 2010 population counts of race and ethnicity, remapped to 2020 block shapes using land area weights from the block assignment file. Used for aggregation up to large geographies. *NOTE: The U.S. Census Bureau advises that [due to noise in the block-level values](https://www.census.gov/newsroom/blogs/director/2021/07/redistricting-data.html), data should be aggregated to higher levels, like block groups or tracts.*

[**2010 race and ethnicity, weighted/aggregated to 2020 tracts**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_tracts_2010_rc_eth_weighted.csv) Select columns from 2010 population counts of race and ethnicity, remapped to 2020 block shapes using land area weights from the block assignment file and aggregated up to 2020 tracts.

[**2010 race and ethnicity, by county**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_county_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the county summary level. *NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file.*

[**2010 race and ethnicity, by place**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_places_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the place summary level. *NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file.*

**2010 diversity index, weighted/aggregated to 2020 tracts** *COMING SOON*

**2010 diversity index, by county** *COMING SOON*

**2010 diversity index, by place** *COMING SOON*

## Story recipes

The team at Carolina Demography put together [a great (still in-progress) how-to guide](https://www.ncdemography.org/2021/08/11/census-2020-story-recipe-how-to-find-and-explore-census-data/) on using R to work with the 2020 census redistricting data, [including sample scripts](https://github.com/mcclatchy-southeast/census2020/blob/main/scripts/story_recipe_pl94171.R) you can use to get started.

You can also take a look at the [McClatchy team's own R scripts](https://github.com/mcclatchy-southeast/census2020/blob/main/scripts/mcc_sample_scripts.R) for loading in and cleaning up the data.

## Quick reference

### NC population change over time
| Year | Population | % change
|:---|---:|---:|
| 1990 | 6,628,637 | -- |
| 2000 | 8,049,313 | 21.4 |
| 2010 | 9,535,483 | 18.5 |
| 2020 | 10,439,388 | 9.5 |

Resident population according to Census apportionment results from [2020](https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html), [2010](https://www.census.gov/data/tables/2010/dec/2010-apportionment-data.html), [2000](https://www.census.gov/data/tables/2000/dec/2000-apportionment-data.html) and [1990](https://www.census.gov/data/tables/1990/dec/1990-apportionment-data.html).

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
Resources for other newsrooms in McClatchy Southeast.

### South Carolina

- **2010 population:** 4,625,364
- **2020 population:** [5,118,425](https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html)
- **Counties:** 46
- **2010 place count:** 395

[SOURCE](https://www.census.gov/geographies/reference-files/2010/geo/state-local-geo-guides-2010/south-carolina.html)

[**2010 race and ethnicity, by county**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/sc_county_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the county summary level for South Carolina.

[**2010 race and ethnicity, by place**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/sc_place_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the place summary level for South Carolina.

### Mississippi

- **2010 population:** 2,967,297
- **2020 population:** [2,961,279](https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html)
- **Counties:** 82
- **2010 place count:** 362

[SOURCE](https://www.census.gov/geographies/reference-files/2010/geo/state-local-geo-guides-2010/mississippi.html)

[**2010 race and ethnicity, by county**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/ms_county_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the county summary level for Mississippi.

[**2010 race and ethnicity, by place**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/ms_place_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the place summary level for Mississippi.

### Georgia

- **2010 population:** 9,687,653
- **2020 population:** [10,711,908](https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html)
- **Counties:** 159
- **2010 place count:** 624

[SOURCE](https://www.census.gov/geographies/reference-files/2010/geo/state-local-geo-guides-2010/georgia.html)

[**2010 race and ethnicity, by county**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/ga_county_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the county summary level for Georgia.

[**2010 race and ethnicity, by place**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/ga_place_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the place summary level for Georgia.

### Alabama

- **2010 population:** 4,779,736
- **2020 population:** [5,024,279](https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html)
- **Counties:** 67
- **2010 place count:** 578

[SOURCE](https://www.census.gov/geographies/reference-files/2010/geo/state-local-geo-guides-2010/alabama.html)

[**2010 race and ethnicity, by county**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/al_county_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the county summary level for Alabama.

[**2010 race and ethnicity, by place**](https://github.com/mcclatchy-southeast/census2020/blob/main/data/al_place_2010_rc_eth.csv) Select columns from 2010 population counts of race and ethnicity on the place summary level for Alabama.

## Complete coverage

[**2020 Census population data is out. What could it mean for NC’s 14th congressional seat?**](https://www.charlotteobserver.com/news/politics-government/article253419799.html) *Brian Murphy.* Aug. 12, 2021.


[**‘We can’t stop the growth.’ These Triangle cities and towns are booming in NC.**](https://www.newsobserver.com/news/local/article253401580.html) *Anna Johnson and David Raynor.* Aug. 12, 2021.

[**Fast-growing Hispanic population helps drive Charlotte-area growth, new census data show.**](https://www.charlotteobserver.com/news/local/article253421459.html) *Will Wright and Gavin Off.* Aug. 12, 2021.

[**Adjust your scorecard: These are NC’s largest cities, new census count says.**](https://www.charlotteobserver.com/news/local/article253396180.html) *Richard Stradling.* Aug. 12, 2021.

[**How has your NC neighborhood grown since 2010? Use this map of census data to find out.**](https://www.newsobserver.com/news/local/article253375248.html) *Tyler Dukes.* Aug. 12, 2021.

[**Triangle, Charlotte led NC population growth while rural counties shrank, census shows.**](https://www.newsobserver.com/news/local/article253388708.html) *Richard Stradling.* Aug. 12, 2021.

[**NC lawmakers will not use racial and election data from the census to draw district maps.**](https://www.newsobserver.com/news/politics-government/article253434564.html) *Lucille Sherman.* Aug. 12, 2021

[**NC lawmakers move to bar the use of racial, election data in drawing election districts**
](https://www.newsobserver.com/news/politics-government/article253397675.html) *Lucille Sherman.* Aug. 11, 2021.

[**NC will redistrict after census data release. Here’s why you should care.**](https://www.newsobserver.com/news/politics-government/article253320118.html) *Will Doran.* Aug. 11, 2021.

[**New census data will help shape elections, reveal who North Carolina is becoming.**](https://www.newsobserver.com/news/politics-government/article253227433.html) *Will Doran and Richard Stradling.* Aug. 10, 2021.

[**NC adds nearly 1 million residents in a decade to earn a new congressional seat, Census says.**](https://www.newsobserver.com/news/politics-government/article250944864.html) *Brian Murphy and Richard Stradling.* May 14, 2021.

[**For first time, Wake County tops Mecklenburg County in estimated NC population. Gavin Off.**](https://www.newsobserver.com/news/state/north-carolina/article251183669.html) May 5, 2021.

[**Gerrymandering reform advocates cautiously optimistic, despite GOP keeping control in NC.**](https://www.charlotteobserver.com/article246987667.html) *Will Doran.* Nov. 6, 2020.

[**As census wraps up early, NC risks undercounting vulnerable populations, experts say.**](https://www.charlotteobserver.com/news/politics-government/article246452865.html) *Danielle Chemtob.* Oct. 14, 2020.