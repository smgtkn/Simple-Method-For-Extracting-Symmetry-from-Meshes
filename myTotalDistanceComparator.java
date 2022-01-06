import java.util.Comparator;
public class myTotalDistanceComparator implements Comparator<Dijkstra2>
{  
    public int compare( Dijkstra2 a, Dijkstra2 b )
    {
        if( a.total- b.total==0){
        return 0;}
        else if( a.total- b.total<0){
        return -1;}
         else{
        return 1;}
    }
}
