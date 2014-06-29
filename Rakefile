desc "Fetch dependencies"
task :bundle do
	sh "bundle install --quiet --path vendor/isolated_gems"
end

desc "Run a local VM"
task :boot do
	sh "vagrant up"
end

desc "Destroy the local VM and delete all files"
task :destroy do
	sh "vagrant destroy -f"
end