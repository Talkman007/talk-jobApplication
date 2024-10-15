local function sendToDiscord(webhook, message)
    local discordData = {
        {
            ['color'] = 16711680,
            ['title'] = "Job Application",
            ['description'] = message,
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'Job Applications', embeds = discordData}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('job-application:submit')
AddEventHandler('job-application:submit', function(webhook, message)
    local _source = source
    sendToDiscord(webhook, message)
end)
