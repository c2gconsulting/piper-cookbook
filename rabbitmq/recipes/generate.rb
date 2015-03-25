node[:deploy].each do |appname, deployconfig|
  # determine root folder of new app deployment
  approot = "#{deployconfig[:deploy_to]}/current"

  # use template .rabbit.json.erb. to generate 'config/rabbit.json'
  template "#{approot}/shared/config/rabbit.json" do
    source "rabbit.json.erb"
    cookbook "rabbitmq"

    # set mode, group and owner of generated file
    mode 00660
    group deployconfig[:group]
    owner deployconfig[:user]

    # only generate if its a valid nodejs app
    only_if do
       deployconfig[:application_type] == 'nodejs'
    end

  end
end