# Principal components and whitening

Feb. 15, 2016  
Yimeng Zhang

## 5.1 DC component or mean grey-scale value

1. pp. 97 Eq. 5.1 notice this is subtracting the mean of all pixels in a patch, not the mean of a single pixel location over all patches considered. But assume the assumption in Exercise 1 of this chapter, the mean at every pixel location should be zero.
2. pp. 98 just above Fig 5.1. For DC-removed images, mean of any feature s is zero. This is proved in the solution.


## 5.2 Principal component analysis

1. pp. 99 definition of second order structure is given

    > More specifically, PCA considers the second-order structure of natural images, i.e. the variances and and covariances of pixel values I(x,y).
    
2. pp. 100 top importance of DC removal to discover the "true" correlation among pixels. Check Fig. 5.4. Without removing DC, the correlation is dominated by the overall brightness of different images. Here Fig. 5.4 is computed as the correlations of the central pixel and the others over all images. I guess the same is the same for Fig 5.3.

    > without DC removal, all the correlation coefficients are strongly positive. Re- moving the DC components reduces the correlations to some extent, and introduces negative correlations.
    
3. pp. 103 Definition of PCA with multiple components. Below (5.8), the authors point out that uncorrelatedness of features and orthogonality of feature detectors (W) are the same.

    > An interesting property is that any two principal components are uncorrelated, and not only orthogonal. In fact, we could change the constraint in the definition to uncorrelatedness, and the principal components would be the same.
    
    * This can be proved.
    * First we do a eigendecomposition of covariance matrix C = S \Lambda S^T = X^T X, where S saves columns of eigenvectors, and X is a N x D matrix, saving N (centered) data points of dimension D.
    * given the first component being V, and we know that it must be some column of S (regardless of sign), and let this column be k, and V = (+/-) S_k.
    * we want to find the second component W, so that the features are uncorrelated, i.e. `W^T X^T X V = 0. Let C = X^T X = S \Lambda S^T` , we have `W^T S \Lambda S^T V = W^T S \Lambda [ 0 0 ... 1 ... 0 0 ]' =  W^T S [0, 0, ... , \lambda_k, 0, 0, 0 ] = \lambda_k W^T S_k =  \lambda_k W^T V`.
    * This is equal to zero if and only if W and V are orthogonal (certainly I assume all lambda are positive, this is definitely true if data is sufficient).
    * This equivalence is consistent with the fact that after PCA, features are uncorrelated (diagonal covariance matrix).

4. pp. 103 Critique of the definition. Notice that this definition is not well defined, so only the subspace defined by top components, not the feature detectors themselves are useful. Check Fig 5.8

    > So, not only we cannot say what is the order of the components, but actually there is an infinite number of different components from which we cannot choose the "right" one.
    
    > Thus, we cannot really say what the 100th principal component is, for example, because the result we get from computing it depends so much on random sampling effects. This will be demonstrated in the experiments that follow.
    
    > In fact, most of the features do not seem to be really well defined for the reason explained in the previous section: the variances are too similar for different features. For example, some of the possible 100th principal components, for different random sets of natural image patches, are shown in Figure 5.8. The random changes in the component are obvious.

5. pp. 107 Eq. (5.10) establishes the somewhat equivalence between DFT and PCA in this special case of covariance matrix. The proof in Section 5.8.2 works only for infinitely large matrix.
6. pp. 108 Another interpretation of PCA is given in Section 5.6, that is, through power spectrum.

    > An alternative viewpoint is that you could also consider the computation of the principal components as doing a Fourier analysis of the covariance matrix of the image patch; this interesting connection will be considered in Section 5.6.
    
## 5.3 PCA as a proprocessing tool

1. pp. 109 for PCA, the subspace matters, not the feature detectors.

    > Returning to the case of image data, we can rephrase this result by saying that it is the set of features defined by the n first principal components and their linear combinations that is (relatively) well defined, and not the features themselves.
    
2. pp. 110 PCA can do whitening (removal of variance or covariance) and this can be used to let our later coding algorithm focus on properties unrelated with covariance, such as sparseness.
3. pp. 110 Section 5.3.2.2 There are many whitening transformations. Also, for whitened data, uncorrelatedness and orthogonality are the same.

    > In later chapters, we will often use the fact that the connection between orthogonality and uncorrelatedness is even stronger for whitened data. In fact, if we compute two linear components ... they are uncorrelated only if the two vectors v and w (which contain the entries vi and wi, respectively) are orthogonal.
    
    > In general, we have the following theoretical result. For white data, multiplication by a square matrix gives white components if and only if the matrix is orthogonal.
    
    * this is because, for white data, the covariance matrix is just Identity matrix, and the new transformed data's covariance matrix is just `W*W^T` (or `W^T * W`, depending on how you define transformation matrix `W`).
    * when we compute `E[ (\sum_i v_i s_i ) (\sum_j w_j s_j) ]`, because s is white, we are left with `E \sum_i s_i^2 w_i v_i`, which is `\sum w_i v_i`. Cross terms disappear, and pure quadratic terms have value 1 (notice all s have zero mean so centering is already done). [all sum is done over pixels of the image]
    * Getting uncorrelated features if and only if `\sum w_i v_i = 0`, so if and only if orthogonality of feature detectors.
    * this is stronger than the statement under (5.8) on pp. 103 because in that case we fixed one vector to be eigenvector. (well in this case anything is eigenvector).
4. pp. 111 anti-aliasing of PCA. Aliasing has the following definition by Wikipedia:
    > In signal processing and related disciplines, aliasing is an effect that causes different signals to become indistinguishable (or aliases of one another) when sampled. It also refers to the distortion or artifact that results when the signal reconstructed from samples is different from the original continuous signal.
    
    * in Figure 5.11, the author says that oblique orientation can sample with higher frequency than in horizontal or vertical orientation. I think this is bad in the following sense.
        * aliasing can always be there due to finite sampling, and we don't know the ground truth of the Nyquist frequency of the natural scene.
        * However, it is unacceptable that this aliasing effect is anisotropic. Since oblique orientation has higher sampling rate, it means that higher frequency patterns can be detected along the oblique orientation, but not the horizontal or vertical orientation. This means that the frequency representation of the image has some bias in favor of oblique and against horizontal / vertical orientations. Thus, it's better to simply make all orientations have roughly the same (low) highest possible frequency, and this can be roughly done by throwing small components in PCA.
    * Another issue of keeping high frequency things is that they can only have two phases as described in Section 5.3.3.2. This poses some problem on computing tuning curves, etc. It has nothing to do with the representational power with only 2 phases, but a practical issue in the context of natural image analysis.
    * When first reading this part, I don't understand what that oblique grating is. I want to make it clear now.
        * Figure 5.11 is just a checkerboard pattern, each black or white square having side length of 1. The orientation of the oblique grating is 45 degrees, and one full cycle of it is from the center of one square to the center of another same-colored square on its bottom right. The distance between these two centers is sqrt(2), and half cycle is sqrt(2)/2 or sqrt(1/2). Notice that, the black and white part of the grating is sampled in a zigzag fashion.

## 5.4 Canonical preprocessing used in this book

I really think it's good to follow this preprocessing pipeline, which has been tested to work well for many scene statistics tasks.

1. pp. 114 "Notation" in the end: Notice that after preprocessing, we transform each image from a **high** dimensional vector to a **lower** dimensional vector z of length n, and this n is smaller than number of pixels in the original patch.

## 5.5 Gaussianity as the basis for PCA

Here the authors point out that PCA has an underlying Gaussian assumption, and gives a way to generate samples from the PCA eigenvectors and eigenvalues (pp. 116). However, I think it's more accurate to say that PCA considers the same set of info as a Gaussian model does, but whether PCA assumes a Gaussian distribution is another problem. Indeed, PCA can be formulated in the more general framework of factor analysis, which has Gaussian assumption. **So PCA can be seen as solution to some Gaussian-based model.**

* Notice that for the data generation method in pp. 116, if we choose all components, the resultant distribution has the same covariance matrix as the training set; if using only top components, then the resultant distribution is somehow degenerate (the resultant covariance matrix can't be invertible).

## 5.6 Power spectrum of natural images

This considers whitening from the frequency domain.

1. pp. 118 1/f Fourier amplitude or 1/f^2 power spectrum of natural images. Notice that definition of power spectrum is **square** of amplitude!
2. connections among power spectrum of image and covariance matrix and Gaussianity.
    1. Due to translation invariance of covariance matrix, every covariance matrix (it's matrix because images are not vectorized) of one pixel to others should be the same. This shared covariance matrix is called autocorrelation function (well it should be better called autocovariance, since the function is not normalized by standard deviations; this confusion is due to different definitions of autocorrelation in different communities, here the unnormalized (so it's covariance) version is used).
    2. the FT of this covariance matrix (autocorrelation function) is power spectrum.
    3. so power spectrum <-> covariance matrix of single pixel <-> the whole covariance structure of images <-> underlying Gaussian model (only covariance considered).
3. Notice that since power spectrum (or covariance matrix) is only a function of the amplitude of FT, this means that phase info is not used, as shown in Fig 5.16.
4. The connection of power spectrum and covariance matrix is the foundation of 1/f whitening in Olshausen's 1996 and 1997 sparse coding papers, and this will be explained in more detail in Section 5.9.
5. This section assumes that natural image is a wide-sense stationary process, so that the statistics between pixels only depend on their relative locations (thus autocorrelation is well-defined), and average power spectrum is computed as follows.
    1. compute the power spectrum of each image
    2. average the power spectrum over all images.
6. For more detail over definition of power spectrum, and Wiener-Khinchin theorem, which is the basis for the connection, check the follows (local copies available). Notice that ideally, to compute power spectrum we should have infinitely large images, but this subtlety is ignored.
    * [https://en.wikipedia.org/wiki/Spectral_density#Power_spectral_density](./snapshots/Spectral density - Wikipedia, the free encyclopedia (2016-02-16 11-56-07 AM).htm)
    * [https://en.wikipedia.org/wiki/Wiener%E2%80%93Khinchin_theorem](./snapshots/Wiener–Khinchin theorem - Wikipedia, the free encyclopedia (2016-02-16 12-00-34 PM).htm)

## 5.7 Anisotropy in natural images

Horizontal and (a little) vertical cardinal effect (in Tai-Sing's terminology) for pixel values of natural images! The following text explains why this anisotropy must be the case. Otherwise, first PCA component can't be so stable at all.

> If the images exactly isotropic, horizontal edges and vertical edges would have exactly the same variance, and the first principal component would not be well-defined at all; this would be reflected in Figure 5.6 so that we would get edges with different random orientations.


## 5.8 Mathematics of principal component analysis

Here everything is assumed to have zero mean.

1. Eq. (5.24) is a very classical result. 
2.  Eq. (5.27)-(5.28) solves the problem through eigendecomposition, and here, there's one-to-one & onto mappings between m, w, and v. so we can solve m only, then get w.
    * well, there's some ambiguity when mapping m to v, since we don't know v's sign. But that doesn't matter.
3. pp. 125 eigenvalue decomposition is only unique (up to sign) when eigenvalues are distinct.

    > In fact, in linear algebra, it is well-known that the eigenvalue decomposition is uniquely defined only when the eigenvalues are all distinct.
    
4. pp. 125 Section 5.8.2 I have some notes for the derivation here. Basically, the derivation should only work for infinitely large image, I guess. I only write notes for the 1D case, but 2D case should be able to be proved similarly, just with more care on indexing. 

    > the problem with this argument is that z is not summed over an infinitely large interval (not even symmetric).
    > 
    > Don’t know how this will work for cyclic images as said in errata.
    > 
    > Actually, it’s impossible for a finite large matrix to have infinitely many eigenvectors of different frequency and phase….except when all its eigenvalues are the same….which means we have the covariance matrix being multiple of Identity matrix.
    > 
    > the end result is that, a eigenvector sin(x+a), x= 1,2..., N (N is the size the matrix) is the eigenvector of the covariance matrix. Here. c(x-x') is any arbitrary row of the covariance matrix, and this row is symmetric (infinitely long, or sufficiently long, so that c(z) is symmetric. (on two ends, c(z) becomes zero I guess). 
    > 
    > (5.34) means, when we multiply this sin(x+a) by this covariance matrix, we get a new vector, which is the original sin(x+a) multiplied by [\sum_z c(z) cos(z) ], a constant, (eigenvalue). (x' denotes the value of this vector on this specific row).

## 5.9 Decorrelation models of retina and LGN

This section tries to explain the center surround structure of LGN receptive fields from both a spatial and a frequency-based perspective. Notice that the methods proposed here are not the only possible whitening approaches, since filters of shape unlike LGNs can do whitening as well in principle. Therefore, it is unclear why LGN should follow the approaches here, if only whitening is required. Still, the methods here are interesting.

1. pp. 126 definition of whitening in the context of neurons. Notice that it makes no sense to talk about decorrelation of a single image. Decorrelation must be defined over many images. The **on the average** (over images) flat power spectrum corresponds to an identity (with some multiplier) covariance matrix.

    > The outputs of the neurons would then be uncorrelated, and if we were to look at the outputs of the whole set of neurons as an image (or a set of images for multiple input images), these output images would **on the average** have a flat power spectrum.
    
### 5.9.2 Patch-based decorrelation

This is usually called ZCA whitening in other places, such as [UFLDL](http://ufldl.stanford.edu/wiki/index.php/Whitening#ZCA_Whitening).

1. pp. 131 Fig. 5.19 shows the filters derived from a spatial perspective. Notice that they are shifts of each other. This is probably related to the fact that W is inverse square root of covariance matrix (top of pp. 130), which is basically very spatially invariant. Below are my notes for this phenomenon

    > why are columns (rows) of W just shifts of a common filter? Maybe because W = C^{-1/2}, and C is shift-invariant.

2. pp. 131 Eq. (5.46) Notice that this ZCA whitening matrix is symmetric, and it's the only symmetric whitening matrix according to authors (I didn't try to prove this).

### 5.9.3 Filter-based decorrelation

I think these two formulations (patch and filter) are not equivalent. At least in spatial (patch) formulation, we don't consider noise reduction explicitly.

The approach taken here is basically the **1/f whitening** in Olshausen's 1996 and 1997 sparse coding papers.

Also, I think we should also assume that a wide-sense stationary (WSS) signal after convolution by a filter is still WSS, so we can talk about its auto correlation in a meaningful way. Otherwise, if the resultant signal is not WSS, then even if we make its power spectrum flat, we don't know if it's whitened or not. But I guess this is definitely true, since filtering is only linear.

1. pp. 132 there are two principles for designing this filter

    > 1. the linear filters are whitening natural image data    > 2. with the constraint that noise is not amplified unduly.
    
2. pp. 132 Eq (5.47) tries to satisfy the first principle, trying to make power spectrum flat.
3. pp. 132 Eq (5.48) is the gain on top of the filter in Eq. (5.47), suppressing noise. Derivation of Eq. (5.48) is not given. 
4. pp. 133 Eq (5.49) gives the final amplitude response of the filter. 
5. pp. 133 Eq (5.51) specifies the phase. I don't understand why zero phase gives concentrated filter shape, but whatever.

    > "With the phases of all frequencies at zero, the energy of the filter is highly concentrated around the spatial origin, yielding a highly spatially localized filter."
    
## 5.11 Exercises

a sample solution is at [here](./sample_solutions/sol_chap_05.pdf).
