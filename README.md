# renzu_minigame
Unique Minigame can be used in your scripts.
    - SAMPLE USAGE
`   
    local o = {
        --scenario = 'WORLD_HUMAN_AA_COFFEE',
        dict = "veh@break_in@0h@p_m_one@",
        name = "low_force_entry_ds",
        flag = 1,
    }
    local result = exports.renzu_minigame:Start(o)

    if result then
        print('success')
    else
        print('fail)
    end
    
    `

