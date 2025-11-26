# PowerShell helper to create a venv, install requirements and run the test MQTT broker
param(
    [string]$python = "python"
)

$cwd = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $cwd

if (-Not (Test-Path .venv)) {
    & $python -m venv .venv
}

$activate = Join-Path $cwd '.venv\Scripts\Activate'
. $activate

pip install --upgrade pip
pip install -r requirements.txt

python Server.py
