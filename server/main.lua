local function sendToDiscord(webhook, message)
    -- Check if the webhook is defined
    if not webhook or webhook == '' then
        print("^1[Job Application] Error: No webhook provided for this job.^0")
        return
    end

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
