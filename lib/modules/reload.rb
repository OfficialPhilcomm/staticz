require "securerandom"

module Staticz
  module Modules
    class Reload
      def self.hash
        @@hash
      end

      def self.build_reload_js
        <<~JS
          var hash = null;
  
          function checkForChanges() {
            console.log("Check for file changes");
            var response = new XMLHttpRequest();
            response.open("GET", "api/test", true);
            response.onload = function() {
              if (response.status === 200) {
                if (!hash) {
                  console.log("Set initial hash")
                  hash = response.responseText
                }
                if (response.responseText !== hash) {
                  location.reload();
                }
              }
            }
            response.send(null);
          }
          checkForChanges()
          setInterval(checkForChanges, 1000);
        JS
      end

      def self.generate_hash
        @@hash = SecureRandom.uuid[0..6]
      end
    end
  end
end
