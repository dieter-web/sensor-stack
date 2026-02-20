import { loadConfig} from "./engine/loader.mjs"
import { startRuntime } from "./engine/scheduler.mjs"
import { execFile } from "child_process";

async function validateWithHaskell(config) {
    return new Promise((resolve, reject) => {
        const p = execFile(
            "stack",
            ["run","--","validate"],
            {cwd: "core" },
            (err, stdout, stderr) => {
                if(err) return reject(err);
                const res = JSON.parse(stdout);
                if(res.ok) resolve();
                else reject(new Error(res.error));
                }
            );
            p.stdin.write(JSON.stringify(config));
            p.stdin.end();
            });
}

const config = await loadConfig();
await validateWithHaskell(config);
console.log("Config valid, starting runtime...");
startRuntime(config);


