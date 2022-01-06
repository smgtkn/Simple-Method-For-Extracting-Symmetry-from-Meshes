void func(ArrayList<Vertex> vertices,ArrayList<MyPair<Integer>> previousMatches) {
for(int i=0;i<matches.size();i++) {

  vertices.get(matches.get(i).siraNo).dijk =(vertices.get(matches.get(i).siraNo).dijk==null)?new Dijkstra2(vertices,matches.get(i).siraNo,2f):vertices.get(matches.get(i).siraNo).dijk;
  vertices.get(matches.get(i).vertexNo).dijk= (vertices.get(matches.get(i).vertexNo).dijk==null)?new Dijkstra2(vertices,matches.get(i).vertexNo,2f):vertices.get(matches.get(i).vertexNo).dijk;
}
 

  for(int i=0;i<vertices.size();i++) {
  int leftCount=0;
  int rightCount=0;
 Vertex vert=vertices.get(i);
    for(int j=0;j<100 && j<previousMatches.size();j++){
      
         if( vertices.get(previousMatches.get(j).x).dijk.distances.get(i).distance<vertices.get(previousMatches.get(j).y).dijk.distances.get(i).distance){
             leftCount++;
         }
         else{
             rightCount++;
         }
            
         
    
    }
    if(leftCount>rightCount){
        vertices.get(i).mainRegion=1;
         if(vertices.get(i).region==0 || vertices.get(i).region==1)
              leftHandReg2.add(vertices.get(i));
        else if(vertices.get(i).region==2 || vertices.get(i).region==3)
              leftFootReg2.add(vertices.get(i));
         else{
             mainRegLeft2.add(vertices.get(i));
         }
    }
        
    else{
        vertices.get(i).mainRegion=2;
        if(vertices.get(i).region==0 || vertices.get(i).region==1)
             rightHandReg2.add(vertices.get(i));
        else if(vertices.get(i).region==2 || vertices.get(i).region==3)
              rightFootReg2.add(vertices.get(i));
       else{
             mainRegRight2.add(vertices.get(i));
       }
    }

}
//for(Vertex vert : vertices){
  
//  if(vert.mainRegion==2)
//      vert.setRenk(0,0,255);
//}

              
 //for(Vertex vert: vertices) {
 //       ArrayList<Integer> komsular=vert.getKomsular();
 //       for(Integer i: komsular) {
        
 //            // if(vertices.get(i).mainRegion!=vert.mainRegion && vert.region!=0 && vert.region!=1 && vert.region!=2 && vert.region!=3){
 //               if(vertices.get(i).mainRegion!=vert.mainRegion){
              
 //               // vert.setRenk(0,0,255);

 //                 break;
              
 //             }
              
 //            //  if((vertices.get(i).region==0 && vert.region==1) || (vertices.get(i).region==1 && vert.region==0) || (vertices.get(i).region==3 && vert.region==2) || (vertices.get(i).region==2 && vert.region==3 )){
 //            ////   if(vertices.get(i).mainRegion!=vert.mainRegion){
              
 //            //     vert.setRenk(0,0,255);

 //            //     break;
              
 //            // }
        
        
        
 //       }  
 // }
  
  //for(int i=0;i<previousMatches.size();i++) {
  
  //         PVector start=vertices.get(previousMatches.get(i).x).getCoordinates();
          
  //        PVector end=vertices.get(previousMatches.get(i).y).getCoordinates();
  //         Paint(255,0,255,start,10);
  //         Paint(0,255,0,end,10);
   
  //        PShape line;
  //        line=createShape();
      
  //        line.beginShape(LINES);
  //        line.strokeWeight(2f);
  //        line.stroke(color(0,0,255));
  //        line.vertex(start.x,start.y,start.z);       
  //        line.vertex(end.x,end.y,end.z);
  
  //        line.endShape();
 
  //        sekil.addChild(line);
 
  //}
  
  
  
}

void func2(ArrayList<Vertex> vertices,ArrayList<MyPair<Integer>> previousMatches) {

 for(Vertex vert: vertices) {
        ArrayList<Integer> komsular=vert.getKomsular();
        for(Integer i: komsular) {
        
             // if(vertices.get(i).mainRegion!=vert.mainRegion && vert.region!=0 && vert.region!=1 && vert.region!=2 && vert.region!=3){
                if(vertices.get(i).mainRegion!=vert.mainRegion){
              
                  vert.setRenk(0,0,255);

                  break;
              
              }
              
   
        
        
        }  
  }
  

  
  
  
}
void elayakmatch(ArrayList<Dijkstra2> handsAndFeet) {
    PVector start=vertices.get(handsAndFeet.get(rightHand).vertexNo).getCoordinates();
    
     PVector end=vertices.get(handsAndFeet.get(leftHand).vertexNo).getCoordinates();
      
          PShape line;
          line=createShape();
      
          line.beginShape(LINES);
          line.strokeWeight(2f);
          line.stroke(color(0,0,255));
          line.vertex(start.x,start.y,start.z);       
          line.vertex(end.x,end.y,end.z);
  
          line.endShape();
 
          sekil.addChild(line);

        start=vertices.get(handsAndFeet.get(rightFoot).vertexNo).getCoordinates();
    
     end=vertices.get(handsAndFeet.get(leftFoot).vertexNo).getCoordinates();
      PShape line2;
          line2=createShape();
      
          line2.beginShape(LINES);
          line2.strokeWeight(2f);
          line2.stroke(color(0,0,255));
          line2.vertex(start.x,start.y,start.z);       
          line2.vertex(end.x,end.y,end.z);
  
          line2.endShape();
 
          sekil.addChild(line2);
   }

void Puanlama(float radius) {


        float radius005=0;
        float radius01=0;
        float radius015=0;
        float radius02=0;
        float radius025=0;
        for(MyTuple tuple : matches) {
              println(tuple.point+" rad "+radius*0.2);
              if(tuple.point< radius*0.05)
                      radius005++;
              if(tuple.point< radius*0.1)
                      radius01++;
              if(tuple.point< radius*0.15)
                      radius015++;
              if(tuple.point< radius*0.2)
                      radius02++;
              if(tuple.point< radius*0.25)
                      radius025++;
  
  
        }
  radius005/=matchSize;
  radius01/=matchSize;
  radius015/=matchSize;
  radius02/=matchSize;
  radius025/=matchSize;


 println( "*"+radius005+","+radius01+","+radius015+","+radius02+","+radius025+"*");






}



void Puanlama2(float meshArea) {
       double T=Math.sqrt(meshArea/(20*PI));
           
        int total=0;
        for(MyTuple tuple : matches) {
              if(tuple.point<T )
                 total++;
  
  
        }
 
 println( "%"+ (float)total/matches.size()*100+"-");






}

void Ayiklama() {
  for(int i=0;i<previousMatches.size();i++) {
  int leftCount=0;
  int rightCount=0,leftCount2=0,rightCount2=0;
  Vertex vert1=vertices.get(previousMatches.get(i).x);
    Vertex vert2=vertices.get(previousMatches.get(i).y);
    if(vert1.region==0 || vert1.region==1 || vert1.region==2 || vert1.region==3)
          continue;
    if(vert2.region==0 || vert2.region==1 || vert2.region==2 || vert2.region==3)
          continue;
          
    for(int j=0;j<previousMatches.size();j++){
      
         if( vertices.get(previousMatches.get(j).x).dijk.distances.get(previousMatches.get(i).x).distance<vertices.get(previousMatches.get(j).y).dijk.distances.get(previousMatches.get(i).x).distance){
             leftCount++;
         }
         else{
             rightCount++;
         }
         if( vertices.get(previousMatches.get(j).x).dijk.distances.get(previousMatches.get(i).y).distance<vertices.get(previousMatches.get(j).y).dijk.distances.get(previousMatches.get(i).y).distance){
             leftCount2++;
         }
         else{
             rightCount2++;
         }   
         
    
    }
    
    if((leftCount>rightCount && leftCount2>rightCount2 )|| (leftCount<rightCount && leftCount2<rightCount2 ) ){
            previousMatches.remove(i);
           
          
           matches.remove(i);
            i--;
           
            matchSize--;
            
    
    }


}


}
void DrawMatches() {
     for(int i=0;i<matches.size();i++) {
     
  
           PVector start=vertices.get(matches.get(i).vertexNo).getCoordinates();
          
          PVector end=vertices.get(matches.get(i).siraNo).getCoordinates();
           Paint(255,0,255,start,10);
           Paint(0,255,0,end,10);
   
          PShape line;
          line=createShape();
      
          line.beginShape(LINES);
          line.strokeWeight(2f);
          line.stroke(color(0,0,255));
          line.vertex(start.x,start.y,start.z);       
          line.vertex(end.x,end.y,end.z);
  
          line.endShape();
 
          sekil.addChild(line);
 
  }


}
