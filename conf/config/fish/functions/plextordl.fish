function plextordl --description 'Download a video from youtube to plex'
  set token (cat ~/.webhook)
  curl -X POST --data "token=$token" --data "type=$argv[1]" --data "uri=$argv[2]" https://ballyda.com:8080/hooks/add-torrent
end
