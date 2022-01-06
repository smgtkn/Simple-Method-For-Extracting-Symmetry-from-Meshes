import java.util.PriorityQueue;
import java.util.Comparator;
import java.util.ArrayList;
import processing.core.PVector;
import java.util.Iterator;
public class Dijkstra2 {
  
  
  public int vertexNo;
  public int enUzak;
  public ArrayList <Integer> path;

  public float total;
  ArrayList<Vertex>vertices;
  public ArrayList <shortestDistance> distances;
  public PriorityQueue<shortestDistance> pQueue;
   public Dijkstra2(ArrayList<Vertex> vertices,int pointedVertex,float call) { // normal dijk call(2f) uniform dijk call(1f)
  pQueue=new PriorityQueue<shortestDistance>(vertices.size(),new myComparator());
  distances=new ArrayList<shortestDistance>();
 this. vertices=vertices;
  this.vertexNo=pointedVertex;
  for(int i=0;i<vertices.size();i++){
    
   if(i==pointedVertex) {
      distances.add(new shortestDistance(0,i,-1));
   //   pQueue.add(distances.get(i));
  
   continue;
   }  
   
     distances.add(new shortestDistance(Float.MAX_VALUE,i));
    //pQueue.add(distances.get(i));
  }
   pQueue.add(distances.get(pointedVertex));
   while(pQueue.size()!=0){
   shortestDistance u=pQueue.poll();
  
   //System.out.println("polled"+u.distance);
   distances.get(u.vertexNo).distance=u.distance;
   for(Integer i:vertices.get(u.vertexNo).getKomsular()){
       float tempDistance=0;
      if(call==2)
       tempDistance=u.distance+FindDistance(vertices.get(u.vertexNo).getCoordinates(),vertices.get(i).getCoordinates());
      if(call==1)
        tempDistance=u.distance+1;
      
      if(tempDistance<distances.get(i).distance ){
           
            distances.get(i).distance=tempDistance;
            distances.get(i).fromWhere=u.vertexNo;
            //pQueue.remove(distances.get(i));
            pQueue.add(distances.get(i));
             
            
          }
 
   }
  // System.out.println(pQueue.size());
   if(pQueue.size()==1)
    enUzak=pQueue.peek().vertexNo;

 }
 
 //for(shortestDistance m : distances) {
 
 //System.out.println("who: "+m.vertexNo+" from: "+m.fromWhere+" distance: "+m.distance);
 //}
 //System.out.println(vertices.get(5).getKomsular());
   }
   
   public Dijkstra2(ArrayList<Vertex> vertices,int pointedVertex,int endVertex) { // uzaklıklı dijk exit conditionla
  pQueue=new PriorityQueue<shortestDistance>(vertices.size(),new myComparator());
  distances=new ArrayList<shortestDistance>();
  path=new ArrayList<Integer>();
  this. vertices=vertices;
  this.vertexNo=pointedVertex;
  for(int i=0;i<vertices.size();i++){
    
   if(i==pointedVertex) {
      distances.add(new shortestDistance(0,i,-1));
   //   pQueue.add(distances.get(i));
  
   continue;
   }  
   
     distances.add(new shortestDistance(Float.MAX_VALUE,i));
    //pQueue.add(distances.get(i));
  }
   pQueue.add(distances.get(pointedVertex));
   while(pQueue.size()!=0){
   shortestDistance u=pQueue.poll();
  // System.out.println(u.vertexNo);
   if(u.vertexNo==endVertex)
     break;
   //System.out.println("polled"+u.distance);
   distances.get(u.vertexNo).distance=u.distance;
   for(Integer i:vertices.get(u.vertexNo).getKomsular()){
    float tempDistance=u.distance+FindDistance(vertices.get(u.vertexNo).getCoordinates(),vertices.get(i).getCoordinates());
      if(tempDistance<distances.get(i).distance ){
           
            distances.get(i).distance=tempDistance;
            distances.get(i).fromWhere=u.vertexNo;
            //pQueue.remove(distances.get(i));
            pQueue.add(distances.get(i));
             
            
          }
 
   }
  // System.out.println(pQueue.size());
   if(pQueue.size()==1)
    enUzak=pQueue.peek().vertexNo;

 }
 
 //for(shortestDistance m : distances) {
 
 //System.out.println("who: "+m.vertexNo+" from: "+m.fromWhere+" distance: "+m.distance);
 //}
 //System.out.println(vertices.get(5).getKomsular());
   }
   
   
       float FindDistance(PVector a,PVector b) {
  return   (float)Math.sqrt(Math.pow(a.x-b.x,2)+Math.pow(a.y-b.y,2)+Math.pow(a.z-b.z,2));
  }
  
 public ArrayList<Integer> findPathBetween(int end) {    
  path=new ArrayList<Integer>();
  
  while(distances.get(end).fromWhere!=-1){
  path.add(end);
  end=distances.get(end).fromWhere;
  
  
  }
  path.add(distances.get(end).vertexNo);
  path.add(vertexNo);
  
  return path;
    }
  
  
  public int findMiddle(int end){
    findPathBetween(end);
   int index=0;
   float exFark=Float.MAX_VALUE;
   float middle=distances.get(end).distance/2;
  for( Integer i : path) {
   float fark =middle-distances.get(i).distance;
   fark=Math.abs(fark);
   if(fark<exFark) {
   exFark=fark;
   index=i;
   
   }
  }
  
  return index;
  
  }
  public void findTotal() {
  this.total=0;
  for(int i=0;i<distances.size();i++){
  total+=distances.get(i).distance;
  
  }
  
  }
  
 
  
  public Dijkstra2(ArrayList<Vertex> vertices,int pointedVertex, double radius) {  // uniform dijk radiuslu
  pQueue=new PriorityQueue<shortestDistance>(vertices.size(),new myComparator());
  distances=new ArrayList<shortestDistance>();
 this. vertices=vertices;
  this.vertexNo=pointedVertex;
  for(int i=0;i<vertices.size();i++){
    
   if(i==pointedVertex) {
      distances.add(new shortestDistance(0,i,-1));
   //   pQueue.add(distances.get(i));
  
   continue;
   }  
   
     distances.add(new shortestDistance(Float.MAX_VALUE,i));
    //pQueue.add(distances.get(i));
  }
   pQueue.add(distances.get(pointedVertex));
   while(pQueue.size()!=0){
   shortestDistance u=pQueue.poll();
  if(u.distance>radius){

    
       break;}
   //System.out.println("polled"+u.distance);
   distances.get(u.vertexNo).distance=u.distance;
   for(Integer i:vertices.get(u.vertexNo).getKomsular()){
    float tempDistance=u.distance+1;
      if(tempDistance<distances.get(i).distance ){
           
            distances.get(i).distance=tempDistance;
            distances.get(i).fromWhere=u.vertexNo;
            //pQueue.remove(distances.get(i));
            pQueue.add(distances.get(i));
             
            
          }
 
   }
  // System.out.println(pQueue.size());
   if(pQueue.size()==1)
    enUzak=pQueue.peek().vertexNo;

 }
 

   
  
  
  }
  
  
  
    public Dijkstra2(ArrayList<Vertex> vertices,int pointedVertex, double radius,int no) { // radiuslu nonuniform dijk
  pQueue=new PriorityQueue<shortestDistance>(vertices.size(),new myComparator());
  distances=new ArrayList<shortestDistance>();
 this. vertices=vertices;
  this.vertexNo=pointedVertex;
  for(int i=0;i<vertices.size();i++){
    
   if(i==pointedVertex) {
      distances.add(new shortestDistance(0,i,-1));
   //   pQueue.add(distances.get(i));
  
   continue;
   }  
   
     distances.add(new shortestDistance(Float.MAX_VALUE,i));
    //pQueue.add(distances.get(i));
  }
   pQueue.add(distances.get(pointedVertex));
   while(pQueue.size()!=0){
   shortestDistance u=pQueue.poll();
  if(u.distance>radius){

    
       break;}
   //System.out.println("polled"+u.distance);
   distances.get(u.vertexNo).distance=u.distance;
   for(Integer i:vertices.get(u.vertexNo).getKomsular()){
    float tempDistance=u.distance+FindDistance(vertices.get(u.vertexNo).getCoordinates(),vertices.get(i).getCoordinates());
      if(tempDistance<distances.get(i).distance ){
           
            distances.get(i).distance=tempDistance;
            distances.get(i).fromWhere=u.vertexNo;
            //pQueue.remove(distances.get(i));
            pQueue.add(distances.get(i));
             
            
          }
 
   }
  // System.out.println(pQueue.size());
   if(pQueue.size()==1)
    enUzak=pQueue.peek().vertexNo;

 }
 

   
  
  
  }
  
  
  public static ArrayList<Dijkstra2> DijkstraForAll(ArrayList <Integer> pointsToDijk, ArrayList<Vertex> vertices) {
   int theSize=pointsToDijk.size();
   ArrayList<Dijkstra2> dijkForAll=new ArrayList<Dijkstra2>();
   for(int i=0;i<theSize;i++){
   
         dijkForAll.add(new Dijkstra2(vertices,pointsToDijk.get(i),2f));
         System.out.println("Dijk yapiliyor... vertex : "+pointsToDijk.get(i));
   
   
   
   }  
  
  
  
  return dijkForAll;
  }
  
  
}
