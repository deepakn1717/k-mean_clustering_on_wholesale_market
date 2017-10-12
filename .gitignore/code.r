# The data set refers to clients of a wholesale distributor. 
# It includes the annual spending in monetary units (m.u.) on diverse product categories
# Load the data from specific folder
Customer_Data <- read.csv("C:\\Users\\deepa\\Desktop\\Edureka\\Wholesale customers data.csv", header=TRUE )
str(Customer_Data)
summary(Customer_Data)
 
# Only Numeric data
Customer_Data_Num <- Customer_Data[ , c(-1, -2)]
class(Customer_Data_Num)

# Standardizing the variables
Customer_Data_Num_scale <- as.data.frame(scale(Customer_Data_Num))
# (Customer_Data$Fresh[1] - mean(Customer_Data$Fresh))/sd(Customer_Data$Fresh)

class(Customer_Data_Num_scale)
names(Customer_Data_Num_scale)
# Apply Weight on a specific variable.
Customer_Data_Num_scale$Grocery_Wt <- Customer_Data_Num_scale$Grocery * 3

Customer_Data_Num_scale <- Customer_Data_Num_scale [ , -3]
names(Customer_Data_Num_scale)
# Optimal Number of clusters 
mydata <- Customer_Data_Num_scale
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

# Set the random seed value, to reproduce the same result -----------------
set.seed(1001)

# Run Kmeans clustering with specified number of clusters.  ---------------
clustercustomer = kmeans(Customer_Data_Num_scale, 6) 
clustercustomer

# Combined cluster number with the "ORIGINAL" data set --------------------
Customer_cluster_Final <- cbind(Customer_Data, Cluster_Number = clustercustomer$cluster)
names(Customer_cluster_Final)

# Profiling of clusters ---------------------------------------------------
tapply(Customer_cluster_Final$Fresh, Customer_cluster_Final$Cluster_Number, mean)
tapply(Customer_cluster_Final$Milk, Customer_cluster_Final$Cluster_Number, mean)
tapply(Customer_cluster_Final$Grocery, Customer_cluster_Final$Cluster_Number, mean)
tapply(Customer_cluster_Final$Frozen, Customer_cluster_Final$Cluster_Number, mean)
tapply(Customer_cluster_Final$Detergents_Paper, Customer_cluster_Final$Cluster_Number, mean)
tapply(Customer_cluster_Final$Delicassen, Customer_cluster_Final$Cluster_Number, mean)

