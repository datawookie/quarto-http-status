-- HTTP status descriptions from the IANA HTTP Status Code Registry.
-- https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
local descriptions = {
  [100] = "Continue",
  [101] = "Switching Protocols",
  [102] = "Processing",
  [103] = "Early Hints",
  [104] = "Upload Resumption Supported",
  [200] = "OK",
  [201] = "Created",
  [202] = "Accepted",
  [203] = "Non-Authoritative Information",
  [204] = "No Content",
  [205] = "Reset Content",
  [206] = "Partial Content",
  [207] = "Multi-Status",
  [208] = "Already Reported",
  [226] = "IM Used",
  [300] = "Multiple Choices",
  [301] = "Moved Permanently",
  [302] = "Found",
  [303] = "See Other",
  [304] = "Not Modified",
  [305] = "Use Proxy",
  [307] = "Temporary Redirect",
  [308] = "Permanent Redirect",
  [400] = "Bad Request",
  [401] = "Unauthorized",
  [402] = "Payment Required",
  [403] = "Forbidden",
  [404] = "Not Found",
  [405] = "Method Not Allowed",
  [406] = "Not Acceptable",
  [407] = "Proxy Authentication Required",
  [408] = "Request Timeout",
  [409] = "Conflict",
  [410] = "Gone",
  [411] = "Length Required",
  [412] = "Precondition Failed",
  [413] = "Content Too Large",
  [414] = "URI Too Long",
  [415] = "Unsupported Media Type",
  [416] = "Range Not Satisfiable",
  [417] = "Expectation Failed",
  [421] = "Misdirected Request",
  [422] = "Unprocessable Content",
  [423] = "Locked",
  [424] = "Failed Dependency",
  [425] = "Too Early",
  [426] = "Upgrade Required",
  [428] = "Precondition Required",
  [429] = "Too Many Requests",
  [431] = "Request Header Fields Too Large",
  [451] = "Unavailable For Legal Reasons",
  [500] = "Internal Server Error",
  [501] = "Not Implemented",
  [502] = "Bad Gateway",
  [503] = "Service Unavailable",
  [504] = "Gateway Timeout",
  [505] = "HTTP Version Not Supported",
  [506] = "Variant Also Negotiates",
  [507] = "Insufficient Storage",
  [508] = "Loop Detected",
  [511] = "Network Authentication Required",
}

return {
  ["http-status"] = function(args)
    if #args ~= 1 then
      error("http-status expects exactly one status code, for example {{< http-status 404 >}}")
    end

    local code = pandoc.utils.stringify(args[1])
    if not code:match("^[1-5]%d%d$") then
      error("http-status expects a three-digit HTTP status code; got " .. string.format("%q", code))
    end

    local description = descriptions[tonumber(code)]
    if not description then
      error("http-status has no registered description for " .. code)
    end

    if quarto.doc.is_format("html") then
      quarto.doc.add_html_dependency({
        name = "http-status",
        stylesheets = { "http-status.css" },
      })
    end

    local classes = { "http-status" }
    local category = code:sub(1, 1)
    if category == "2" then
      table.insert(classes, "http-status-success")
    elseif category == "4" or category == "5" then
      table.insert(classes, "http-status-error")
    end
    table.insert(classes, "http-status-" .. code)

    return pandoc.Span(code .. " " .. description, pandoc.Attr("", classes))
  end,
}
