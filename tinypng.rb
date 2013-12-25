require "net/https"
require "uri"
require "filesize"
require "json"
require "optparse"

def prettySize(filename)
    Filesize.from(File.size(filename).to_s + " B").pretty
end

class TinyPNG
    attr_accessor :uri, :http, :key
    
    def initialize
        @uri = URI.parse("https://api.tinypng.com/shrink")
        @http = Net::HTTP.new(uri.host, uri.port)
        self.http.use_ssl = true
        @key = "<YOUR API KEY HERE>"
        
        # Uncomment below if you have trouble validating our SSL certificate.
        # Download cacert.pem from: http://curl.haxx.se/ca/cacert.pem
        # http.ca_file = File.join(File.dirname(__FILE__), "cacert.pem")
    end
    
    
    def execute(input, output)
        request = Net::HTTP::Post.new(self.uri.request_uri)
        request.basic_auth("api", key)
        response = self.http.request(request, File.read(input))
        if response.code == "201"
            # Compression was successful, retrieve output from Location header.
            File.write(output, http.get(response["location"]).body)
            puts "Processed: '" + input +
                "' Compressed size: " + prettySize(output)
        else
            # Something went wrong! You can parse the JSON body for details.
            puts "Compression failed for file: '" + input + "'"
            errDescription = JSON.parse(response.body)
            puts "\tError (" + errDescription["error"] + "):" + errDescription["message"]
        end
    end
    
end

def browseDirectory(dirname, processor)
	Dir.open(dirname).each do |filename|
        if filename == "." || filename == ".."
            next
        end

        absPath = dirname + "/" + filename
        if File.directory? absPath
            browseDirectory(absPath, processor)
	    next
        end
        
        output = "_t_" + filename
        outputAbsPath = dirname + "/" + output
        if File.extname(filename).casecmp(".png") == 0
            puts "Processing: '" + absPath +
                "' Size: " + prettySize(absPath)
            processor.execute(absPath, outputAbsPath)
        end
    end
end


class ApplyCompression
   def execute(input, output)
       if (input =~ /_t_/) != nil
           newName = input[(input =~ /_t_/) + 3, input.length - 3]
           newName = File.dirname(input) + "/" + newName;
           p "Rename: '" + input + "' to '" + newName + "'"
           if File.exist?(newName)
               File.delete newName
            end
           File.rename(input, newName)
        end
   end
end

## ====== MAIN ==========

options = {}
options[:dir] = Dir.pwd
OptionParser.new do |opts|
    opts.banner = "Usage: [-d|--dir PATH] [--apply]"
    opts.on("-a", "--apply", "Apply compression files: rename temp file to source files names") do |apply|
        options[:apply] = apply
    end
    
    opts.on("-d", "--dir PATH", "Source files directory. Default: " + Dir.pwd) do |dir|
        options[:dir] = dir
    end
    
    opts.on_tail("-h", "--help", "Show this help") do
        puts opts
        exit
    end
end.parse!

processor = TinyPNG.new
if (options[:apply])
    processor = ApplyCompression.new
    p "Applying changes"
end

browseDirectory(options[:dir], processor)

