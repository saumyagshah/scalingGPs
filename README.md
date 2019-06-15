# Scaling Up Gaussian Processes

**The detailed Project Report can be viewed in CS698X_ProjectReport.pdf.**

Course project for Topics in Probabilistic Modeling and Inference (CS698X), under Prof. Piyush Rai, Department of Computer Science and Engineering, IIT Kanpur

The Gaussian Processes (GPs) is a very popular method for Bayesian non-linear Regression and Classification. Due to the non-parametric nature of GPs there are computational problems at both training O(N^3) and test times O(N^2) and also it requires O(N^2) storage for a data with N inputs. So, it becomes a huge challenge for applying GPs to very large datasets. There are a different approaches to tackle this problem and in this project we studied and explored one such approach - Inducing Point Methods in detail. We implemented various approximations via Inducing points methods and compared these methods.

Another topic that we studied is learning kernels from data for Gaussian Processes to give better predictive performance as compared to other well known kernels. Using some standard kernels like the Squared Exponential Kernel (RBF kernel) allows use to learn very limited patterns in the data. We would like to study ways in which this can be resolved. Specifically, we are interested in studying kernels whose Fourier Transform is taken as a Gaussian Mixture.
