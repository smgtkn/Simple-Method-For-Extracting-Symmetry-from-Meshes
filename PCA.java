import processing.core.PVector;
import processing.core.PShape;
import processing.*;
import java.util.*;
import java.lang.Math;
import Jama.*;
public class PCA {

      static PVector centerOfMass(ArrayList<Vertex> vertices) {
            int size=vertices.size();  
            float x=0,y=0,z=0;
            for(int i=0;i<size;i++){
                  PVector point=vertices.get(i).getCoordinates();
                  x+=point.x;
                  y+=point.y;
                  z+=point.z;
            }
      
        System.out.println("center " +x/size +" " + y/size + " "+ z/size);      
         return new PVector(x/size,y/size,z/size);
      }


    static double[][] Covariance(ArrayList<Vertex> vertices,PVector center,float[][] AlignAxes) {
              int size=vertices.size();
              double a00=0,a10=0,a11=0,a20=0,a21=0,a22=0;
              for(int i=0;i<size;i++){
                    PVector coords=vertices.get(i).getCoordinates();
                    coords.x=coords.x-center.x; // translate the center of the shape to 0,0,0
                    coords.y=coords.y-center.y;
                    coords.z=coords.z-center.z;
                    a11+=coords.y*coords.y;
                    a22+=coords.z*coords.z;
                    a00+=coords.x*coords.x;
                    a10+=coords.x*coords.y;
                    a20+=coords.x*coords.z;
                    a21=coords.y*coords.z;
              }
              double[][] cov=new double[3][3];
              cov[0][0]=a00;
              cov[0][1]=a10;
              cov[0][2]=a20;
              cov[1][0]=a10;
              cov[1][1]=a11;
              cov[1][2]=a21;
              cov[2][0]=a20;
              cov[2][1]=a21;
              cov[2][2]=a22;
   // Matrix1.printMtrx(3,(float)cov);
     Matrix A = new Matrix(cov);
   EigenvalueDecomposition decomp=new EigenvalueDecomposition(A);
  double x[]=decomp.getRealEigenvalues();
  Matrix D=decomp.getD();
  Matrix V=decomp.getV();
  V.print(5,2);
    D.print(5,2);
    double [][] arrayD=D.getArray();
  double [][] arrayV=V.getArray();
   for(int i=0;i<3;i++){ //normalization 
       double total=arrayV[0][i]*arrayV[0][i]+arrayV[1][i]*arrayV[1][i]+arrayV[2][i]*arrayV[2][i];
       total=Math.sqrt(total);
       arrayV[0][i]/=total;
       arrayV[1][i]/=total;
       arrayV[2][i]/=total;
   }
   
   
   PriorityQueue<MyTuple> eigenValuesOrdering=new PriorityQueue<MyTuple> (3,new TupleComparator());
   eigenValuesOrdering.add(new MyTuple((float)arrayD[0][0],0,0));
   eigenValuesOrdering.add(new MyTuple((float)arrayD[1][1],1,1));
   eigenValuesOrdering.add(new MyTuple((float)arrayD[2][2],2,2));
   int w=eigenValuesOrdering.poll().vertexNo;
   int v=eigenValuesOrdering.poll().vertexNo;
   int u=eigenValuesOrdering.poll().vertexNo;
 for(int i=0;i<3;i++){
   AlignAxes[0][i]=(float)arrayV[i][v];
   AlignAxes[1][i]=(float)arrayV[i][u];
   AlignAxes[2][i]=(float)arrayV[i][w];
   AlignAxes[3][i]=0;
 }
   AlignAxes[3][3]=1; // u v w 'li matris oluşturuldu 
   AlignAxes[2][3]=0;
   AlignAxes[1][3]=0;
   AlignAxes[0][3]=0;
   
 System.out.println("ALIGNAXES MATRIX"); 
 Matrix1.printMtrx(4,AlignAxes);
 
    return arrayV;
    }
    
   static void Alignment(ArrayList<Vertex> vertices,float[][] AlignAxes){
   
        int size=vertices.size();
        
        for(int i=0;i<size;i++){
          PVector vertex=vertices.get(i).getCoordinates();
          double[][] pointMatrix=new double[4][1];
          pointMatrix[0][0]=vertex.x;
          pointMatrix[1][0]=vertex.y;
          pointMatrix[2][0]=vertex.z;
          pointMatrix[3][0]=1;
          
          double[][] point=Matrix1.multiplyMatrices(AlignAxes,pointMatrix,4,4,1);
           vertex.x=(float)point[0][0];
           vertex.y=(float)point[1][0];
           vertex.z=(float)point[2][0];
           
        }
        

   }
   
   
   
    static ArrayList<PVector> symmetricFPSPoints(ArrayList <Vertex> vertices, Dijkstra2 [] samples,float MeshArea){
           int size=samples.length;
           float epsilon = 0.03f*(float)Math.sqrt(MeshArea);
           ArrayList<PVector> symPoints=new ArrayList<PVector> (size);
           for(int i=0;i<size;i++){
                 PVector base=vertices.get(samples[i].vertexNo).getCoordinates();
                 
                 PVector sym=new PVector(-1*base.x,base.y,base.z);
                 if(isClose(sym,vertices,epsilon) ){
                 symPoints.add(sym);
                 symPoints.add(base);
                 }
           
           }
   
   
       return symPoints;
   }
   
   
   static boolean isClose(PVector b,ArrayList <Vertex> vertices,float epsilon) {
     int size=vertices.size();          
     boolean flag=false;
     for(int i=0;i<size;i++){
             PVector a=vertices.get(i).getCoordinates();
             if((float)Math.sqrt(Math.pow(a.x-b.x,2)+Math.pow(a.y-b.y,2)+Math.pow(a.z-b.z,2))<epsilon){
                       flag=true;
                       //b.x=a.x;
                       //b.y=a.y;
                       //b.z=a.z;
                       break;
             
             }
     
     
     }
     return flag;
   }
    

}
