# Set your working directory to wherever you store the FIigraph data 
# file that you download.
setwd('/Users/shaina/Library/Mobile Documents/com~apple~CloudDocs/Social Network Analysis/SNA2019/Day1')
#######################################################
#install.packages("RColorBrewer")
#install.packages("igraph")
#install.packages("networkD3")
#install.packages("magrittr")
library(magrittr)
library(networkD3)
library(RColorBrewer) 
library(igraph)
#######################################################
# The name of the file, which contains a graph object called slack along with the edge and node data tables.
load("SlackNetworkData2019.RData") 
vertex_attr(slack) # Lists all the vertex data
plot(slack)
# Change the colors, suppress the labels, add arrows to directed edges
plot(slack, edge.arrow.size = .3, vertex.label=NA,vertex.size=10,
     vertex.color='gray',edge.color='blue')
# Change the layout of nodes
plot(slack, edge.arrow.size = .3, vertex.label=NA,vertex.size=10,
     vertex.color='lightblue',layout=layout_with_fr)
################### #########################################
### Other potential layouts
############################################################
?layout
l = layout_on_sphere(slack) 
l2 = layout_nicely(slack)
l3 = layout_with_mds(slack)
l4 =  layout_with_graphopt(slack)
par(mfrow=c(2,2),mar=c(1,1,1,1)) # Tells the graphic window to use the
# following plots to fill out a 2x2 grid with margins of 1 unit 
# on each side. Must reset these options with dev.off() when done!
plot(slack, edge.arrow.size = .3, vertex.label=NA,vertex.size=10,
     vertex.color='lightblue', layout=l,main="Sphere")
plot(slack, edge.arrow.size = .3, vertex.label=NA,vertex.size=10,
     vertex.color='lightblue', layout=l2,main="Nicely")
plot(slack, edge.arrow.size = .3, vertex.label=NA,vertex.size=10,
     vertex.color='lightblue', layout=l3,main="MDS")
plot(slack, edge.arrow.size = .3, vertex.label=NA,vertex.size=10,
     vertex.color='lightblue', layout=l4,main = "GraphOpt")

dev.off() #resets the graphic window options.

######################################################
# COLORING THE GRAPH BY VERTEX ATTRIBUTE "COHORT"    #
# BY SETTING THE COLOR ATTRIBUTE DIRECTLY IN GRAPH   #
######################################################
V(slack)$color=c("blue","grey","orange")[as.factor(V(slack)$Cohort)]
plot(slack, edge.arrow.size = .2, vertex.label=V(slack)$name, vertex.size=10,
      layout=l4,main = "Slack Network Colored by Cohort")
###################################################################
# CREATING A LEGEND, WHICH IS PERHAPS NOT AS EASY AS IT SHOULD BE #
###################################################################

V(slack)$Cohort
unique(V(slack)$Cohort)
legend(x=-1.5,y=0,unique(V(slack)$Cohort),pch=21,
       pt.bg=c("blue","grey","orange"),pt.cex=2,bty="n",ncol=1)
# pch =21 makes circles 
# pt.cex controls size of circles
# bty="n" means no frame around it (switch to "y" for frame)

#######################################################
#######################################################
# IF TIME PERMITS:    PACKAGE NETWORKD3
#######################################################
#######################################################
# This package insists that the label names (indices)
# of your nodes start from zero. That is something to be
# aware of when moving between R and python as well!!
# If they don't start from zero the graph just won't render
# you won't even get a warning message!! 

# To use this package, you need a data frame containing
# the edge list and a data frame containing the node data.

# Start by deleting any vertices that have no edges attached.
slack=delete.vertices(slack,degree(slack)==0)
# we need to create ID attribute taking values 0,..,103 
nodes=data.frame(vertex_attr(slack))
nodes$ID=as.numeric(nodes$name)-1
#data frame with edge list
edges=data.frame(get.edgelist(slack)) 
colnames(edges)=c("source","target")

edges=merge(edges, nodes[,c("name","ID")],by.x="source",by.y="name")
edges=merge(edges, nodes[,c("name","ID")],by.x="target",by.y="name")
edges=edges[,3:4]
colnames(edges)=c("source","target")


# data frame with node data
# reorder nodes table to match the 0,...,104 identifiers in
# edges table
nodes=nodes[order(nodes$ID),]


forceNetwork(Links=edges, Nodes=nodes, Source = "source",
             Target = "target", NodeID="name", Group="Cohort",
             fontSize=12, opacity = 0.8, zoom=T, legend=T, charge = -100)

# You can use the "Charge" of the Algorithm to change the spread of the layout
# A negative charge creates a repulsive force between the nodes, a positive
# charge creates an attractive force.
colors = JS('d3.scaleOrdinal().domain(["Blue", "Orange", "None"]).range(["#0000ff", "#ffa500", "#808080"])')

forceNetwork(Links=edges, Nodes=nodes, Source = "source",
             Target = "target", NodeID="name", Group="Cohort", colourScale=colors,
             charge=-100,fontSize=12, opacity = 0.8, zoom=F, legend=T)

#######################################################
#######################################################
# SAVING THE HTML FILE WITH THE D3 GRAPH
#######################################################
#######################################################
j=forceNetwork(Links=edges, Nodes=nodes, Source = "source",
               Target = "target", NodeID="name", Group="Cohort",
               fontSize=12, opacity = 0.8, zoom=T, legend=T)
saveNetwork(j, file = 'slack.html')








