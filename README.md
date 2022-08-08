# Electricity Demand
## Forecasting aggregate US electricity demand

OK, so I've been reading *[Forecasting: Principles and Practice, 3rd
Edition](https://otexts.com/fpp3/)* and I wanted to try my hand at a
forecasting task of my own using the knowledge therein. Electricity demand
seems like a very practical thing to forecast, so I downloaded the [relevant
Excel
file](https://www.eia.gov/electricity/data/eia861m/xls/sales_revenue.xlsx)
from the US Energy Information Administration's website, which was hardly
usable for any kind of really automated analysis. Fortunately I was able to
take a few steps with Tidyverse packages to get it into the .csv format seen
here, with separate state demands aggregated to national demand for each
month and stated in terawatt-hours rather than gigawatt-hours. (dplyr rocks.)

I then used the neural network autoregression model approach mentioned in the
"Advanced Methods" chapter to forecast aggregate electricity demand 24 months
ahead. Neural networks can be very powerful and there is something intriguing
about a crazy black box method that spits out potentially highly useful
outputs. Anyway, the data actually ended at February of 2022, which means that
some of the forecast really applies to data the EIA hasn't come up with yet.
But there's still a lot of genuine future in it:

![24-month forecast of US electricity demand](https://i.imgur.com/IbQwZJ0.png)

I will be updating this Markdown as the true data actually roll in.

**UPDATE:**

The EIA have begun to provide the data that will test my model:

|  Month   | EIA Data | Prediction |
------------------------------------
| Mar 2022 |   307    |    294     |
| Apr 2022 |   283    |    277     |
| May 2022 |   303    |    290     |

RMSE: 11.17
Normalized RMSE: 0.37
