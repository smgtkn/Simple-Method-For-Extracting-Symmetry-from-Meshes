void MatchHandsAndFeet(ArrayList<MyPair<Float>>MGDsOfHandsAndFeet){
  for(int i=0;i<4;i++) {
  
        for(int j=i+1;j<4;j++) {
             if(MGDsOfHandsAndFeet.get(j).x<MGDsOfHandsAndFeet.get(i).x ){
                   MyPair<Float> temp=  MGDsOfHandsAndFeet.get(j);
                   MGDsOfHandsAndFeet.set(j,MGDsOfHandsAndFeet.get(i));
                   MGDsOfHandsAndFeet.set(i,temp);
          }
     
        }
  
   }
   



} 

void DefineLeftRight(ArrayList<MyPair <Float> > MGDsOfHandsAndFeet,ArrayList<Dijkstra2> handsAndFeet) {

  
    int left1VertNo =handsAndFeet.get(Math.round(MGDsOfHandsAndFeet.get(0).y)).vertexNo;
    int right1VertNo =handsAndFeet.get(Math.round(MGDsOfHandsAndFeet.get(1).y)).vertexNo;
    int leftOrRight1VertNo =handsAndFeet.get(Math.round(MGDsOfHandsAndFeet.get(2).y)).vertexNo;
    int leftOrRight2VertNo =handsAndFeet.get(Math.round(MGDsOfHandsAndFeet.get(3).y)).vertexNo;
    leftHand=Math.round(MGDsOfHandsAndFeet.get(0).y); //buralar orijinali 0 1
    rightHand=Math.round(MGDsOfHandsAndFeet.get(1).y);
    
    
    
  if(handsAndFeet.get(leftHand).distances.get(leftOrRight1VertNo).distance< handsAndFeet.get(leftHand).distances.get(leftOrRight2VertNo).distance){
   
           leftFoot=Math.round(MGDsOfHandsAndFeet.get(2).y);
           rightFoot=Math.round(MGDsOfHandsAndFeet.get(3).y);

   }
   else {
   
          leftFoot=Math.round(MGDsOfHandsAndFeet.get(3).y);
           rightFoot=Math.round(MGDsOfHandsAndFeet.get(2).y);
           
   }



}
