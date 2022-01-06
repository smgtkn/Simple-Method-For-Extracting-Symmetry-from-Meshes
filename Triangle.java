import processing.core.PVector;
import java.util.*;
import java.lang.Math;
public class Triangle{

  public int v0;
  public int v1;
  public int v2;
  float alan;
  public Triangle(int v0,int v1,int v2) {
      this.v0=v0;
      this.v1=v1;
      this.v2=v2;
  
  }
  public Triangle(){
      v1=v2=v0=0;
  }
  public float alanHesapla(ArrayList <Vertex> vertices) { //returns çevre
  
         Vertex a=vertices.get(v0); 
         Vertex b=vertices.get(v1);
         Vertex c=vertices.get(v2);
         float edge1=  FindDistance(a.getCoordinates(),b.getCoordinates());
         float edge2=  FindDistance(b.getCoordinates(),c.getCoordinates());
         float edge3=  FindDistance(a.getCoordinates(),c.getCoordinates());
         float u=(edge1+edge2+edge3)/2f;
         alan=(float)Math.sqrt(u*(u-edge1)*(u-edge2)*(u-edge3));
  //       System.out.println("alan : "+alan);
  return u*2;
 }
  
  float FindDistance(PVector a,PVector b) {
        return   (float)Math.sqrt(Math.pow(a.x-b.x,2)+Math.pow(a.y-b.y,2)+Math.pow(a.z-b.z,2));
  }
  
  
  static float findMeshArea(ArrayList<Triangle> triangles) {
          int size=triangles.size();
          float Total=0;
          for(int i=0;i<size;i++)
                Total+=triangles.get(i).alan;
        
      return Total;
  }

}
