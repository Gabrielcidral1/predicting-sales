# Problem description

The sales team has concerns about ongoing product sales in one of the stores. Specifically, they asked us to redo our previous sales prediction analysis, but this time including the ‘product type’ attribute in predictions to understand how specific product types perform against each other. This will help the sales team better understand how types of products might impact sales across the enterprise.

# Assignment objectives

•	Predicting sales of four different product types: PC, Laptops, Netbooks and Smartphones

•	Assessing the impact services reviews and customer reviews have on sales of different product types	
  o	 A chart that displays the impact of customer and service reviews have on sales volume

# Key Findings

•	Product category is not a relevant variable to predict sales volume. 

•	4 star review and positive service review are the best variables to predict sales volume.

•	New potential products have price conflict with the existing ones.

•	As the distribution of sales volume is not normal and the sample is small, the predictions in this report are limited in scope and should be taken just as a reference. In order to have a powerful decision making, it should be combine with a descriptive analysis and a better understanding of the market.

# Preprocessing

## Impact of product type to predict volume

Before including product type in the variables to predict sales volume, some tests can confirm if the two variables are indeed correlated. The below shows the correlation of the dummy product categories against sales volume. The first conclusion is that there is no correlation, with exception to Game Console. This high correlation is biased as there are only two observations of this product in the existing product list. 

Table: Correlation between product type and volume

![image](https://user-images.githubusercontent.com/33734080/44286649-1a85a780-a26a-11e8-89d5-46b2e70d5121.png)

Also, running a simple decision tree to predict volume, it shows that 4 star review and Positive Review are the most reliable variables, and not the product category.

Decision tree: Relevant variables to predict sales volume

![image](https://user-images.githubusercontent.com/33734080/44287155-0cd12180-a26c-11e8-99fd-3f42a99562a2.png)

## Attributes correlation

5 star review has a perfect correlation to volume. As this is in practice impossible, the former was considered wrong and excluded. 
Also, attributes highly correlated (above 0.85) represents collinearity and can create noise to the model. 

![image](https://user-images.githubusercontent.com/33734080/44287188-2bcfb380-a26c-11e8-854d-bf317011f3bd.png)

The remaining indicators with high correlation to sales volume are: 4 star review and Positive Service Review. 

## Outliers treatment

There are two outliers, which were excluded from the model as they don’t represent the standard sales behavior. 

Graph: Distribution of sales volume

![image](https://user-images.githubusercontent.com/33734080/44287053-aba94e00-a26b-11e8-98e9-282fdb511acf.png)

## Creation of training and testing sets

As the distribution of the sales volume is not normal, the split between training and testing sets could strongly impact and jeopardize the results.  Using the Set.seed() function, several random numbers were tested in order to have a similar training and testing distributions. The final data is displayed below, which still contain differences, but at a low level. 

Graph: Distribution of training set

![image](https://user-images.githubusercontent.com/33734080/44287229-5a4d8e80-a26c-11e8-8107-81d6b0b890b4.png)

Graph: Distribution of testing set

![image](https://user-images.githubusercontent.com/33734080/44287275-7cdfa780-a26c-11e8-8798-44f4e19eeff8.png)

# Modeling

Running the models in the training and testing sets, the results are summarized below (direct export from R in appendix):

Table: R2 per method

Method | R2 – Model | R2 - Predicted | Average R2
-- | -- | -- | --
Random Forest | 0.935 | 0.784 | 0.8595
Gradient Boosted Machine | 0.826 | 0.790 | 0.808
Support Vector Machine | 0.768 | 0.721 | 0.7445
Knn | 0.924 | 0.630 | 0.777
Linear | 0.797 | 0.729 | 0.763

The two best models were selected according to the average R2 (Random Forest and Gradient Boosted Machine). They were both applied to the new product list in order to predict sales volume. The final sales volume is an average of both model results.

Table: Rank of best products 

Rank | Product   Type | Product   Num | Price | x4StarReviews | Positive   ServiceReview | Volume   - rf | Volume   - gbm | Volume   - avg
-- | -- | -- | -- | -- | -- | -- | -- | --
1 | Netbook | 180 | 329 | 112 | 28 | 1,114 | 1,189 | 1,152
2 | Smartphone | 194 | 49 | 26 | 14 | 610 | 891 | 750
3 | PC | 171 | 699 | 26 | 12 | 467 | 811 | 639
4 | Laptop | 173 | 1,199 | 10 | 11 | 197 | 803 | 500
5 | Smartphone | 193 | 199 | 26 | 8 | 311 | 401 | 356
6 | PC | 172 | 860 | 11 | 7 | 118 | 167 | 143
7 | Smartphone | 196 | 300 | 19 | 5 | 141 | 41 | 91
8 | Smartphone | 195 | 149 | 8 | 4 | 79 | 82 | 81
9 | Netbook | 181 | 439 | 18 | 5 | 117 | 32 | 74
10 | Netbook | 178 | 400 | 8 | 2 | 47 | 54 | 50
11 | Laptop | 175 | 1,199 | 2 | 2 | 38 | 42 | 40
12 | Netbook | 183 | 330 | 4 | 1 | 34 | 39 | 36
13 | Laptop | 176 | 1,999 | 1 | - | 6 | 39 | 23

# Descriptive analysis on product type

Graph: Price comparison of new vs existing products

![image](https://user-images.githubusercontent.com/33734080/44278517-76dace00-a24e-11e8-99a7-3c9dd52b578a.png)

Looking at the graph above, it seems that Blackwell is adding products in the same price range than the current portfolio. The management should assess if it will give more options to clients and increase sales or if it will just create brand cannibalization. 
On the other hand, when looking at the laptop category, the new product is substantially more expensive than the average. The company should analyze its positioning and evaluate if customers are indeed looking for higher quality product for a higher price. 

