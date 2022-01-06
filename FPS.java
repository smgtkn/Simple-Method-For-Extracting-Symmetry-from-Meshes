import java.util.ArrayList;
import java.util.PriorityQueue;
public class FPS{
public static int numOfSamples;
public PriorityQueue<shortestDistance> pQueue;
public Dijkstra2[] samples;
public FPS(ArrayList <Vertex>vertices,int numOfSamples){
this.numOfSamples=numOfSamples;

samples=new Dijkstra2[numOfSamples];

}

public void farthestPoint(ArrayList <Vertex>vertices,int vertexIndex,ArrayList <Vertex>meshvertices) {
 Dijkstra2 dijkstra=new Dijkstra2(meshvertices,vertexIndex,2f);
 // sampledVertices.add(dijkstra.enUzak);
  vertexIndex=dijkstra.enUzak;
   meshvertices.get(vertexIndex).dijk=dijkstra;
 
//System.out.println("Index "+vertexIndex);
int i=0;
myComparatorMax comparator=new myComparatorMax();
  for(;i<numOfSamples-1;i++){
   // pQueue=new PriorityQueue<shortestDistance>(vertices.size(),new myComparatorMax());
    
     
     samples[i]=new Dijkstra2(meshvertices,vertexIndex,2f);
    
     shortestDistance minDist=new shortestDistance(0,-1);
     for(int k=0;k<vertices.size();k++){
       shortestDistance min=samples[0].distances.get(vertices.get(k).vertexNo);
   
       int j=0;
       while(j<=i){
       if(min.distance>samples[j].distances.get(vertices.get(k).vertexNo).distance){
       min=samples[j].distances.get(vertices.get(k).vertexNo);
      
       }
     
     
     j++;
     }
     if(comparator.compare(min,minDist)==-1 || comparator.compare(min,minDist)==0) {
         minDist=min;
         
     }
    
     //pQueue.add(min);
   }
   vertexIndex=minDist.vertexNo;
   //vertexIndex=pQueue.peek().vertexNo;
 //System.out.println("Index "+vertexIndex);
   //sampledVertices.add(vertexIndex);
   
   
    

}

samples[i]=new Dijkstra2(meshvertices,vertexIndex,2f);












}


}
