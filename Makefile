flavors=dev,qa,prod

setup: .check_flavor
	@echo "[APP] setup environment $(flavor)"
	@(cp -f $(shell pwd)/.secrets/$(flavor)/dart_define.json .dart_define.json)
	@make .setup_enviroment
	@make .finish_setup environment=$(flavor)
	

.check_flavor:
ifeq ($(flavor),)
	$(error "flavor is required. eg. make flavor=<value> $(MAKECMDGOALS)")
endif
ifeq ($(findstring $(flavor),$(flavors)),)
	$(error "flavor is invalid. Possibles values are: $(flavors) eg. make flavor=<value> $(MAKECMDGOALS)")
endif

.setup_enviroment:
	@(grep -o '"[^"]*"[[:space:]]*:[[:space:]]*"[^"]*"' .dart_define.json | sed 's/"//g; s/[[:space:]]*:[[:space:]]*/=/;' > temp.txt)
	@(while IFS="=" read -r key value; do [ -n "$$key" ] && echo "$$key=$$value"; done < temp.txt > .env)

.finish_setup: 
	@(cp -v .secrets/$(environment)/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist)
	@(cp -v .secrets/$(environment)/firebase_app_id_file.json ios/firebase_app_id_file.json)
	@(cp -v .secrets/$(environment)/firebase_options.dart lib/firebase_options.dart)
	@(cp -v .secrets/$(environment)/google-services.json android/app/google-services.json)
	@(cp -v .secrets/$(environment)/google-services.json android/app/google-services.json)
	@(cp -v .secrets/certificates/Android/android-key.jks android/app/key.jks )
	@(cp -v .secrets/certificates/Android/android-key.properties android/app/key.properties )