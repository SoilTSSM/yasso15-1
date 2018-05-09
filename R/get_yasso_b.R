
# small wrapper for biomassTree
biomass.tree = function(trees){
  return (biomassTree(trees$d,trees$h,trees$sp))
}

get.Yasso.b = function(trees,turnover,AWEN.array){
  # biomass components
  cmp = c("sw","rf","fl","br","db","rc","su","sb")
  trees.biomass = data.table(biomass.tree(trees))

  # biomass to Carbon
  trees.C = trees.biomass*0.5

  # sum up by species
  trees.C = cbind(trees[,.(sp)],trees.C[,.(sw,rf,fl,br,db,rc,su,sb)])

  plot.C = matrix(0,3,8)
  rownames(plot.C) = c(1,2,3)
  colnames(plot.C) = cmp
  for (i in 1:3){
    if(nrow(trees.C[sp==i])>0){
      plot.C[i,] = t(as.numeric(trees.C[sp==i,.(sum(sw),sum(rf),sum(fl),sum(br),sum(db),sum(rc),sum(su),sum(sb))]))
    }
  }

  # calculate litter input
  litter.cmp = plot.C*turnover

  a = sum(AWEN.array[,,1]*litter.cmp)
  w = sum(AWEN.array[,,2]*litter.cmp)
  e = sum(AWEN.array[,,3]*litter.cmp)
  n = sum(AWEN.array[,,4]*litter.cmp)

  # yearly litter input
  return(c(a,w,e,n,0))
}
