cd LaunchpadLLM
cd files
wget -c https://huggingface.co/TheBloke/Speechless-Llama2-Hermes-Orca-Platypus-WizardLM-13B-GGUF/resolve/main/speechless-llama2-hermes-orca-platypus-wizardlm-13b.Q5_K_M.gguf
wget -c https://ipfs.io/ipfs/QmNLmFcV3yQfshUMG7nRG8rjFR9jHCxnB1LrMG4hvnvXnD -O temp.zip
unzip temp.zip
rm -rf temp.zip
cd ..
python3 -m venv env
source env/bin/activate
export CMAKE_ARGS="-DLLAMA_CUBLAS=on" 
export FORCE_CMAKE=1
pip install --trusted-host pypi.python.org --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt
deactivate
cd ..