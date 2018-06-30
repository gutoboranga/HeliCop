install:
	pip install -r requirements.txt
	
simulate-mobile:
	cd simulator; python run.py
	
simulate-keyboard:
	cd simulator; python simulation_keyboard.py
