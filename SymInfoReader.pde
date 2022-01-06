

 ArrayList <Integer> loadSymInfo(String filename) {
  ArrayList<Integer> integers = new ArrayList();
    String [] text=loadStrings(filename);
     for(int i=0;i<text.length;i++){
     
             String a[]=splitTokens(text[i]);
             for(int j=0;j<a.length;j++){
             
                BigDecimal bd = new BigDecimal(a[j]);
                Integer val = bd.intValue();
                integers.add(val);
             }
     
     
     
     }
     
     



return integers;


}
 void loadTestMatches(String filename,String filename2) {
  
  String[] lines;
  String[] lines2;
  String[] numbers1;
  lines=loadStrings(filename); 
  lines2 =loadStrings(filename2);
 // println(lines.length);
 ArrayList<Integer> indexes=new ArrayList();
 for(int i=0;i<lines2.length;i++) {
  numbers1=split(lines2[i]," ");
  indexes.add(Integer.parseInt(numbers1[0]));

 }
 for (int i=0 ;i< lines.length;i++)  {
   numbers1=split(lines[i]," ");


 source.add(vertices.get(indexes.get(Integer.parseInt(numbers1[0]))));
 
 target.add(new MyPair(source.get(i).vertexNo,indexes.get(Integer.parseInt(numbers1[1]))));

// println("corr "+source.get(i)+" "+target.get(i));
}

for(Vertex vert: source ) {
      if(vert.region==0) {
          TestLeftHand.add(vert);
      }
      else if(vert.region==1) {
          TestRightHand.add(vert);
      
      }
      else if(vert.region==2) {
          TestLeftFoot.add(vert);
          
      
      }
      else if(vert.region==3) {
          TestRightFoot.add(vert);
      }
      else {
          TestMainReg.add(vert);
      
      }
      

}


}
