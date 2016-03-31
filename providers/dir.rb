use_inline_resources

# Support whyrun
def whyrun_supported?
  true
end

action :create do
  if @current_resource.exists
    if updated?
      converge_by("Create #{@new_resource}") do
        create_dir
      end
    else
      Chef::Log.info "#{@new_resource} already exists - nothing to do."
    end
  else
    converge_by("Create #{@new_resource}") do
      create_dir
    end
  end
end

action :delete do
  if @current_resource.exists
    converge_by("Delete #{@new_resource}") do
      delete_dir
    end
  else
    Chef::Log.info "#{@current_resource} does not exist - nothing to delete."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::ChefExampleDir.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.base(@new_resource.base)
  @current_resource.type(@new_resource.type)

  @current_resource.exists = ::File.directory?(build_path(@current_resource))
  @current_resource
end

def updated?
  diff = false
  diff = true if @current_resource.type != @new_resource.type
  diff = true if @current_resource.base != @new_resource.base
  diff
end

def build_path(res)
  ::File.join(res.base, res.type, res.name)
end

def create_dir
  directory build_path(new_resource) do
    owner     'root'
    group     'root'
    mode      0755
    recursive true
    action    :create
  end
end

def delete_dir
  directory build_path(new_resource) do
    action    :delete
  end
end
