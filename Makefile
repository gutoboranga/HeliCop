install:
	pip install -r requirements.txt
	
simulate-mobile:
	cd simulator; python run.py
	
simulate-keyboard:
	cd simulator; python simulation_keyboard.py

pre_quest:
	@open -a "Google Chrome" https://docs.google.com/forms/d/e/1FAIpQLSdH9s1hu7KVuQ4WUhLCbXoxgSZ-Y9SzQpmLX9UI5Yv35z125Q/viewform?usp=sf_link

post_keyboard_quest:
	@open -a "Google Chrome" https://docs.google.com/forms/d/e/1FAIpQLSepYY0dEtEZ4lwkPqcFda6dl86NOoDafIJXET90HfGyV_Cbpw/viewform?usp=sf_link
	
post_mobile_quest:
	# @echo "não foi feito ainda"
	@open -a "Google Chrome" LINK