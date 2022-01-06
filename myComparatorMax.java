import java.util.Comparator;
public class myComparatorMax implements Comparator<shortestDistance>
{  
    public int compare( shortestDistance a, shortestDistance b )
    {
        if( a.distance- b.distance==0){
        return 0;}
        else if( a.distance- b.distance<0){
        return 1;}
         else{
        return -1;}
    }
}
