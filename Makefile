run_app:
	python3 app.py & echo $$! > myapp.pid & sleep 30

	wget -r http://127.0.0.1:8050/
	wget -r http://127.0.0.1:8050/_dash-layout
	wget -r http://127.0.0.1:8050/_dash-dependencies

	wget -r -np -nH --cut-dirs=1 http://127.0.0.1:8050/_dash-component-suites/
	wget -r -np -nH --cut-dirs=1 http://127.0.0.1:8050/assets/

	mkdir -p pages_files
	mv 127.0.0.1:8050/* pages_files/
	ls -a ./
	ls -a pages_files

	for pattern in _dash-component-suites _dash-layout _dash-dependencies _reload-hash _dash-update-component assets; do \
	    find pages_files -type f -exec sed -i.bak "s|$$pattern|flight-ops/$$pattern|g" {} \; ; \
	done

	mv pages_files/_dash-layout pages_files/_dash-layout.json
	mv pages_files/_dash-dependencies pages_files/_dash-dependencies.json
	mv assets/* pages_files/assets/

	kill -9 $$(cat myapp.pid)

clean_dirs:
	ls
	rm -rf 127.0.0.1:8050/
	rm -rf pages_files/
	rm -rf joblib
