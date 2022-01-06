import javafx.util.Pair; 
import java.util.*;
import java.math.BigDecimal; 
import java.io.FileNotFoundException;  
import java.io.*;
ArrayList<MyTuple> matches;
float translateX=0,translateY=0;
float avgEdgeLength=0;
int matchSize=0;
float meshArea=0;
float maxPoint=0;
  ArrayList<Vertex> rightHandReg2=new ArrayList(); 
  ArrayList<Vertex> leftHandReg2=new ArrayList(); 
  ArrayList<Vertex> rightFootReg2=new ArrayList(); 
  ArrayList<Vertex> leftFootReg2=new ArrayList();

  ArrayList<Vertex> mainRegLeft2=new ArrayList();
    ArrayList<Vertex> mainRegRight2=new ArrayList();
  
float translateSpeed=0.01f;
 float rotationRate=0.05;
PShape sekil;
float quality=0;
float zoomRate=0.5f;
ArrayList<Integer> symInfo;
int numOfMiddles=10;
int pointedVertex=1;

float scale=0.01f;
int norm=4;
int leftHand,rightHand,leftFoot,rightFoot;
ArrayList <Vertex> vertices;
ArrayList<Triangle> triangles;
ArrayList<Vertex> mainRegFPS;
ArrayList<MyPair<Integer>> previousMatches;

ArrayList<Vertex> source ;
  ArrayList<MyPair<Integer>> target;
  ArrayList<Vertex> TestLeftHand;
  ArrayList<Vertex> TestRightHand;
    ArrayList<Vertex> TestLeftFoot;
  ArrayList<Vertex> TestRightFoot;
    ArrayList<Vertex> TestMainReg;
 
int num=8;
void setup () {

  size(1000,1000,P3D);
  source = new ArrayList();
  target = new ArrayList();
  TestLeftHand=new ArrayList();
  TestRightHand=new ArrayList();
  TestLeftFoot=new ArrayList();
  TestRightFoot=new ArrayList();
  TestMainReg=new ArrayList();
  previousMatches=new ArrayList();
   ArrayList<PVector> coordinatesCopy=new ArrayList();
   
  long start = System. currentTimeMillis(); 
 //String filename="cat0.off";
//String filename="../../kids/off/0001.isometry.3.off";
//String filename="dino.off";
String filename="../../SurfCorr2.0.benchmarks.bins/CorrsBenchmark/Data/TOSCA/Meshes/cat10.off";
String filenameSym="../../SurfCorr2.0.benchmarks.bins/CorrsBenchmark/Data/TOSCA/Corrs/cat.sym.info";
String filenameSym2="../../SurfCorr2.0.benchmarks.bins/CorrsBenchmark/Data/TOSCA/Corrs/cat.pid";

//String filename="../../SurfCorr2.0.benchmarks.bins/CorrsBenchmark/Data/SCAPE/Meshes/mesh001.off";
//String filenameSym="../../SurfCorr2.0.benchmarks.bins/CorrsBenchmark/Data/SCAPE/Corrs/1.sym.info";
//String filenameSym2="../../SurfCorr2.0.benchmarks.bins/CorrsBenchmark/Data/SCAPE/Corrs/1.pid";



  loadFile(filename);
  println(filename);

  //symInfo=loadSymInfo("sym.txt");
  sekil=createShape(GROUP);
 matches=new ArrayList();
  ArrayList<Dijkstra2> handsAndFeet=new ArrayList();
  for(Vertex vert: vertices){
      PVector coords=vert.getCoordinates();
      coordinatesCopy.add(new PVector(coords.x,coords.y,coords.z));
  }
  
  FPS points=new FPS(vertices,200); 
  FPS pointsForMDS=new FPS(vertices,200); 
 
 
  points.farthestPoint(vertices,pointedVertex,vertices);
   float radius=points.samples[0].distances.get(points.samples[1].vertexNo).distance;
 println(radius);
  Matrix1 MDS= new Matrix1(200,vertices,points.samples);
  MDS.findAffinity();
  pointsForMDS.farthestPoint(vertices,pointedVertex,vertices);
  AGD agdfunc=new AGD(vertices,triangles,this,sekil);
  agdfunc.CalculateRingArea();
  agdfunc.AGDForAllVerts(pointsForMDS.samples);
// agdfunc.paintField(233,0,14,12,agdfunc.S1);
  agdfunc.MGD();
 // agdfunc.paintField(0,0,255,12,agdfunc.S2);
  

  float ind=0;
   ArrayList<MyPair<Float>>MGDsOfHandsAndFeet=new ArrayList();

  for(int i=0;i<num;i++){ 
 //Paint(255,0,0,vertices.get(pointsForMDS.samples[i].vertexNo).getCoordinates(),30);
    
    if(i!=4 && i!=5 && i!= 2 && i!=6) //Cat0
        continue;
      //if(i!=1 && i!=3 && i!=5 && i!=4) // wolf2
      //  continue;
   
      
        int vertNo=pointsForMDS.samples[i].vertexNo;
      
      // println("AGD "+i+" "+vertices.get(vertNo).AGD);
  
   handsAndFeet.add(pointsForMDS.samples[i]);

     MGDsOfHandsAndFeet.add(new MyPair(vertices.get(pointsForMDS.samples[i].vertexNo).AGD,ind));
ind++;
     
  } 

  
  MatchHandsAndFeet(MGDsOfHandsAndFeet);
 // rightHand=0;leftFoot=1;leftHand=2;rightFoot=3; //sym 12 0 1 2 3, kadın  3 1 0 2,adam 1 0 3 2,gorilla  2 3 0 1 ,sym02-9 2 3 0 1 ,sym02-13 2 3 0 1,sym1-4 ,reg24- 1 2 3 3
  DefineLeftRight(MGDsOfHandsAndFeet,handsAndFeet);
  for(int i=0;i<vertices.size();i++) {
   Vertex vert=vertices.get(i);
       vert.setCoordinates(coordinatesCopy.get(i));
   
 }
 for(int i=0;i<4;i++) {
  
  handsAndFeet.set(i, new Dijkstra2(vertices,handsAndFeet.get(i).vertexNo,2f));
 
 }
 elayakmatch(handsAndFeet);

  
  ArrayList<Vertex> rightHandReg=new ArrayList(); 
  ArrayList<Vertex> leftHandReg=new ArrayList(); 
  ArrayList<Vertex> rightFootReg=new ArrayList(); 
  ArrayList<Vertex> leftFootReg=new ArrayList(); 
  ArrayList<Vertex> mainReg=new ArrayList();
  ArrayList<Vertex> left=new ArrayList();
  ArrayList<Vertex> right=new ArrayList();
  ArrayList<Vertex> mainRegLeft=new ArrayList();
  ArrayList<Vertex> mainRegRight=new ArrayList();
  ArrayList<Vertex> leftHandRegFPS=new ArrayList();
  ArrayList<Vertex> rightHandRegFPS=new ArrayList();
    ArrayList<Vertex> leftFootRegFPS=new ArrayList();
  ArrayList<Vertex> rightFootRegFPS=new ArrayList();
  ArrayList<Vertex> leftMainRegFPS=new ArrayList();
  ArrayList<Vertex> rightMainRegFPS=new ArrayList();
 mainRegFPS=new ArrayList();
  Partition4Regions(handsAndFeet,leftHandReg,rightHandReg,leftFootReg,rightFootReg,mainReg,mainRegLeft,mainRegRight,leftHandRegFPS,rightHandRegFPS,leftFootRegFPS,rightFootRegFPS,leftMainRegFPS,rightMainRegFPS);

   
 
    Paint(255,0,0,vertices.get(handsAndFeet.get(leftHand).vertexNo).getCoordinates(),30);
   Paint(0,0,255,vertices.get(handsAndFeet.get(rightHand).vertexNo).getCoordinates(),30);
  Paint(255,0,0,vertices.get(handsAndFeet.get(leftFoot).vertexNo).getCoordinates(),30);
   Paint(0,0,255,vertices.get(handsAndFeet.get(rightFoot).vertexNo).getCoordinates(),30);

////////// //////***********************************
 
  loadTestMatches(filenameSym,filenameSym2);
  ArrayList<Integer> bestMatchesStart=new ArrayList();
  ArrayList<Integer> bestMatchesEnd=new ArrayList();
  ArrayList<  Dijkstra2> mids=new ArrayList<Dijkstra2>(0);
   Dijkstra2 leftHandDijk=handsAndFeet.get(leftHand);
   Dijkstra2 rightHandDijk=handsAndFeet.get(rightHand);
   Dijkstra2 leftFootDijk=handsAndFeet.get(leftFoot);
   Dijkstra2 rightFootDijk=handsAndFeet.get(rightFoot);
   int handsMid=leftHandDijk.findMiddle(rightHandDijk.vertexNo);
   int feetMid=leftFootDijk.findMiddle(rightFootDijk.vertexNo);
   Dijkstra2 handsMidDijk=new Dijkstra2 (vertices,handsMid,2f);
   Dijkstra2 feetMidDijk=new Dijkstra2 (vertices,feetMid,2f);
  int midElAyak1 =leftHandDijk.findMiddle(leftFootDijk.vertexNo);
  int midElAyak2 =rightHandDijk.findMiddle(rightFootDijk.vertexNo);
  Dijkstra2 dijkElAyak1=new Dijkstra2(vertices,midElAyak1,2f);
  int midMid=dijkElAyak1.findMiddle(midElAyak2);
  Dijkstra2 dijkMid=new Dijkstra2(vertices,midMid,2f);
  // Paint (255,0,0,vertices.get(midMid).getCoordinates(),40);
  
 ArrayList<Vertex> S2LeftMain=new ArrayList();
 ArrayList<Vertex> S2RightMain=new ArrayList();
 ArrayList<Vertex> S2LeftFoot=new ArrayList();
 ArrayList<Vertex> S2RightFoot=new ArrayList();
 ArrayList<Vertex> S2LeftHand=new ArrayList();
 ArrayList<Vertex> S2RightHand=new ArrayList();

 DivideS2LeftRight(left, right,agdfunc.S1,S2LeftMain ,  S2RightMain,S2LeftHand ,  S2RightHand,S2LeftFoot ,  S2RightFoot);
FindMatch(S2LeftHand,S2RightHand,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
           ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,0,5,1);
FindMatch(S2LeftFoot,S2RightFoot,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
           ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,0,5,1);


   //println("Quality S2 -1:"+quality);
            int midsCurrentSize=mids.size();
            int prevCurrentSize=previousMatches.size();
  
 quality=0;
 matchSize=0;
 
  S2LeftMain=new ArrayList();
 S2RightMain=new ArrayList();
 S2LeftFoot=new ArrayList();
S2RightFoot=new ArrayList();
 S2LeftHand=new ArrayList();
  S2RightHand=new ArrayList();
  
   DivideS2LeftRight(left, right,agdfunc.S2,S2LeftMain ,  S2RightMain,S2LeftHand ,  S2RightHand,S2LeftFoot ,  S2RightFoot);
FindMatch(S2LeftHand,S2RightHand,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
           ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,0,5,1);
FindMatch(S2LeftFoot,S2RightFoot,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
           ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,0,5,1);

 //println("Quality S2 -2 :"+quality/matchSize/radius);
 //println ("mids S2 "+mids.size());
       
        println( "Stage 1-2: "+ (System.currentTimeMillis()-start)/1000.f);
 for(int i=0;i<prevCurrentSize;i++) {
       previousMatches.remove(0);
     

 }
 
 
            
  prevCurrentSize=previousMatches.size();
 quality=0;
 matchSize=0;
   
  
   FindMatch(leftFootRegFPS,rightFootReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
            ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,15,1);
  FindMatch(leftHandRegFPS,rightHandReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
            ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,15,1);
            
            println( "Stage 3: "+ (System.currentTimeMillis()-start)/1000.f);
 
   // println("prev matches size " +previousMatches.size());
    
 for(int i=0;i<prevCurrentSize;i++) {
       previousMatches.remove(0);
     
 }

// println("Quality 1 :"+quality/matchSize/radius);           
            
 quality=0;
  matchSize=0;
  //**************************
          //   matches=new ArrayList();
             
             //***********************
   prevCurrentSize=previousMatches.size();
      FindMatch(mainRegFPS,mainReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
            ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,mainRegFPS.size(),0);
           
    FindMatch(leftFootRegFPS,rightFootReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
            ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,leftFootRegFPS.size(),0);
  FindMatch(leftHandRegFPS,rightHandReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
            ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,leftHandRegFPS.size(),0);
  
 println( "Stage 4: "+ (System.currentTimeMillis()-start)/1000.f);
  
  ArrayList<MyPair<Integer>> previousMatchesCopy=new ArrayList();
         for(MyPair <Integer> pair : previousMatches) {
         
                 previousMatchesCopy.add(new MyPair(pair.x,pair.y));
         
         }
   
   
 //for(int i=0;i<prevCurrentSize;i++) {  // sym axis için burayı yörumla, puan için kaldır !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!^^^^^^^^^^^^^^^^^###########################
 //      previousMatches.remove(0);
     

 //}
// println("sizes "+matches.size() +" "+previousMatches.size() +" "+ matchSize);
 
            
 
          Ayiklama();
            
            prevCurrentSize=previousMatches.size();
      //println("Quality 2 :"+quality/matchSize/radius);
       

            points=null;
      System.gc(); 
            

            //println("sizes "+matches.size() +" "+previousMatches.size() +" "+ matchSize);
            func(vertices,previousMatchesCopy);
            
         //   println("MATCH SIZE : "+matchSize);
         //   Puanlama(radius);
         //   Puanlama2(meshArea);
           //****
         //    matches=new ArrayList();
           //   matchSize=0;
        //      println(leftHandReg.size()+" "+rightHandReg.size()+" "+leftFootReg.size());
              ArrayList<Vertex>left1 =new ArrayList();
              ArrayList<Vertex> right1=new ArrayList();
          
              for(int i=0 ;i<vertices.size();i++){
              //  println(vertices.get(i).mainRegion);
                    if(vertices.get(i).mainRegion==1)
                        left1.add(vertices.get(i));
                     else{
                        right1.add(vertices.get(i));}
              }
              float mymax=0, mymin=0;
              for(int i=0;i<left1.size();i++){
                      float temp=left1.get(i).getCoordinates().x;
                        if(temp<mymin)
                            mymin=temp;
                         if(temp>mymax)
                              mymax=temp;
                
                
              }
              
        //         if(left1.size()>right1.size()){
             for(int i=0;i<left1.size();i++){
                   float y=left1.get(i).getCoordinates().x;
                //   println((y-mymin)/(mymax-mymin));
                   left1.get(i).setRenk(150,int((y-mymin)/(mymax-mymin)*255),int((y-mymin)/(mymax-mymin)*255));
                 
             }
              
              
 
           
          println(left1.size()+" "+right1.size());
          
          //     FindMatchTest(mainRegLeft2,mainRegRight2,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
          //    ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,mainRegLeft2.size(),0);
               
          
          //    FindMatchTest(leftHandReg2,rightHandReg2,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
          //    ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,leftHandReg2.size(),0);
          
         
              
          //    FindMatchTest(leftFootReg2,rightFootReg2,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
          //    ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,leftFootReg2.size(),0);
              
          //    println( "Dense: "+ (System.currentTimeMillis()-start)/1000.f);
           
        matches=new ArrayList();
              matchSize=0;
              FindMatchTest(TestLeftHand,rightHandReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
              ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,TestLeftHand.size(),0);
             FindMatchTest(TestLeftFoot,rightFootReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
              ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,TestLeftFoot.size(),0);
              
             FindMatchTest(TestMainReg,mainReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
              ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,TestMainReg.size(),0);
            
             FindMatchTest(TestRightHand,leftHandReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
              ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,TestRightHand.size(),0);
             
              FindMatchTest(TestRightFoot,leftFootReg,dijkMid,handsMidDijk,feetMidDijk,handsAndFeet.get(leftHand),handsAndFeet.get(rightHand) 
              ,handsAndFeet.get(leftFoot), handsAndFeet.get(rightFoot),norm,bestMatchesStart,bestMatchesEnd,mids,1,TestRightFoot.size(),0);
              //******
           
               Puanlama(radius);
            Puanlama2(meshArea);
              

// func2(vertices,previousMatchesCopy);
   DrawMatches();
  
           
           

System.gc();
//System.out.println("Meg used="+(Runtime.getRuntime().totalMemory()-
//Runtime.getRuntime().freeMemory())/(1000*1000)+"M");
 drawShape();
 long end = System.currentTimeMillis();
long elapsedTime = end - start; 


println("time: "+elapsedTime/1000.f);
}
void draw() {
  background(255);
translate(width/2,height/2);
fill(155);
ellipse(-400,-370,80,80);
//fill(0);
ellipse(-400,-270,80,80);
//rotateX(PI/4);
 
 pushMatrix();
 scale(scale);
 shape(sekil,translateX,translateY);
 popMatrix();
// shape(mdssekil,0,80);
 vertices=null;

  if(keyPressed){
    keyPressedContinuously();
  }
  if(pmouseX-mouseX>7 && mousePressed){
  sekil.rotateY(-rotationRate);
 // mdssekil.rotateY(-rotationRate);
  }
  if(pmouseX-mouseX<-7 && mousePressed){
  sekil.rotateY(rotationRate);
 // mdssekil.rotateY(rotationRate);

  }
  if(pmouseY-mouseY>5 && mousePressed){
  sekil.rotateX(rotationRate);
//  mdssekil.rotateX(rotationRate);
  }
  if(pmouseY-mouseY<-5 &&mousePressed){
  sekil.rotateX(-rotationRate);
 // mdssekil.rotateX(-rotationRate);
  }

  
  if((pow(mouseX-100,2)+pow(mouseY-130,2))<pow(40,2)&&mousePressed)
  scale+=zoomRate;
  if((pow(mouseX-100,2)+pow(mouseY-230,2))<pow(40,2)&&mousePressed)
  scale-=zoomRate;
}

void keyPressedContinuously() {
 switch(key){
 
     case 's' :
         translateY+=translateSpeed;
         break;
     case 'w':
         translateY-=translateSpeed;
         break;
     case 'd' :
         translateX+=translateSpeed;
         break;
     case 'a':
          translateX-=translateSpeed;
          break;
 

 
 }
}
