require 'cgi'

def temp_cricinfo(params)
    url = 'https://search.espncricinfo.com/ci/content/site/search.html'
    return "#{url}?search=#{CGI.escape(params)}"
end

def get_url(command, params)
    command_url_map = {
        'cr' => temp_cricinfo(params)
    }
    return command_url_map[command]
end

def process_command_and_params(query)
    args = query.split(' ')
    command = args[0]
    params = args[1, args.length].join(' ')
    return get_url(command, params)
end

puts process_command_and_params('cr virat kohli')
