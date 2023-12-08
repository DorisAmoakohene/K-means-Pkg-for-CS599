
#' K-means Clustering Algorithm
#'
#' This function performs the K-means clustering algorithm on a given data matrix
#'
#' @param data.matrix The data matrix for the clustering
#' @param K The number of clusters
#' @param max_iters The maximum number of iterations for convergence
#'
#' @return A list containing the results of the K-means clustering algorithm
#' @export
#'
#' @examples
#' # Generate a test dataset
#' set.seed(123)
#' data.matrix <- matrix(rnorm(300), ncol = 2)
#' # Perform K-means clustering
#' K <- 3
#' result <- KMEANS(data.matrix, K)
#' # Print the cluster assignments and centers
#' print(result)
#'
#'
KMEANS <- function(data.matrix, K, max_iters = 100) {
  # Ensure data.matrix is a numeric matrix
  if (!is.matrix(data.matrix) || !is.numeric(data.matrix)) {
    stop("data.matrix must be a numeric matrix")
  }

  NROWS <- nrow(data.matrix)
  NCOLS <- ncol(data.matrix)

  # Randomly initialize cluster centroids
  initial_centroids <- data.matrix[sample(1:NROWS, K), , drop = FALSE]

  # Initialize cluster assignments and centroid matrix
  cluster_assignments <- rep(0, NROWS)
  centroids <- initial_centroids

  for (iter in 1:max_iters) {
    # Assign each example to the nearest centroid
    distances <- matrix(NA, nrow = NROWS, ncol = K)
    for (k in 1:K) {
      diff_matrix <- sweep(data.matrix, 2, centroids[k, ], "-")
      distances[, k] <- rowSums(diff_matrix^2)
    }
    labels <- apply(distances, 1, which.min)

    # Update centroids
    new_centroids <- matrix(NA, nrow = K, ncol = NCOLS)
    for (k in 1:K) {
      cluster_data <- data.matrix[labels == k, ]
      if (nrow(cluster_data) > 0) {
        new_centroids[k, ] <- colMeans(cluster_data, na.rm = TRUE)
      } else {
        new_centroids[k, ] <- centroids[k, ]
      }
    }

    # Check convergence
    if (all(cluster_assignments == labels)) break

    centroids <- new_centroids
    cluster_assignments <- labels
  }

  # Calculate the within-cluster sum of squares
  within_cluster_sumsq <- sum(rowSums((data.matrix - centroids[cluster_assignments, ])^2))

  # Return the result similar to stats::kmeans function
  result <- list()
  result$cluster <- cluster_assignments
  result$centers <- centroids
  result$tot.withinss <- within_cluster_sumsq
  result$iter <- iter

  return(result)
}
