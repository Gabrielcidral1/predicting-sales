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

![image](https://user-images.githubusercontent.com/33734080/44277418-e6e75500-a24a-11e8-9606-282ed54debe5.png)

Also, running a simple decision tree to predict volume, it shows that 4 star review and Positive Review are the most reliable variables, and not the product category.

Decision tree: Relevant variables to predict sales volume

![image](https://user-images.githubusercontent.com/33734080/44277434-f1a1ea00-a24a-11e8-8293-4c99617f7d4e.png)

## Attributes correlation

5 star review has a perfect correlation to volume. As this is in practice impossible, the former was considered wrong and excluded. 
Also, attributes highly correlated (above 0.85) represents collinearity and can create noise to the model. 


