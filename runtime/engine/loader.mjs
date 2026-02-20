import { LuaFactory } from "wasmoon";
import { readFile } from "fs/promises";
import { resolve } from "path";

export async function loadConfig() {
    const lua = await new LuaFactory().createEngine();
    const file = await readFile(resolve("dsl/config.lua"), "utf8");
    const mod = await lua.doString(file);
    return {
        sensors: mod._sensors,
        actions: mod._actions,
        rules: mod._rules,
    };
}
