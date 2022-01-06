void loadFile(String filename){
 int numbers[]=new int[3];

 ArrayList <Integer>  [] komsu;
 String[] lines;
 String[] numbers1;
 lines=loadStrings(filename); 
 PShape total=createShape(GROUP);
 numbers1=split(lines[1]," ");
 for (int i=0 ;i< numbers1.length;i++)  {
 numbers[i] = Integer.parseInt(numbers1[i]);
}
vertices=new ArrayList <Vertex>(numbers[0]);
//System.out.println(numbers[0]);
 for(int i=2;i<numbers[0]+2;i++){
   numbers1=split(lines[i]," ");

PVector vector=new PVector();
vector.x=Float.parseFloat(numbers1[0]);
vector.y=Float.parseFloat(numbers1[1]);
vector.z=Float.parseFloat(numbers1[2]);
//println(numbers1[0]+" "+vector.x+" "+vector.y+" "+vector.z);
vertices.add(new Vertex(vector,i-2));


}

int count=numbers[0];
int faces=numbers[1];
int loop=faces+count+2;
triangles=new ArrayList<Triangle>();
  float totalEdgeLength=0;
for(int i=count+2;i<loop;i++){
     numbers1=split(lines[i]," ");
     numbers[0]=Integer.parseInt(numbers1[1]);
     numbers[1]=Integer.parseInt(numbers1[2]);
     numbers[2]=Integer.parseInt(numbers1[3]); 
     //numbers[0]--;
     //numbers[1]--;
     //numbers[2]--;
     addKomsu(numbers[0],numbers[1],vertices);
     addKomsu(numbers[0],numbers[2],vertices);
     addKomsu(numbers[1],numbers[2],vertices);
     Triangle temp=new Triangle(numbers[0],numbers[1],numbers[2]);
     totalEdgeLength+=temp.alanHesapla(vertices);
     triangles.add(temp);
     
     
     int indexTri=triangles.size()-1;
     vertices.get(numbers[0]).ucgenKomsular.add(temp);
     vertices.get(numbers[1]).ucgenKomsular.add(temp);
     vertices.get(numbers[2]).ucgenKomsular.add(temp);
     

 }
 avgEdgeLength=totalEdgeLength/faces/3;
lines=null;
//for(Vertex vert : vertices){
//     // vert.findVertexArea();
//     // vert.findCurvature(vertices);

//}
meshArea=Triangle.findMeshArea(triangles);

return;
}
void addKomsu(int i,Integer vertex,ArrayList<Vertex> vertices) {
  ArrayList <Integer > komsular=vertices.get(i).getKomsular();
  for( int j=0; j<komsular.size();j++){
      if(vertex.equals(komsular.get(j))){
      return;
      }
    }    
 komsular.add(vertex);
 vertices.get(vertex).getKomsular().add(i);
 return;
}
 float FindDistance(PVector a,PVector b) {
  return   (float)Math.sqrt(Math.pow(a.x-b.x,2)+Math.pow(a.y-b.y,2)+Math.pow(a.z-b.z,2));
  }



void Paint(int color1,int color2,int color3,PVector v,float strokeWeight){
  PShape paint=createShape();
  paint.beginShape(POINTS);
  paint.strokeWeight(strokeWeight);
  paint.stroke(color(color1,color2,color3));
  paint.vertex(v.x,v.y,v.z);
  paint.endShape();
  sekil.addChild(paint);

}
void paintPath(ArrayList <Integer> path,ArrayList <Vertex> vertices,float color1,float color2,float color3){
  int size=path.size()-1;
  PVector a,b;
 PShape paintedPath=createShape();
 paintedPath.beginShape();
  
  paintedPath.strokeWeight(10f);
  paintedPath.noFill();
  paintedPath.stroke(color1,color2,color3);
  for (int i=0;i<size;i++){
 
   a=vertices.get(path.get(i)).getCoordinates();
   b=vertices.get(path.get(i+1)).getCoordinates();

  paintedPath.vertex(a.x,a.y,a.z);
  paintedPath.vertex(b.x,b.y,b.z);
  
  }
 paintedPath.endShape();

sekil.addChild(paintedPath);
}

void paintKomsu(ArrayList <Vertex>vertices) {
  

  PShape points2=createShape();

   points2.beginShape(POINTS);
         
          for (int i=0;i<vertices.get(pointedVertex).getKomsular().size();i++){
           int index=vertices.get(pointedVertex).getKomsular().get(i);
            points2.strokeWeight(10);
           // println(index);
    // println(pointedVertex+".vertex:"+vertices.get(index).x+" "+vertices.get(index).y+ " "+vertices.get(index).z);
         points2.stroke(color(255,0,255));
         points2.vertex(vertices.get(index).getCoordinates().x,vertices.get(index).getCoordinates().y,vertices.get(index).getCoordinates().z);
   
     
  
} 

points2.endShape();
sekil.addChild(points2);
}
