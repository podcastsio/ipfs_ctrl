require 'sinatra'

post '/download' do
  # download url and add to ipfs
  cid = `wget -q -O /tmp/#{params[:filename]} #{params[:url]} && ipfs add /tmp/#{params[:filename]} -q`.chomp
  `rm /tmp/#{params[:filename]}`
  return cid
end

post '/check' do
  # check on filecoin bucket status
  return `cd /data/podcasts/#{params[:bucket]} && hub buck archive status`
end

post '/info' do
  # check on filecoin bucket status
  return `cd /data/podcasts/#{params[:bucket]} && hub buck archive info`
end

post '/show' do
  # check powergate info for cid
  return `hub pow show #{params[:cid]}`
end

post '/archive' do
  # push a list of episodes to textile bucket and enqueue archive to filecoin
  directory_path = "/data/podcasts/#{params[:bucket]}"

  `mkdir #{directory_path}`
  params[:episodes].each do |i, e|
    `ipfs get #{e['cid']} -o #{directory_path}/#{e['filename']}`
  end
  return `cd #{directory_path} && hub buck init --name=#{params[:bucket]} --private=false --thread=#{params[:thread_id]} -q && hub buck push -y -f -q && hub buck archive -y`
end

post '/push' do
  return `cd /data/podcasts/#{params[:bucket]} && hub buck push -y -f`
end

post '/retry_archive' do
  return `cd /data/podcasts/#{params[:bucket]} && hub buck push -y -f && hub buck archive -y`
end
