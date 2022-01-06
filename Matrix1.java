import java.lang.Math;
import java.util.*;
import Jama.*;
import processing.core.*;
public class Matrix1{
  public int n;
  ArrayList<Vertex> vertices;
  public double affinity[][];
  public double kernelWidth;
  public double squareKernel;
  Dijkstra2 samples[];
  public Matrix1(int n,ArrayList <Vertex> vertices,Dijkstra2 samples[]){
  this.n=n;
  this.affinity=new double[n][n];
  this.vertices=vertices;
  this.samples=samples;
  }
  public void findAffinity() {
     double value; 
    double kernelWidth=-1;
    for(int i=0;i<n;i++){
        for(int j=0;j<=i;j++){
            value=samples[i].distances.get(samples[j].vertexNo).distance;
            affinity[i][j]= value;
            affinity[j][i]=value;
        }
        if(kernelWidth<affinity[i][0])
          kernelWidth=affinity[i][0];
          
      }
      
      this.kernelWidth=kernelWidth;
    
      kernel();
      //printMtrx();
   
       findEigen(this.affinity,samples);
 
  }
  
  public void kernel() {
    double squareKernel=2*kernelWidth*kernelWidth;
    this.squareKernel=squareKernel;
  //  System.out.println("square kernel : "+squareKernel+" Kernelwidth:"+kernelWidth);
    double value;
    for(int i=0;i<n;i++){
      for(int j=0;j<=i;j++){
        value=(float)Math.exp((-(affinity[i][j]*affinity[i][j]))/squareKernel);
        affinity[i][j]=value;
        affinity[j][i]=value;
        
      }
    }
      
      //printMtrx();
      
  
  }
  public double[][] findEigen(double affinity[][],Dijkstra2 samples[]) {
  Matrix A = new Matrix(affinity);
  //A.print(5,2);
 
  EigenvalueDecomposition decomp=new EigenvalueDecomposition(A);
  double x[]=decomp.getRealEigenvalues();
  Matrix D=decomp.getD();
  Matrix V=decomp.getV();
  //V.print(5,2);
  //D.print(5,2);
//  Arrays.sort(x);
  //for(int i=0;i<x.length;i++)
  //  //System.out.println("eigenvalue: "+x[i]);
  double orderedValue[] =new double[3];
  int m=0;
 for(int i=2;i<5;i++){
 // System.out.println(x[n-i]);
  orderedValue[m++]=x[n-i];
 }
 double diagonal[][]=new double[3][3];
 double pseudodiagonal[][]=new double[3][3];
 for(int i=0;i<3;i++)
     for(int j=0;j<3;j++){
         if(i==j)
           { diagonal[i][j]=Math.sqrt(orderedValue[i]);
             pseudodiagonal[i][j]=(1/Math.sqrt(orderedValue[i]));}
         else {
             diagonal[i][j]=0;
             pseudodiagonal[i][j]=0;
         }
     
     }
     Matrix Pseudo =new Matrix(pseudodiagonal);
    Matrix Diag=new Matrix(diagonal);
     //Diag.print(5,2);
     
     
  double principal[][]=new double[n][3];
  for(int j=n-2;j>n-5;j--)
  for(int i=0;i<n;i++){
    principal[i][n-2-j]=V.getArray()[i][j];
  }
  Matrix princ=new Matrix(principal);
  //princ.print(5,2);
 

  
  Matrix pseudosonuc=(Pseudo.times(princ.transpose()));
  Matrix sonuc=(Diag.times(princ.transpose()));
//  sonuc.print(5,2);
double arr[][]=sonuc.getArray();
for(int i=0;i<n;i++){
    
    PVector coord=new PVector((float)arr[0][i],(float)arr[1][i],(float)arr[2][i]);
    vertices.get(samples[i].vertexNo).setCoordinates(coord);
    // vertices.get(samples[i].vertexNo).landmark=true;
    

}
AllPointsEmbedding(pseudosonuc,affinity,samples);
return arr;
  
  }
  public static void printMtrx(int n,float mat[][]){
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
           System.out.print(mat[i][j]+" ");
        
        }
       // System.out.println();
      }
  
  
  }
  
  public void AllPointsEmbedding(Matrix pseudosonuc,double [][]affinity,Dijkstra2 [] samples){
    double total=0; 
    double meanVec[][]=new double[n][1];
      for(int i=0;i<n;i++){
        total=0;
         for(int j=0;j<n;j++){
                 total+=samples[i].distances.get(j).distance;
         
         
         }
         //System.out.println("total "+total);
         meanVec[i][0]=total/n*total/n;
      
      
      }
      Vertex a;
      
    Matrix meanVector = new Matrix(meanVec);
    Matrix distToLandmarks =new Matrix(n,1);
    Matrix temp;
    double value;
    for(int i=0;i<vertices.size();i++){
      a=vertices.get(i);   
      
               
          for(int j=0;j<n;j++){
          value=samples[j].distances.get(i).distance;
          distToLandmarks.set(j,0,value*value);
       
          
          }
          
       
        
    
         PVector x=new PVector();
                     temp   =(pseudosonuc.times(distToLandmarks.minus(meanVector))).times(0.2);
                     x.x=(float)temp.get(0,0);
                     x.y=(float)temp.get(1,0);
                     x.z=(float)temp.get(2,0);
                     a.setCoordinates(x);
          
    
      
    }
  

  }
  public static double[][] multiplyMatrices(float[][] firstMatrix, double[][] secondMatrix, int r1, int c1, int c2) {
        double[][] product = new double[r1][c2];
        for(int i = 0; i < r1; i++) {
            for (int j = 0; j < c2; j++) {
                for (int k = 0; k < c1; k++) {
                    product[i][j] += firstMatrix[i][k] * secondMatrix[k][j];
                }
            }
        }

        return product;
    }


}
