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


# Create loading functions to import 2020 data ----------------------------

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
#load_header2020('file_path/nc_geoheader.pl', 'nc')
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


# Create table generating functions for 2020 ------------------------------

#these functions will allow us to generate tables of data based on summary level
#and state (for example on the state, county, or block level)

#build table for select race/ethnicity fields, based on state code and summary level
#assumes header and race/ethnicity files are already loaded into memory
#usage:
#gen_race_ethnicity2020('nc', '040')
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
gen_race_ethnicity2020 <- function(state_code, sumlev_code){
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
#gen_vap2020('nc', '040')
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
gen_vap2020 <- function(state_code, sumlev_code){
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
#gen_housing2020('nc', '040')
#
#field layout
#geocode -- Unique identifier for the given summary level
#hs_total (H0010001) -- Total housing units
#hs_occupied (H0010002) -- Occupied housing units
#hs_vacant (H0010003) -- Vacant housing 
gen_housing2020 <- function(state_code, sumlev_code){
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
#gen_group_quarters2020('nc', '040')
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
gen_group_quarters2020 <- function(state_code, sumlev_code){
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

# Create loading functions for importing 2010 data ------------------------

#geoheader file for 2010
#
#usage
#load_header2010('file_path/nc_geoheader.pl', 'nc')
load_header2010 <- function(path, state_code){
  state_code <- tolower(state_code)
  assign( paste0('geo_header_', state_code, '2010'),
          envir = .GlobalEnv,
          read_fwf(
            path,
            col_types = cols(.default = "c"),
            progress = show_progress(),
            trim_ws = TRUE,
            fwf_cols(
              fileid = c(1, 6),
              stusab = c(7, 8),
              sumlev = c(9, 11),
              geocomp = c(12, 13),
              chariter = c(14, 16),
              cifsn = c(17, 18),
              logrecno = c(19, 25),
              region = c(26, 26),
              division = c(27, 27),
              state = c(28, 29),
              county = c(30, 32),
              countycc = c(33, 34),
              countysc = c(35, 36),
              cousub = c(37, 41),
              cousubcc = c(42, 43),
              cousubsc = c(44, 45),
              place = c(46, 50),
              placecc = c(51, 52),
              placesc = c(53, 54),
              tract = c(55, 60),
              blkgrp = c(61, 61),
              block = c(62, 65),
              iuc = c(66, 67),
              concit = c(68, 72),
              concitcc = c(73, 74),
              concitsc = c(75, 76),
              aianhh = c(77, 80),
              aianhhfp = c(81, 85),
              aianhhcc = c(86, 87),
              aihhtli = c(88, 88),
              aitsce = c(89, 91),
              aits = c(92, 96),
              aitscc = c(97, 98),
              ttract = c(99, 104),
              tblkgrp = c(105, 105),
              anrc = c(106, 110),
              anrccc = c(111, 112),
              cbsa = c(113, 117),
              cbsasc = c(118, 119),
              metdic = c(120, 124),
              csa = c(125, 127),
              necta = c(128, 132),
              nectasc = c(133, 134),
              nectadeiv = c(135, 139),
              cnecta = c(140, 142),
              cbsapci = c(143, 143),
              nectapci = c(144, 144),
              ua = c(145, 149),
              uasc = c(150, 151),
              uatype = c(152, 152),
              ur = c(153, 153),
              cd = c(154, 155),
              sldu = c(156, 158),
              sldl = c(159, 161),
              vtd = c(162, 167),
              vtdi = c(168, 168),
              reserve2 = c(169, 171),
              zcta5 = c(172, 176),
              submcd = c(177, 181),
              submcdcc = c(182, 183),
              sdelm = c(184, 188),
              sdsec = c(189, 193),
              sduni = c(194, 198),
              arealand = c(199, 212),
              areawater = c(213, 226),
              name = c(227, 316),
              funcstat = c(317, 317),
              gcuni = c(318, 318),
              pop100 = c(319, 327),
              hu100 = c(328, 336),
              intptlat = c(337, 347),
              intptlon = c(348, 359),
              lsadc = c(360, 361),
              partflag = c(362, 362),
              reserve3 = c(363, 368),
              uga = c(369, 373),
              statens = c(374, 381),
              countyns = c(382, 389),
              cousubns = c(390, 397),
              placens = c(398, 405),
              concitns = c(406, 413),
              aianhhns = c(414, 421),
              aitsns = c(422, 429),
              anrcns = c(430, 437),
              submcdns = c(438, 445),
              cd113 = c(446, 447),
              cd114 = c(448, 449),
              cd115 = c(450, 451),
              sldu2 = c(452, 454),
              sldu3 = c(455, 457),
              sldu4 = c(458, 460),
              sldl2 = c(461, 463),
              sldl3 = c(464, 466),
              sldl4 = c(467, 469),
              aianhhsc = c(470, 471),
              csasc = c(472, 473),
              cnectasc = c(474, 475),
              memi = c(476, 476),
              nmemi = c(477, 477),
              puma = c(478, 482),
              reserved = c(483, 500)
            ) 
          ) %>%
            clean_names(case = 'snake')
  )
}

#race and ethnicity file
#
#usage
#load_race_ethnicity2010(file_path/nc_geoheader.pl', 'nc')
load_race_ethnicity2010 <- function(path, state_code){
  state_code <- tolower(state_code)
  assign( paste0('race_ethnicity_', state_code, '2010'),
          envir = .GlobalEnv,
          read_csv(
            path,
            col_types = cols(.default = "c"),
            col_names = c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO", 
                          paste0("P00", c(10001:10071, 20001:20073)))
          ) %>% 
            clean_names(case = 'snake')
  )
}

#race and ethnicity file
#
#usage
#load_vap_housing2010('file_path/nc_vaphousing.pl', 'nc')
load_vap_housing2010 <- function(path, state_code){
  state_code <- tolower(state_code)
  assign( paste0('vap_housing_', state_code, '2010'),
          envir = .GlobalEnv,
          read_csv(
            path,
            col_types = cols(.default = "c"),
            col_names = c("FILEID", "STUSAB", "CHARITER", "CIFSN", "LOGRECNO", 
                          paste0("P00", c(30001:30071, 40001:40073)), 
                          paste0("H00", 10001:10003))
          ) %>% 
            clean_names(case = 'snake')
  )
}


# Create table generating functions for 2010 ------------------------------

#usage
#gen_race_ethnicity2010('nc','140')
gen_race_ethnicity2010 <- function(state_code, sumlev_code){
  eval( parse( text = paste0('geo_header_', state_code ,'2010') ) ) %>% 
    filter(sumlev == sumlev_code) %>%
    mutate(geocode = paste0( state, county,
                             ifelse(sumlev == '160', place, ''),
                             ifelse(sumlev == '140' | sumlev == '750', tract, ''),
                             ifelse(sumlev == '750', block, '')
    ) 
    ) %>% 
    select(logrecno, geocode) %>%
    left_join(
      eval( parse( text = paste0('race_ethnicity_', state_code ,'2010') ) ) %>%
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
        ) %>% 
        mutate(
          total = as.integer(total),
          rc_white = as.integer(rc_white),
          rc_black = as.integer(rc_black),
          rc_am_indian = as.integer(rc_am_indian),
          rc_asian = as.integer(rc_asian),
          rc_pac_isl = as.integer(rc_pac_isl),
          rc_other = as.integer(rc_other),
          rc_multi = as.integer(rc_multi),
          eth_hispanic = as.integer(eth_hispanic),
          eth_non_hisp = as.integer(eth_non_hisp),
          eth_white_nh = as.integer(eth_white_nh),
          eth_black_nh = as.integer(eth_black_nh),
          eth_am_indian_nh = as.integer(eth_am_indian_nh),
          eth_asian_nh = as.integer(eth_asian_nh),
          eth_pac_isl_nh = as.integer(eth_pac_isl_nh),
          eth_other_nh = as.integer(eth_other_nh),
          eth_mult_nh = as.integer(eth_mult_nh)
        ),
      by = 'logrecno') %>% 
    select(-logrecno)
}

#usaage
#gen_vap2010('nc','140')
gen_vap2010 <- function(state_code, sumlev_code){
  eval( parse( text = paste0('geo_header_', state_code ,'2010') ) ) %>% 
    filter(sumlev == sumlev_code) %>%
    mutate(geocode = paste0( state,
                             ifelse(is.na(county),'', county),
                             ifelse(is.na(place),'', place),
                             ifelse(is.na(tract),'', tract),
                             ifelse(is.na(block),'', block)
    ) 
    ) %>% 
    select(logrecno, geocode) %>%
    left_join(
      eval( parse( text = paste0('vap_housing_', state_code ,'2010') ) ) %>%
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
        ) %>% 
        mutate(
          total_vap =  as.integer(total_vap),
          rc_white_vap =  as.integer(rc_white_vap),
          rc_black_vap =  as.integer(rc_black_vap),
          rc_am_indian_vap =  as.integer(rc_am_indian_vap),
          rc_asian_vap =  as.integer(rc_asian_vap),
          rc_pac_isl_vap =  as.integer(rc_pac_isl_vap),
          rc_other_vap =  as.integer(rc_other_vap),
          rc_multi_vap =  as.integer(rc_multi_vap),
          eth_hispanic_vap =  as.integer(eth_hispanic_vap),
          eth_non_hisp_vap =  as.integer(eth_non_hisp_vap),
          eth_white_nh_vap =  as.integer(eth_white_nh_vap),
          eth_black_nh_vap =  as.integer(eth_black_nh_vap),
          eth_am_indian_nh_vap =  as.integer(eth_am_indian_nh_vap),
          eth_asian_nh_vap =  as.integer(eth_asian_nh_vap),
          eth_pac_isl_nh_vap =  as.integer(eth_pac_isl_nh_vap),
          eth_other_nh_vap =  as.integer(eth_other_nh_vap),
          eth_mult_nh_vap =  as.integer(eth_mult_nh_vap)
        ),
      by = 'logrecno') %>% 
    select(-logrecno)
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
gen_race_ethnicity2020('ri', '140')

#and the county level
gen_race_ethnicity2020('ri', '050')

#build a voting age population table by place
gen_vap2020('ri', '160')

#look at occupancy by county
gen_housing2020('ri','050')

#look at group quarters by tract
gen_group_quarters2020('ri','140')