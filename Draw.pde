


void drawShape() {
    PShape skeleton;
    skeleton=createShape();
    skeleton.beginShape(TRIANGLES);
    for(int i=0;i<triangles.size();i++){
        Vertex v0,v1,v2;
        Triangle triangle=triangles.get(i);
        v0=vertices.get(triangle.v0);
        v1=vertices.get(triangle.v1);
        v2=vertices.get(triangle.v2);
        // skeleton.noFill();
        skeleton.strokeWeight(0.5f);
        //float ort0=(v0.renk.v0+v1.renk.v0+v2.renk.v0)/3.0f;
        //float ort1=(v0.renk.v1+v1.renk.v1+v2.renk.v1)/3.0f;
        //float ort2=(v0.renk.v2+v1.renk.v2+v2.renk.v2)/3.0f;
        //skeleton.fill(color(int(ort0),int(ort1),int(ort2)));
        skeleton.stroke(v0.renk.v0,v0.renk.v1,v0.renk.v2);
        skeleton.vertex(v0.getCoordinates().x,v0.getCoordinates().y,v0.getCoordinates().z);
        skeleton.stroke(v1.renk.v0,v1.renk.v1,v1.renk.v2);
        skeleton.vertex(v1.getCoordinates().x,v1.getCoordinates().y,v1.getCoordinates().z);
        skeleton.stroke(v2.renk.v0,v2.renk.v1,v2.renk.v2);
        skeleton.vertex(v2.getCoordinates().x,v2.getCoordinates().y,v2.getCoordinates().z);
      
    }
    
    
    
    
    skeleton.endShape();
 
    sekil.addChild(skeleton);
    
    

}
