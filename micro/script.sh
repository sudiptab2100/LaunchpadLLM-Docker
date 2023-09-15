cd LaunchpadLLM || exit
ls
pwd
export HF_TOKEN="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"
printenv HF_TOKEN
source env/bin/activate
python src/llm_server.py