REPO = 'git@github.com:cnacorrea/puppet.git'
SSH = 'ssh -t -A -l confman'

desc "Run Puppet on ENV['CLIENT']"
task :apply do
	client = ENV['CLIENT']
	sh "git push"
	sh "#{SSH} #{client} pull-updates"
end

desc "Bootstrap Puppet on ENV['CLIENT'] with hostname ENV['HOSTNAME']"
task :bootstrap do
	client = ENV['CLIENT']
	hostname = ENV['HOSTNAME'] || client
	commands = <<BOOTSTRAP
sudo hostname #{hostname} && \
echo #{hostname} > ~/hostname && \
sudo cp -f ~/hostname /etc/hostname && \
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb && \
sudo dpkg -i puppetlabs-release-precise.deb && \
sudo apt-get update && sudo apt-get -y install git puppet && \
echo \"Host github.com\n\tStrictHostKeyChecking no\n\" >> ~/.ssh/config && \
git clone #{REPO} puppet && \
sudo puppet apply --modulepath=/home/confman/puppet/modules /home/confman/puppet/manifests/site.pp
BOOTSTRAP
	sh "#{SSH} #{client} '#{commands}'"
end
