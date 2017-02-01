actions :create, :delete
default_action :create

attribute :name,  kind_of: String, required: true, name_attribute: true
attribute :base,  kind_of: String, default: '/tmp'
attribute :type,  kind_of: String, default: 'java',
                  equal_to: %w(java tomcat docker web)

attr_accessor :exists
