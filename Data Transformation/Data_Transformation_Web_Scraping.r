# -*- coding: utf-8 -*-

# -- Web_Scraping --

# # Data Transformation and Web Scraping
# 
# ## Sprint 04 - Data Transformation Homework
# 
# ***Objective:***  Use the `rvest` package to scrape data from two different sources and transform it into a useful format
# 
# 
# **Table of contents**
#   * [1. IMDb Dataset](#1.-IMDb-Dataset)
#   * [2. Valorant Champions Tour 2023: LOCK//IN São Paulo](#2.-Valorant-Champions-Tour-2023:-LOCK//IN-São-Paulo)
# 
# 
# 
# 
# 
# **Resource** 🌵
# - [rvest documentation](https://cran.r-project.org/web/packages/rvest/rvest.pdf)


# ## 1. IMDb Dataset
# 
# ![image from unsplash](https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=859&q=80)
# 
# 
# Scrape data from IMdb Top 100 movies web page (Sorted by Popularity Ascending). The data that I want to extract are as follows:
# - movie name
# - rating of that movie
# - number of votes
# - gross earnings in U.S. dollars
# - ranking in top 250
# 
# **Ref:** [IMDb Top 100 movies ](https://www.imdb.com/search/title/?groups=top_100&sort=user_rating.desc)



# import library
library(dplyr)
library(rvest)


# web scraping
# static website e.g.wikipedia, imdb
url <-"https://www.imdb.com/search/title/?groups=top_100&sort=user_rating.desc"
movie_name <- url %>%
  read_html() %>%
  html_nodes("h3.lister-item-header") %>% # html_nodes or html_elements
  html_text2() #html_text2() remove unused character

# change to numeric
ratings <- url %>% read_html() %>%
  html_elements("div.ratings-imdb-rating") %>% 
  html_text2() %>%
  as.numeric()

#vote
# sort-num_votes-visible
votes_gross_top <- url %>% read_html() %>%
  html_elements("p.sort-num_votes-visible") %>% 
  html_text2()

# create data frame and clean data
df <- data.frame(
  movie_name,
  ratings,
  votes_gross_top
)
# view the scrape data
df

# As I created the dataframe name `df` from the scrape data, it was found that 
# - In `movie_names` column, there are indices mixing with movie names 
# - `ratings` column is already in usable numeric form
# -  Data in `votes_gross_top` is mixing and there is indentation included
# 
# Therefore, using **regular expression,** I will extract and transform data in `movie_names` and `votes_gross_top` into usable format


imdb_df <- df %>%
  mutate(
         movie_id=row_number(), # or use relocate() later
         movie_name = str_remove(movie_name,"[0-9]+\\."),
         votes = str_match(votes_gross_top,"Votes:\\s*(\\d+,?\\d+,?\\d+)")[, 2],
         votes = str_remove_all(votes,"\\,"),
         gross = str_match(votes_gross_top,"Gross:\\s*\\$(\\d+\\.\\d+)")[, 2],
         top_250 = str_match(votes_gross_top,"Top\\s*250:\\s*\\#(\\d+)")[, 2] ) %>%
           transform(votes = as.numeric(votes),gross_million_dollar = as.numeric(gross),top_250 = as.numeric(top_250)) %>%
           select(movie_id,movie_name,ratings,votes,gross_million_dollar,top_250)

imdb_df

# My `imdb_df` now have 50 rows and 7 columns, where each row contains a movie sorted by popularity in usable format for analysis.


# ## 2. Valorant Champions Tour 2023: LOCK//IN São Paulo
# 
# ![VCT São Paulo](https://assets.mspimages.in/wp-content/uploads/2023/01/VCT-LOCKIN-Brazil-2023.jpg)
# 
# Scrape stats data of players who participated in VCT LOCK//IN São Paulo. The data that I want to extract are as follows:
# - player name
# - team name
# - no of rounds played in this tour
# - player rating
# - average combat score
# - kill/death
# - kills per round
# - first kill per round
# - %headshot
# - %clutch success
# 
# **Ref:** [VCT LOCK//IN São Paulo](https://www.vlr.gg/event/stats/1188/champions-tour-2023-lock-in-s-o-paulo)


## VCT LOCK//IN Brazil 
## Congratulations to FNC :-)
url_2 <- "https://www.vlr.gg/event/stats/1188/champions-tour-2023-lock-in-s-o-paulo"

# vct stat tibble
vct_tibble <- url_2 %>% read_html() %>%
  html_element("table") %>%
  html_table("div.color-sq", 
             header=TRUE, 
             trim=TRUE,
             convert = TRUE) 

head(vct_tibble)

# The scrape data is in a tibble structure, and there is mixed data in the columns. For example, the player name (k1Ng) is combined with the team name (GEN), and the column names are abbreviated. As a result, I'll extract and alter these columns before converting to a dataframe.





# transform tibble
# select columns and change columns' names
vct_tibble  <- vct_tibble  %>% 
  select(Player,
         Rounds_played = Rnd,
         Rating = R, 
         Avg_Combat_Score = ACS, 
         Kill_Death =`K:D`, 
         Kills_per_round = KPR, 
         First_Kills_per_Round = FKPR, 
         HeadShot = `HS%` ,
         Clutch_Success = `CL%`
         ) %>% 
           mutate(across(where(is.character), str_trim)) %>%
           separate(Player, sep="\n", into=c("Player_name","Team_name"), convert=T) 
           
#head(vct_tibble)

# transform to data frame
vct2023_df <- as.data.frame(vct_tibble)
vct2023_df

# My `vct2023_df` is a dataframe with 162 rows and 11 columns, with each row providing stats from players who participated in VCT LOCK//IN São Paulo.


