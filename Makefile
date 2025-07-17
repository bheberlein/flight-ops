run_app:
	python3 app.py & sleep 30

	wget -r http://127.0.0.1:8050/
	wget -r http://127.0.0.1:8050/_dash-layout
	wget -r http://127.0.0.1:8050/_dash-dependencies

	wget -r -np -nH --cut-dirs=1 http://127.0.0.1:8050/_dash-component-suites/

	mkdir -p pages_files/assets
	mv 127.0.0.1:8050/* pages_files
	ls -a pages_files
	ls -a pages_files/assets

	find pages_files -type f -exec sed -i.bak 's|_dash-component-suites|flight-ops/_dash-component-suites|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|_dash-layout|flight-ops/_dash-layout.json|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|_dash-dependencies|flight-ops/_dash-dependencies.json|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|_reload-hash|flight-ops/_reload-hash|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|_dash-update-component|flight-ops/_dash-update-component|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|assets|flight-ops/assets|g' {} \;

	mv pages_files/_dash-layout pages_files/_dash-layout.json
	mv pages_files/_dash-dependencies pages_files/_dash-dependencies.json

	ps -C python -o pid= | xargs -r kill -9

clean_dirs:
	ls
	rm -rf 127.0.0.1:8050/
	rm -rf pages_files/
	rm -rf joblib
