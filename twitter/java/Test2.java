import twitter4j.*;
import java.util.*;

public class Test2 {

  public static void main(String args[]) throws Exception {

    Twitter t = new Twitter("rafael_unasp", "rafael" );

    List statusList = t.getPublicTimeline();


    System.out.println("###### Timeline publica ######");
    for (Iterator i = statusList.iterator(); i.hasNext();) {
      Status status = (Status) i.next();
      System.out.println("Status => " + status.getText());
    }
  }

}
