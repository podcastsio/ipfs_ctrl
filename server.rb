require 'sinatra'

post '/download' do
  # download url and add to ipfs
  cid = `wget -q -O - #{params[:url]} | ipfs add -q`.chomp
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
  puts '***'
  p params[:episodes]
  puts '***'

  directory_path = "/data/podcasts/#{params[:bucket]}"

  `mkdir #{directory_path}`
  params[:episodes].each do |i, e|
    puts e
    `ipfs get #{e['cid']} -o #{directory_path}/#{e['filename']}`
  end
  return `cd #{directory_path} && hub buck init --name=#{params[:bucket]} --private=false --thread=#{params[:thread_id]} -q && hub buck push -y -f -q && hub buck archive -y`
end
