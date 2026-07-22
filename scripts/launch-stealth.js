const { spawn } = require("child_process")
const fs = require("fs")
const path = require("path")

const root = path.join(__dirname, "..")
const mainJs = path.join(root, "dist-electron", "main.js")

if (!fs.existsSync(mainJs)) {
  console.error(
    "App is not built yet. Run stealth-run.bat, stealth-run-silent.vbs, or npm run build first."
  )
  process.exit(1)
}

const electronPath = require("electron")
const child = spawn(electronPath, [mainJs], {
  cwd: root,
  env: { ...process.env, NODE_ENV: "production" },
  detached: true,
  stdio: "ignore"
})

child.unref()

console.log("App launched in the background. Press Ctrl+B (Cmd+B on Mac) to show the window.")
console.log("You can close this terminal - the app will keep running.")
