class Main{

  public static void main(String[] args) {
    String credential = System.getenv().get("KEY");
    HttpRequest request = HttpRequest.newBuilder()
      .uri(URI.create("https://3.238.116.57/v3/project/c-4dkwn:p-d59k7/workloads/deployment:swe645:swe634?action=redeploy"))
      .timeout(Duration.ofMinutes(1))
      .header("Content-Type", "application/json")
      .header("Accept", "application/json")
      .POST()
      .
      .build()


  }
}


// curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
// -X POST \
// -H 'Accept: application/json' \
// -H 'Content-Type: application/json' \
// 'https://3.238.116.57/v3/project/c-4dkwn:p-d59k7/workloads/deployment:swe645:swe634?action=redeploy'
