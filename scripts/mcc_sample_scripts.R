'''
McClatchy sample scripts
A collection of simple R scripts to run on Aug. 12, the day census data drops,
to process and analyze changes in race, ethnicity and population specifically
for North Carolina and several other states in the McClatchy Southeast region.

Before you get started, download the 2020 census files for your state(s)
from the U.S. Census Bureau here:
https://www2.census.gov/programs-surveys/decennial/2020/data/01-Redistricting_File--PL_94-171/

For more, see our GitHub repo at:
https://github.com/mcclatchy-southeast/census2020

by @mtdukes
'''

# Set up your workspace ---------------------------------------------------

#clear existing variables
rm(list = ls())

#set your working directory
working_directory <- 'ENTER THE PATH OF YOUR WORKING DIRECTORY HERE'
setwd(working_directory)

#check if you've got the necessary packages installed, install if needed
if('tidyverse' %in% rownames(installed.packages()) == FALSE) {
  install.packages('tidyverse')
}
if('janitor' %in% rownames(installed.packages()) == FALSE) {
  install.packages('janitor')
}

#load the tidyverse library, which allows us to easily join and work with
#data with pretty intuitive and readable syntax
library(tidyverse)
#load the janitor library to effortlessly clean up things like headers
library(janitor)

# Create loading functions to import the data -----------------------------

#these functions will allow us to import data from multiple states without
#changing variables or repeating code again and again.
#basing scripts on the prototype data here
#https://www.census.gov/programs-surveys/decennial-census/about/rdo/program-management.html#P3
#
#each function accepts the filename path and the state abbreviation to name the file,
#creating a variable with a standard naming convention

#geoheader file
#
#usage
#load_header('file_path/nc_geoheader.pl', 'nc')
load_header2020 <- function(path, state_code){
  state_code <- tolower(state_code)
  assign( paste0('geo_header_', state_code, '2020'),
          envir = .GlobalEnv,
          read_delim(
            path,
            col_types = cols(.default = "c"),
            col_names = c("FILEID", "STUSAB", "SUMLEV", "GEOVAR", "GEOCOMP", "CHARITER", "CIFSN", "LOGRECNO", "GEOID", 
                          "GEOCODE", "REGION", "DIVISION", "STATE", "STATENS", "COUNTY", "COUNTYCC", "COUNTYNS", "COUSUB",
                          "COUSUBCC", "COUSUBNS", "SUBMCD", "SUBMCDCC", "SUBMCDNS", "ESTATE", "ESTATECC", "ESTATENS", 
                          "CONCIT", "CONCITCC", "CONCITNS", "PLACE", "PLACECC", "PLACENS", "TRACT", "BLKGRP", "BLOCK", 
                          "AIANHH", "AIHHTLI", "AIANHHFP", "AIANHHCC", "AIANHHNS", "AITS", "AITSFP", "AITSCC", "AITSNS",
                          "TTRACT", "TBLKGRP", "ANRC", "ANRCCC", "ANRCNS", "CBSA", "MEMI", "CSA", "METDIV", "NECTA",
                          "NMEMI", "CNECTA", "NECTADIV", "CBSAPCI", "NECTAPCI", "UA", "UATYPE", "UR", "CD116", "CD118",
                          "CD119", "CD120", "CD121", "SLDU18", "SLDU22", "SLDU24", "SLDU26", "SLDU28", "SLDL18", "SLDL22",
                          "SLDL24", "SLDL26", "SLDL28", "VTD", "VTDI", "ZCTA", "SDELM", "SDSEC", "SDUNI", "PUMA", "AREALAND",
                          "AREAWATR", "BASENAME", "NAME", "FUNCSTAT", "GCUNI", "POP100", "HU100", "INTPTLAT", "INTPTLON", 
                          "LSADC", "PARTFLAG", "UGA"),
            delim = '|') %>% 
            clean_names(case = 'snake')
  )
}

#race and ethnicity file
load_race_ethnicity2020 <- function(path, state_code){
  state_code <- tolower(state_code)
  assign( paste0('race_ethnicity_', state_code, '2020'),
          envir = .GlobalEnv,
          read_delim(
            path,
            col_types = cols(.default = "c"),
            col_names = c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO", 
                          paste0("P00", c(10001:10071, 20001:20073))),
            delim = '|') %>% 
            clean_names(case = 'snake')
  )
}

#voting age population and housing file
load_vap_housing2020 <- function(path, state_code){
  state_code <- tolower(state_code)
  assign( paste0('vap_housing_', state_code, '2020'),
          envir = .GlobalEnv,
          read_delim(
            path,
            col_types = cols(.default = "c"),
            col_names = c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO", 
                          paste0("P00", c(30001:30071, 40001:40073)), 
                          paste0("H00", 10001:10003)),
            delim = '|') %>% 
            clean_names(case = 'snake')
  )
}

load_group_quarters2020 <- function(path, state_code){
  state_code <- tolower(state_code)
  assign( paste0('group_quarters_', state_code, '2020'),
          envir = .GlobalEnv,
          read_delim(
            path,
            col_types = cols(.default = "c"),
            col_names = c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO",
                          paste0("P00", 50001:50010)),
            delim = '|') %>% 
            clean_names(case = 'snake')
  )
}

# Create table generating functions ---------------------------------------

#these functions will allow us to generate tables of data based on summary level
#and state (for example on the state, county, or block level)

#build table for select race/ethnicity fields, based on state code and summary level
#assumes header and race/ethnicity files are already loaded into memory
#usage:
#gen_race_ethnicity('nc', '040')
#
#field layout
#geocode -- Unique identifier for the given summary level
#total (P0010001) -- Total population
#rc_white (P0010003) -- Race: Population of one race: White alone
#rc_black (P0010004) -- Race: Population of one race: Black of African American alone
#rc_am_indian (P0010005) -- Race: Population of one race: American Indian and Alaska Native alone
#rc_asian (P0010006) -- Race: Population of one race: Asian alone
#rc_pac_isl (P0010007) -- Race: Population of one race: Native Hawaiian and other Pacific Islander alone
#rc_other (P0010008) -- Race: Population of one race: Some other race alone
#rc_multi (P0010009) -- Race: Population two or more races 
#eth_hispanic (P0020002) -- Ethnicity: Hispanic or Latino
#eth_non_hisp (P0020003) -- Ethnicity: Not Hispanic or Latino
#eth_white_nh (P0020005) -- Ethnicity: Not Hispanic or Latino: Population of one race: White alone
#eth_black_nh (P0020006) -- Ethnicity: Not Hispanic or Latino: Population of one race: Black of African American alone
#eth_am_indian_nh (P0020007) -- Ethnicity: Not Hispanic or Latino: Population of one race: American Indian and Alaska Native alone
#eth_asian_nh (P0020008) -- Ethnicity: Not Hispanic or Latino: Population of one race: Asian alone
#eth_pac_isl_nh (P0020009) -- Ethnicity: Not Hispanic or Latino: Population of one race: Native Hawaiian and other Pacific Islander alone
#eth_other_nh (P0020010) -- Ethnicity: Not Hispanic or Latino: Population of one race: Some other race alone
#eth_mult_nh (P0020011) -- Ethnicity: Not Hispanic or Latino: Population of one race: Population two or more races
gen_race_ethnicity <- function(state_code, sumlev_code){
  eval( parse( text = paste0('geo_header_', state_code ,'2020') ) ) %>% 
    filter(sumlev == sumlev_code) %>%
    select(logrecno, geocode) %>%
    left_join(
      eval( parse( text = paste0('race_ethnicity_', state_code ,'2020') ) ) %>%
        select(logrecno, p0010001, p0010003, p0010004, p0010005, 
               p0010006, p0010007, p0010008, p0010009,
               p0020002, p0020003, p0020005, p0020006, p0020007,
               p0020008, p0020003, p0020009, p0020010, p0020011
        ) %>% 
        rename(total = p0010001,
               rc_white = p0010003,
               rc_black = p0010004,
               rc_am_indian = p0010005,
               rc_asian = p0010006,
               rc_pac_isl = p0010007,
               rc_other = p0010008,
               rc_multi = p0010009,
               eth_hispanic = p0020002,
               eth_non_hisp = p0020003,
               eth_white_nh = p0020005,
               eth_black_nh = p0020006,
               eth_am_indian_nh = p0020007,
               eth_asian_nh = p0020008,
               eth_pac_isl_nh = p0020009,
               eth_other_nh = p0020010,
               eth_mult_nh = p0020011
        ),
      by = 'logrecno') %>% 
    select(-logrecno)
}

#build table for select race/ethnicity voting age population fields,
#based on state code and summary level
#assumes header and race/ethnicity files are already loaded into memory
#usage:
#gen_vap('nc', '040')
#
#field layout
#geocode -- Unique identifier for the given summary level
#total_vap (P0030001) -- Total population 18 years and over
#rc_white_vap (P0030003) -- Race: Voting-age population of one race: White alone
#rc_black_vap (P0030004) -- Race: Voting-age population of one race: Black of African American alone
#rc_am_indian_vap (P0030005) -- Race: Voting-age population of one race: American Indian and Alaska Native alone
#rc_asian_vap (P0030006) -- Race: Voting-age population of one race: Asian alone
#rc_pac_isl_vap (P0030007) -- Race: Voting-age population of one race: Native Hawaiian and other Pacific Islander alone
#rc_other_vap (P0030008) -- Race: Voting-age population of one race: Some other race alone
#rc_multi_vap (P0030009) -- Race: Voting-age population two or more races 
#eth_hispanic_vap (P0040002) -- Ethnicity: Hispanic or Latino
#eth_non_hisp_vap (P0040003) -- Ethnicity: Not Hispanic or Latino
#eth_white_nh_vap (P0040005) -- Ethnicity: Not Hispanic or Latino: Voting-age population of one race: White alone
#eth_black_nh_vap (P0040006) -- Ethnicity: Not Hispanic or Latino: Voting-age population of one race: Black of African American alone
#eth_am_indian_nh_vap (P0040007) -- Ethnicity: Not Hispanic or Latino: Voting-age population of one race: American Indian and Alaska Native alone
#eth_asian_nh_vap (P0040008) -- Ethnicity: Not Hispanic or Latino: Voting-age population of one race: Asian alone
#eth_pac_isl_nh_vap (P0040009) -- Ethnicity: Not Hispanic or Latino: Voting-age population of one race: Native Hawaiian and other Pacific Islander alone
#eth_other_nh_vap (P0040010) -- Ethnicity: Not Hispanic or Latino: Voting-age population of one race: Some other race alone
#eth_mult_nh_vap (P0040011) -- Ethnicity: Not Hispanic or Latino: Voting-age population of one race: Voting-age population two or more races
gen_vap <- function(state_code, sumlev_code){
  eval( parse( text = paste0('geo_header_', state_code ,'2020') ) ) %>% 
    filter(sumlev == sumlev_code) %>%
    select(logrecno, geocode) %>%
    left_join(
      eval( parse( text = paste0('vap_housing_', state_code ,'2020') ) ) %>%
        select(logrecno, p0030001, p0030003, p0030004, p0030005, 
               p0030006, p0030007, p0030008, p0030009,
               p0040002, p0040003, p0040005, p0040006, p0040007,
               p0040008, p0040003, p0040009, p0040010, p0040011
        ) %>% 
        rename(total_vap = p0030001,
               rc_white_vap = p0030003,
               rc_black_vap = p0030004,
               rc_am_indian_vap = p0030005,
               rc_asian_vap = p0030006,
               rc_pac_isl_vap = p0030007,
               rc_other_vap = p0030008,
               rc_multi_vap = p0030009,
               eth_hispanic_vap = p0040002,
               eth_non_hisp_vap = p0040003,
               eth_white_nh_vap = p0040005,
               eth_black_nh_vap = p0040006,
               eth_am_indian_nh_vap = p0040007,
               eth_asian_nh_vap = p0040008,
               eth_pac_isl_nh_vap = p0040009,
               eth_other_nh_vap = p0040010,
               eth_mult_nh_vap = p0040011
        ),
      by = 'logrecno') %>% 
    select(-logrecno)
}

#build table for housing occupancy status
#based on state code and summary level
#assumes header and race/ethnicity files are already loaded into memory
#usage:
#gen_housing('nc', '040')
#
#field layout
#geocode -- Unique identifier for the given summary level
#hs_total (H0010001) -- Total housing units
#hs_occupied (H0010002) -- Occupied housing units
#hs_vacant (H0010003) -- Vacant housing 
gen_housing <- function(state_code, sumlev_code){
  eval( parse( text = paste0('geo_header_', state_code ,'2020') ) ) %>% 
    filter(sumlev == sumlev_code) %>%
    select(logrecno, geocode) %>%
    left_join(
      eval( parse( text = paste0('vap_housing_', state_code ,'2020') ) ) %>%
        select(logrecno, h0010001, h0010002, h0010003
        ) %>% 
        rename(hs_total = h0010001,
               hs_occupied = h0010002,
               hs_vacant = h0010003
        ),
      by = 'logrecno')
}

#build table for group quarter status
#based on state code and summary level
#assumes header and race/ethnicity files are already loaded into memory
#usage:
#gen_group_quarters('nc', '040')
#
#field layout
#geocode -- Unique identifier for the given summary level
#gq_total (P0050001) -- Total population in group quarters
#gq_inst (P0050002) -- Institutionalized population
#gq_correction (P0050003) -- Correctional facilities for adults
#gq_juvenile (P0050004) -- Juvenile facilities
#gq_nursing (P0050005) -- Nursing facilities/Skilled-nursing facilities
#gq_other_inst (P0050006) -- Other institutional facilities
#gq_noninst (P0050007) -- Noninstitutionalized population
#gq_college (P0050008) -- College/University student housing
#gq_military (P0050009) -- Military quarters
#gq_other_noninst (P0050010) -- Other noninstitutional facilities
gen_group_quarters <- function(state_code, sumlev_code){
  eval( parse( text = paste0('geo_header_', state_code ,'2020') ) ) %>% 
    filter(sumlev == sumlev_code) %>%
    select(logrecno, geocode) %>%
    left_join(
      eval( parse( text = paste0('group_quarters_', state_code ,'2020') ) ) %>%
        select(logrecno, p0050001, p0050002, p0050003, p0050004, p0050005,
               p0050006, p0050007, p0050008, p0050009, p0050010
        ) %>% 
        rename(gq_total = p0050001,
               gq_inst = p0050002,
               gq_correction = p0050003,
               gq_juvenile = p0050004,
               gq_nursing = p0050005,
               gq_other_inst = p0050006,
               gq_noninst = p0050007,
               gq_college = p0050008,
               gq_military = p0050009,
               gq_other_noninst = p0050010
        ),
      by = 'logrecno')
}

# Test with a prototype file ----------------------------------------------

#prior to Aug. 12, the U.S. Census Bureau released prototype files for a single
#new jersey county for testing. Download the files here to test them:
#https://www2.census.gov/programs-surveys/decennial/rdo/datasets/2018/ri2018_2020Style.pl.zip

#establish the paths to your census files
geoheader_path <- 'ENTER YOUR FILEPATH HERE'
race_ethnicity_path <- 'ENTER YOUR FILEPATH HERE'
vap_housing_path <- 'ENTER YOUR FILEPATH HERE'
group_quarters_path <- 'ENTER YOUR FILEPATH HERE'

#prototype loading
load_header2020( geoheader_path, 'ri' )
load_race_ethnicity2020( race_ethnicity_path, 'ri' )
load_vap_housing2020( vap_housing_path, 'ri' )
load_group_quarters2020( group_quarters_path, 'ri' )

#build a race and ethnicity table for the tract level
gen_race_ethnicity('ri', '140')

#and the county level
gen_race_ethnicity('ri', '050')

#build a voting age population table by place
gen_vap('ri', '160')

#look at occupancy by county
gen_housing('ri','050')

#look at group quarters by tract
gen_group_quarters('ri','140')