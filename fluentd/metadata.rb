maintainer        'James Birmingham'
maintainer_email  'james@dimsum.tv'
license           'Apache 2.0'
description       'Installs and configures fluentd'
version           '0.1'

['debian','ubuntu'].each do |os|
  supports os
end

