local jobs = Config.Jobs

-- Function to handle job application
local function handleJobApplication(jobData)
    -- Show application form using ox_lib inputDialog
    local input = lib.inputDialog("Job Application - " .. jobData.job, {
        {type = 'input', label = 'Full Name', placeholder = 'John Pork', required = true},
        {type = 'input', label = 'Phone Number', placeholder = 'Phone Number(ic)', required = true},
        {type = 'textarea', label = 'Why should we hire you?', placeholder = 'Enter your reason...', required = true},
    })

    -- If the form is submitted
    if input then
        -- Prepare data to be sent to the Discord webhook
        local name = input[1]
        local phone = input[2]
        local reason = input[3]
        local message = string.format("**New Job Application for %s**\n**Name:** %s\n**Phone:** %s\n**Reason:** %s", jobData.job, name, phone, reason)

        -- Check if webhook is available, if not, notify player
        if not jobData.webhook or jobData.webhook == '' then
            lib.notify({
                title = 'Error',
                description = 'No webhook is set for this job application. Please inform the server administrator.',
                type = 'error',
            })
            return -- Exit the function as there is no valid webhook
        end

        -- Send data to the server for Discord webhook
        TriggerServerEvent('job-application:submit', jobData.webhook, message)

        -- Notify player of successful submission
        lib.notify({
            title = 'Application Submitted',
            description = 'Your application has been submitted!',
            type = 'success',
        })
    else
        lib.notify({title = 'Application Canceled', type = 'inform'})
    end
end

-- Setup target options for each job
for _, job in ipairs(jobs) do
    local pedModel = job.ped
    local pedLocation = job.location
    local pedHeading = job.heading or 0.0  -- Default heading if not specified

    -- Create ped at the specified location
    local pedHash = GetHashKey(pedModel)
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(10)
    end
    local ped = CreatePed(4, pedHash, pedLocation.x, pedLocation.y, pedLocation.z, pedHeading, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    -- Define interaction
    if Config.useOxTarget then
        -- Use ox_target
        exports.ox_target:addLocalEntity(ped, {
            {
                name = 'apply_' .. job.job,
                label = 'Apply for ' .. job.job,
                icon = 'fas fa-clipboard',
                distance = 2.5,
                onSelect = function()
                    handleJobApplication(job)
                end
            }
        })
    else
        -- Use qb-target
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    label = 'Apply for ' .. job.job,
                    icon = 'fas fa-clipboard',
                    action = function()
                        handleJobApplication(job)
                    end
                }
            },
            distance = 2.5
        })
    end
end
