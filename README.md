# renzu_minigame
Unique Minigame can be used in your scripts.
    - SAMPLE USAGE
`   
    local o = {
        --scenario = 'WORLD_HUMAN_AA_COFFEE',
        dict = "random@shop_gunstore",
        name = "_idle_b",
        flag = 1,
    }
    local result = exports.renzu_minigame:Start(o)

    if result then
        print('success')
    else
        print('fail)
    end
    
    `

