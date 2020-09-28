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

post '/archive' do
  puts '***'
  p params[:episodes]
  puts '***'

  # mkdir bucket
  # ipfs get episodes
  # hub buck init
  # hub buck push
  # hub buck archive
end
