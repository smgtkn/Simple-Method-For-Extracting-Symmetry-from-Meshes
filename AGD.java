import java.util.*;
import java.lang.Math;
import processing.core.*;

public class AGD {
public ArrayList<Vertex> vertices;
public ArrayList <Triangle> triangles;
public ArrayList<Integer> localMins;
public ArrayList <Integer> S1;

public PShape sekil;
public ArrayList<Integer> S2;
public PApplet papplet;
public AGD(ArrayList<Vertex> vertices,ArrayList <Triangle> triangles,PApplet papplet,PShape sekil) {
    this.sekil=sekil;
    this.papplet=papplet;
    this.triangles=triangles;
    this.vertices=vertices;
    this.S2=new ArrayList<Integer> ();
   this.S1=new ArrayList<Integer> ();
}

public float[][] createAGDdifferenceMatrix(){
     int size=S1.size();
    
     float differenceMat[][]=new float[size][size]; 
     for(int i=0;i<size;i++ ){
             float difference=vertices.get(S1.get(i)).AGD; 
             for(int j=0;j<size;j++){
                     if(i==j){
                           differenceMat[i][j]=Float.MAX_VALUE; 
                           continue;
                     }
                     differenceMat[i][j]=Math.abs(difference-vertices.get(S1.get(j)).AGD);
   
             }

     }
    Matrix1.printMtrx(size,differenceMat);
     
return differenceMat;
}


  //AGD düzgün yapabilmek icin ilk once calculateRingArea yapılmalı kesinlikle.
public void CalculateRingArea() {  // Calculates one ring area for all the vertices. Vertex class has a field named oneRingArea.
      int size=vertices.size();
      float total=0;
      for(int i=0;i<size;i++){
            total=0;
            Vertex a=vertices.get(i);
            int sizeKomsular=a.ucgenKomsular.size();
            for(int j=0;j<sizeKomsular;j++){
                total+=a.ucgenKomsular.get(j).alan;            
            }
            a.oneRingArea=total;
          //  System.out.println(total);
            
      }

return;
}
public ArrayList<Integer> MGD() {
      ArrayList<Dijkstra2>localMaxDijk=new ArrayList<Dijkstra2>();
      for(Integer i : S1){
      
          localMaxDijk.add(new Dijkstra2(vertices,i,2f));
      
      
      }
      
      ArrayList<Integer> S2=new ArrayList<Integer>();
      int localMaxDijkSize=S1.size();
      int theSize=vertices.size();
      for(int i=0;i<theSize;i++){
        float min=Float.MAX_VALUE;
        for(int j=0;j<localMaxDijkSize;j++){
                    float distance=localMaxDijk.get(j).distances.get(i).distance;
                    if(distance<min){
                          min=distance;
                    }        
        
        }
            
      vertices.get(i).MGD=min;
    //  vertices.get(i).renk.v1=(int)(min*10f);
    //  vertices.get(i).renk.v2=(int)(min*10f);
      //System.out.println("MGD for "+i+" : "+ min);
      
      }
      
      
         ArrayList<Float > tempMGD=new ArrayList<Float>();
        for(Vertex vert : vertices ){  //average AGD over 1-ring 
        
                ArrayList<Integer> neighboursOfVert = vert.getKomsular();
                float total=vert.MGD;
                for(Integer i : neighboursOfVert){
                
                      total+=vertices.get(i).MGD;
 
                
                }
        
               tempMGD.add(total/(neighboursOfVert.size()+1)); 
        
        }
        int l=0;
        for(Vertex vert:vertices ){
              vert.MGD=tempMGD.get(l);
              l++;
        }
      
      
      
      
      Vertex temp;
        for(int i=0;i<theSize;i++){
             temp=vertices.get(i);
             boolean flag=true;
             int looplength=temp.getKomsular().size();
             for(int j=0;j<looplength;j++){  // komsulara bakılıyor 1-ring
             
                 if(temp.MGD<vertices.get(temp.getKomsular().get(j)).MGD){
                    flag=false;
                    break; 
                 }
                   
                 
          
             }
             if(flag){
                 S2.add(i);
                // System.out.println(i);
             }
            
        }
        Normalize('M');

this.S2=S2;


return S2;

}
public void Normalize(char caseX ) {
  float min=Float.MAX_VALUE;
        float max=0;
        float payda;    
  switch(caseX) {
      
        
        case 'A':
      
        for(Vertex i : vertices){
              
              if(min>i.AGD)
                    min=i.AGD;
          
               if(max<i.AGD)
                    max=i.AGD;
        
        }
        payda=max-min;
        for(Vertex i : vertices){
             i.AGD=(i.AGD-min)/payda;
             //i.renk.v0=(int)(i.AGD*1.5f);
        }
        break;
        case 'M':
        min=Float.MAX_VALUE;
        max=0;
        for(Vertex i : vertices){
              
              if(min>i.MGD)
                    min=i.MGD;
          
               if(max<i.MGD)
                    max=i.MGD;
        
        }
         payda=max-min;
        for(Vertex i : vertices){
             i.MGD=(i.MGD-min)/payda;
             //i.renk.v0=(int)(i.AGD*1.5f);
        }
        
      }
}

public ArrayList<Integer> AGDForAllVerts(Dijkstra2[] samples) {
        
        int looplength=samples.length;
        float total=0;
        int size=vertices.size();
        
        Vertex temp;
        for(int k=0;k<size;k++){
              total=0;
              temp=vertices.get(k);
              for(int i=0;i<looplength;i++){
                 total+=samples[i].distances.get(k).distance*vertices.get(samples[i].vertexNo).oneRingArea/3f;   
        
               //     total+=samples[i].distances.get(k).distance;
              }
              
              temp.AGD=total;
              
        }
        
         ArrayList<Float > tempAGD=new ArrayList<Float>();
        for(Vertex vert : vertices ){  //average AGD over 1-ring 
        
                ArrayList<Integer> neighboursOfVert = vert.getKomsular();
                 total=vert.AGD;
                for(Integer i : neighboursOfVert){
                
                      total+=vertices.get(i).AGD;
 
                
                }
        
               tempAGD.add(total/(neighboursOfVert.size()+1)); 
        
        }
        int l=0;
        for(Vertex vert:vertices ){
              vert.AGD=tempAGD.get(l);
              l++;
        }
       
        
        
       
        
         for(int i=0;i<size;i++){
             temp=vertices.get(i);
             boolean flag=true;
             looplength=temp.getKomsular().size();
             for(int j=0;j<looplength;j++){  // komsulara bakılıyor 1-ring
             
                 if(temp.AGD<vertices.get(temp.getKomsular().get(j)).AGD){
                    flag=false;
                    break; 
                 }
                 
                 
             
             }
             if(flag){
                 S1.add(i);
                 
             }
            
        }
        
        
    Normalize('A');
       
return S1;
}
public void paintField(int color1,int color2,int color3,float strokeWeight,ArrayList<Integer> fieldToBePainted) {
     
       for(Integer i : fieldToBePainted){
       
        PVector v=vertices.get(i).getCoordinates();
        PShape paint=papplet.createShape();
        paint.beginShape(processing.core.PApplet.POINTS);
        paint.strokeWeight(strokeWeight);
        paint.stroke(papplet.color(color1,color2,color3));
        paint.vertex(v.x,v.y,v.z);
        paint.endShape();
        sekil.addChild(paint);


    
    }


}



}
