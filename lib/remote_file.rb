require 'net/http'

module RemoteFile
  def self.exists?(url)
    return false if url.nil?

    begin
      url = URI.parse(url)
      Net::HTTP.start(url.host, url.port) do |http|
        code = http.head(url.request_uri).code
        return ["200", "301", "302"].include? code.to_s
      end
    rescue
      false
    end
  end
end
