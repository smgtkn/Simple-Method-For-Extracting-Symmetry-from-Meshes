import java.util.Comparator;
public class TupleComparator implements Comparator<MyTuple>
{  
    public int compare( MyTuple a, MyTuple b )
    {
        if( a.point- b.point==0){
        return 0;}
        else if( a.point- b.point<0){
        return -1;}
         else{
        return 1;}
    }
}
