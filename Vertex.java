import java.util.ArrayList;
import processing.core.*;
import java.lang.Math;
import java.util.PriorityQueue;
public class Vertex {
  private PVector coordinates;
  public int vertexNo;
  public int region=-1;
  public boolean isMatched=false;
  public float oneRingArea;
  public float AGD;
  public float MGD;
  public float score;
  public char mainRegion='n';
  public Dijkstra2 dijk=null;
  public float vertexArea;
  public float curvature;
  boolean landmark =false;
  public Triangle renk=new Triangle();
  private ArrayList <Integer> komsular;
  public ArrayList<Triangle> ucgenKomsular=new ArrayList();

  public Vertex (PVector coordinates,int vertexNo) {
  this.coordinates=coordinates;
  this.vertexNo=vertexNo;
  this.renk.v0=this.renk.v1=this.renk.v2=192;

  this.komsular=new ArrayList <Integer> ();
  }
    
  
  
  
 public PVector getCoordinates () {
 
 return this.coordinates;}
 
 public void setCoordinates (PVector coordinates) {
 this.coordinates=coordinates;
 
 }
 public int getVertexNo() {
 
 return this.vertexNo;
 }
 public void setVertexNo(int vertexNo) {
 this.vertexNo=vertexNo;
 }
 public ArrayList<Integer> getKomsular(){
 return this.komsular;
 }
 public void findCurvature(ArrayList<Vertex> vertices) {
         float sumOfAngles=0;  
         for(Triangle tri : ucgenKomsular){
                 PVector vert = coordinates;
                 PVector v0=vertices.get(tri.v0).getCoordinates();
                 PVector v1=vertices.get(tri.v1).getCoordinates();
                 PVector v2=vertices.get(tri.v2).getCoordinates();
                 PVector Edge1= PVector.sub(vert,v0);
                 PVector Edge2 =PVector.sub(vert,v1);
                 PVector Edge3 =PVector.sub(vert,v2);
                 if(Edge1.x==0 && Edge1.y==0&& Edge1.z== 0){
                         sumOfAngles+= PVector.angleBetween(Edge2,Edge3);
                        
                 
                 }
                 else if(Edge2.x==0 && Edge2.y==0&& Edge2.z== 0){
                         sumOfAngles+= PVector.angleBetween(Edge1,Edge3);
                         
                 }
                 else if(Edge3.x==0 && Edge3.y==0&& Edge3.z== 0){
                         sumOfAngles+= PVector.angleBetween(Edge2,Edge1);
                         
                 
                 }
         
         }
      curvature=2*3.14159265358979323846f-sumOfAngles;
 
 }
 
 public void findVertexArea(){
       
          float area=0;  
         for(Triangle tri : ucgenKomsular){
                 area+=tri.alan;
         
         }
         
 
     vertexArea=area/3f;
 }
 public void setRenk(int i,int j,int k){
     renk.v0=i;
     renk.v1=j;
     renk.v2=k;
 
 }

 

}
