import java.util.Comparator;
public class myPointComparator implements Comparator<Vertex>
{  
    public int compare( Vertex a, Vertex b )
    {
        if( a.score- b.score==0){
        return 0;}
        else if( a.score- b.score<0){
        return -1;}
         else{
        return 1;}
    }
}
