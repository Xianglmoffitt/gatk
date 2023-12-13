setwd("~/Projects/gatk_rna/survival_curve/")

library(survival)
library(ggplot2)
library(survminer)

# sample
s_clin <- read.table("sample_clinical.txt",sep="\t",header=T)
mutation <- read.table("hpv16_sample_mutation.txt",sep="\t",header=T)
total_number <- read.table()
colnames(s_clin)[1] <- "sample_name"

input_df <- merge(s_clin,mutation,by="sample_name")

input_df$Overall.Survival.Status <- ifelse(input_df$Overall.Survival.Status=="0:LIVING",0,1)

# loop each mutation
mut_name <- colnames(input_df)[9:115]
mut_count <- colSums(mutation[,-c(1,2)])
plot_list <- list()
for (m in 1:length(mut_name)) {
  surv_object <- survfit(Surv(Overall.Survival..Months.,Overall.Survival.Status)~input_df[,m+8],data=input_df)
  
  plot_list[[m]] <- ggsurvplot(surv_object,data=input_df,pval=TRUE,
                      legend.labs=c("mutation=0","mutation=1"),
                      title=paste0(mut_count[m],": ",mut_name[m]))
}

for (i in seq(1,107,18)) {
  if (i != 91) {
    pdf(paste0("plots/sur_curve_",i,".pdf"),width=20,height=10)
    print(ggarrange(ncol=6,nrow = 3,
                    plot_list[[i]]$plot,plot_list[[i+1]]$plot,
                    plot_list[[i+2]]$plot,plot_list[[i+3]]$plot,
                    plot_list[[i+4]]$plot,plot_list[[i+5]]$plot,
                    plot_list[[i+6]]$plot,plot_list[[i+7]]$plot,
                    plot_list[[i+8]]$plot,plot_list[[i+9]]$plot,
                    plot_list[[i+10]]$plot,plot_list[[i+11]]$plot,
                    plot_list[[i+12]]$plot,plot_list[[i+13]]$plot,
                    plot_list[[i+14]]$plot,plot_list[[i+15]]$plot,
                    plot_list[[i+16]]$plot,plot_list[[i+17]]$plot))
    dev.off()
  } else {
    pdf(paste0("plots/sur_curve_",i,".pdf"),width=20,height=10)
    print(ggarrange(ncol=6,nrow = 3,
                    plot_list[[i]]$plot,plot_list[[i+1]]$plot,
                    plot_list[[i+2]]$plot,plot_list[[i+3]]$plot,
                    plot_list[[i+4]]$plot,plot_list[[i+5]]$plot,
                    plot_list[[i+6]]$plot,plot_list[[i+7]]$plot,
                    plot_list[[i+8]]$plot,plot_list[[i+9]]$plot,
                    plot_list[[i+10]]$plot,plot_list[[i+11]]$plot,
                    plot_list[[i+12]]$plot,plot_list[[i+13]]$plot,
                    plot_list[[i+14]]$plot,plot_list[[i+15]]$plot))
    dev.off()
  }

}

pdf("plots/sur_curve_1.pdf",width=20,height=10)
ggarrange(plot_list[[1]]$plot,)
dev.off()


