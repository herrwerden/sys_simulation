# ID: 22835
# 09-07-2018
# Course: System Simulation
# Final course project Title : The SIR model in R 


install.packages("deSolve")
install.packages("tidyverse")
install.packages("factoextra")
install.packages("dbscan")
install.packages("geosphere")
install.packages("sqldf")
install.packages("nycflights13")

library(deSolve)
library(nycflights13)
library(sqldf)
library(tidyverse)
library(factoextra)
library(dbscan)
library(stringi)
library(stringr)
library(lubridate)
library(reshape2)

#---------------- The SIR model ---------------

# (1) Firstly we let the parameters infection rate a = 0.3 lower than the recovering rate b = 0.9
#     then the initial state condition for I and R was varied.
#     state 1: S(0) = 300, I(0) = 10 and R(0) = 0
#     state 2: S(0) = 300, I(0) = 10 and R(0) = 10
#     state 1: S(0) = 300, I(0) = 50 and R(0) = 10

parameters <- c(a = 0.3, b = 0.9) 
state_1 <- c(S = 300, I = 10, R = 0)
state_2 <- c(S = 300, I = 10, R = 10)
state_3 <- c(S = 300, I = 50, R = 10)

# Model equations
#state 1
SIR_state_1 <- function(t, state_1, parameters) {
  with(as.list(c(state_1, parameters)),{ 
    dS <- -a*I*S
    dI <- a*I*S - b*I
    dR <- b*I
    list(c(dS, dI, dR)) })
}

#state_2
SIR_state_2 <- function(t, state_2, parameters) {
  with(as.list(c(state_2, parameters)),{ 
    dS <- -a*I*S
    dI <- a*I*S - b*I
    dR <- b*I
    list(c(dS, dI, dR)) })
}

#state_3
SIR_state_3 <- function(t, state_3, parameters) {
  with(as.list(c(state_3, parameters)),{ 
    dS <- -a*I*S
    dI <- a*I*S - b*I
    dR <- b*I
    list(c(dS, dI, dR)) })
}

# Time specification
times <- seq(0, 10, by = 1)

# Model integration
#state_1
out_state_1 <- ode(state_1, times, SIR_state_1, parameters)

#state_2
out_state_2 <- ode(state_2, times, SIR_state_2, parameters)

#state_3
out_state_3 <- ode(state_3, times, SIR_state_3, parameters)

# Plotting results on seperate figure for each state
par(oma = c(1, 1, 1, 1)) # Set outside margins par(mar = c(4, 5, 2, 1)) # Set plot margins

# state_1 plot
plot(out_state_1, xlab = "time", ylab = "Changes in time")
# state_2 plot
plot(out_state_2, xlab = "time", ylab = "Changes in time")
# state_3 plot
plot(out_state_3, xlab = "time", ylab = "Changes in time")


         ## Ploting results on same figure for each state
#state 1
out_1 = as.data.frame(out_state_1) # required by ggplot: data object must be a data frame
out_1_melt = melt(out_1, id.vars='time') # this makes plotting easier by puting all variables in a single column

p_1 <- ggplot(out_1_melt, aes(time, value , color = variable)) + geom_line() + ylab("population") + ggtitle("SIR model  (a=0.3, b=0.9) (S=300, I=10, R=0)")  #+geom_line()
print(p_1)

#state 2
out_2 = as.data.frame(out_state_2) # required by ggplot: data object must be a data frame
out_2_melt = melt(out_2, id.vars='time') # this makes plotting easier by puting all variables in a single column

p_2 <- ggplot(out_2_melt, aes(time, value, color = variable)) + geom_line() + ylab("population") + ggtitle("SIR model  (a=0.3, b=0.9) (S=300, I=10, R=10)") #+geom_line()
print(p_2)

#state 3
out_3 = as.data.frame(out_state_3) # required by ggplot: data object must be a data frame
out_3_melt = melt(out_3, id.vars='time') # this makes plotting easier by puting all variables in a single column

p_3 <- ggplot(out_3_melt, aes(time, value, color = variable)) + geom_line() + ylab("population") + ggtitle("SIR model  (a=0.3, b=0.9) (S=300, I=50, R=10)") #+geom_line()
print(p_3)


# clear of all object for the first observation and the run for the second observations when parameter
# was a and b was interchange


rm(list=ls(all=TRUE)) 
remove(list=ls(all=TRUE))
graphics.off()



# (2) Secondly we let the parameters infection rate a = 0.9 lower than the recovering rate b = 0.3
#     then the initial state condition for I and R was varied.
#     state 1: S(0) = 300, I(0) = 10 and R(0) = 0
#     state 2: S(0) = 300, I(0) = 10 and R(0) = 10
#     state 1: S(0) = 300, I(0) = 50 and R(0) = 10

parameters <- c(a = 0.9, b = 0.3) 
state_1 <- c(S = 300, I = 10, R = 0)
state_2 <- c(S = 300, I = 10, R = 10)
state_3 <- c(S = 300, I = 50, R = 10)

# Model equations
#state 1
SIR_state_1 <- function(t, state_1, parameters) {
  with(as.list(c(state_1, parameters)),{ 
    dS <- -a*I*S
    dI <- a*I*S - b*I
    dR <- b*I
    list(c(dS, dI, dR)) })
}

#state_2
SIR_state_2 <- function(t, state_2, parameters) {
  with(as.list(c(state_2, parameters)),{ 
    dS <- -a*I*S
    dI <- a*I*S - b*I
    dR <- b*I
    list(c(dS, dI, dR)) })
}

#state_3
SIR_state_3 <- function(t, state_3, parameters) {
  with(as.list(c(state_3, parameters)),{ 
    dS <- -a*I*S
    dI <- a*I*S - b*I
    dR <- b*I
    list(c(dS, dI, dR)) })
}

# Time specification
times <- seq(0, 10, by = 1)

# Model integration
#state_1
out_state_1 <- ode(state_1, times, SIR_state_1, parameters)

#state_2
out_state_2 <- ode(state_2, times, SIR_state_2, parameters)

#state_3
out_state_3 <- ode(state_3, times, SIR_state_3, parameters)

# Plotting results on seperate figure for each state
par(oma = c(1, 1, 1, 1)) # Set outside margins par(mar = c(4, 5, 2, 1)) # Set plot margins

# state_1 plot
plot(out_state_1, xlab = "time", ylab = "Changes in time")
# state_2 plot
plot(out_state_2, xlab = "time", ylab = "Changes in time")
# state_3 plot
plot(out_state_3, xlab = "time", ylab = "Changes in time")


## Ploting results on same figure for each state
#state 1
out_1 = as.data.frame(out_state_1) # required by ggplot: data object must be a data frame
out_1_melt = melt(out_1, id.vars='time') # this makes plotting easier by puting all variables in a single column

p_1 <- ggplot(out_1_melt, aes(time, value, color = variable)) + geom_line() + ylab("population") + ggtitle("SIR model  (a=0.9, b=0.3) (S=300, I=10, R=0)")  #+geom_line()
print(p_1)

#state 2
out_2 = as.data.frame(out_state_2) # required by ggplot: data object must be a data frame
out_2_melt = melt(out_2, id.vars='time') # this makes plotting easier by puting all variables in a single column

p_2 <- ggplot(out_2_melt, aes(time, value, color = variable)) + geom_line() + ylab("population") + ggtitle("SIR model (a=0.9, b=0.3) (S=300, I=10, R=10)") #+geom_line()
print(p_2)

#state 3
out_3 = as.data.frame(out_state_3) # required by ggplot: data object must be a data frame
out_3_melt = melt(out_3, id.vars='time') # this makes plotting easier by puting all variables in a single column

p_3 <- ggplot(out_3_melt, aes(time, value, color = variable)) + geom_line() + ylab("population") + ggtitle("SIR model (a=0.9, b=0.3) (S=300, I=50, R=10)") #+geom_line()
print(p_3)

# clear of all object for the first observation and the run for the second observations when parameter
# was a and b was interchange




# clear of all object 

rm(list=ls(all=TRUE)) 
remove(list=ls(all=TRUE))
graphics.off()

