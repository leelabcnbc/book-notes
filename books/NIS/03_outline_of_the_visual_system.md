# Outline of the visual system

Feb. 15, 2016  
Yimeng Zhang

## 3.1 Neurons and firing rates

1. pp. 54 neurons can be thought as pattern matching device, but this is simplified.

    > Thus, a neuron can be thought of as an elementary pattern-matching device: its firing rates is large when it receives input from those neurons which excite it (strongly), and no input from those neurons which inhibit it. A basic mathematical model for such an action is to consider the firing rate as a linear combination of incoming signals; we will consider linear models below.
Thinking in terms of the original visual stimuli, it is often thought that a neuron is active when the input contains a feature for which the neuron is specialized - but this is a very gross simplification.

## 3.3 Linear models of visual neurons

1. pp. 55 definition of receptive field. It means both the spatial area and the pattern.

    > In the early visual system, the response of a typical neuron depends only on the intensity pattern of a very small part of the visual field. This area, where light increments or decrements can elicit increased firing rates, is called the (classical) receptive field (RF) of the neuron. More generally, the concept also refers to the particular light pattern that yields the maximum response.

2. pp. 56 best patterns are dynamic.

    > So, what kind of light patterns actually elicit the strongest responses? This of course varies from neuron to neuron. One thing that most cells have in common is that they don't respond to a static image which consists of a uniform surface. They respond to stimuli in which there is some change, either temporally or spatially; such change is called contrast in vision science.

3. pp. 57 footnote: direct input to neurons are not used for simplicity.

    > Alternatively, one could model the output as a function of the direct inputs to the cell, i.e. the rates of action potentials received in its dendrites. This latter approach is more general, because it can be applied to any neuron in the brain. However, it is not usually used in vision research because it does not tell us much about the function of the visual system unless we already know the response properties of those neurons whose firing rates are input to the neuron via dendrites, and just finding those cells whose axons connect to a given neuron is technically very difficult.

4. pp. 57 Here I think the authors made a mistake: reverse correlation is no more complicated or general than spike trigger average. Essentially, they are the same, if one checks the book Theoretical Neuroscience by Dayan and Abbott.

## 3.4 Nonlinear models of visual neurons

1. pp. 62 Energy model's definition. "Energy" simply means squaring! How well can neuroscientists invent terms! Energy model is probably the most important model to give phase-invariant response.

   > The responses of complex cells have often been modelled by the classical 'energy model'. (The term 'energy' simply denotes the squaring operation.) 


## 3.9 Exercises

a sample solution is at [here](./sample_solutions/sol_chap_03.pdf).
