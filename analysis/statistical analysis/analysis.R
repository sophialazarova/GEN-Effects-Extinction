#######  choice preference ####### 

## Rats | All Phases 
#  Bins -  last 20 trials acquisition, 15 trials extinction, 5 renewal x 16 rats!
## 1. difference in the proportion of learned choices (acquisition and extinction)
prop.test(x = c(262, 131), n = c(320, 240), alternative = 'greater')
# X-squared = 47.514, df = 1, p-value = 2.731e-12


## Simulation | All Phases 
#  Bins -  last 50 trials acquisition, last 50 trials extinction, first 10 trials renewal x 16 rats!
## 1. difference in the proportion of learned choices (acquisition and extinction)
prop.test(x = c(172, 145), n = c(250, 250), alternative = 'greater')
# X-squared = 5.8265, df = 1, p-value = 0.007893

## 2. difference in the proportion of alternative choices (acquisition and extinction)
prop.test(x = c(14, 97), n = c(250, 250), alternative = 'less')
# X-squared = 77.862, df = 1, p-value < 2.2e-16


### Rats | Extinction ### 
## Bins (onset, mid, end) are 5 trials each. x 16 subjects
## 1. difference in the proportions of correct responses (onset and end)
prop.test(x = c(49, 36), n = c(80, 80), alternative = 'greater')
# X-squared = 3.6141, df = 1, p-value = 0.02865

## 2. difference in the proportion of omissions (onset and end)
prop.test(x = c(16, 35), n = c(80, 80), alternative = 'less')
# X-squared = 9.3254, df = 1, p-value = 0.00113


### Simulation | Extinction ### 
## Bins (onset, mid, end) are 33, 33 and 34 trials respectively x 5 subjects
## 1. difference in the proportion of learned choices (onset and end)
prop.test(x = c(115, 97), n = c(165, 170), alternative = 'greater')
# X-squared = 5.2247, df = 1, p-value = 0.01113

## 2. difference in the proportion of alternative choices (onset and end)
prop.test(x = c(8, 68), n = c(165, 170), alternative = 'less')
# X-squared = 56.999, df = 1, p-value = 2.18e-14


#######  Omission dominant vs alternative dominant behavior ####### 

#rat-28 alternative rsponses dominate over omissions
t.test(x=c(0.4,0.4), y=c(0.0,0.2), alternative = "greater",var.equal = TRUE)
# t = 3, df = 2, p-value = 0.04773
#mean of x mean of y 
#0.4       0.1 

#sim_01
t.test(x=c(0.3333,0.3235), y=c(0.0303,0.0294), alternative = "greater",var.equal = TRUE)
# t = 60.673, df = 2, p-value = 0.0001358
#mean of x mean of y 
#0.32840   0.02985 

#sim_02
t.test(x=c(0.3333,0.5000), y=c(0.0303,0.0294), alternative = "greater",var.equal = TRUE)
# t = 4.6406, df = 2, p-value = 0.02172 
#mean of x mean of y 
#0.41665   0.02985 

#sim_03
t.test(x=c(0.3030, 0.3529), y=c(0.0303, 0.0294), alternative = "greater",var.equal = TRUE)
# t = 11.946, df = 2, p-value = 0.003467
#mean of x mean of y 
#0.32795   0.02985 

#sim_04
t.test(x=c(0.3636, 0.4706), y=c(0.0303, 0.0294), alternative = "greater",var.equal = TRUE)
# t = 7.2381, df = 2, p-value = 0.009279
#mean of x mean of y 
#0.41710   0.02985 



####### No extinction ####### 

# rat-12 and ra-23 have the same values
prop.test(x = c(12, 3), n = c(15, 15), alternative = 'greater')
# X-squared = 8.5333, df = 1, p-value = 0.001744
#prop 1 prop 2 
#0.8    0.2 

# rat-26
prop.test(x = c(10, 5), n = c(15, 15), alternative = 'greater')
# X-squared = 2.1333, df = 1, p-value = 0.07206
#prop 1    prop 2 
#0.6666667 0.3333333 

# sim_05
prop.test(x = c(69, 31), n = c(100, 100), alternative = 'greater')
# X-squared = 27.38, df = 1, p-value = 8.358e-08
#prop 1 prop 2 
#0.69   0.31 
