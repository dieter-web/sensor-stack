sensors {
    sensor {
        id = "temp1",
        type = "temperature",
        driver = "dht22",
        pin = 4,
        interval = "5s",
        filter = {
            median = 3,
            smooth = 0.2
        }
    }
}

rules {
    rule {
        when = "temp1 > 25",
        action = "fan_on"
    }
}

actions {
    action {
        id = "fan_on",
        type = "gpio",
        pin = 12,
        value = 1
    }
}

local M = { _sensors = {}, _actions = {}, _rules = {}}

function sensors(def)
    for _, s in ipairs(def) do table.insert(M._sensors, s) end
end

function action(def)
    for _, a in ipairs(def) do table.insert(M._actions, a) end
end

function rules(def)
    for _, r in ipairs(def) do table.insert(M._rules, r) end
end

function sensor(t) return t end
function action(t) return t end
function rule(t) return t end

return M

