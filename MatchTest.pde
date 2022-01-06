void FindMatchTest(  ArrayList<Vertex> leftReg,ArrayList<Vertex> rightReg,Dijkstra2 dijkMid,Dijkstra2 dijkStart,Dijkstra2 dijkEnd,Dijkstra2 leftHand,
 Dijkstra2 rightHand,Dijkstra2 leftFoot, Dijkstra2 rightFoot,int norm,ArrayList<Integer> bestMatchesStart,ArrayList<Integer> bestMatchesEnd,ArrayList<Dijkstra2> mids,int show ,int matchesCount,int elAyakDahilMi) {
       int sizeLeft=leftReg.size();
       int sizeRight=rightReg.size();
       
        if(sizeLeft==0 || sizeRight==0)
            return ;
        
        
        PriorityQueue<MyTuple> pq=new PriorityQueue(sizeLeft,new TupleComparator());
        int index=0;
       
         
        for(int j=0;j<sizeLeft;j++){
          
          
          
        //  println("hoooo " + vertices.get(leftReg.get(j).vertexNo));
            //if(vertices.get(leftReg.get(j).vertexNo).isMatched){
            //      continue;
            //  }
            double min=MAX_FLOAT;
            int leftIndex=leftReg.get(j).vertexNo;
            float distEnd=dijkEnd.distances.get(leftIndex).distance;
            float distStart=dijkStart.distances.get(leftIndex).distance;
            float distMid=dijkMid.distances.get(leftIndex).distance;
            float distLeftHand=leftHand.distances.get(leftIndex).distance;
            float distLeftFoot=leftFoot.distances.get(leftIndex).distance;
            float AGDleft=vertices.get(leftIndex).AGD;
            float [] distsToMiddles=new float[mids.size()];
          
            for(int k=0;k<mids.size();k++){
                      distsToMiddles[k]=mids.get(k).distances.get(leftIndex).distance;
            }
            double dist=0;
             int leftCount=0,rightCount=0;
   
          
            for(int i=0;i<sizeRight;i++){
                 int rightIndex=rightReg.get(i).vertexNo;
              
              if(vertices.get(rightReg.get(i).vertexNo).isMatched){
                  continue;
              }
 
               
                  switch(norm){
                
                
                    case 4:
                        dist=0;
                        
                        dist=Math.pow(abs(dijkMid.distances.get(rightIndex).distance-distMid)/dijkMid.distances.get(rightIndex).distance,2)+
                        Math.pow(abs(dijkStart.distances.get(rightIndex).distance-distStart)/dijkStart.distances.get(rightIndex).distance,2)+
                        Math.pow(abs(dijkEnd.distances.get(rightIndex).distance-distEnd)/dijkEnd.distances.get(rightIndex).distance,2);
                       
                      dist+=Math.pow(abs(rightHand.distances.get(rightIndex).distance-distLeftHand)/rightHand.distances.get(rightIndex).distance,2)+ 
                      Math.pow(abs(rightFoot.distances.get(rightIndex).distance-distLeftFoot)/rightFoot.distances.get(rightIndex).distance,2);
                        
                      for(int l=0;l<distsToMiddles.length;l++){
                          dist+=Math.pow(abs(mids.get(l).distances.get(rightIndex).distance-distsToMiddles[l])/mids.get(l).distances.get(rightIndex).distance,2);
                      }
                      for(int l=0;l<min(previousMatches.size(),400);l++) {
                              
                             dist+=Math.pow(abs(vertices.get(previousMatches.get(l).x).dijk.distances.get(rightIndex).distance-vertices.get(previousMatches.get(l).y).dijk.distances.get(leftIndex).distance)
                             /vertices.get(previousMatches.get(l).x).dijk.distances.get(rightIndex).distance,2)  ;
                      
                      }
                     
                        break;
                      
                }
          
                  if(dist<min ){
                            index=i;
                             min=dist;
              
                  }
          
             }
         //    pq.add(new MyTuple((float)min,leftIndex,rightReg.get(index).vertexNo));
        
         if(min<maxPoint){
              MyTuple match=new MyTuple((float)min,leftIndex,rightReg.get(index).vertexNo);
            int targetIndex=0;
               for(int k=0;k<target.size();k++){
                       if(target.get(k).x==match.vertexNo)
                             targetIndex=target.get(k).y;
               }
      
         
           vertices.get(match.siraNo).dijk=(vertices.get(match.siraNo).dijk==null)?new Dijkstra2(vertices,match.siraNo,targetIndex):vertices.get(match.siraNo).dijk;
            
            
            
         float quality1= (vertices.get(match.siraNo).dijk.distances.get(targetIndex).distance);
        matches.add(match);
        rightReg.get(index).isMatched=true;
        Vertex aa=leftReg.get(j);
        rightReg.get(index).setRenk(aa.renk.v0,aa.renk.v1,aa.renk.v2);
         match.point=quality1;
        matchSize++;
         }
      //  println("aloooooo");
        }
        //MyTuple match=matches.get(0);

        
  return;
}
