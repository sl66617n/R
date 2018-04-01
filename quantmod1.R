###http://www.business-science.io/investments/2016/10/23/SP500_Analysis.html#sim
###http://www.rfortraders.com/lecture-6-stochastic-processes-and-monte-carlo/

library(quantmod)   # get stock prices; useful stock analysis functions
library(xts)        # working with extensible time series 
library(rvest)      # web scraping
library(tidyverse)  # ggplot2, purrr, dplyr, tidyr, readr, tibble
library(stringr)    # working with strings
library(forcats)    # working with factors
library(lubridate)  # working with dates in tibbles / data frames
library(plotly)     # Interactive plots
library(corrplot)   # Visuazlize correlation plots
getSymbols("AAPL", from = "2009-01-01", to = "2017-12-07")
AAPL %>% class()
AAPL %>% str()
AAPL %>% head()
AAPL %>% 
  Ad() %>%       # adjust prices
  chartSeries()

####alternative way to write
#chartSeries(Ad(AAPL))
AAPL %>%
  chartSeries(TA='addBBands();
              addBBands(draw="p");
              addVo();
              addMACD()', 
              subset='2017',
              theme="white"
  ) 
AAPL %>%
  Ad() %>%
  dailyReturn(type = 'log') %>% 
  head() 
AAPL_log_returns <- AAPL %>%
  Ad() %>%
  dailyReturn(type = "log")
names(AAPL_log_returns) <- "AAPL.Log.Returns"
# Plot the log-returns    
AAPL_log_returns %>%    
  ggplot(aes(x = AAPL.Log.Returns)) + 
  geom_histogram(bins = 100) + 
  geom_density() +
  geom_rug(alpha = 0.5)


probs <- c(.005, .025, .25, .5, .75, .975, .995)
dist_log_returns <- AAPL_log_returns %>% 
  quantile(probs = probs, na.rm = TRUE)
dist_log_returns

mean_log_returns <- mean(AAPL_log_returns, na.rm = TRUE)
sd_log_returns <- sd(AAPL_log_returns, na.rm = TRUE)

mean_log_returns %>% exp()


# Parameters
N     <- 1000
mu    <- mean_log_returns
sigma <- sd_log_returns
day <- 1:N
price_init <- MA$MA.Adjusted[[nrow(MA$MA.Adjusted)]]
# Simulate prices
set.seed(386) 
price  <- c(price_init, rep(NA, N-1))
for(i in 2:N) {
  price[i] <- price[i-1] * exp(rnorm(1, mu, sigma))
}
price_sim <- cbind(day, price) %>% 
  as_tibble()
# Visualize price simulation
price_sim %>%
  ggplot(aes(day, price)) +
  geom_line() +
  ggtitle(str_c("MA: Simulated Prices for ", N," Trading Days"))





# Parameters
N     <- 252 # Number of Stock Price Simulations
M     <- 250  # Number of Monte Carlo Simulations   
mu    <- mean_log_returns
sigma <- sd_log_returns
day <- 1:N
price_init <- MA$MA.Adjusted[[nrow(MA$MA.Adjusted)]]
# Simulate prices
set.seed(123)
monte_carlo_mat <- matrix(nrow = N, ncol = M)
for (j in 1:M) {
  monte_carlo_mat[[1, j]] <- price_init
  for(i in 2:N) {
    monte_carlo_mat[[i, j]] <- monte_carlo_mat[[i - 1, j]] * exp(rnorm(1, mu, sigma))
  }
}
# Format and organize data frame
price_sim <- cbind(day, monte_carlo_mat) %>%
  as_tibble() 
nm <- str_c("Sim.", seq(1, M))
nm <- c("Day", nm)
names(price_sim) <- nm
price_sim <- price_sim %>%
  gather(key = "Simulation", value = "Stock.Price", -(Day))
# Visualize simulation
price_sim %>%
  ggplot(aes(x = Day, y = Stock.Price, Group = Simulation)) + 
  geom_line(alpha = 0.1) +
  ggtitle(str_c("MA: ", M, 
                " Monte Carlo Simulations for Prices Over ", N, 
                " Trading Days"))




end_stock_prices <- price_sim %>% 
  filter(Day == max(Day))
probs <- c(.005, .025, .25, .5, .75, .975, .995)
dist_end_stock_prices <- quantile(end_stock_prices$Stock.Price, probs = probs)
dist_end_stock_prices %>% round(2)





# Inputs
N_hist          <- nrow(MA) / 252
p_start_hist    <- MA$MA.Adjusted[[1]]
p_end_hist      <- MA$MA.Adjusted[[nrow(MA)]]
N_sim           <- N / 252
p_start_sim     <- p_end_hist
p_end_sim       <- dist_end_stock_prices[[4]]
# CAGR calculations
CAGR_historical <- (p_end_hist / p_start_hist) ^ (1 / N_hist) - 1
CAGR_sim        <- (p_end_sim / p_start_sim) ^ (1 / N_sim) - 1




library(rvest)
# Web-scrape SP500 stock list
sp_500 <- read_html("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies") %>%
  html_node("table.wikitable") %>%
  html_table() %>%
  select(`Ticker symbol`, Security, `GICS Sector`, `GICS Sub Industry`) %>%
  as_tibble()
# Format names
names(sp_500) <- sp_500 %>% 
  names() %>% 
  str_to_lower() %>% 
  make.names()
# Show results
sp_500 

