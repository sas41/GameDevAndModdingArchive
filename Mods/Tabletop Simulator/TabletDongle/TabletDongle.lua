syncedTablet = nil
url = nil
relative = false

function onUpdate()
    if syncedTablet ~= nil then
        if url ~= syncedTablet.getValue() then

            url = syncedTablet.getValue()

            local lastThree = string.sub(url, -3)
            local lastFour = string.sub(url, -4)
            if (lastThree == '.jpg' or lastThree == '.png' or lastFour == '.jpeg') then
                WebRequest.get(url, function(a) webRequestCallback(a, 'image') end)
            else
                    WebRequest.get(url, function(a) webRequestCallback(a, 'page') end)
            end

        end
    end
end

function onChat(message, player)
    if (player.admin) then
        local compare = '!MediaDongle relative'
        if string.sub(message, 1, string.len(compare)) == compare then
            relative = not relative
            print('Media Dongle Relative Path Mode: '..tostring(relative))
        end
    end
end

function onCollisionEnter(collision_info)
    if(collision_info.collision_object.tag == 'Tablet') then
        syncedTablet = collision_info.collision_object
    end
end

function webRequestCallback(webReturn, type)
    if type == 'image' then
        SpawnCustomBoard(webReturn.url)
    else
        DetectPlaylist(webReturn.text)
    end
end

function SpawnCustomBoard(imageURL)
end

function DetectPlaylist(pageBody)
    local count = 0
    local newPlayList = {}
    for hyperlink in string.gmatch(pageBody, "<a.-</a>") do

        local hyperlinkURL = string.match(hyperlink, "href=\".-\"")
        hyperlinkURL = string.sub(hyperlinkURL, 7, string.len(hyperlinkURL)-1)

        if string.sub(hyperlinkURL, -4) == '.mp3' then

            local hyperlinkInner = string.match(hyperlink, ">.-</a>")
            hyperlinkInner = string.sub(hyperlinkInner, 2, string.len(hyperlinkInner)-4)

            if  relative then
                local fullpath = url..hyperlinkURL
                table.insert(newPlayList, {url=fullpath, title=hyperlinkInner})
            else
                table.insert(newPlayList, {url=hyperlinkURL, title=hyperlinkInner})
            end

            count = count + 1
        end
    end

    if (count > 0) then
        print('Created a new playlist with ['..tostring(count)..'] itmes.')
        MusicPlayer.setPlaylist(newPlayList)
        MusicPlayer.setCurrentAudioclip(newPlayList[math.random(1,count)])
    end
end