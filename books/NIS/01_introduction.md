# Introduction

Feb. 15 2016  
Yimeng Zhang

## 1.1 What this book is all about

1. pp. 1 [this book] says what is the optimal way of doing these things, and predictions of the theory in the book has been confirmed by experiments, and the theory also has some prediction about V2.
2. pp. 2 Fig 1.1 An example of prediction made by the theory (topographic ICA).


## 1.2 What is vision?

1. pp. 3: The problem of sampling.

   > Although the spatial sampling performed by biological systems is not rectangular or even regular, **the effects of the sampling process are not very different.**

    * maybe sampling in the retina is more log spherical.
    * I see no foundation of this claim, but probably we can only accept it.
    * In the footnote of this page, the discretization issue of pixel values is also mentioned. But we usually assume this has been done with high sufficient precision so it's not an issue.

## 1.3 The magic of your visual system

1. pp. 5 Figure 1.2 shows the difficulty of vision.
2. pp. 6 Biology cannot help computer vision beyond very early vision.

   > However, beyond the very early stages, little is actually known about the representations used in the brain. Thus, there is actually not much to guide computer vision research at the present.

## 1.4 Importance of prior information

1. pp. 6 Why Fourier transform is not what biology vision adopts.

    > An adaptive representation is one that does not attempt to represent all possible kinds of data; instead, the representation is adapted to a particular kind of data.

    >  This is in stark contrast to classic representations (e.g. Fourier analysis) that are fixed based on some general theoretical criteria, and completely ignore what kind of data is being analyzed.

    > Thus, the visual system is not viewed as a general signal processing machine or a general problem-solving system. Instead, it is acknowledged that it has evolved to solve some very particular problems that form a small subset of all possible problems. For example, the biological visual system needs to recognize faces under different lighting environments, while the people are speaking, possibly with different emotional expressions superimposed; this is definitely an extremely demanding problem. But on the other hand, the visual system does not need to recognize a face when it is given in an unconventional format, as in Figure 1.2.

2. pp. 8 Image synthesis, generative model. Key thing here is that the structure of the world is encoded in the prior probabilities of latent variables.

    >  our visual system has an unconscious internal model for image generation. Estimates of object identity, lighting direction, and scene depth are all adjusted until a satisfactory match between the observed image and the internally generated image is achieved.



## 1.5 Natural Images

1. pp. 12 task of this book

   > It is this probability density function of the image set in question that we will model in this book.

2. pp. 12 definition of natural images

   > Natural images is thus some set that we believe has similar statistical structure to that which the visual system is adapted to.

3. pp. 12 while images today are not that "natural" anymore, it should not matter.

   > Fortunately, this choice of image set does not have a drastic influence on the results of the analysis: Most image sets collected for the purpose of analysing natural images give quite similar results in statistical modelling

4. pp. 13 natural images are redundant. check Fig. 1.7. In the next section, information theory would be introduced to address redundancy formally.

## 1.6 Redundancy and information

1. pp. 14 some relation between predictability and redundancy. Here the equivalence is not formal. But intuitively, that is the case.

   > information theory ensures that predictability is essentially the same thing as redundancy.

2. pp. 15 Birth of the redundancy reduction idea for vision system.

   > In Attneave's original article describing the redundancy inherent in images, Attneave suggested that the visual system recodes the inputs to reduce redundancy, providing an ‘economical description’ of the sensory signals. He likened the task of the visual system to that of an engineer who seeks to represent pictures with the smallest possible number of bits. It is easy to see the intuitive appeal of this idea.

3. pp. 15 Redundancy reduction requires identification of structure.

   > More generally: to reduce redundancy one must first identify it. Thus, redundancy reduction requires discovering structure.

## 1.7 Statistical modelling of the visual system

1. pp. 16 Connecting information theory and Bayesian inference. Why talk about information theory at all when we want generative model? Because they both need a good model of data!

   > To accomplish their goals, both of these methods fundamentally need the same thing: a good model of the statistical distribution of the data. That is the basic motivation for this book. It leads to a new approach to normative visual modelling as will be discussed next.

## 1.8 Features and statistical models of natural images

1. pp. 19 This book tries to **learn** features.
2. pp. 19 basis for learning.

    > We can learn features from image data by optimizing some statistical properties of the features si.

3. pp. 19 section 1.8.3 talks about relation between Bayesian modeling and feature learning.


