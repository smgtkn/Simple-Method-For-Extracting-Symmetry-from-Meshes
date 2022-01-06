void DivideS2LeftRight(ArrayList<Vertex> left,ArrayList<Vertex> right,ArrayList<Integer> S2,ArrayList<Vertex> S2LeftMain , ArrayList<Vertex> S2RightMain
,ArrayList<Vertex> S2LeftHand , ArrayList<Vertex> S2RightHand,ArrayList<Vertex> S2LeftFoot , ArrayList<Vertex> S2RightFoot){

  for(Integer i : S2) {
      Vertex temp=vertices.get(i);
      if(temp.region==0 && temp.mainRegion=='l') {
            S2LeftHand.add(temp);
           // Paint(255,0,255,temp.getCoordinates(),30);
      
      }
      else  if(temp.region==1 && temp.mainRegion=='r') {
            S2RightHand.add(temp);
            //  Paint(100,255,255,temp.getCoordinates(),30);
      
      }
      else  if(temp.region==2 && temp.mainRegion=='l') {
            S2LeftFoot.add(temp);
            // Paint(255,255,0,temp.getCoordinates(),30);
      }
      else  if(temp.region==3 && temp.mainRegion=='r') {
            S2RightFoot.add(temp);
            //  Paint(255,0,0,temp.getCoordinates(),30);
      
      }
      else if ( temp.mainRegion=='l'){
      
            S2LeftMain.add(temp);
            //  Paint(100,255,100,temp.getCoordinates(),30);
      
      }
      else {
      
            S2RightMain.add(temp);
             // Paint(100,255,100,temp.getCoordinates(),30);
      
      }
  
  
  
  
  
  
  
  
  
  }
  
  
  

}
