require "savon"

module Bluecat
  class Client
    def initialize(wsdl: '')
      @client ||= Savon.client(wsdl: wsdl, ssl_verify_mode: :none)
    end

    def ops
      @client.operations
    end

    def ip4_networks(container_id)
      start = 0
      count = 10

      Enumerator.new do |yielder|
        loop do
          response = @client.call(:get_ip4_networks_by_hint, message: { container_id: container_id, start: start, count: count, options: '' }, cookies: @cookies)
          retval = response.body[:get_ip4_networks_by_hint_response][:return]

          raise StopIteration if retval == nil

          # Last item will be hash if not more than one. Make it an array.
          retval[:item] = [retval[:item]] unless retval[:item].is_a?(Array)

          retval[:item].each do | item |
            range = item[:properties].split('|')[0].split('=')[1]
            yielder.yield({ id: item[:id], name: item[:name], ip_range: range })
          end

          start += count
        end
      end
    end

    def login(username, password)
      response = @client.call(:login, message: { username: username, password: password })
      @cookies = response.http.cookies
    end

    def logout
      @client.call(:logout, cookies: @cookies)
    end
  end
end