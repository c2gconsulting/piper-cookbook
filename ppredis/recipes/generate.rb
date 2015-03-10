node[:deploy].each do |appname, deployconfig|
  # determine root folder of new app deployment
  approot = "#{deployconfig[:deployto]}/current"

  # use template .redis.json.erb. to generate 'config/redis.json'
  template "#{approot}/config/redis.json" do
    source "redis.json.erb"
    cookbook "ppredis"

    # set mode, group and owner of generated file
    mode 00660
    group deployconfig[:group]
    owner deployconfig[:user]

    # only generate a file if there is Redis configuration
    # notif do
    #   deploy_config[:redis].blank?
    # end
  end
end