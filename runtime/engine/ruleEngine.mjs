export function evalRule(rule, sensorValues) {
    // sehr einfache Auswertung: "temp1 > 25"
    const [id, op, valStr] = rule.when.split(" ");
    const current = sensorValues[id];
    const threshold = Number(valStr);
    if(op === ">" && current > threshold) return true;
    if(op === "<" && current < threshold) return true;
    return false;
}
