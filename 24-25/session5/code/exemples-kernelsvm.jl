# from apxml.com/courses/julia-for-machine-learning/... chapter 3

# In the Julia REPL, press ']' to enter Pkg mode
# pkg> add MLJLIBSVMInterface
# Press Backspace to exit Pkg mode

using MLJ
using DataFrames, Random, StableRNGs

# Load the Support Vector Classifier (SVC) model type from MLJLIBSVMInterface
# modest=false returns the model type itself, not an instance.
SVC = @load SVC pkg=LIBSVM modest=false
# For a dedicated linear SVM, which can be faster if data is linearly separable:
LinearSVC = @load LinearSVC pkg=LIBSVM modest=false

# For reproducibility, use a stable RNG
rng = StableRNG(123)

# Generate synthetic 2D data for classification
# X will be features, y will be categorical labels
X_raw, y = make_blobs(150, 2; centers=2, cluster_std=0.9, rng=rng, as_table=false)
X = DataFrame(X_raw, :auto) # Convert to DataFrame for MLJ

# Instantiate a linear SVM model
# LinearSVC is often faster for linear problems.
# It internally uses LIBSVM's linear solver.
linear_svm_model = LinearSVC(cost=1.0) # 'cost' is the C parameter

# Alternatively, using SVC:
# linear_svm_model = SVC(kernel=LIBSVM.Kernel.LINEAR, cost=1.0)

# Create an MLJ machine
mach_linear_svm = machine(linear_svm_model, X, y)

# Train the machine
fit!(mach_linear_svm, verbosity=0)

# Make predictions
y_pred_linear = predict_mode(mach_linear_svm, X)

# Evaluate (evaluation metrics are covered in detail in another section)
# For example, calculate misclassification rate:
accuracy_linear = accuracy(y_pred_linear, y)
println("Linear SVM Accuracy: $(round(accuracy_linear, digits=3))")


# Instantiate an SVM model with an RBF kernel
rbf_svm_model = SVC(kernel=LIBSVM.Kernel.RADIAL, # RADIAL is RBF
                    cost=1.0,      # Regularization parameter C
                    gamma=0.5)     # Kernel coefficient for RBF

# `LIBSVM.Kernel` provides access to kernel types:
# LIBSVM.Kernel.LINEAR, LIBSVM.Kernel.POLY, LIBSVM.Kernel.RADIAL, LIBSVM.Kernel.SIGMOID

# Create an MLJ machine
mach_rbf_svm = machine(rbf_svm_model, X, y)

# Train the machine
fit!(mach_rbf_svm, verbosity=0)

# Make predictions
y_pred_rbf = predict_mode(mach_rbf_svm, X)

accuracy_rbf = accuracy(y_pred_rbf, y)
println("RBF Kernel SVM Accuracy: $(round(accuracy_rbf, digits=3))")


# println(params(rbf_svm_model))
