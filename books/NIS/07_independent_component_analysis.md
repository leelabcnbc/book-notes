# Independent Component Analysis

Feb. 16, 2016  
Yimeng Zhang

This chapter gives the a formal, probabilistic framework of sparse coding called Independent Component Analysis.

Results from sparse coding chapter (chapter 6) are JUST ICA (look at the code).


## 7.1 Limitations of the sparse coding approach

this is just theoretical limitations. In practice we are already doing ICA in chapter 6.

3 limitations:

1. theory for the nonlinear function h. THIS is solved (unsatisfactorily) at 7.7.2
2. theory for why using decorrelation. THIS is solved at "bottom notes in pp.163" (check **"7.3.1 Why whitening does not find independent components**" in this document). 
3. theory for giving a probability distribution. THIS is solved at 7.4.
    
## 7.2 Definition of ICA

### 7.2.1 Independence

pp. 161 Eq. (7.2) shows that if the two variables s1 and s2 were independent, any nonlinear transformation of the outputs would be uncorrelated as well. This can be proved by definition of independence (7.1), plugging that in the definition of expectation (so the integral can be separated for two variables).

### 7.2.2 Generative Model

pp. 161 Eq. (7.3) is the generative model of ICA. A are the generative features. However, in practice, the inverse of A, or W in the text, is directly estimated.

Some notes about Eq (7.4):

> basically, we assume we have components as many as image pixels; and the transformation matrix is invertible.  
> This is always possible, if we make A invertible (A being a square matrix).  
> In practice, we don't do this… we can get W, but W is not invertible...
>
> In matrix notation, this is s = W^T * I.

### 7.2.3 Model for preprocessed data.

There's some complication when dealing with preprocessed data. I think ICA only cares about what invertible transformation, so ICA is done on n-D preprocessed data z, and learn feature detector (or receptive field) V.

In order to visualize feature detector in the image space, we concatenate whitening and V to get W = V*U, where U is the whitening matrix. But this is just a small nuisance due to PCA. So the problem that we never have a A in Eq. (7.3) that can represent the image faithfully is not a problem: A in Eq. (7.3) should really be the B in Eq. (7.5), which is square and all the nice properties follow.

1. pp. 162 Notes for (7.5):
    
    > z = U I
    > 
    > Let I be the original image vector, U be the whitening matrix.
    > 
    > then, actually, we should have I = A * s
    > 
    > then, z = U I = U A s., and we let UA to be B.
    > 
    > and the inversion of B is V, so s = V z.
    > 
    > W = V * U. so this is a NxM matrix, where N < M.
    > 
    > But this will give difficulty in computing A. (feature vectors, not receptive fields W).

2. pp. 162 Notes for (7.6):
    
    > expressing z as U * I(x,y), where U is PCA whitening matrix.
    > 
    > So W = V*U somewhat.
    >
    > In practice, we solve feature detector V in the whitened space, and we can then get W easily. But here getting A is still difficult. Usually, we use pseudo inverse.
    
## 7.3 Insufficiency of second-order information

summary of 7.3.

* 7.3.1: whitening (using only 2nd order stat) can't get the correct inverse mixing matrix (W), for some independent distribution of latent variable.
* 7.3.2: If latent variable has Gaussian distribution, then we can get the (infinitely) correct mixing matrix just using PCA whitening, and 2nd order stat
* If latent variable is really Gaussian, then ICA is 1) having infinitely many solutions 2) not adding anything new to PCA whitening.
* In order for ICA to make a difference, the underlying model must be non Gaussian.

### 7.3.1 Why whitening does not find independent components

1. pp. 163 One computational reason that ICA can't be done only using covariance is that the constraints imposed by covariance matrix is too few. n(n+1)/2 covariance matrix entries vs. n^2 entries for mixing matrix in ICA.
    * I think these constraints are linear, so we have a linear system with more variables than equations. No solution or many solutions...
2. pp. 163 Figure 7.1 shows the insufficiency of whitening. This example is valid because it follows our assumption of the model.
    * We start from some factored distribution, and we mix it (linearly) to get the observed distribution, and we want to return it back.
3. some notes for Figure 7.1:
    
    > In b, horizontal is z1, vertical is z2. 
    > In c, horizontal/vertical should be s1/s2 ideally?
    > 
    > Actually, if you rotate c) counterclockwisely about 150 degrees, you will find that will be exactly a). actually, if our only criteria is uncorrelated, any rotation will do.
    > 
    > a and c are just rotations of a same thing.

4. "bottom notes in pp. 163". This answers why we ask for uncorrelated outputs, because this is a necessary condition for independence of outputs, which are assumed by ICA model.

    > ICA can be thought as finding a whitening matrix W + finding the correct rotation R. The correct inverse mixing matrix can be always decomposed as an arbitrary whitening matrix and a rotation.
    > 
    > a whitening matrix W is easy to find, and it's not necessarily orthogonal. R is orthogonal. So the inverse mixing matrix W * R (or R * W whatever) is not orthogonal.
    > 
    > Since we can decompose ICA into 2 steps, we first whiten the data, finding a W, and then find R, constraining the rotation matrix to be orthogonal (certainly).
    > 
    > So in general, we should optimize under the constraint that features are uncorrelated (necessary condition for independent). 
    > In whitened data, this is easier.
    > constraining features to be uncorrelated is the best we can do to guarantee independence.

5. As said in the last note, ICA can be thought as finding a whitening matrix W + finding the correct rotation R. this means that, we can start from any whitening matrix, and try to find a rotation (actually orthogonal) matrix, to find the inverse of the original mixing matrix. In particular, we need to show that, starting with PCA whitening matrix, we can always get the correct whitening matrix (or the inverse mixing matrix) by multiplying some orthogonal matrix. This is shown in [proof that orthogonal rotation can convert PCA whitening to original whitening.txt](./proof that orthogonal rotation can convert PCA whitening to original whitening.txt)
    * the proof given is a little convolved. By using the definition of whitening `V^T B^T B V = I`, it can be shown that no matter what `V` is used to whiten (not just the PCA one), a rotation can always be found (`R=V^{-1} B^{-1}`).
    * In the proof, everything is square, as PCA dimensionality reduction is just some nuisance of ICA on natural images.
6. the inverse of the mixing matrix is what we are directly working on, trying to optimize.

### 7.3.2 Why components have to be non-gaussian

basically, if we assume the model (variable s_i's) is Gaussian, then actually every solution (rotation) is ONLY based on the covariance matrix, which is just identity in the case of whitened data. Figure 7.2 on pp. 165 shows the shape that ALL Gaussian white distribution would take, so "**there is no way to distinguish the right rotation from the wrong ones**".

In addition, as mentioned in 7.3.2.2, uncorrelated and independent are the same for Gaussian variables, so whitening has finished the search of independent components already, and our complicated ICA procedure makes no sense.

## 7.4 The probability density defined by ICA

From assumed distribution of latent independent components in Eq. (7.9), and the relationship between preprocessed white data and independent components (z = V * s), we have Eq. (7.13). Notice the scaling problem when substituting variables for probability density function. This is mentioned in top of pp. 167, and I have some notes for it.

> 7.12 wants to make p(x) \delta x = p(y) \delta y.  
> another explanation can be found in chapter 1 of PRML eq (1.27).

Notice that 7.13 is formulated in V, not the actual mixing matrix B, and they have relationship V*B=I, or more strongly, V=B^T for white data.

## 7.5 Maximum likelihood estimation in ICA

1. pp. 168 notes for Eq. (7.15). this note says why Gaussian prior is impossible for ICA.

    > this works because we have non Gaussian forms of prior. If we use gaussian prior (with constant variance). then second term reduces to 
    >
    > `\sum_i=1^N \sum_t=1^T (v_i^T z_t)^2.` = `trace( V^T Z^T Z V )` = `trace(Z^T Z V V^T)` = `trace(Z^T Z)` = constant, and there's nothing to optimize.
    > 
    > `(v_i^T z_t)^2` is the exponent term in the univariate Gaussian pdf, and summing this over all t and n is computing the sum of squares of elements in matrix Z V, , with z_t being columns of Z^T.   Z is of size T x N, and V of size N x N. `V* V^T = I`, and Z^T Z is some constant times identity matrix.
    > 
    > This means that as long as we choose gaussian prior and orthogonal transformation. Any choice gives us the same log L (v1,v2,…vn).
    >
    > This holds even Z is not white at all (i.e. Z^T Z is NOT a multiple of identity matrix). But if we do so, V being orthogonal is meaningless, since we want to optimize (7.15) under the constraint that transformed features `S = Z*V` is white, and if we use arbitrary orthogonal V, generally, S can't be white.
    >
    > (because we assume v is orthonormal, so any combination `v_i^T z_t` has a variance of 1, so we omit that. Notice that in this case, no matter what v we choose, **`log L` doesn't change at all**.

## 7.6 Results on natural images

Fig. 7.3 shows the generating features A rather than feature detectors W. This is actually done by pseudoinverse (or, equivalently, simply inverse of V multiplied by the pseudoinverse of whitening matrix) as mentioned in Section 7.11 of the book. I guess these two ways of constructing pseudoinverse can be proved to be equivalent using <https://en.wikipedia.org/wiki/Moore%E2%80%93Penrose_pseudoinverse#Singular_value_decomposition_.28SVD.29>.

## 7.7 Connection to maximization of sparseness

### 7.7.1 Likelihood as a measure of sparseness

Here they are trying to interpret the Eq. (7.15) (the objective function) as maximizing sparseness, through Eq. (7.16) and Eq. (7.17). notes for Eq. 7.17:

> this seems to assume that our `p_i` only depends on |s|, which is true if we assume the form of 7.16.

Eq. 7.19 is smooth version of 7.18. for the non smoothness, one way is to make the sharp peak a little smoother... 

### 7.7.2 optimal sparseness measures

Here we want to optimize (not fix beforehand) h as well.

I think here the approach taken just makes the log L(v1,v2,...) as large as possible. So this is the rationale for choosing h? 

in theory, you can treat the probability distribution of features as a hidden variable, and use an iterative approach to iteratively optimize hidden variables and the features.

As mentioned in pp. 172, to optimize both h and w, we do the follows.

> To really find the best nonlinearities, we could first maximize the likelihood using some initial guesses of the hi, then estimate the pdf's of the obtained independent components and recompute the hi according to Equation (7.17). In principle, we should then re-estimate the Wi using these new hi, re-estimate the hi using the latest Wi and so on until the process converges. This is because we are basically maximizing the likelihood with respect to two different groups of parameters (the Wi and the hi) and the real maximum can only be found if we go on maximizing one of the parameters groups with the other fixed until no increase in likelihood can be obtained. 

My notes on the above text and Figure 7.6 (which shows updated estimated h) is as follows. It seems that in the supplied code, this re-estimation is never done.

> how to re compute based on 7.17. What I know is that h(u) is a parametric model, and we can tune its parameters so that it looks like the histogram. In the code, I don't see such re estimation.
> 
> why we estimate `h_i ( p(s_i) )` using the histogram of `s_i`? because given a sample of a lot of `s_i`, the ML estimation of the probability function is certainly a probability function having this histogram as the underlying distribution.
> 
> 
> there's code for this... check!
> 
> First do ICA, and get some `s_i`. 
> 
> Then compute the histogram of 2 features `s_i` and `s_j`. that's all.

pp. 173 gives some alternative sparse prior distributions and give reasons why using these or histogram (empirical distribution) is bad.

pp. 174 more notes for caption of Fig. 7.6

* "**After doing ICA, the histograms of the component with the highest kurtosis and a component with kurtosis in the middle range were computed**": from the code, it seems that it just chooses one with a middle index? Are the output sorted? the code for mid-range is buggy.
* "**Third row: optimal h**": the so-called optimal `h_i` is just histogram for `s_i^2`.

In the end of pp. 174, it says that these more fancy distributions "are likely to be quite useful in Bayesian inference where we really do need a good probabilistic model." But HOW good?



## 7.8 Why are independent components sparse.

7.8.1 introduces two kinds of non-Gaussian: super and sub Gaussianity, and a third kind, skewness, which is related to symmetry.

7.8.2 it argues that sub-Gaussianity and high skewness are more less often than super-Gaussianity (sparseness). In particular DC, and low frequency components can be sparse, and if we use some ICA algorithm where some h likes both super and sub gaussian (or part of components being super and part of them being sub), then we will discover these components.

7.8.3 explains the dominance of sparseness to local variation.

## 7.9 General ICA as maximization of non-gaussianity

7.9.2 gives connection between independent and non-gaussian. By (informal) use of central limit theorem, it shows that there is correlation between being independent and being non-Gaussian, so the following principle for ICA is proposed near the end of pp. 178: "**find linear combinations ∑i wizi of the observed variables that are maximally non-gaussian.**" Due to the correlation between independence and non-Gaussian, we expect that maximally non-Gaussian mixture would be the true independent components. As mentioned in pp. 179, this is not formally true.
> 
> This is really only an intuitive justification and not exactly true.) Thus, the non-gaussianity of such a linear combination is maximal when it equals one of the original independent components, and the maximally non-gaussian linear combinations are the independent components.

More notes for 7.9.2:

> maximally non-gaussian linear combinations are single s_j, not combinations, like `0.3*s_1 + 0.7*s_2`, which according to an intuitive version of CLT, will be more Gaussian.

Summary of 7.9.3: sparse coding is treated as special case of ICA. sparse coding is ICA with non-gaussian function tuned to sparsity, not necessarily other non-gaussian.

## 7.10 Receptive fields vs. feature vectors

It points out that relation between A and W, is just that A are low-pass filtered version of W. Here, it's assumed that A and W are square.

1. pp. 180 notes for Eq. (7.31):
    
    > A is composed of N columns `A_i`. each `A_i` can be reshaped to get feature vectors.
    > 
    > 7.31 is just the inter product of two rows in A. (i is iterating over N columns)

2. pp. 181 notes for Eq. (7.32):

    > In 7.32, we first have a covariance matrix, computed by (7.31), and here, we compute the inner product of one row of covariance matrix and one column in W.
    
    > `x = As, s = A^{-1} x = W^T x`. by our definition of ICA analysis function.
    > 
    > `C = A*A^T`. This is repeating what (7.31) says, `E(xx^T)=C`.
    >
    > `C*W = A*A^T*W = A`. This is the matrix version of (7.32).
    >
    > `A*W^T = I.  W*A^T = I. A^T * W = I`, by definition of `W` and property of inverse matrix.
    
3. pp. 181 notes for "**Such multiplication by the covariance matrix has a simple interpretation as a low-pass filtering operation.**" This in the low-pass filtering interpretation of `C*W_i`, where `W_i` is one column in W, and by (7.32), we have `C*W_i=A_i`. Notice this C is shift invariant, so multiplying it with `W_i` is basically filtering `W_i` with that invariant template.
    
    > we can arrange each column (or row) of covariance matrix in to a square, and we should see a bright dot in the (x,y) position corresponding to this column, as in Figure 5.4. So, basically, we can think that Wi is convoluted (filtered) by this dot.

## 7.12 Frequency channels and ICA

the fact that V1 has frequency channels may be justified by that different channels are independent.

## 7.14 Exercises

a sample solution is at [here](./sample_solutions/sol_chap_07.pdf).
