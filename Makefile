.PHONY: run build deploy

run:
	flutter run

build:
	flutter build apk --release

deploy: build
	git checkout main
	$(eval CURRENT_VERSION := $(shell grep '^version:' pubspec.yaml | sed 's/version: //'))
	$(eval CURRENT_NAME := $(shell echo $(CURRENT_VERSION) | cut -d+ -f1))
	$(eval CURRENT_BUILD := $(shell echo $(CURRENT_VERSION) | cut -d+ -f2))
	$(eval NEXT_BUILD := $(shell echo $$(($(CURRENT_BUILD) + 1))))
	$(eval NEXT_NAME := $(shell echo $(CURRENT_NAME) | awk -F. '{print $$1"."$$2"."$$3+1}'))
	$(eval NEXT_VERSION := $(NEXT_NAME)+$(NEXT_BUILD))
	sed -i '' 's/^version: .*/version: $(NEXT_VERSION)/' pubspec.yaml
	git add -A
	git commit -m "$$(copilot -sp 'Analyze the staged git changes and generate a concise commit message. Output ONLY the commit message. Do not execute any commands. Do not include quotes, markdown, explanation, or bullet points.')"
	git push origin main
	git tag "v$(NEXT_NAME)"
	git push origin "v$(NEXT_NAME)"
	gh release create "v$(NEXT_NAME)" \
		build/app/outputs/flutter-apk/app-release.apk \
		--title "v$(NEXT_NAME)" \
		--generate-notes
