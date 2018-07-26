## From normal distribution to Chi-squred, T, and F tests
The central limit theorem lets us take a whatever unknown and probably weird distribution, and arrive at the well known normal distribution.  
Once we are dealing with normal distributions, we can combine them to get different properties that suits our purposes.  

$$ X_1,X_2,...,X_n \sim N(\mu, \sigma^2)$$ are i.i.d.s  

Examples of different manipulations:  
### Chi-Squared $$\chi^2$$   
sum of squares of standard normal distributions has a $$\chi^2$$ distribution. So $$ \sum-{i=1}^n [ (X_i - \mu)/\sigma]^2 \sim \chi^2(n)$$.    
It can also be expressed in terms of sample variance $$ s^2 = \frac{\sum_{i=1}^n (X_i - \bar{X})^2}{n-1}, \qquad \frac{(n-1)s^2}{\sigma^2}=  \sum [(X_i - \bar{X})/\sigma]^2 \sim \chi^2(n-1) $$    
The decrement of 1 in degree of freedom can be explained in two ways:  
(a) There are only ( n-1 ) variables that are free to change in $$ s^2 $$, since if we know the sample mean, the n samples are not completely free to change anymore.  
(b) $$ \frac{(n-1)s^2}{\sigma^2}=  \sum [(X_i - \bar{X})/\sigma]^2 =  \sum [(X_i - \mu)/\sigma]^2 - \sum [(\bar{X} - \mu)/\sigma]^2 = \chi^2(n) - \chi^2(1) $$   
If this $$ \chi^2(n) $$ and $$ \chi^2(1) $$ are indep., their difference will $$\sim \chi^2(n-1) $$. And, by Basu's theorem, sample mean and sample variance are indeed independent.
 
### T-distribution  
divide a standard normal distribution by the square root of a scaled Chi-Squared Distribution, it has a t-distribution. So $$ \frac{N(0,1)}{\sqrt{\chi^2 (k)/k}} \sim t_k$$.  
Using sample mean and variance to express it: $$ t_{n-1} = \frac{(\bar{X} - \mu)/(\sigma/\sqrt{n})}{\sqrt{\chi^2(n-1)/(n-1)}} =  \frac{(\bar{X} - \mu)/(\sigma/\sqrt{n})}{\sqrt{(n-1)s_n^2/\sigma^2/(n-1)}} = \frac{(\bar{X} - \mu)}{s_n/\sqrt{n}}$$  

### F-Distribution  
Ratio of two scaled chi-squared  
$$ F_{m-1,n-1} = \frac{\chi^2_{m-1}/(m-1)}{\chi^2_{n-1}/(n-1)} = \frac{s_m^2/\sigma_m^2}{s_n^2/\sigma_n^2} $$


