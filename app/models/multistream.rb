class Multistream # < ActiveRecord::Base
  include Her::Model

  has_many :streams
  # accepts_nested_attributes_for :streams
  # attr_accessible :streams_attributes

  def post uid
    url = "#{CONF['API_URL']}/users/#{uid.to_s}/streams/"
    send_data(:post, url)
  end

  def put uid, sid
    url = "#{CONF['API_URL']}/users/#{uid.to_s}/streams/#{sid.to_s}"
    send_data(:put, url)
  end

  private
    def send_data(method, url)
      new_connection

      @conn.send(method) do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = @attributes.to_json
      end
    end

    def new_connection
      @conn = Faraday.new(:url => "#{CONF['API_URL']}") do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
end
