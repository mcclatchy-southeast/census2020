

# Data files for the 2020 Census
Right-click on "Download" below to save these files to your desktop in comma-separated value format.

## NC block assignment file, with weights
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_baf_2010_2010_weighted.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_baf_2010_2010_weighted.csv)

Used to remap 2010 population counts to the redrawn 2020 block for aggregation up to the tract level. Weights are calculated using the intersection of each 2010 block with the 2020 block divided by the total area of the 2010 block (  `AREALAND_INT`  /  `AREALAND_2010`  ) for all 2010 blocks split into parts ( `BLOCK_PART_FLAG_O == 'p'` ). *NOTE: NHGIS on Aug. 9 [published identical figures](https://www.nhgis.org/nhgis-news#crosswalks-2021-08a) used to translate 2010 blocks to 2020 blocks here (free with signup).*

## 2010 race and ethnicity, weighted to 2020 blocks
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_blocks_2010_rc_eth_weighted.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_blocks_2010_rc_eth_weighted.csv)

Select columns from 2010 population counts of race and ethnicity, remapped to 2020 block shapes using land area weights from the block assignment file. Used for aggregation up to large geographies.  _NOTE: The U.S. Census Bureau advises that  [due to noise in the block-level values](https://www.census.gov/newsroom/blogs/director/2021/07/redistricting-data.html), data should be aggregated to higher levels, like block groups or tracts._

### Methodology
The U.S. Census Bureau changes both blocks and tracts between each decennial census cycle. That's not an issue for more static geographies like counties and states. But if you want to compare population changes in smaller geographies  – tracts, for example – to the new 2020 figures, you need to do some math.

By redistributing past population totals (2010, 2000, etc.) into the newly drawn 2020 blocks (the smallest geographic unit available) and aggregating up to the geographic unit you want (like tracts), you'll get the most accurate estimate possible of past year populations using comparable geometries.

That said, the numbers don't match exactly for a few reasons, one of which is that fractional weights sometimes give you remainders and "fractions of a person" in a block or tract. But the U.S. Census Bureau also makes tiny adjustments with each release of its new blocks that effectively re-sort portions of a geography (and the people in them) counted in the wrong state or county. [The 2020 block assignment file](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_baf_2010_2010_weighted.csv), in fact, includes 168 *small pieces* of blocks from four bordering states that will be counted in the new 2020 blocks for North Carolina.

| State | FIPS code | Block portion count |
|:--|--:|--:|
| Georgia | 13 | 1 |
| South Carolina | 45 | 94 |
| Tennessee | 47 | 8 |
| Virginia | 51 | 65 |
| **TOTAL** | -- | **168**

The result is that some blocks have derived populations that include fractions. We're leaving these decimals in the block-level and tract-level totals to communicate the uncertainty inherent in these figures.

For simplicity, we'll use the data from the 2010 Census already provided at the county and place summary level, instead of using these remapped blocks to aggregate up.

But here's a look at how those derived totals based on `land_weight` compare on the county level.

*NOTE: On 8/10, these numbers were revised after applying the* `land_weight` *calculation only to blocks with a flag indicating they were split into parts. Only one count, Duplin, was affected by +5 population.*

| FIPS | County | 2010 population | Derived population | Difference | Difference (%) |
|:--|:--|--:|--:|--:|--:|
| 37109 | Lincoln | 78265 | 77912.75 | 352.25 | 0.45 |
| 37023 | Burke | 90912 | 90766.86 | 145.14 | 0.16 |
| 37061 | Duplin | 58505 | 58429.93 | 75.07 | 0.13 |
| 37093 | Hoke | 46952 | 46916.63 | 35.37 | 0.08 |
| 37083 | Halifax | 54691 | 54654.05 | 36.95 | 0.07 |
| 37193 | Wilkes | 69340 | 69290.75 | 49.25 | 0.07 |
| 37141 | Pender | 52217 | 52184.90 | 32.10 | 0.06 |
| 37009 | Ashe | 27281 | 27267.39 | 13.61 | 0.05 |
| 37089 | Henderson | 106740 | 106683.78 | 56.22 | 0.05 |
| 37025 | Cabarrus | 178011 | 177937.89 | 73.11 | 0.04 |
| 37059 | Davie | 41240 | 41225.38 | 14.62 | 0.04 |
| 37135 | Orange | 133801 | 133752.63 | 48.37 | 0.04 |
| 37103 | Jones | 10153 | 10149.50 | 3.50 | 0.03 |
| 37017 | Bladen | 35190 | 35183.00 | 7.00 | 0.02 |
| 37045 | Cleveland | 98078 | 98054.61 | 23.39 | 0.02 |
| 37175 | Transylvania | 33090 | 33083.41 | 6.59 | 0.02 |
| 37183 | Wake | 900993 | 900778.96 | 214.04 | 0.02 |
| 37049 | Craven | 103505 | 103498.28 | 6.72 | 0.01 |
| 37067 | Forsyth | 350670 | 350651.68 | 18.32 | 0.01 |
| 37097 | Iredell | 159437 | 159423.70 | 13.30 | 0.01 |
| 37107 | Lenoir | 59495 | 59487.07 | 7.93 | 0.01 |
| 37161 | Rutherford | 67810 | 67800.30 | 9.70 | 0.01 |
| 37189 | Watauga | 51079 | 51076.33 | 2.67 | 0.01 |
| 37003 | Alexander | 37198 | 37196.17 | 1.83 | 0.00 |
| 37007 | Anson | 26948 | 26946.81 | 1.19 | 0.00 |
| 37013 | Beaufort | 47759 | 47758.93 | 0.07 | 0.00 |
| 37015 | Bertie | 21282 | 21281.99 | 0.01 | 0.00 |
| 37019 | Brunswick | 107431 | 107431.70 | -0.70 | 0.00 |
| 37029 | Camden | 9980 | 9980.00 | 0.00 | 0.00 |
| 37031 | Carteret | 66469 | 66469.04 | -0.04 | 0.00 |
| 37039 | Cherokee | 27444 | 27443.42 | 0.58 | 0.00 |
| 37041 | Chowan | 14793 | 14793.00 | 0.00 | 0.00 |
| 37053 | Currituck | 23547 | 23547.00 | 0.00 | 0.00 |
| 37055 | Dare | 33920 | 33920.00 | 0.00 | 0.00 |
| 37069 | Franklin | 60619 | 60621.01 | -2.01 | 0.00 |
| 37073 | Gates | 12197 | 12197.12 | -0.12 | 0.00 |
| 37075 | Graham | 8861 | 8861.12 | -0.12 | 0.00 |
| 37077 | Granville | 59916 | 59915.96 | 0.04 | 0.00 |
| 37081 | Guilford | 488406 | 488401.39 | 4.61 | 0.00 |
| 37087 | Haywood | 59036 | 59035.24 | 0.76 | 0.00 |
| 37091 | Hertford | 24669 | 24668.28 | 0.72 | 0.00 |
| 37095 | Hyde | 5810 | 5809.92 | 0.08 | 0.00 |
| 37099 | Jackson | 40271 | 40269.58 | 1.42 | 0.00 |
| 37105 | Lee | 57866 | 57865.97 | 0.03 | 0.00 |
| 37113 | Macon | 33922 | 33923.10 | -1.10 | 0.00 |
| 37117 | Martin | 24505 | 24504.33 | 0.67 | 0.00 |
| 37119 | Mecklenburg | 919628 | 919610.73 | 17.27 | 0.00 |
| 37121 | Mitchell | 15579 | 15578.81 | 0.19 | 0.00 |
| 37123 | Montgomery | 27798 | 27797.85 | 0.15 | 0.00 |
| 37125 | Moore | 88247 | 88246.81 | 0.19 | 0.00 |
| 37127 | Nash | 95840 | 95838.96 | 1.04 | 0.00 |
| 37137 | Pamlico | 13144 | 13144.00 | 0.00 | 0.00 |
| 37139 | Pasquotank | 40661 | 40661.00 | 0.00 | 0.00 |
| 37143 | Perquimans | 13453 | 13452.88 | 0.12 | 0.00 |
| 37145 | Person | 39464 | 39464.29 | -0.29 | 0.00 |
| 37151 | Randolph | 141752 | 141757.09 | -5.09 | 0.00 |
| 37153 | Richmond | 46639 | 46639.16 | -0.16 | 0.00 |
| 37155 | Robeson | 134168 | 134161.40 | 6.60 | 0.00 |
| 37157 | Rockingham | 93643 | 93639.67 | 3.33 | 0.00 |
| 37165 | Scotland | 36157 | 36157.00 | 0.00 | 0.00 |
| 37167 | Stanly | 60585 | 60585.00 | 0.00 | 0.00 |
| 37173 | Swain | 13981 | 13980.77 | 0.23 | 0.00 |
| 37177 | Tyrrell | 4407 | 4407.00 | 0.00 | 0.00 |
| 37181 | Vance | 45422 | 45422.17 | -0.17 | 0.00 |
| 37187 | Washington | 13228 | 13228.00 | 0.00 | 0.00 |
| 37195 | Wilson | 81234 | 81233.61 | 0.39 | 0.00 |
| 37197 | Yadkin | 38406 | 38407.28 | -1.28 | 0.00 |
| 37199 | Yancey | 17818 | 17818.00 | 0.00 | 0.00 |
| 37021 | Buncombe | 238318 | 238347.11 | -29.11 | -0.01 |
| 37027 | Caldwell | 83029 | 83033.54 | -4.54 | -0.01 |
| 37043 | Clay | 10587 | 10587.74 | -0.74 | -0.01 |
| 37047 | Columbus | 58098 | 58105.34 | -7.34 | -0.01 |
| 37057 | Davidson | 162878 | 162902.40 | -24.40 | -0.01 |
| 37063 | Durham | 267587 | 267618.97 | -31.97 | -0.01 |
| 37065 | Edgecombe | 56552 | 56555.69 | -3.69 | -0.01 |
| 37071 | Gaston | 206086 | 206100.83 | -14.83 | -0.01 |
| 37133 | Onslow | 177772 | 177792.75 | -20.75 | -0.01 |
| 37147 | Pitt | 168148 | 168157.27 | -9.27 | -0.01 |
| 37179 | Union | 201292 | 201303.38 | -11.38 | -0.01 |
| 37011 | Avery | 17797 | 17799.74 | -2.74 | -0.02 |
| 37051 | Cumberland | 319431 | 319503.43 | -72.43 | -0.02 |
| 37101 | Johnston | 168878 | 168905.31 | -27.31 | -0.02 |
| 37111 | McDowell | 44996 | 45006.08 | -10.08 | -0.02 |
| 37129 | NewHanover | 202667 | 202697.59 | -30.59 | -0.02 |
| 37131 | Northampton | 22099 | 22102.44 | -3.44 | -0.02 |
| 37171 | Surry | 73673 | 73690.47 | -17.47 | -0.02 |
| 37001 | Alamance | 151131 | 151182.55 | -51.55 | -0.03 |
| 37037 | Chatham | 63505 | 63525.58 | -20.58 | -0.03 |
| 37079 | Greene | 21362 | 21369.25 | -7.25 | -0.03 |
| 37191 | Wayne | 122623 | 122657.70 | -34.70 | -0.03 |
| 37115 | Madison | 20764 | 20773.29 | -9.29 | -0.04 |
| 37085 | Harnett | 114678 | 114732.86 | -54.86 | -0.05 |
| 37149 | Polk | 20510 | 20520.35 | -10.35 | -0.05 |
| 37159 | Rowan | 138428 | 138514.12 | -86.12 | -0.06 |
| 37033 | Caswell | 23719 | 23735.55 | -16.55 | -0.07 |
| 37163 | Sampson | 63431 | 63472.74 | -41.74 | -0.07 |
| 37169 | Stokes | 47401 | 47438.30 | -37.30 | -0.08 |
| 37005 | Alleghany | 11155 | 11167.85 | -12.85 | -0.12 |
| 37185 | Warren | 20972 | 21005.63 | -33.63 | -0.16 |
| 37035 | Catawba | 154358 | 154867.52 | -509.52 | -0.33 |
| **Total** | - | **9535483** | **9535455.71** | **27.29** | **0.00** |

## 2010 race and ethnicity, weighted/aggregated to 2020 tracts
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_tracts_2010_rc_eth_weighted.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_tracts_2010_rc_eth_weighted.csv)

Select columns from 2010 population counts of race and ethnicity, remapped to 2020 block shapes using land area weights from the block assignment file and aggregated up to 2020 tracts. *NOTE: Some tracts include fractional values in population totals due to the weights applied at the block level. For more details on the methodology, see [the section in the file on 2010 race and ethnicity, weighted to 2020 blocks](https://github.com/mcclatchy-southeast/census2020/tree/main/data#methodology).*

## 2010 race and ethnicity, by county
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_county_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_county_2010_rc_eth.csv)

Select columns from 2010 population counts of race and ethnicity on the county summary level.  _NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file._

## 2010 race and ethnicity, by place
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_places_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_places_2010_rc_eth.csv)

Select columns from 2010 population counts of race and ethnicity on the place summary level.  _NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file._

---

## 2010 Mississippi race and ethnicity, by county
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/ms_county_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/ms_county_2010_rc_eth.csv)

Select columns from 2010 population counts of race and ethnicity on the county summary level for Mississippi.

## 2010 Georgia race and ethnicity, by county
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/ga_county_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/ga_county_2010_rc_eth.csv)

Select columns from 2010 population counts of race and ethnicity on the county summary level for Georgia.

## 2010 South Carolina race and ethnicity, by county
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/sc_county_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/sc_county_2010_rc_eth.csv)

Select columns from 2010 population counts of race and ethnicity on the county summary level for South Carolina.

## 2010 Alabama race and ethnicity, by county
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/al_county_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/al_county_2010_rc_eth.csv)

Select columns from 2010 population counts of race and ethnicity on the county summary level for Alabama.

## Race/ethnicity data dictionary

The following fields apply to most of the race and ethnicity files above.

| Field name           | Census code | Description                                                                                                                                     |
|----------------------|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| fips                 | geocode     | Unique identifier for the given summary level                                                                                                   |
| county/place         |     #N/A    | County or place name                                                                                                                                     |
| state                |     #N/A    | State name                                                                                                                                      |
| total                | P0010001    | Total population                                                                                                                                |
| rc_white             | P0010003    | Race: Population of one race: White alone                                                                                                       |
| rc_black             | P0010004    | Race: Population of one race: Black of African American alone                                                                                   |
| rc_am_indian         | P0010005    | Race: Population of one race: American Indian and Alaska Native alone                                                                           |
| rc_asian             | P0010006    | Race: Population of one race: Asian alone                                                                                                       |
| rc_pac_isl           | P0010007    | Race: Population of one race: Native Hawaiian and other Pacific Islander alone                                                                  |
| rc_other             | P0010008    | Race: Population of one race: Some other race alone                                                                                             |
| rc_multi             | P0010009    | Race: Population two or more races                                                                                                              |
| eth_hispanic         | P0020002    | Ethnicity: Hispanic or Latino                                                                                                                   |
| eth_non_hisp         | P0020003    | Ethnicity: Not Hispanic or Latino                                                                                                               |
| eth_white_nh         | P0020005    | Ethnicity: Not Hispanic or Latino: Population of one race: White alone                                                                          |
| eth_black_nh         | P0020006    | Ethnicity: Not Hispanic or Latino: Population of one race: Black of African American alone                                                      |
| eth_am_indian_nh     | P0020007    | Ethnicity: Not Hispanic or Latino: Population of one race: American Indian and Alaska Native alone                                              |
| eth_asian_nh         | P0020008    | Ethnicity: Not Hispanic or Latino: Population of one race: Asian alone                                                                          |
| eth_pac_isl_nh       | P0020009    | Ethnicity: Not Hispanic or Latino: Population of one race: Native Hawaiian and other Pacific Islander alone                                     |
| eth_other_nh         | P0020010    | Ethnicity: Not Hispanic or Latino: Population of one race: Some other race alone                                                                |
| eth_mult_nh          | P0020011    | Ethnicity: Not Hispanic or Latino: Population of one race: Population two or more races                                                         |
| total_raw            |     #N/A    | Raw change in total population from 2010 to 2020                                                                                                |
| rc_white_raw         |     #N/A    | Raw change in race: population of one race: white alone from 2010 to 2020                                                                       |
| rc_black_raw         |     #N/A    | Raw change in race: population of one race: black of african american alone from 2010 to 2020                                                   |
| rc_am_indian_raw     |     #N/A    | Raw change in race: population of one race: american indian and alaska native alone from 2010 to 2020                                           |
| rc_asian_raw         |     #N/A    | Raw change in race: population of one race: asian alone from 2010 to 2020                                                                       |
| rc_pac_isl_raw       |     #N/A    | Raw change in race: population of one race: native hawaiian and other pacific islander alone from 2010 to 2020                                  |
| rc_other_raw         |     #N/A    | Raw change in race: population of one race: some other race alone from 2010 to 2020                                                             |
| rc_multi_raw         |     #N/A    | Raw change in race: population two or more races from 2010 to 2020                                                                              |
| eth_hispanic_raw     |     #N/A    | Raw change in ethnicity: hispanic or latino from 2010 to 2020                                                                                   |
| eth_non_hisp_raw     |     #N/A    | Raw change in ethnicity: not hispanic or latino from 2010 to 2020                                                                               |
| eth_white_nh_raw     |     #N/A    | Raw change in ethnicity: not hispanic or latino: population of one race: white alone from 2010 to 2020                                          |
| eth_black_nh_raw     |     #N/A    | Raw change in ethnicity: not hispanic or latino: population of one race: black of african american alone from 2010 to 2020                      |
| eth_am_indian_nh_raw |     #N/A    | Raw change in ethnicity: not hispanic or latino: population of one race: american indian and alaska native alone from 2010 to 2020              |
| eth_asian_nh_raw     |     #N/A    | Raw change in ethnicity: not hispanic or latino: population of one race: asian alone from 2010 to 2020                                          |
| eth_pac_isl_nh_raw   |     #N/A    | Raw change in ethnicity: not hispanic or latino: population of one race: native hawaiian and other pacific islander alone from 2010 to 2020     |
| eth_other_nh_raw     |     #N/A    | Raw change in ethnicity: not hispanic or latino: population of one race: some other race alone from 2010 to 2020                                |
| eth_mult_nh_raw      |     #N/A    | Raw change in ethnicity: not hispanic or latino: population of one race: population two or more races from 2010 to 2020                         |
| total_pct            |     #N/A    | Percent change in total population from 2010 to 2020                                                                                            |
| rc_white_pct         |     #N/A    | Percent change in race: population of one race: white alone from 2010 to 2020                                                                   |
| rc_black_pct         |     #N/A    | Percent change in race: population of one race: black of african american alone from 2010 to 2020                                               |
| rc_am_indian_pct     |     #N/A    | Percent change in race: population of one race: american indian and alaska native alone from 2010 to 2020                                       |
| rc_asian_pct         |     #N/A    | Percent change in race: population of one race: asian alone from 2010 to 2020                                                                   |
| rc_pac_isl_pct       |     #N/A    | Percent change in race: population of one race: native hawaiian and other pacific islander alone from 2010 to 2020                              |
| rc_other_pct         |     #N/A    | Percent change in race: population of one race: some other race alone from 2010 to 2020                                                         |
| rc_multi_pct         |     #N/A    | Percent change in race: population two or more races from 2010 to 2020                                                                          |
| eth_hispanic_pct     |     #N/A    | Percent change in ethnicity: hispanic or latino from 2010 to 2020                                                                               |
| eth_non_hisp_pct     |     #N/A    | Percent change in ethnicity: not hispanic or latino from 2010 to 2020                                                                           |
| eth_white_nh_pct     |     #N/A    | Percent change in ethnicity: not hispanic or latino: population of one race: white alone from 2010 to 2020                                      |
| eth_black_nh_pct     |     #N/A    | Percent change in ethnicity: not hispanic or latino: population of one race: black of african american alone from 2010 to 2020                  |
| eth_am_indian_nh_pct |     #N/A    | Percent change in ethnicity: not hispanic or latino: population of one race: american indian and alaska native alone from 2010 to 2020          |
| eth_asian_nh_pct     |     #N/A    | Percent change in ethnicity: not hispanic or latino: population of one race: asian alone from 2010 to 2020                                      |
| eth_pac_isl_nh_pct   |     #N/A    | Percent change in ethnicity: not hispanic or latino: population of one race: native hawaiian and other pacific islander alone from 2010 to 2020 |
| eth_other_nh_pct     |     #N/A    | Percent change in ethnicity: not hispanic or latino: population of one race: some other race alone from 2010 to 2020                            |
| eth_mult_nh_pct      |     #N/A    | Percent change in ethnicity: not hispanic or latino: population of one race: population two or more races from 2010 to 2020                     |