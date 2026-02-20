import * as dht22 from "../drivers/dht22.mjs";
import * as gpio from "../actions/gpio.mjs";
import { evalRule } from "./ruleEngine.mjs";

const drivers = { dht22 };
const actions = { gpio };

function parseInterval(str) {
    const n = Number(str.match("%d+")[0]);
    return n * 1000;
}

export function startRuntime(config) {
    const sensorValues = [];

    for(const s of config.sensors) {
        const drv = drivers[s.driver];
        const interval = parseIntervals(s.interval);
        setInterval(async() => {
            const v = await drv.read({pin: s.pin});
            sensorValues[s.id] = v;
            console.log(`[sensor] ${s.id} = ${v}`);
            runRules(config, sensorValues);
            }, interval);
    }

    function runRules(cfg, values) {
        for(const r of cfg.rules) {
            if(evalRule(r, values)) {
                const act = cfg.actions.find(a => a.id === r.action);
                const impl = actions[act.type];
                impl.execute({pin: act.pin, value: act.value});
            }
        }
    }
}
