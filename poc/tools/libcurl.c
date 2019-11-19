#include <stdio.h>
#include <curl/curl.h>
int main(void) {
  CURL *curl = curl_easy_init();
  CURL *curl2 = curl_easy_init(); /* a second handle */
  CURLcode ret;
  if(curl) {
    CURLSH *shobject = curl_share_init();
    curl_share_setopt(shobject, CURLSHOPT_SHARE, CURL_LOCK_DATA_SSL_SESSION);
    curl_easy_setopt(curl, CURLOPT_URL, "https://www.google.com/");
    curl_easy_setopt(curl, CURLOPT_COOKIEFILE, "");
    curl_easy_setopt(curl, CURLOPT_SHARE, shobject);
    ret = curl_easy_perform(curl);
    curl_easy_cleanup(curl);
    curl_easy_setopt(curl2, CURLOPT_URL, "https://www.google.com/");
    curl_easy_setopt(curl2, CURLOPT_COOKIEFILE, "");
    curl_easy_setopt(curl2, CURLOPT_SHARE, shobject);
    ret = curl_easy_perform(curl2);
    curl_easy_cleanup(curl2);
    curl_share_cleanup(shobject);
  }
  return 0;
}
