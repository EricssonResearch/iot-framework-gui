# Her::API.setup url: "http://srv1.csproj13.student.it.uu.se:8000/" do |c|
Her::API.setup url: "http://130.238.15.218:8000/" do |c|
  c.use Faraday::Request::UrlEncoded
  c.use Her::Middleware::DefaultParseJSON
	# c.use ESParser
  c.use Faraday::Adapter::NetHttp
end
