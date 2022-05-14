library(fable)
library(forecast)
library(tidyverse)
library(tsibble)
library(zoo)

# Load data wrangled from the EIA's grody spreadsheet and run totals for all 50 states and DC, ultimately producing a tsibble
electricity_demand <- read_csv('electricity-demand.csv')
electricity_demand <- electricity_demand %>% group_by(year, month) %>% summarize(terawatt_hours=sum(megawatt_hours) / 1000000)
electricity_demand <- electricity_demand %>% mutate(month=yearmonth(as.yearmon(paste(year, month), '%Y %m')))
electricity_demand <- electricity_demand %>% ungroup() %>% select(-year)
electricity_demand <- electricity_demand %>% as_tsibble()

# Build model and save, or load existing model
fit_path <- 'fit.rds'

if (file.exists(fit_path)) {
  fit <- readRDS(fit_path)
} else {
  fit <- electricity_demand %>% model(NNETAR(terawatt_hours))

  saveRDS(fit, fit_path)
}

# Forecast
forecast_24_months <- fit %>% forecast(h=24)
print(forecast_24_months, n=24)
png(filename='forecast.png', width=2048, height=1024)
forecast_24_months %>% autoplot() + labs(x='Month', y='TWh', title='24-Month Forecast for US Aggregate Electricity Demand (TWh)')
dev.off()
