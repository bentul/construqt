module Construqt
  module Flavour
    module Ciscian
      class DeployTemplate
        def self.write_template(host, flavour, ip, user, pass)
          template = <<-TEMPLATE
#!/bin/bash

CURRENT_DIR="`pwd`/$(dirname $0)"
if [[ ! -e $CURRENT_DIR ]]
then
CURRENT_DIR="$(dirname $0)"
fi

if [ -z "$CONSTRUQT_PATH" ]
then
if [[ $CURRENT_DIR =~ (.*construqt).* ]]
then
CONSTRUQT_PATH=${BASH_REMATCH[1]}
else
echo "could not automatically find construqt path"
exit
fi
fi

FLAVOUR="#{flavour}"
cd $CONSTRUQT_PATH
bash $CONSTRUQT_PATH/construqt/switch/deploy/deploy.sh $FLAVOUR #{ip} #{user} #{pass} "$CURRENT_DIR/$FLAVOUR.cfg"
cd - > /dev/null
TEMPLATE
                Util.write_str(template, File.join(host.name, "deploy.sh"))
              end
            end
          end
        end
      end
