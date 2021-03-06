## name: plot_sub3_model.r
## date: 01/31/2018

library(ggplot2)
library(reshape2)
library(plyr)
library(scales)

source("~/function/my_palette.r")
source("~/function/multiplot.R")

## 1. number of features #########
b10=readLines("../sub2/prediction/breast/individual_10feature/cor_avg_breast.txt")
b10=as.numeric(sub("\\[1\\] ","",b10))
b100=readLines("../sub2/prediction/breast/individual_100feature/cor_avg_breast.txt")
b100=as.numeric(sub("\\[1\\] ","",b100))
b1000=readLines("../sub2/prediction/breast/individual_1000feature/cor_avg_breast.txt")
b1000=as.numeric(sub("\\[1\\] ","",b1000))
b=readLines("../sub2/prediction/breast/individual/cor_avg_breast.txt")
b=as.numeric(sub("\\[1\\] ","",b))
bgo=readLines("../sub2/prediction/breast/individual_go_expression/cor_avg_breast.txt")
bgo=as.numeric(sub("\\[1\\] ","",bgo))

o10=readLines("../sub2/prediction/ova/individual_10feature/cor_avg_ova.txt")
o10=as.numeric(sub("\\[1\\] ","",o10))
o100=readLines("../sub2/prediction/ova/individual_100feature/cor_avg_ova.txt")
o100=as.numeric(sub("\\[1\\] ","",o100))
o1000=readLines("../sub2/prediction/ova/individual_1000feature/cor_avg_ova.txt")
o1000=as.numeric(sub("\\[1\\] ","",o1000))
o=readLines("../sub2/prediction/ova/individual/cor_avg_ova.txt")
o=as.numeric(sub("\\[1\\] ","",o))
ogo=readLines("../sub2/prediction/ova/individual_go_expression/cor_avg_ova.txt")
ogo=as.numeric(sub("\\[1\\] ","",ogo))

tbl=rbind(cbind(b10,b100,b1000,bgo,b),cbind(o10,o100,o1000,ogo,o))
colnames(tbl)=c(10,100,1000,"4472/4473(GO)","8738/5837(all)")
rownames(tbl)=rep(c("breast","ovary"),each=5)
tbl.m=melt(tbl)
colnames(tbl.m)=c("cancer","model","correlation")
tmp_col=my_palette[c("blue","red")]
names(tmp_col)=c("breast","ovary")

sub2_feature = ggplot(tbl.m, aes(model, correlation, fill=cancer)) +
    geom_violin(colour="grey50",draw_quantiles = 0.5) +
    scale_fill_manual(values=tmp_col) +
    labs(title="Sub2 Individual Model", x="Number of features", y="Pearson's correlation") +
    theme(plot.title = element_text(hjust = 0.5)) +
    ylim(0,0.6) +
    geom_rect(mapping=aes(xmin=4.5,xmax=5.5,ymin=0.2,ymax=0.4,fill=NA),color=my_palette["yellow"])
#######################################

## 2. number of samples ###############
b0.4=readLines("../sub2/prediction/breast/individual_0.4sample/cor_avg_breast.txt")
b0.4=as.numeric(sub("\\[1\\] ","",b0.4))
b0.6=readLines("../sub2/prediction/breast/individual_0.6sample/cor_avg_breast.txt")
b0.6=as.numeric(sub("\\[1\\] ","",b0.6))
b0.8=readLines("../sub2/prediction/breast/individual_0.8sample/cor_avg_breast.txt")
b0.8=as.numeric(sub("\\[1\\] ","",b0.8))
b=readLines("../sub2/prediction/breast/individual/cor_avg_breast.txt")
b=as.numeric(sub("\\[1\\] ","",b))
bt=readLines("../sub2/prediction/breast/individual_transplant/cor_avg_breast.txt")
bt=as.numeric(sub("\\[1\\] ","",bt))

o0.4=readLines("../sub2/prediction/ova/individual_0.4sample/cor_avg_ova.txt")
o0.4=as.numeric(sub("\\[1\\] ","",o0.4))
o0.6=readLines("../sub2/prediction/ova/individual_0.6sample/cor_avg_ova.txt")
o0.6=as.numeric(sub("\\[1\\] ","",o0.6))
o0.8=readLines("../sub2/prediction/ova/individual_0.8sample/cor_avg_ova.txt")
o0.8=as.numeric(sub("\\[1\\] ","",o0.8))
o=readLines("../sub2/prediction/ova/individual/cor_avg_ova.txt")
o=as.numeric(sub("\\[1\\] ","",o))
ot=readLines("../sub2/prediction/ova/individual_transplant/cor_avg_ova.txt")
ot=as.numeric(sub("\\[1\\] ","",ot))

tbl=rbind(cbind(b0.4,b0.6,b0.8,b,bt),cbind(o0.4,o0.6,o0.8,o,ot))
colnames(tbl)=c("40%","60%","80%","100%(b=77;o=105)","100% b+o")
rownames(tbl)=rep(c("breast","ovary"),each=5)
tbl.m=melt(tbl)
colnames(tbl.m)=c("cancer","model","correlation")
tmp_col=my_palette[c("blue","red")]
names(tmp_col)=c("breast","ovary")

sub2_sample = ggplot(tbl.m, aes(model, correlation, fill=cancer)) +
    geom_violin(colour="grey50",draw_quantiles = 0.5) +
    scale_fill_manual(values=tmp_col) +
    labs(title="Sub2 Trans-cell Line Model", x="Number of samples", y="Pearson's correlation") +
    theme(plot.title = element_text(hjust = 0.5)) +
    ylim(0,0.6) +
    geom_rect(mapping=aes(xmin=4.5,xmax=5.5,ymin=0.25,ymax=0.45,fill=NA),color=my_palette["yellow"])
######################################

## 3. stacking #######################
bg=readLines("../sub2/prediction/breast/rna/cor_avg_breast.txt")
bg=as.numeric(sub("\\[1\\] ","",bg))
bi=readLines("../sub2/prediction/breast/global_individual/cor_avg_breast.txt")
bi=as.numeric(sub("\\[1\\] ","",bi))
bf=readLines("../sub2/prediction/breast/final/cor_avg_breast.txt")
bf=as.numeric(sub("\\[1\\] ","",bf))


og=readLines("../sub2/prediction/ova/rna/cor_avg_ova.txt")
og=as.numeric(sub("\\[1\\] ","",og))
oi=readLines("../sub2/prediction/ova/global_individual/cor_avg_ova.txt")
oi=as.numeric(sub("\\[1\\] ","",oi))
of=readLines("../sub2/prediction/ova/final/cor_avg_ova.txt")
of=as.numeric(sub("\\[1\\] ","",of))

tbl=rbind(cbind(bg,bi,bf),cbind(og,oi,of))
colnames(tbl)=c("Generic","Gene-specific","Trans-cell line")
rownames(tbl)=rep(c("breast","ovary"),each=5)
tbl.m=melt(tbl)
colnames(tbl.m)=c("cancer","model","correlation")
tmp_col=my_palette[c("blue","red")]
names(tmp_col)=c("breast","ovary")

sub2_stacking = ggplot(tbl.m, aes(model, correlation, fill=cancer)) +
    geom_violin(colour="grey50",draw_quantiles = 0.5) +
    scale_fill_manual(values=tmp_col) +
    labs(title="Sub2 Model Comparison", x="Model", y="Pearson's correlation") +
    theme(plot.title = element_text(hjust = 0.5)) +
    ylim(0,0.6) +
    geom_rect(mapping=aes(xmin=2.5,xmax=3.5,ymin=0.35,ymax=0.55,fill=NA),color=my_palette["yellow"])
###################################################

list_p=list()
list_p[[1]]=sub2_feature
list_p[[2]]=sub2_sample
list_p[[3]]=sub2_stacking

pdf(file="../figure/sub2_model_comparison.pdf",width=9.5,height=12)
mat_layout=matrix(1:3,nrow=3)
multiplot(plotlist=list_p,layout = mat_layout)
dev.off()


