void Partition4Regions ( ArrayList<Dijkstra2> handsAndFeet,  ArrayList<Vertex> leftHandReg, ArrayList<Vertex> rightHandReg,ArrayList<Vertex>leftFootReg,ArrayList<Vertex> rightFootReg,
ArrayList<Vertex> mainReg,ArrayList<Vertex> mainRegLeft,ArrayList<Vertex> mainRegRight,ArrayList<Vertex> leftHandRegFPS,ArrayList<Vertex> rightHandRegFPS
,ArrayList<Vertex> leftFootRegFPS,ArrayList<Vertex> rightFootRegFPS,ArrayList<Vertex> leftMainRegFPS,ArrayList<Vertex> rightMainRegFPS) {
   int size=vertices.size();
  
   Dijkstra2 leftHandDijk=handsAndFeet.get(leftHand);
   Dijkstra2 rightHandDijk=handsAndFeet.get(rightHand);
   Dijkstra2 leftFootDijk=handsAndFeet.get(leftFoot);
   Dijkstra2 rightFootDijk=handsAndFeet.get(rightFoot);
   int handsMid=leftHandDijk.findMiddle(rightHandDijk.vertexNo);
   int feetMid=leftFootDijk.findMiddle(rightFootDijk.vertexNo);
   Dijkstra2 handsMidDijk=new Dijkstra2 (vertices,handsMid,2f);
   Dijkstra2 feetMidDijk=new Dijkstra2 (vertices,feetMid,2f);
   
   //Paint (255,0,0,vertices.get(handsMid).getCoordinates(),40);
   //Paint (255,0,0,vertices.get(feetMid).getCoordinates(),40);
   int lefthandcount=0; int righthandcount=0;int  leftfootcount=0; int rightfootcount=0; int mainregcount=0;
   for(int i=0;i<size;i++) {
     Vertex vert=vertices.get(i);
     if(leftHandDijk.distances.get(i).distance<= leftHandDijk.distances.get(handsMid).distance){
         leftHandReg.add(vert);
         vert.region=0;
       //  lee-avgEdgeLength*7t.add(vert);
         
        vert.mainRegion='l';
       //  vert.setRenk(255, 140, 0);

     }
     else  if(rightHandDijk.distances.get(i).distance<= rightHandDijk.distances.get(handsMid).distance){
         rightHandReg.add(vert);
         vert.region=1;
         vert.mainRegion='r';
         //right.add(vert);
        // vert.setRenk(229, 204, 255);

     }
     else  if(leftFootDijk.distances.get(i).distance<= leftFootDijk.distances.get(feetMid).distance){
         leftFootReg.add(vert);
         vert.region=2;
         vert.mainRegion='l';
        // left.add(vert);
         //vert.setRenk(255, 140, 0);

     }
     else  if(rightFootDijk.distances.get(i).distance<= rightFootDijk.distances.get(feetMid).distance){
         rightFootReg.add(vert);
         vert.region=3;
         //ri-avgEdgeLength*7ght.add(vert);
         vert.mainRegion='r';
        // vert.setRenk(229,204,255);

     }
     else {
       
        mainReg.add(vert);
        vert.region=4;
     
     }
     
   
   
   }
   int numOfFPS=Math.round(vertices.size()*0.11f/100)+1;
   //println("heyyyy "+vertices.size()*0.11f/100);
   FPS leftHandFPS = new FPS(leftHandReg,numOfFPS);
   FPS rightHandFPS = new FPS(rightHandReg,numOfFPS);
   FPS leftFootFPS = new FPS(leftFootReg,numOfFPS);
   FPS rightFootFPS = new FPS(rightFootReg,numOfFPS);
   leftHandFPS.farthestPoint(leftHandReg,leftHandReg.get(0).vertexNo,vertices);
   rightHandFPS.farthestPoint(rightHandReg,rightHandReg.get(0).vertexNo,vertices);
   leftFootFPS.farthestPoint(leftFootReg,leftFootReg.get(0).vertexNo,vertices);
   rightFootFPS.farthestPoint(rightFootReg,rightFootReg.get(0).vertexNo,vertices);



    for(Vertex vert: vertices) {
     long leftcount=0;
  long rightcount=0;
       for(int i=0;i<numOfFPS;i++){
     
           for(int j=0;j<numOfFPS;j++) {
           // if(leftHandDijk.distances.get(vert.vertexNo).distance<leftFootDijk.distances.get(vert.vertexNo).distance){
              
                 if(leftHandFPS.samples[i].distances.get(vert.vertexNo).distance<
                 rightHandFPS.samples[j].distances.get(vert.vertexNo).distance) {
                    
                    leftcount++;                 
                 }   
                 
                  if(leftHandFPS.samples[j].distances.get(vert.vertexNo).distance>
                  rightHandFPS.samples[i].distances.get(vert.vertexNo).distance) {
                 
                    rightcount++;                
                 }          
              
           
           
                 if(leftFootFPS.samples[i].distances.get(vert.vertexNo).distance<
                 rightFootFPS.samples[j].distances.get(vert.vertexNo).distance) {
                 
                    leftcount++;
                
                 }   
                 
                  if(leftFootFPS.samples[j].distances.get(vert.vertexNo).distance>
                  rightFootFPS.samples[i].distances.get(vert.vertexNo).distance) {                 
                    rightcount++;                 
                 
                 }        
            
    
         }
 
      }
      if(rightcount>=leftcount) {
     //  vert.setRenk(229, 204, 255);
      vert.setRenk(192, 192, 192);   
       
        if(vert.region!=0 && vert.region!=1 && vert.region!=2 && vert.region!=3)
         vert.mainRegion='r';
       
        
      
      }
      else if(leftcount>=rightcount){
  //    vert.setRenk(255, 140, 0);
      vert.setRenk(192, 192, 192);
      if(vert.region!=0 && vert.region!=1& vert.region!=2 && vert.region!=3)
       vert.mainRegion='l';
      
      
      }
      
     

  }
  
  for(Vertex vert : mainReg ) {
      
        if(vert.mainRegion=='l'){
                 mainRegLeft.add(vert);
              
          
          
          
          }
          else {
                mainRegRight.add(vert);
          }
  
  
  
  }
    
   FPS mainRegFPSPoints=new FPS(mainReg,Math.round(vertices.size()*0.22f/100)+1);
   //println("main reg size " + Math.round(vertices.size()*0.22f/100));
    mainRegFPSPoints.farthestPoint(mainReg,mainReg.get(2).vertexNo,vertices);
   for(int k=1;k<Math.round(vertices.size()*0.11f/100)+1;k++)
   mainRegFPS.add(vertices.get(mainRegFPSPoints.samples[k].vertexNo));
    for(int k=1;k<numOfFPS;k++) {
      
   Vertex leftHandVert=vertices.get(leftHandFPS.samples[k].vertexNo);
   Vertex rightHandVert=vertices.get(rightHandFPS.samples[k].vertexNo);
   Vertex leftFootVert=vertices.get(leftFootFPS.samples[k].vertexNo);
   Vertex rightFootVert=vertices.get(rightFootFPS.samples[k].vertexNo);

   if(leftHandVert.region==0 )
      leftHandRegFPS.add(vertices.get(leftHandFPS.samples[k].vertexNo));
   if(rightHandVert.region==1 )    
      rightHandRegFPS.add(vertices.get(rightHandFPS.samples[k].vertexNo));
   if(leftFootVert.region==2 )
      leftFootRegFPS.add(vertices.get(leftFootFPS.samples[k].vertexNo));
   if(rightFootVert.region==3)    
      rightFootRegFPS.add(vertices.get(rightFootFPS.samples[k].vertexNo));
 
  }
   

 
  
}
