## A Crash Tutorial on Social Network Analysis in R

### Description

This two-hour tutorial is intended for researchers interested in using
R to perform analyses on networked data. Social network analysis is
used in a variety of disciplines, from sociology to epidemiology.
Given the increasing popularity of using R to analyze social science
data, the number of user-created packages have similarly
increased. The decision of which analytical technique to use or which
package to install is a non-trivial decision, and can be bewildering
to a nascent researcher (I’m definitely still learning
myself!). Within the context of relational data science, this tutorial
is intended to dispel some of these confusions and provide resources
for researchers who work with social networks. This tutorial will be
divided into four main sections:

1. We will start the tutorial by going through some graph theory
   basics, enough to lay the foundation for understanding and
   manipulating networked data.
2. Then, using toy network data, we will learn to turn this dataset
   into relational data structures in R, and explore functions that
   can calculate network measures.
3. Finally, we will end by discussing other useful ways to use R in
   social network analysis, including respondent driven sampling to
   population size estimation techniques.
4. After the tutorial, I will be happy to answer individual questions
   regarding your own research and data idiosyncrasies.g

### Prior Preparation

Some familiarity with R will be very useful. Some participants may
request to work with their own data during the tutorial. I’m going to
kindly suggest that we stick with the toy datasets, simply because
addressing issues with data formatting can be a major drain on
time. However, I am happy to take questions after the tutorial to
address specific analytic questions. So do bring your datasets for the
Q and A session after the tutorial!

### Software Requirements and Data Downloads
Please make sure to have the following software requirements, class
materials, and datasets ready before class begins on Monday.

#### R downloads
You'll need both the R statistical computing language and RStudio
integrated development environment for R. You're welcome to use
another text editor, but RStudio is highly functional and recommended
for most users.
+ [Download R here:](https://www.r-project.org/)
  Click on a CRAN mirror to start the download process.
+ [Download R studio:](https://www.rstudio.com/products/rstudio/download/)
  The free version will suffice.
  
#### Install R packages
Please install the `sna`, `network`, and `GGally` package. 

```R
install.packages(c("statnet", "network", "GGally"))
```

#### Slide decks and exercise materials
+ [Click here for the slides](./slides/sna_slides.pdf)
+ [Exercise 1 materials](./scripts/1_ex1.zip)
+ [Exercise 2 materials](./scripts/2_ex2.zip)

### About Me

I’m a second year PhD student in geography with an NSF IGERT
traineeship in network science. Although my degrees are in public
health and infectious disease, most of my work is interdisciplinary
and focused on incorporating computational techniques in global health
research. You can read more about my research
[here](https://www.vaniaw.com).
