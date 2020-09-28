# ipfs ctrl server

examples:

cid = Typhoeus.post('http://127.0.0.1:4567/download', params: {url: e.enclosure_url}).body

status = Typhoeus.post('http://127.0.0.1:4567/check', params: {bucket: f.bucket_name}).body

archive = Typhoeus.post('http://127.0.0.1:4567/archive', params: {episodes: [{cid: '123', filename: 'abc.mp3'}], bucket: f.bucket_name, thread_id: f.thread_id})
