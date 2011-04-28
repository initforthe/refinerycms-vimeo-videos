module Refinery
  module VimeoVideos
    class URLTempfile < Tempfile

      def initialize(url)
        @url = URI.parse(url)

        begin
          super('url', Dir.tmpdir, :encoding => 'ascii-8bit')

          Net::HTTP.start(@url.host) do |http|
            resp = http.get(@url.path)
            self.write resp.body
          end
        ensure
        end
      end

    end
  end
end