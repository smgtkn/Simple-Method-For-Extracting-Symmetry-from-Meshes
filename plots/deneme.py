from matplotlib import pyplot as plt
plt.plot([0, 0.05, 0.1, 0.15, 0.2, 0.25], [0,0.73 , 0.84, 0.86, 0.88, 0.89],"b") #kids
plt.plot([0, 0.05, 0.1, 0.15, 0.2, 0.25], [0,0.8  , 0.91 ,0.96 ,0.96 ,0.97],"r") #tosca 
plt.plot([0, 0.05, 0.1, 0.15, 0.2, 0.25], [0,0.712548 ,0.859155 ,0.941101, 0.954545, 0.959667],"g") #scape
plt.ylabel('Fraction of Correspondences')
plt.xlabel('Geodesic Error')
plt.xlim(xmin=0)
plt.ylim(ymin=0)

plt.show()

