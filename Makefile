install:
	pip install -r requirements.txt

instructions_keyboard:
	@open instructions/key1.jpg instructions/key2.jpg

instructions_mobile:
	@open instructions/mobile1.jpg instructions/mobile2.jpg

simulate_keyboard:
	cd simulator; python simulation_keyboard.py
	
simulate_mobile:
	cd simulator; python run.py
	
pre_quest:
	@open https://docs.google.com/forms/d/e/1FAIpQLSdH9s1hu7KVuQ4WUhLCbXoxgSZ-Y9SzQpmLX9UI5Yv35z125Q/viewform?usp=sf_link

post_keyboard_quest:
	@open https://docs.google.com/forms/d/e/1FAIpQLSepYY0dEtEZ4lwkPqcFda6dl86NOoDafIJXET90HfGyV_Cbpw/viewform?usp=sf_link
	
post_mobile_quest:
	@open https://docs.google.com/forms/d/e/1FAIpQLScuAN3RwwcUf89M1pV0s6yqnr8TokXttpdtzXZ1w0gedsCuHQ/viewform?usp=sf_link
