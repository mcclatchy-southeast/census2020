# Data files for the 2020 Census
Right-click on "Download" below to save these files to your desktop in comma-separated value format.

## NC block assignment file, with weights
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_baf_2010_2010_weighted.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_baf_2010_2010_weighted.csv)
Used to remap 2010 population counts to the redrawn 2020 block for aggregation up to the tract level. Weights are calculated using the intersection of each 2010 block with the 2020 block divided by the total area of the 2010 block (  `AREALAND_INT`  /  `AREALAND_2010`  ).

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

| FIPS | County | 2010 population | Derived population | Difference | Difference (%) |
|:--|:--|--:|--:|--:|--:|
| 37109 | Lincoln | 78,265 | 77,912.75 | 352.25 | 0.45 |
| 37023 | Burke | 90,912 | 90,766.86 | 145.14 | 0.16 |
| 37061 | Duplin | 58,505 | 58,424.93 | 80.07 | 0.14 |
| 37093 | Hoke | 46,952 | 46,916.63 | 35.37 | 0.08 |
| 37083 | Halifax | 54,691 | 54,654.05 | 36.95 | 0.07 |
| 37193 | Wilkes | 69,340 | 69,290.75 | 49.25 | 0.07 |
| 37141 | Pender | 52,217 | 52,184.90 | 32.10 | 0.06 |
| 37009 | Ashe | 27,281 | 27,267.39 | 13.61 | 0.05 |
| 37089 | Henderson | 106,740 | 106,683.78 | 56.22 | 0.05 |
| 37025 | Cabarrus | 178,011 | 177,937.89 | 73.11 | 0.04 |
| 37059 | Davie | 41,240 | 41,225.38 | 14.62 | 0.04 |
| 37135 | Orange | 133,801 | 133,752.63 | 48.37 | 0.04 |
| 37103 | Jones | 10,153 | 10,149.50 | 3.50 | 0.03 |
| 37017 | Bladen | 35,190 | 35,183.00 | 7.00 | 0.02 |
| 37045 | Cleveland | 98,078 | 98,054.61 | 23.39 | 0.02 |
| 37175 | Transylvania | 33,090 | 33,083.41 | 6.59 | 0.02 |
| 37183 | Wake | 900,993 | 900,778.96 | 214.04 | 0.02 |
| 37049 | Craven | 103,505 | 103,498.28 | 6.72 | 0.01 |
| 37067 | Forsyth | 350,670 | 350,651.68 | 18.32 | 0.01 |
| 37097 | Iredell | 159,437 | 159,423.70 | 13.30 | 0.01 |
| 37107 | Lenoir | 59,495 | 59,487.07 | 7.93 | 0.01 |
| 37161 | Rutherford | 67,810 | 67,800.30 | 9.70 | 0.01 |
| 37189 | Watauga | 51,079 | 51,076.33 | 2.67 | 0.01 |
| 37003 | Alexander | 37,198 | 37,196.17 | 1.83 | 0.00 |
| 37007 | Anson | 26,948 | 26,946.81 | 1.19 | 0.00 |
| 37013 | Beaufort | 47,759 | 47,758.93 | 0.07 | 0.00 |
| 37015 | Bertie | 21,282 | 21,281.99 | 0.01 | 0.00 |
| 37019 | Brunswick | 107,431 | 107,431.70 | -0.70 | 0.00 |
| 37029 | Camden | 9,980 | 9,980.00 | 0.00 | 0.00 |
| 37031 | Carteret | 66,469 | 66,469.04 | -0.04 | 0.00 |
| 37039 | Cherokee | 27,444 | 27,443.42 | 0.58 | 0.00 |
| 37041 | Chowan | 14,793 | 14,793.00 | 0.00 | 0.00 |
| 37053 | Currituck | 23,547 | 23,547.00 | 0.00 | 0.00 |
| 37055 | Dare | 33,920 | 33,920.00 | 0.00 | 0.00 |
| 37069 | Franklin | 60,619 | 60,621.01 | -2.01 | 0.00 |
| 37073 | Gates | 12,197 | 12,197.12 | -0.12 | 0.00 |
| 37075 | Graham | 8,861 | 8,861.12 | -0.12 | 0.00 |
| 37077 | Granville | 59,916 | 59,915.96 | 0.04 | 0.00 |
| 37081 | Guilford | 488,406 | 488,401.39 | 4.61 | 0.00 |
| 37087 | Haywood | 59,036 | 59,035.24 | 0.76 | 0.00 |
| 37091 | Hertford | 24,669 | 24,668.28 | 0.72 | 0.00 |
| 37095 | Hyde | 5,810 | 5,809.92 | 0.08 | 0.00 |
| 37099 | Jackson | 40,271 | 40,269.58 | 1.42 | 0.00 |
| 37105 | Lee | 57,866 | 57,865.97 | 0.03 | 0.00 |
| 37113 | Macon | 33,922 | 33,923.10 | -1.10 | 0.00 |
| 37117 | Martin | 24,505 | 24,504.33 | 0.67 | 0.00 |
| 37119 | Mecklenburg | 919,628 | 919,610.73 | 17.27 | 0.00 |
| 37121 | Mitchell | 15,579 | 15,578.81 | 0.19 | 0.00 |
| 37123 | Montgomery | 27,798 | 27,797.85 | 0.15 | 0.00 |
| 37125 | Moore | 88,247 | 88,246.81 | 0.19 | 0.00 |
| 37127 | Nash | 95,840 | 95,838.96 | 1.04 | 0.00 |
| 37137 | Pamlico | 13,144 | 13,144.00 | 0.00 | 0.00 |
| 37139 | Pasquotank | 40,661 | 40,661.00 | 0.00 | 0.00 |
| 37143 | Perquimans | 13,453 | 13,452.88 | 0.12 | 0.00 |
| 37145 | Person | 39,464 | 39,464.29 | -0.29 | 0.00 |
| 37151 | Randolph | 141,752 | 141,757.09 | -5.09 | 0.00 |
| 37153 | Richmond | 46,639 | 46,639.16 | -0.16 | 0.00 |
| 37155 | Robeson | 134,168 | 134,161.40 | 6.60 | 0.00 |
| 37157 | Rockingham | 93,643 | 93,639.67 | 3.33 | 0.00 |
| 37165 | Scotland | 36,157 | 36,157.00 | 0.00 | 0.00 |
| 37167 | Stanly | 60,585 | 60,585.00 | 0.00 | 0.00 |
| 37173 | Swain | 13,981 | 13,980.77 | 0.23 | 0.00 |
| 37177 | Tyrrell | 4,407 | 4,407.00 | 0.00 | 0.00 |
| 37181 | Vance | 45,422 | 45,422.17 | -0.17 | 0.00 |
| 37187 | Washington | 13,228 | 13,228.00 | 0.00 | 0.00 |
| 37195 | Wilson | 81,234 | 81,233.61 | 0.39 | 0.00 |
| 37197 | Yadkin | 38,406 | 38,407.28 | -1.28 | 0.00 |
| 37199 | Yancey | 17,818 | 17,818.00 | 0.00 | 0.00 |
| 37021 | Buncombe | 238,318 | 238,347.11 | -29.11 | -0.01 |
| 37027 | Caldwell | 83,029 | 83,033.54 | -4.54 | -0.01 |
| 37043 | Clay | 10,587 | 10,587.74 | -0.74 | -0.01 |
| 37047 | Columbus | 58,098 | 58,105.34 | -7.34 | -0.01 |
| 37057 | Davidson | 162,878 | 162,902.40 | -24.40 | -0.01 |
| 37063 | Durham | 267,587 | 267,618.97 | -31.97 | -0.01 |
| 37065 | Edgecombe | 56,552 | 56,555.69 | -3.69 | -0.01 |
| 37071 | Gaston | 206,086 | 206,100.83 | -14.83 | -0.01 |
| 37133 | Onslow | 177,772 | 177,792.75 | -20.75 | -0.01 |
| 37147 | Pitt | 168,148 | 168,157.27 | -9.27 | -0.01 |
| 37179 | Union | 201,292 | 201,303.38 | -11.38 | -0.01 |
| 37011 | Avery | 17,797 | 17,799.74 | -2.74 | -0.02 |
| 37051 | Cumberland | 319,431 | 319,503.43 | -72.43 | -0.02 |
| 37101 | Johnston | 168,878 | 168,905.31 | -27.31 | -0.02 |
| 37111 | McDowell | 44,996 | 45,006.08 | -10.08 | -0.02 |
| 37129 | New Hanover | 202,667 | 202,697.59 | -30.59 | -0.02 |
| 37131 | Northampton | 22,099 | 22,102.44 | -3.44 | -0.02 |
| 37171 | Surry | 73,673 | 73,690.47 | -17.47 | -0.02 |
| 37001 | Alamance | 151,131 | 151,182.55 | -51.55 | -0.03 |
| 37037 | Chatham | 63,505 | 63,525.58 | -20.58 | -0.03 |
| 37079 | Greene | 21,362 | 21,369.25 | -7.25 | -0.03 |
| 37191 | Wayne | 122,623 | 122,657.70 | -34.70 | -0.03 |
| 37115 | Madison | 20,764 | 20,773.29 | -9.29 | -0.04 |
| 37085 | Harnett | 114,678 | 114,732.86 | -54.86 | -0.05 |
| 37149 | Polk | 20,510 | 20,520.35 | -10.35 | -0.05 |
| 37159 | Rowan | 138,428 | 138,514.12 | -86.12 | -0.06 |
| 37033 | Caswell | 23,719 | 23,735.55 | -16.55 | -0.07 |
| 37163 | Sampson | 63,431 | 63,472.74 | -41.74 | -0.07 |
| 37169 | Stokes | 47,401 | 47,438.30 | -37.30 | -0.08 |
| 37005 | Alleghany | 11,155 | 11,167.85 | -12.85 | -0.12 |
| 37185 | Warren | 20,972 | 21,005.63 | -33.63 | -0.16 |
| 37035 | Catawba | 154,358 | 154,867.52 | -509.52 | -0.33 |
| **Total** | -- | **9,535,483** | **9,535,450.64** | **32.36** | **0.00** |

## 2010 race and ethnicity, weighted/aggregated to 2020 tracts
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_tracts_2010_rc_eth_weighted.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_tracts_2010_rc_eth_weighted.csv)
Select columns from 2010 population counts of race and ethnicity, remapped to 2020 block shapes using land area weights from the block assignment file and aggregated up to 2020 tracts. *NOTE: Some tracts include fractional values in population totals due to the weights applied at the block level. For more details on the methodology, see the file on 2010 race and ethnicity, weighted to 2020 blocks.*

## 2010 race and ethnicity, by county
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_county_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_county_2010_rc_eth.csv)
Select columns from 2010 population counts of race and ethnicity on the county summary level.  _NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file._

## 2010 race and ethnicity, by place
[View](https://github.com/mcclatchy-southeast/census2020/blob/main/data/nc_places_2010_rc_eth.csv) | [Download](https://raw.githubusercontent.com/mcclatchy-southeast/census2020/main/data/nc_places_2010_rc_eth.csv)
Select columns from 2010 population counts of race and ethnicity on the place summary level.  _NOTE: These totals are directly from the 2010 Census redistricting file and not weighted or aggregated based on the block assignment file._