node[:deploy].each do |appname, deployconfig|
  # determine root folder of new app deployment
  approot = "#{deployconfig[:deploy_to]}/current"

  # use template .redis.json.erb. to generate 'config/redis.json'
  template "#{approot}/shared/config/redis.json" do
    source "redis.json.erb"
    cookbook "ppredis"

    # set mode, group and owner of generated file
    mode 00660
    group deployconfig[:group]
    owner deployconfig[:user]

    # only generate if it's a valid nodejs app
    only_if do
       deployconfig[:application_type] == 'nodejs'
    end
  end
end