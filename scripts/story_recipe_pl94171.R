# File: story_recipe_pl94171.R
# Author: Rebecca Tippett, Carolina Demography (demography@unc.edu)
# Data: 8/11/2021

# -----------------------------
# Set Working Directory and Install Libraries
# -----------------------------
setwd("C:/Users/rtippett/University of North Carolina at Chapel Hill/2020 NC Redistricting - Documents/General/Legacy Format/R Versions")
library(dplyr)

# -----------------------------
# Specify location of the files
# -----------------------------
# Note: This data is for Rhode Island from the Prototype redistricting data produced from the 2018 End-to-End Census Test
# For 2020 Census, download appropriate files from: https://www2.census.gov/programs-surveys/decennial/2020/data/01-Redistricting_File--PL_94-171/ (available 8/12/2021 at 13:00 EST)
header_file_path <- "rigeo2018_2020style.pl"
part1_file_path  <- "ri000012018_2020Style.pl"
part2_file_path  <- "ri000022018_2020Style.pl"
part3_file_path  <- "ri000032018_2020Style.pl"

# -----------------------------
# Import the data
# -----------------------------
header <- read.delim(header_file_path, header=FALSE, colClasses="character", sep="|")
part1  <- read.delim(part1_file_path,  header=FALSE, colClasses="character", sep="|")
part2  <- read.delim(part2_file_path,  header=FALSE, colClasses="character", sep="|")
part3  <- read.delim(part3_file_path,  header=FALSE, colClasses="character", sep="|")

# -----------------------------
# Assign names to data columns
# -----------------------------

# ========== HEADER ==========

#  FILEID        File Identification 
#  STUSAB        State/US-Abbreviation (USPS) 
#  SUMLEV        Summary Level 
#  GEOVAR        Geographic Variant 
#  GEOCOMP       Geographic Component 
#  CHARITER      Characteristic Iteration 
#  CIFSN         Characteristic Iteration File Sequence Number 
#  LOGRECNO      Logical Record Number 
#  GEOID         Geographic Record Identifier 
#  GEOCODE       Geographic Code Identifier 
#  REGION        Region 
#  DIVISION      Division 
#  STATE         State (FIPS) 
#  STATENS       State (NS) 
#  COUNTY        County (FIPS) 
#  COUNTYCC      FIPS County Class Code 
#  COUNTYNS      County (NS) 
#  COUSUB        County Subdivision (FIPS) 
#  COUSUBCC      FIPS County Subdivision Class Code 
#  COUSUBNS      County Subdivision (NS) 
#  SUBMCD        Subminor Civil Division (FIPS) 
#  SUBMCDCC      FIPS Subminor Civil Division Class Code 
#  SUBMCDNS      Subminor Civil Division (NS) 
#  ESTATE        Estate (FIPS) 
#  ESTATECC      FIPS Estate Class Code 
#  ESTATENS      Estate (NS) 
#  CONCIT        Consolidated City (FIPS) 
#  CONCITCC      FIPS Consolidated City Class Code 
#  CONCITNS      Consolidated City (NS) 
#  PLACE         Place (FIPS) 
#  PLACECC       FIPS Place Class Code 
#  PLACENS       Place (NS) 
#  TRACT         Census Tract 
#  BLKGRP        Block Group 
#  BLOCK         Block 
#  AIANHH        American Indian Area/Alaska Native Area/Hawaiian Home Land (Census) 
#  AIHHTLI       American Indian Trust Land/Hawaiian Home Land Indicator 
#  AIANHHFP      American Indian Area/Alaska Native Area/Hawaiian Home Land (FIPS) 
#  AIANHHCC      FIPS American Indian Area/Alaska Native Area/Hawaiian Home Land Class Code 
#  AIANHHNS      American Indian Area/Alaska Native Area/Hawaiian Home Land (NS) 
#  AITS          American Indian Tribal Subdivision (Census) 
#  AITSFP        American Indian Tribal Subdivision (FIPS) 
#  AITSCC        FIPS American Indian Tribal Subdivision Class Code 
#  AITSNS        American Indian Tribal Subdivision (NS) 
#  TTRACT        Tribal Census Tract 
#  TBLKGRP       Tribal Block Group 
#  ANRC          Alaska Native Regional Corporation (FIPS) 
#  ANRCCC        FIPS Alaska Native Regional Corporation Class Code 
#  ANRCNS        Alaska Native Regional Corporation (NS) 
#  CBSA          Metropolitan Statistical Area/Micropolitan Statistical Area 
#  MEMI          Metropolitan/Micropolitan Indicator 
#  CSA           Combined Statistical Area 
#  METDIV        Metropolitan Division 
#  NECTA         New England City and Town Area 
#  NMEMI         NECTA Metropolitan/Micropolitan Indicator 
#  CNECTA        Combined New England City and Town Area 
#  NECTADIV      New England City and Town Area Division 
#  CBSAPCI       Metropolitan Statistical Area/Micropolitan Statistical Area Principal City Indicator 
#  NECTAPCI      New England City and Town Area Principal City Indicator 
#  UA            Urban Area 
#  UATYPE        Urban Area Type 
#  UR            Urban/Rural 
#  CD116         Congressional District (116th) 
#  CD118         Congressional District (118th) 
#  CD119         Congressional District (119th) 
#  CD120         Congressional District (120th) 
#  CD121         Congressional District (121st) 
#  SLDU18        State Legislative District (Upper Chamber) (2018) 
#  SLDU22        State Legislative District (Upper Chamber) (2022) 
#  SLDU24        State Legislative District (Upper Chamber) (2024) 
#  SLDU26        State Legislative District (Upper Chamber) (2026) 
#  SLDU28        State Legislative District (Upper Chamber) (2028) 
#  SLDL18        State Legislative District (Lower Chamber) (2018) 
#  SLDL22        State Legislative District (Lower Chamber) (2022) 
#  SLDL24        State Legislative District (Lower Chamber) (2024) 
#  SLDL26        State Legislative District (Lower Chamber) (2026) 
#  SLDL28        State Legislative District (Lower Chamber) (2028) 
#  VTD           Voting District 
#  VTDI          Voting District Indicator 
#  ZCTA          ZIP Code Tabulation Area (5-Digit) 
#  SDELM         School District (Elementary) 
#  SDSEC         School District (Secondary) 
#  SDUNI         School District (Unified) 
#  PUMA          Public Use Microdata Area 
#  AREALAND      Area (Land) 
#  AREAWATR      Area (Water) 
#  BASENAME      Area Base Name 
#  NAME          Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator 
#  FUNCSTAT      Functional Status Code 
#  GCUNI         Geographic Change User Note Indicator 
#  POP100        Population Count (100%) 
#  HU100         Housing Unit Count (100%) 
#  INTPTLAT      Internal Point (Latitude) 
#  INTPTLON      Internal Point (Longitude) 
#  LSADC         Legal/Statistical Area Description Code 
#  PARTFLAG      Part Flag 
#  UGA           Urban Growth Area 
#
# ========== PART 1 ==========

#  FILEID    File Identification
#  STUSAB    State/US-Abbreviation (USPS)
#  CHARITER  Characteristic Iteration
#  CIFSN     Characteristic Iteration File Sequence Number
#  LOGRECNO  Logical Record Number
#  P0010001  Total:
#  P0010002  Population of one race:
#  P0010003  White alone
#  P0010004  Black or African American alone
#  P0010005  American Indian and Alaska Native alone
#  P0010006  Asian alone
#  P0010007  Native Hawaiian and Other Pacific Islander alone
#  P0010008  Some Other Race alone
#  P0010009  Population of two or more races:
#  P0010010  Population of two races:
#  P0010011  White; Black or African American
#  P0010012  White; American Indian and Alaska Native
#  P0010013  White; Asian
#  P0010014  White; Native Hawaiian and Other Pacific Islander
#  P0010015  White; Some Other Race
#  P0010016  Black or African American; American Indian and Alaska Native
#  P0010017  Black or African American; Asian
#  P0010018  Black or African American; Native Hawaiian and Other Pacific Islander
#  P0010019  Black or African American; Some Other Race
#  P0010020  American Indian and Alaska Native; Asian
#  P0010021  American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0010022  American Indian and Alaska Native; Some Other Race
#  P0010023  Asian; Native Hawaiian and Other Pacific Islander
#  P0010024  Asian; Some Other Race
#  P0010025  Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010026  Population of three races:
#  P0010027  White; Black or African American; American Indian and Alaska Native
#  P0010028  White; Black or African American; Asian
#  P0010029  White; Black or African American; Native Hawaiian and Other Pacific Islander
#  P0010030  White; Black or African American; Some Other Race
#  P0010031  White; American Indian and Alaska Native; Asian
#  P0010032  White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0010033  White; American Indian and Alaska Native; Some Other Race
#  P0010034  White; Asian; Native Hawaiian and Other Pacific Islander
#  P0010035  White; Asian; Some Other Race
#  P0010036  White; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010037  Black or African American; American Indian and Alaska Native; Asian
#  P0010038  Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0010039  Black or African American; American Indian and Alaska Native; Some Other Race
#  P0010040  Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0010041  Black or African American; Asian; Some Other Race
#  P0010042  Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010043  American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0010044  American Indian and Alaska Native; Asian; Some Other Race
#  P0010045  American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010046  Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010047  Population of four races:
#  P0010048  White; Black or African American; American Indian and Alaska Native; Asian
#  P0010049  White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0010050  White; Black or African American; American Indian and Alaska Native; Some Other Race
#  P0010051  White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0010052  White; Black or African American; Asian; Some Other Race
#  P0010053  White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010054  White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0010055  White; American Indian and Alaska Native; Asian; Some Other Race
#  P0010056  White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010057  White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010058  Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0010059  Black or African American; American Indian and Alaska Native; Asian; Some Other Race
#  P0010060  Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010061  Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010062  American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010063  Population of five races:
#  P0010064  White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0010065  White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race
#  P0010066  White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010067  White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010068  White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010069  Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0010070  Population of six races:
#  P0010071  White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020001  Total:
#  P0020002  Hispanic or Latino
#  P0020003  Not Hispanic or Latino:
#  P0020004  Population of one race:
#  P0020005  White alone
#  P0020006  Black or African American alone
#  P0020007  American Indian and Alaska Native alone
#  P0020008  Asian alone
#  P0020009  Native Hawaiian and Other Pacific Islander alone
#  P0020010  Some Other Race alone
#  P0020011  Population of two or more races:
#  P0020012  Population of two races:
#  P0020013  White; Black or African American
#  P0020014  White; American Indian and Alaska Native
#  P0020015  White; Asian
#  P0020016  White; Native Hawaiian and Other Pacific Islander
#  P0020017  White; Some Other Race
#  P0020018  Black or African American; American Indian and Alaska Native
#  P0020019  Black or African American; Asian
#  P0020020  Black or African American; Native Hawaiian and Other Pacific Islander
#  P0020021  Black or African American; Some Other Race
#  P0020022  American Indian and Alaska Native; Asian
#  P0020023  American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0020024  American Indian and Alaska Native; Some Other Race
#  P0020025  Asian; Native Hawaiian and Other Pacific Islander
#  P0020026  Asian; Some Other Race
#  P0020027  Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020028  Population of three races:
#  P0020029  White; Black or African American; American Indian and Alaska Native
#  P0020030  White; Black or African American; Asian
#  P0020031  White; Black or African American; Native Hawaiian and Other Pacific Islander
#  P0020032  White; Black or African American; Some Other Race
#  P0020033  White; American Indian and Alaska Native; Asian
#  P0020034  White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0020035  White; American Indian and Alaska Native; Some Other Race
#  P0020036  White; Asian; Native Hawaiian and Other Pacific Islander
#  P0020037  White; Asian; Some Other Race
#  P0020038  White; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020039  Black or African American; American Indian and Alaska Native; Asian
#  P0020040  Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0020041  Black or African American; American Indian and Alaska Native; Some Other Race
#  P0020042  Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0020043  Black or African American; Asian; Some Other Race
#  P0020044  Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020045  American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0020046  American Indian and Alaska Native; Asian; Some Other Race
#  P0020047  American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020048  Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020049  Population of four races:
#  P0020050  White; Black or African American; American Indian and Alaska Native; Asian
#  P0020051  White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0020052  White; Black or African American; American Indian and Alaska Native; Some Other Race
#  P0020053  White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0020054  White; Black or African American; Asian; Some Other Race
#  P0020055  White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020056  White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0020057  White; American Indian and Alaska Native; Asian; Some Other Race
#  P0020058  White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020059  White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020060  Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0020061  Black or African American; American Indian and Alaska Native; Asian; Some Other Race
#  P0020062  Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020063  Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020064  American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020065  Population of five races:
#  P0020066  White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0020067  White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race
#  P0020068  White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020069  White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020070  White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020071  Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race
#  P0020072  Population of six races:
#  P0020073  White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race

# ========== PART 2 ==========

#  FILEID    File Identification
#  STUSAB    State/US-Abbreviation (USPS)
#  CHARITER  Characteristic Iteration
#  CIFSN     Characteristic Iteration File Sequence Number
#  LOGRECNO  Logical Record Number
#  P0030001  P3-1: Total
#  P0030002  P3-2: Population of one race
#  P0030003  P3-3: White alone
#  P0030004  P3-4: Black or African American alone
#  P0030005  P3-5: American Indian and Alaska Native alone
#  P0030006  P3-6: Asian alone
#  P0030007  P3-7: Native Hawaiian and Other Pacific Islander alone
#  P0030008  P3-8: Some other race alone
#  P0030009  P3-9: Population of two or more races
#  P0030010  P3-10: Population of two races
#  P0030011  P3-11: White; Black or African American
#  P0030012  P3-12: White; American Indian and Alaska Native
#  P0030013  P3-13: White; Asian
#  P0030014  P3-14: White; Native Hawaiian and Other Pacific Islander
#  P0030015  P3-15: White; Some other race
#  P0030016  P3-16: Black or African American; American Indian and Alaska Native
#  P0030017  P3-17: Black or African American; Asian
#  P0030018  P3-18: Black or African American; Native Hawaiian and Other Pacific Islander
#  P0030019  P3-19: Black or African American; Some other race
#  P0030020  P3-20: American Indian and Alaska Native; Asian
#  P0030021  P3-21: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0030022  P3-22: American Indian and Alaska Native; Some other race
#  P0030023  P3-23: Asian; Native Hawaiian and Other Pacific Islander
#  P0030024  P3-24: Asian; Some other race
#  P0030025  P3-25: Native Hawaiian and Other Pacific Islander; Some other race
#  P0030026  P3-26: Population of three races
#  P0030027  P3-27: White; Black or African American; American Indian and Alaska Native
#  P0030028  P3-28: White; Black or African American; Asian
#  P0030029  P3-29: White; Black or African American; Native Hawaiian and Other Pacific Islander
#  P0030030  P3-30: White; Black or African American; Some other race
#  P0030031  P3-31: White; American Indian and Alaska Native; Asian
#  P0030032  P3-32: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0030033  P3-33: White; American Indian and Alaska Native; Some other race
#  P0030034  P3-34: White; Asian; Native Hawaiian and Other Pacific Islander
#  P0030035  P3-35: White; Asian; Some other race
#  P0030036  P3-36: White; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030037  P3-37: Black or African American; American Indian and Alaska Native; Asian
#  P0030038  P3-38: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0030039  P3-39: Black or African American; American Indian and Alaska Native; Some other race
#  P0030040  P3-40: Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0030041  P3-41: Black or African American; Asian; Some other race
#  P0030042  P3-42: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030043  P3-43: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0030044  P3-44: American Indian and Alaska Native; Asian; Some other race
#  P0030045  P3-45: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030046  P3-46: Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030047  P3-47: Population of four races
#  P0030048  P3-48: White; Black or African American; American Indian and Alaska Native; Asian
#  P0030049  P3-49: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0030050  P3-50: White; Black or African American; American Indian and Alaska Native; Some other race
#  P0030051  P3-51: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0030052  P3-52: White; Black or African American; Asian; Some other race
#  P0030053  P3-53: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030054  P3-54: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0030055  P3-55: White; American Indian and Alaska Native; Asian; Some other race
#  P0030056  P3-56: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030057  P3-57: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030058  P3-58: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0030059  P3-59: Black or African American; American Indian and Alaska Native; Asian; Some other race
#  P0030060  P3-60: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030061  P3-61: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030062  P3-62: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030063  P3-63: Population of five races
#  P0030064  P3-64: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0030065  P3-65: White; Black or African American; American Indian and Alaska Native; Asian; Some other race
#  P0030066  P3-66: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030067  P3-67: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030068  P3-68: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030069  P3-69: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0030070  P3-70: Population of six races
#  P0030071  P3-71: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040001  P4-1: Total
#  P0040002  P4-2: Hispanic or Latino
#  P0040003  P4-3: Not Hispanic or Latino
#  P0040004  P4-4: Population of one race
#  P0040005  P4-5: White alone
#  P0040006  P4-6: Black or African American alone
#  P0040007  P4-7: American Indian and Alaska Native alone
#  P0040008  P4-8: Asian alone
#  P0040009  P4-9: Native Hawaiian and Other Pacific Islander alone
#  P0040010  P4-10: Some other race alone
#  P0040011  P4-11: Population of two or more races
#  P0040012  P4-12: Population of two races
#  P0040013  P4-13: White; Black or African American
#  P0040014  P4-14: White; American Indian and Alaska Native
#  P0040015  P4-15: White; Asian
#  P0040016  P4-16: White; Native Hawaiian and Other Pacific Islander
#  P0040017  P4-17: White; Some other race
#  P0040018  P4-18: Black or African American; American Indian and Alaska Native
#  P0040019  P4-19: Black or African American; Asian
#  P0040020  P4-20: Black or African American; Native Hawaiian and Other Pacific Islander
#  P0040021  P4-21: Black or African American; Some other race
#  P0040022  P4-22: American Indian and Alaska Native; Asian
#  P0040023  P4-23: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0040024  P4-24: American Indian and Alaska Native; Some other race
#  P0040025  P4-25: Asian; Native Hawaiian and Other Pacific Islander
#  P0040026  P4-26: Asian; Some other race
#  P0040027  P4-27: Native Hawaiian and Other Pacific Islander; Some other race
#  P0040028  P4-28: Population of three races
#  P0040029  P4-29: White; Black or African American; American Indian and Alaska Native
#  P0040030  P4-30: White; Black or African American; Asian
#  P0040031  P4-31: White; Black or African American; Native Hawaiian and Other Pacific Islander
#  P0040032  P4-32: White; Black or African American; Some other race
#  P0040033  P4-33: White; American Indian and Alaska Native; Asian
#  P0040034  P4-34: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0040035  P4-35: White; American Indian and Alaska Native; Some other race
#  P0040036  P4-36: White; Asian; Native Hawaiian and Other Pacific Islander
#  P0040037  P4-37: White; Asian; Some other race
#  P0040038  P4-38: White; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040039  P4-39: Black or African American; American Indian and Alaska Native; Asian
#  P0040040  P4-40: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0040041  P4-41: Black or African American; American Indian and Alaska Native; Some other race
#  P0040042  P4-42: Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0040043  P4-43: Black or African American; Asian; Some other race
#  P0040044  P4-44: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040045  P4-45: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0040046  P4-46: American Indian and Alaska Native; Asian; Some other race
#  P0040047  P4-47: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040048  P4-48: Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040049  P4-49: Population of four races
#  P0040050  P4-50: White; Black or African American; American Indian and Alaska Native; Asian
#  P0040051  P4-51: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
#  P0040052  P4-52: White; Black or African American; American Indian and Alaska Native; Some other race
#  P0040053  P4-53: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander
#  P0040054  P4-54: White; Black or African American; Asian; Some other race
#  P0040055  P4-55: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040056  P4-56: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0040057  P4-57: White; American Indian and Alaska Native; Asian; Some other race
#  P0040058  P4-58: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040059  P4-59: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040060  P4-60: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0040061  P4-61: Black or African American; American Indian and Alaska Native; Asian; Some other race
#  P0040062  P4-62: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040063  P4-63: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040064  P4-64: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040065  P4-65: Population of five races
#  P0040066  P4-66: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander
#  P0040067  P4-67: White; Black or African American; American Indian and Alaska Native; Asian; Some other race
#  P0040068  P4-68: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040069  P4-69: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040070  P4-70: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040071  P4-71: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  P0040072  P4-72: Population of six races
#  P0040073  P4-73: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race
#  H0010001  H1-1: Total
#  H0010002  H1-2: Occupied
#  H0010003  H1-3: Vacant

# ========== PART 3 ==========

#  FILEID   File Identification
#  STUSAB   State/US-Abbreviation (USPS)
#  CHARITER Characteristic Iteration
#  CIFSN    Characteristic Iteration File Sequence Number
#  LOGRECNO Logical Record Number
#  P0050001 Total:
#  P0050002 Institutionalized population:
#  P0050003 Correctional facilities for adults
#  P0050004 Juvenile facilities
#  P0050005 Nursing facilities/Skilled-nursing facilities
#  P0050006 Other institutional facilities
#  P0050007 Noninstitutionalized population:
#  P0050008 College/University student housing
#  P0050009 Military quarters
#  P0050010 Other noninstitutional facilities

# -----------------------------
colnames(header) <- c("FILEID", "STUSAB", "SUMLEV", "GEOVAR", "GEOCOMP", "CHARITER", "CIFSN", "LOGRECNO", "GEOID", 
  "GEOCODE", "REGION", "DIVISION", "STATE", "STATENS", "COUNTY", "COUNTYCC", "COUNTYNS", "COUSUB",
  "COUSUBCC", "COUSUBNS", "SUBMCD", "SUBMCDCC", "SUBMCDNS", "ESTATE", "ESTATECC", "ESTATENS", 
  "CONCIT", "CONCITCC", "CONCITNS", "PLACE", "PLACECC", "PLACENS", "TRACT", "BLKGRP", "BLOCK", 
  "AIANHH", "AIHHTLI", "AIANHHFP", "AIANHHCC", "AIANHHNS", "AITS", "AITSFP", "AITSCC", "AITSNS",
  "TTRACT", "TBLKGRP", "ANRC", "ANRCCC", "ANRCNS", "CBSA", "MEMI", "CSA", "METDIV", "NECTA",
  "NMEMI", "CNECTA", "NECTADIV", "CBSAPCI", "NECTAPCI", "UA", "UATYPE", "UR", "CD116", "CD118",
  "CD119", "CD120", "CD121", "SLDU18", "SLDU22", "SLDU24", "SLDU26", "SLDU28", "SLDL18", "SLDL22",
  "SLDL24", "SLDL26", "SLDL28", "VTD", "VTDI", "ZCTA", "SDELM", "SDSEC", "SDUNI", "PUMA", "AREALAND",
  "AREAWATR", "BASENAME", "NAME", "FUNCSTAT", "GCUNI", "POP100", "HU100", "INTPTLAT", "INTPTLON", 
  "LSADC", "PARTFLAG", "UGA")
colnames(part1) <- c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO", 
                     paste0("P00", c(10001:10071, 20001:20073)))
colnames(part2) <- c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO", 
                     paste0("P00", c(30001:30071, 40001:40073)), 
                     paste0("H00", 10001:10003))
colnames(part3) <- c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO",
                     paste0("P00", 50001:50010))

# -----------------------------
# Merge the data
# -----------------------------
combine <- Reduce(function(x,y) {merge(x, y, by=c("LOGRECNO", "STUSAB", "FILEID", "CHARITER"))}, list(header[,-7], part1[,-4], part2[,-4], part3))

# -----------------------------
# Order the data
# -----------------------------
combine <- combine[order(combine$LOGRECNO), c("FILEID", "STUSAB", "SUMLEV", "GEOVAR", "GEOCOMP", "CHARITER", "CIFSN", "LOGRECNO", "GEOID", 
                                              "GEOCODE", "REGION", "DIVISION", "STATE", "STATENS", "COUNTY", "COUNTYCC", "COUNTYNS", "COUSUB",
                                              "COUSUBCC", "COUSUBNS", "SUBMCD", "SUBMCDCC", "SUBMCDNS", "ESTATE", "ESTATECC", "ESTATENS", 
                                              "CONCIT", "CONCITCC", "CONCITNS", "PLACE", "PLACECC", "PLACENS", "TRACT", "BLKGRP", "BLOCK", 
                                              "AIANHH", "AIHHTLI", "AIANHHFP", "AIANHHCC", "AIANHHNS", "AITS", "AITSFP", "AITSCC", "AITSNS",
                                              "TTRACT", "TBLKGRP", "ANRC", "ANRCCC", "ANRCNS", "CBSA", "MEMI", "CSA", "METDIV", "NECTA",
                                              "NMEMI", "CNECTA", "NECTADIV", "CBSAPCI", "NECTAPCI", "UA", "UATYPE", "UR", "CD116", "CD118",
                                              "CD119", "CD120", "CD121", "SLDU18", "SLDU22", "SLDU24", "SLDU26", "SLDU28", "SLDL18", "SLDL22",
                                              "SLDL24", "SLDL26", "SLDL28", "VTD", "VTDI", "ZCTA", "SDELM", "SDSEC", "SDUNI", "PUMA", "AREALAND",
                                              "AREAWATR", "BASENAME", "NAME", "FUNCSTAT", "GCUNI", "POP100", "HU100", "INTPTLAT", "INTPTLON", 
                                              "LSADC", "PARTFLAG", "UGA", paste0("P00", c(10001:10071, 20001:20073)), paste0("P00", c(30001:30071, 40001:40073)), 
                                              paste0("H00", 10001:10003), paste0("P00", 50001:50010))]
rownames(combine) <- 1:nrow(combine)

# -----------------------------
# Extract Pop & Housing Unit Totals
# -----------------------------

# Pop & Housing Unit Only Files for County and Block (example)
cty_pop <- subset(combine,select = c(SUMLEV, GEOCODE, STATE, COUNTY, POP100, HU100), SUMLEV=="050")
write.csv(cty_pop,"2020_county_pop_only.csv")

block_pop <- subset(combine,select = c(SUMLEV, GEOCODE, COUNTY, TRACT, BLKGRP, BLOCK, POP100, HU100),SUMLEV=="750")
write.csv(block_pop,"2020_block_pop_only.csv")

# -----------------------------
# CREATING AND EXPORTING A SMALLER AND EASIER TO USE DATASET
# -----------------------------

# -----------------------------
# Subset variables of interest
# -----------------------------
# POP100    Population Count (100%) (Total Population)
# HU100     Housing Unit Count (100%) (Total Housing Units)
# P0020002  Total Population: Hispanic Or Latino
# P0020003  Total Population: Not Hispanic or Latino
# P0020005  Total Population: Not Hispanic or Latino: White alone
# P0020006  Total Population: Not Hispanic or Latino: Black or African American alone
# P0020007  Total Population: Not Hispanic or Latino: American Indian and Alaska Native alone
# P0020008  Total Population: Not Hispanic or Latino: Asian alone
# P0020009  Total Population: Not Hispanic or Latino: Native Hawaiian and Other Pacific Islander alone 
# P0020010  Total Population: Not Hispanic or Latino: Some other race alone
# P0020011  Total Population: Not Hispanic or Latino: Population of two or more races
# P0040001  Total Population 18 years and over
# P0040002  Total Population 18 years and over: Hispanic Or Latino
# P0040003  Total Population 18 years and over: Not Hispanic or Latino
# P0040005  Total Population 18 years and over: Not Hispanic or Latino: White alone
# P0040006  Total Population 18 years and over: Not Hispanic or Latino: Black or African American Alone
# P0040007  Total Population 18 years and over: Not Hispanic or Latino: American Indian and Alaska Native alone
# P0040008  Total Population 18 years and over: Not Hispanic or Latino: Asian alone 
# P0040009  Total Population 18 years and over: Not Hispanic or Latino: Native Hawaiian and Other Pacific Islander alone
# P0040010  Total Population 18 years and over: Not Hispanic or Latino: Some other race alone
# P0040011  Total Population 18 years and over: Not Hispanic or Latino: Population of two or more races
# H0010002  Housing Units: Occupied
# H0010003  Housing Units: Vacant
# P0050001  Total Population in Group Quarters
# P0050002  Total Population in Group Quarters: Institutionalized Population
# P0050003  Total Population in Group Quarters: Institutionalized Population: Correctional facilities for adults
# P0050004  Total Population in Group Quarters: Institutionalized Population: Juvenile facilities
# P0050005  Total Population in Group Quarters: Institutionalized Population: Nursing facilities/Skilled-nursing facilities
# P0050006  Total Population in Group Quarters: Institutionalized Population: Other institutional facilities
# P0050007  Total Population in Group Quarters: Noninstitutionalized population
# P0050008  Total Population in Group Quarters: Noninstitutionalized population: College/University student housing
# P0050009  Total Population in Group Quarters: Noninstitutionalized population: Military quarters
# P0050010  Total Population in Group Quarters: Noninstitutionalized population: Other noninstitutional facilities

subset <- subset(combine,select = c(SUMLEV, GEOCODE, REGION, DIVISION, STATE, COUNTY, PLACE, TRACT, BLKGRP, BLOCK, POP100, HU100, P0020002,
                           P0020003, P0020005, P0020006, P0020007, P0020008, P0020009, P0020010, P0020011, P0040001, P0040002,
                           P0040003, P0040005, P0040006, P0040007, P0040008, P0040009, P0040010, P0040011, H0010002,
                           H0010003, P0050001, P0050002, P0050003, P0050004, P0050005, P0050006, P0050007, P0050008, P0050009, P0050010))

# -----------------------------
# Rename for ease of interpretation
# -----------------------------
subset <- subset %>%
  rename(pop2020 = POP100,
         hu2020 = HU100, 
         hisp2020 = P0020002,
         nh2020 = P0020003, 
         nh_white2020 = P0020005, 
         nh_black2020 = P0020006, 
         nh_amin2020 = P0020007, 
         nh_asian2020 = P0020008, 
         nh_paci2020 = P0020009, 
         nh_other2020 = P0020010, 
         nh_twomore2020 = P0020011, 
         pop18_2020 = P0040001, 
         pop18_hisp2020 = P0040002,
         pop18_nh2020 = P0040003, 
         pop18_nh_white2020 = P0040005, 
         pop18_nh_black2020 = P0040006, 
         pop18_nh_amin2020 = P0040007, 
         pop18_nh_asian2020 = P0040008, 
         pop18_nh_paci2020 = P0040009, 
         pop18_nh_other2020 = P0040010, 
         pop18_nh_twomore2020 = P0040011, 
         hu_occ2020 = H0010002,
         hu_vac2020 = H0010003, 
         gq2020 = P0050001, 
         gq_inst2020 = P0050002, 
         gq_inst_corrad2020 = P0050003, 
         gq_inst_corrjuv2020 = P0050004, 
         gq_inst_nh2020 = P0050005, 
         gq_inst_other2020 = P0050006, 
         gq_noninst2020 = P0050007, 
         gq_noninst_dorm2020 = P0050008, 
         gq_noninst_mil2020 = P0050009, 
         gq_noinst_other2020 = P0050010)

# -----------------------------
# Create Files of Select Geographic Outputs
# -----------------------------
blocks2020 <- subset(subset,SUMLEV=="750")
tracts2020 <- subset(subset,SUMLEV=="140")
county2020 <- subset(subset,SUMLEV=="050")
place2020 <- subset(subset, SUMLEV=="160")

# Export files for key geographies
write.csv(blocks2020,"2020_blocks.csv")
write.csv(county2020,"2020_county.csv")
write.csv(place2020,"2020_place.csv")
write.csv(tracts2020,"2020_tracts.csv")


