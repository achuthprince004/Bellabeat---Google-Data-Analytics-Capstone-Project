# ---- Load Libraries ----
library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)
library(skimr)

# ---- Load Data ----
daily_activity <- read_csv("../data/dailyActivity_merged.csv")
sleep_day <- read_csv("../data/sleepDay_merged.csv")
daily_intensities <- read_csv("../data/dailyIntensities_merged.csv")
weight_log <- read_csv("../data/weightLogInfo_merged.csv")
heartrate_seconds <- read_csv("../data/heartrate_seconds_merged.csv")

# ---- Inspect Data ----
head(daily_activity)
skim_without_charts(daily_activity)
glimpse(daily_activity)

# ---- Data Cleaning ----
daily_activity <- daily_activity %>%
  rename_with(tolower) %>%
  mutate(activitydate = mdy(activitydate)) %>%
  distinct()

sleep_day <- sleep_day %>%
  rename_with(tolower) %>%
  mutate(sleepday = mdy_hms(sleepday)) %>%
  distinct()

daily_intensities <- daily_intensities %>%
  rename_with(tolower) %>%
  mutate(activityday = mdy(activityday)) %>%
  distinct()

weight_log <- weight_log %>%
  rename_with(tolower) %>%
  mutate(date = mdy(date)) %>%
  distinct()

# ---- Merge Sleep and Activity Data ----
sleep_activity <- merge(daily_activity, sleep_day, by.x = c("id", "activitydate"), by.y = c("id", "sleepday"))

# ---- Add Day of Week ----
sleep_activity <- sleep_activity %>%
  mutate(day = weekdays(activitydate))

# ---- Average Steps by Day ----
avg_steps_day <- sleep_activity %>%
  group_by(day) %>%
  summarise(avg_steps = mean(totalsteps))

ggplot(avg_steps_day, aes(x = reorder(day, avg_steps), y = avg_steps)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Average Steps by Weekday", x = "Day", y = "Average Steps") +
  theme_minimal()

# ---- Correlation Between Sleep and Steps ----
ggplot(sleep_activity, aes(x = totalminutesasleep, y = totalsteps)) +
  geom_point(color = "darkgreen", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Sleep Duration vs. Steps", x = "Total Minutes Asleep", y = "Total Steps") +
  theme_minimal()

# ---- Average Sleep Duration by Day ----
avg_sleep_day <- sleep_activity %>%
  group_by(day) %>%
  summarise(avg_sleep = mean(totalminutesasleep))

ggplot(avg_sleep_day, aes(x = reorder(day, avg_sleep), y = avg_sleep)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Average Sleep Duration by Weekday", x = "Day", y = "Minutes Asleep") +
  theme_minimal()

# ---- Analyze User Engagement ----
active_users <- daily_activity %>%
  group_by(id) %>%
  summarise(active_days = n()) %>%
  arrange(desc(active_days))

ggplot(active_users, aes(x = active_days)) +
  geom_histogram(fill = "orange", bins = 20) +
  labs(title = "User Engagement: Number of Active Days", x = "Active Days", y = "Number of Users") +
  theme_minimal()

# ---- Weight Log Analysis ----
ggplot(weight_log, aes(x = bmi)) +
  geom_histogram(fill = "skyblue", bins = 20) +
  labs(title = "BMI Distribution of Users", x = "BMI", y = "Count") +
  theme_minimal()

# ---- Intensity Levels ----
daily_intensities_summary <- daily_intensities %>%
  group_by(id) %>%
  summarise(mean_very = mean(veryactivedistance),
            mean_moderate = mean(moderatelyactivedistance),
            mean_light = mean(lightactivedistance))

# ---- Save Plots ----
ggsave("../visuals/avg_steps_day.png", width = 6, height = 4)
ggsave("../visuals/sleep_vs_steps.png", width = 6, height = 4)
ggsave("../visuals/avg_sleep_day.png", width = 6, height = 4)
ggsave("../visuals/active_users_hist.png", width = 6, height = 4)
ggsave("../visuals/bmi_distribution.png", width = 6, height = 4)

# ---- Summary Table ----
summary_table <- sleep_activity %>%
  summarise(avg_steps = mean(totalsteps),
            avg_sleep = mean(totalminutesasleep),
            avg_calories = mean(calories),
            avg_very_active_mins = mean(veryactiveminutes),
            avg_sedentary_mins = mean(sedentaryminutes))
print(summary_table)

# ---- End of Script ----
