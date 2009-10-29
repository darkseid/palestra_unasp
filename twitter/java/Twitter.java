import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.methods.*;
import java.io.IOException;


public class Twitter {


  public static void main(String args[]) throws Exception {

    Twitter twitter = new Twitter();

    System.out.println(twitter.getPublicTimeline());


  }

  /**
   * Obtem a timeline publica. Nao necessita de autenticacao, basicamente é um 
   * GET na URL http://twitter.com/statuses/public_timeline.xml
   *
   */
  public String getPublicTimeline() throws Exception {
    HttpClient client = new HttpClient();

    // get para obter a timeline publica
    GetMethod get = new GetMethod("/statuses/public_timeline.xml");

    // Criando o host, para onde sera enviada a requisicao
    HostConfiguration host = client.getHostConfiguration();
    host.setHost(new URI("http://twitter.com"));

    // executando o get na url de timeline publica do twitter
    client.executeMethod(host, get);

    // obtendo a resposta
    return get.getResponseBodyAsString();

  }

}
