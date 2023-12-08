# Installation
To install the CS599Kmeans.DAA package from the GitHub repository, follow these steps:

Open your R console or RStudio.
Make sure you have the remotes package installed. If not, install it by running

```
   install.packages("remotes")
```
   
Run the following command to install the package
```
remotes::install_github("DorisAmoakohene/K-means-Pkg-for-CS599")
```
# Example Usage
Here's an example of how to use the package (CS599Kmeans.DAA):

# Generate a test dataset

```
set.seed(123)
data.matrix <- matrix(rnorm(300), ncol = 2)

# Perform K-means clustering
K <- 3
result <- KMEANS(data.matrix, K)

# Print the cluster assignments and centers
print(result)
```
