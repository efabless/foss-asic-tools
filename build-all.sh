virtualenv -p python3 venv
source venv/bin/activate
pip3 install -r requirements.txt
python3 run.py recipe --csv recipes/recipe.csv

