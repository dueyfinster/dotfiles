function plexytdl --description 'Download a video from youtube to plex'
  token=(cat ~/.webhook)
  curl -X POST --data "token=$token" --data "type=$argv[1]" --data "uri=$argv[2]" https://ballyda.com/hooks/yt-dl
end
