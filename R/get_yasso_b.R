# small wrapper for biomassTree
biomass.tree = function(trees){
  return (biomassTree(trees$d,trees$h,trees$sp))
}

#' @title Yasso yearly litter input
#'
#' @description
#' Calculate the 'b' Yasso parameter (yearly litter input by chemical pool), given a set of trees with dbh(d), heigh(h) and species(sp)
#'
#' @param trees a data.frame with three columns: d,h, and sp
#' @param turnover the type of turnover to use: turnover=1, natural turnover of living trees; turnover=2, turnover due to mortality; turnover=3, turnover due to harvest

#' @return a matrix with 3 rows (non, fine, and coarse woody litter) and 5 columns: a,w,e,n,h corresponding to the amount of carbon in each chemical pool generated from litter each year
#' @examples
#' trees = data.table(d=c(10,15,20),h=c(10,15,17),sp=c(1,2,2))
#' get.Yasso.b(trees,turnover=1)
#'
#' @rdname get_yasso_b
#' @author Victor Felix Strîmbu \email{victor.strimbu@@nmbu.no}
#' @export
get.Yasso.b = function(trees, turnover){
  require(data.table)
  # turnover table
  if (turnover==1) turnover = turnover.1

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
  a = AWEN.array[,,1]*litter.cmp
  w = AWEN.array[,,2]*litter.cmp
  e = AWEN.array[,,3]*litter.cmp
  n = AWEN.array[,,4]*litter.cmp

  # non woody litter
  a.nw = sum(a[,c("rf","fl")])
  w.nw = sum(w[,c("rf","fl")])
  e.nw = sum(e[,c("rf","fl")])
  n.nw = sum(n[,c("rf","fl")])

  # fine woody litter
  a.fw = sum(a[,c("br","db","rc","sb")])
  w.fw = sum(w[,c("br","db","rc","sb")])
  e.fw = sum(e[,c("br","db","rc","sb")])
  n.fw = sum(n[,c("br","db","rc","sb")])

  # coarse woody litter
  a.cw = sum(a[,c("sw","su")])
  w.cw = sum(w[,c("sw","su")])
  e.cw = sum(e[,c("sw","su")])
  n.cw = sum(n[,c("sw","su")])

  # yearly litter input
  litter = matrix(0,3,5)
  litter[] = c(a.nw,a.fw,a.cw,
            w.nw,w.fw,w.cw,
            e.nw,e.fw,e.cw,
            n.nw,n.fw,n.cw,
            0,0,0)
  rownames(litter) = c("non woody", "fine woody", "coarse woody")
  colnames(litter) = c("a","w","e","n","h")
  return(litter)
}
