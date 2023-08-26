# PAIRED T-TEST

## **LOAD LIBRARIES**

```{r}
# To get a statistical report of our test
library(report) 

# To visualize data
library(ggpubr) 

# To visualize paired data
library(PairedData)
```

## **BUILD A DATAFRAME**

```{r}
# BSL of 10 T1DM patients before and after insulin injection
before <- c(392.9, 393.2, 345.1, 393, 434, 427.9, 422, 383.9, 392.3, 352.2)

after <- c(200.1, 190.9, 192.7, 213, 241.4, 196.9, 172.2, 185.5, 205.2, 193.7)

# Create a dataframe object `df`
df <- data.frame(group = rep(c("before", "after"), each = 10),
                 bsl = c(before,  after))

# View our data
View(df)

# Attach our data
attach(df)
```

## **SUMMARY STATISTICS**

```{r}
summary(bsl[group=="before"])
summary(bsl[group=="after"])
```

## **PAIRED T-TEST ASSUMPTIONS**

1.  Paired samples.

2.  Random sampling: The sample obtained is a random sample of the population.

3.  Large sample.

4.  Normality: The differences in before and after values are approximately normally distributed.

    ```{r}
    # Calculate the differences and store it in object `d`
    diff <- with(df, 
            bsl[group == "before"] - bsl[group == "after"])

    # Shapiro-Wilk normality test for the differences
    shapiro.test(diff)
    ```

## **PAIRED T-TEST**

```{r}
# Perform the t-test and store the results in an object `tt`
ptt <- t.test(bsl ~ group, 
             paired=T)

# Reports the results of the t-test
report(ptt)
```

## PLOTS

```{r}
# Plots a simple mean and confidence interval plot for the `bsl` before and after the intervention`
ggline(data=df, 
       x="group", 
       y="bsl", 
       add="mean_ci",
       size = 1)

# Plots a boxplot for the `bsl` before and after the intervention
ggboxplot(data=df, 
          x="group", 
          y="bsl")

# Creates an object of class paired
pd <- paired(before, after)

# Plots paired data points
plot(pd, type = "profile") + theme_bw()
```
