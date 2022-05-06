require 'socket'
require_relative 'url_maps'

server = TCPServer.new('localhost', 3000)

loop do
    socket = server.accept
    request = socket.gets
    STDERR.puts request

    method, full_path = request.split(' ')
    path, params = full_path.split('?')

    params = CGI.parse(params.gsub('?','')) if params
    query = params['q'].join(' ')
    redirect_url = process_command_and_params(query)
    STDERR.puts redirect_url

    output = "<html><head></head><body>#</body></html>" 
    headers = [
        "HTTP/1.1 302 Found", 
        "Location: #{redirect_url}\r\n\r\n", 
        "content-length: #\r\n\r\n"
    ].join("\r\n") 
    socket.puts headers 
    socket.puts output
end