import java.util.Comparator;
public class ScoreComparator implements Comparator<Score>
{  
    public int compare( Score a,Score b )
    {
        if(a.score - b.score==0){
        return 0;}
        else if( a.score- b.score<0){
        return -1;}
         else{
        return 1;}
    }
}
