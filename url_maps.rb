require 'cgi'

def temp_cricinfo(params)
    if params.length == 0
        return 'https://espncricinfo.com'
    end
    url = 'https://search.espncricinfo.com/ci/content/site/search.html?'
    return "#{url}search=#{CGI.escape(params)}"
end

def temp_ecosia(params)
    if params.length == 0
        return 'https://www.ecosia.org'
    end
    url = 'https://www.ecosia.org/search?'
    return "#{url}q=#{CGI.escape(params)}"
end

def get_url(command, params)
    command_url_map = {
        'cr' => temp_cricinfo(params),
        'ec' => temp_ecosia(params),
    }
    default_url = temp_ecosia(command + ' ' + params)
    return command_url_map[command] || default_url
end

def process_command_and_params(query)
    args = query.split(' ')
    command = args[0]
    params = args[1, args.length].join(' ')
    return get_url(command, params)
end