 MyTuple FindMatch(  ArrayList<Vertex> leftReg,ArrayList<Vertex> rightReg,Dijkstra2 dijkMid,Dijkstra2 dijkStart,Dijkstra2 dijkEnd,Dijkstra2 leftHand,
 Dijkstra2 rightHand,Dijkstra2 leftFoot, Dijkstra2 rightFoot,int norm,ArrayList<Integer> bestMatchesStart,ArrayList<Integer> bestMatchesEnd,ArrayList<Dijkstra2> mids,int show ,int matchesCount,int elAyakDahilMi) {
       int sizeLeft=leftReg.size();
       int sizeRight=rightReg.size();
       
        if(sizeLeft==0 || sizeRight==0)
            return null;
        
        
        PriorityQueue<MyTuple> pq=new PriorityQueue(sizeLeft,new TupleComparator());
        int index=0;
       
         
        for(int j=0;j<sizeLeft;j++){
            if(vertices.get(leftReg.get(j).vertexNo).isMatched){
                  continue;
              }
              
              
              
              
              
              
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
           
            int region=vertices.get(leftIndex).region;
          
            for(int i=0;i<sizeRight;i++){
              
              
              if(leftIndex==rightReg.get(i).vertexNo)
                  continue;
              if(vertices.get(rightReg.get(i).vertexNo).isMatched){
                  continue;
              }
                  int rightIndex=rightReg.get(i).vertexNo;
                  
                  
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
                      for(int l=0;l<min(previousMatches.size(),100);l++) {
                              
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
             pq.add(new MyTuple((float)min,leftIndex,rightReg.get(index).vertexNo));

        }
         MyTuple match=null;
        for(int i=0;i<matchesCount;i++){
         
              if(pq.size()==0)
                  break;
              
             match=pq.poll();
             
              int leftCount=0,rightCount=0,leftCount2=0,rightCount2=0;
             for(int j=0;j<previousMatches.size();j++) {
              
               if(vertices.get(previousMatches.get(j).x).dijk.distances.get(match.vertexNo).distance<vertices.get(previousMatches.get(j).y).dijk.distances.get(match.vertexNo).distance){
                     leftCount++;
               }
               else {
                   rightCount++;
               }
               
               if(vertices.get(previousMatches.get(j).x).dijk.distances.get(match.siraNo).distance<vertices.get(previousMatches.get(j).y).dijk.distances.get(match.siraNo).distance){
                     leftCount2++;
               }
               else {
                   rightCount2++;
               }
               
               
           
             }
             if(maxPoint<match.point){
                 maxPoint=match.point;
             }
         
              if(true){
                 
                   if(leftCount>rightCount && leftCount>leftCount2  ){
              
                     previousMatches.add(new MyPair(match.vertexNo,match.siraNo));
                       if(vertices.get(match.vertexNo).dijk==null){
                         vertices.get(match.vertexNo).dijk=new Dijkstra2(vertices,match.vertexNo,2f);
                       }
                       if(vertices.get(match.siraNo).dijk==null){
                           vertices.get(match.siraNo).dijk=new Dijkstra2(vertices,match.siraNo,2f);
                       }
                 }
                 else{
                       previousMatches.add(new MyPair(match.siraNo,match.vertexNo));
                       if(vertices.get(match.vertexNo).dijk==null){
                         vertices.get(match.vertexNo).dijk=new Dijkstra2(vertices,match.vertexNo,2f);
                       }
                       if(vertices.get(match.siraNo).dijk==null){
                           vertices.get(match.siraNo).dijk=new Dijkstra2(vertices,match.siraNo,2f);
                       }
                       int temp=match.siraNo;
                       match.siraNo=match.vertexNo;
                       match.vertexNo=temp;
                       
                 }
           
               }
             
             
             matchSize++;

                 PVector start=vertices.get(match.vertexNo).getCoordinates();
                 bestMatchesStart.add(match.vertexNo);
          PVector end=vertices.get(match.siraNo).getCoordinates();
                 bestMatchesEnd.add(match.siraNo);
       // PVector realMatch=vertices.get(symInfo.get(match.vertexNo)).getCoordinates();
            
      //    float quality1= (vertices.get(match.siraNo).dijk.distances.get(symInfo.get(match.vertexNo)).distance);
        //  quality+=quality1; 
         if(show==1){
          //     match.point=quality1;
                matches.add(match);
                vertices.get(match.siraNo).isMatched=true;
                vertices.get(match.vertexNo).isMatched=true;
               
        }
        }
        if(mids.size()<80)
         BestMatchesMids( bestMatchesStart,  bestMatchesEnd, mids);
        
  return match;
}

ArrayList <Dijkstra2>  BestMatchesMids(ArrayList<Integer> bestMatchesStart, ArrayList<Integer> bestMatchesEnd, ArrayList<Dijkstra2 >midDijks) {
      int size=bestMatchesStart.size();
      ArrayList<Integer> mids=new ArrayList();
      for(int i=0;i<size;i++){
            Dijkstra2 start=new Dijkstra2(vertices,bestMatchesStart.get(i),bestMatchesEnd.get(i));
            int mid=start.findMiddle(bestMatchesEnd.get(i));
        
                  mids.add(mid);
      
      }
      int midsSize=mids.size();
     
      for(int i=0;i<midsSize;i++){
            boolean flag=true;
            for(int j=0;j<midDijks.size();j++){
                     if(midDijks.get(j).vertexNo==mids.get(i))
                             flag=false;
      
            }
            if(flag){
                  Dijkstra2 toAdd= new Dijkstra2(vertices,mids.get(i),2f);
               
                 // if(midDijks.size()<50)
                  midDijks.add(toAdd);
                  
            }      
      }

return midDijks;
}
