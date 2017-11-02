# Sparse Coding and Simple Cells

Feb. 16, 2016  
Yimeng Zhang

This chapter gives an intuitive understanding of ICA (a flavor of sparse coding), and the results shown in this chapter will be formulated more formally in Chapter 7 of the book.

## 6.1 Definition of sparseness

1. pp. 137 sparseness is not small variance.
    
    > It is very important to distinguish sparseness from small variance. When we say “very close to zero”, this is relative to the general deviation of the random variable from zero, i.e. relative to its variance and standard deviation. Thus, “very close to zero” would mean something like “an absolute value that is smaller than 0.1 times the standard deviation”.

2. pp. 138 a sparse distribution with peak at zero must have some heavy tail to make the variance normalized to unity. Fig. 6.1 shows this well.

    > the peak at zero must be compensated by a relatively large probability mass at large values; a phenomenon often called "heavy tails".
    
## 6.2 Learning one feature by maximization of sparseness

1. pp. 139 Eq (6.2) gives the basic framework of measuring sparseness (I guess they use s squared as baseline for 1) variance is normalized, and 2) thus only amplitude of response matters, not sign). On top of pp. 140, it says that we can design h to be either focus on peaked zero or heavy tail, as unit variance will compensate the other.

    > We can choose h so that it emphasizes values that are close to zero, or values that are much larger than one. However, it may not be necessary to explicitly measure both of them, because the constraint of unit variance means that if there is a peak at zero, there has to be something like heavy tails to make the variance equal to unity, and vice versa.

2. pp. 140 Eq. (6.5). Kurtosis can be a measure of sparseness, but it's sensitive to outliers.
3. pp. 141 Generally, convex h can be used. Notice that it's convex when s squared is the argument, not necessarily s itself. This I guess is due to the fact we already normalized s squared.
4. pp. 143 Eq. (6.16), (6.17) give the general framework of sparse feature learning, and (6.18) and (6.19) are for the case of canonically preprocessed data.
5. pp. 145, maximally sparse features are not unique, as for PCA. This ambiguity comes naturally from spatial invariance of natural image. Fig. 6.5 show some examples. 

    > it is natural to assume that the sparsenesses of the two features must be equal, since the properties of natural images should be the same in all locations. The fact that sparseness has many local maxima forms the basis for learning many features.

## 6.3 Learning many features by maximization of sparseness

### 6.3.3 Sparseness of feature vs. sparseness of representation



The whole page of pp. 149 should be understood as follows.

1. (6.27) and (6.28) are exactly the same.
2. without proper constraint, (6.27) (or 6.28) doesn't represent anything. 
3. If we have the constraints 1&2 on this page, we are optimizing the sparseness of representation.
4. if we make every feature have same variance, we make optimizing sparseness of feature.
5. if we have many images & features, somehow (seeming logic is missing here), features are independent, and have same distribution, and 3 & 4 can be satisfied at the same time. Thus we are optimizing both representation and feature.

1. pp. 149 footnote 4 gives an example where population sparseness  (sparseness of representation) is different from lifetime sparseness (sparseness of feature) .

1. In the middle of pp. 149, sparseness of population is justified as follows.

    > In particular, if the features are statistically independent and identically distributed (see Section 4.5), the conditions will be approximately fulfilled by the law of large numbers — the basic statistical law that says that the average of independent observations tends to the expectation.
    
    * The first part of this statement (if the features are statistically independent and identically distributed) is simply an assumption, and the second part (the conditions will be approximately fulfilled by the law of large numbers) follows from this assumption, because If features have the same distribution and are independent, then features from one image are just random sample of this distribution. Certainly they should have zero mean and constant variance.

2. additional notes for the two constraints in pp. 149.
    
    > when we compute the sparseness of a feature, we assume its distribution has zero mean and unit variance.
    > 
    > When we compute the sparseness of the representation of a single image, we also need that the representation is somewhat normalized (mean and var of features (from THIS image) is 0 and 1, respectively).
    > 
    > so, if we learn N receptive fields, what these constraints say is that the response of these N features should have zero mean and unit variance.
    > 
    > this assumptions make sure that the result of 6.26  is comparable for different solutions, with the same mean and variance.

3. for (6.27), only the two constraints hold can we say that 6.27 represent sparseness of features.

## 6.4 Sparse coding features for natural images

### 6.4.1 Full set of features.

Here features are learned through FastICA, and non-linearity is log cosh. However, in the ICA code available, tanh is used. For detail, see Chapter 18 (section 18.7) for detail.

### 6.4.2 Analysis of tuning properties

The code for the (phase, frequency, orientation) analysis here might be useful. 

In pp. 152, it's mentioned that real neurons are also tuned to temporal frequency of the grating, yet here don't need to care about it.

## 6.5 How is sparseness useful?

Some arguments in favor of sparseness are given here.

## 6.7 Exercises

a sample solution is at [here](./sample_solutions/sol_chap_06.pdf).
