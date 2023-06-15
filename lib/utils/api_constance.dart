/// https://newsapi.org/v2/everything?q=bitcoin&apiKey=b57d9b1784c443c7955c0941978f7b11
class ApiConstance {
  static const basicApi = 'b57d9b1784c443c7955c0941978f7b11';
  static const basicUrl = 'https://newsapi.org/v2';
  static const String getAllNews = '$basicUrl/everything?q=bitcoin&apiKey=$basicApi';
}
