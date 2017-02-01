property :name, String, name_property: true
property :base, String, required: true
property :type, String, required: true, equal_to: %w(java tomcat docker web)

default_action :create

# No more load_current_resource block
# There is a new load_current_value, but that is primarily for pulling in
# data from an actual file/object on the box or a node attribute.

action :create do
  if updated?(new_resource)
    converge_by "creating #{name}" do
      directory build_path(new_resource) do
        owner     'root'
        group     'root'
        mode      '0755'
        recursive true
        action    :create
      end
    end
  end
end

action :delete do
  if ::File.directory?(build_path(new_resource))
    converge_by "deleting #{name}" do
      directory build_path(new_resource) do
        action    :delete
      end
    end
  end
end

def build_path(res)
  ::File.join(res.base, res.type, res.name)
end

def updated?(res)
  (base != res.base || type != res.type)
end
