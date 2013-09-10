REPO = 'git@github.com:cnacorrea/puppet.git'
SSH = 'ssh -t -A -l confman'

desc "Run Puppet on ENV['CLIENT']"
task :apply do
	client = ENV['CLIENT']
	sh "git push"
	sh "#{SSH} #{client} pull-updates"
end

desc "Bootstrap **Ubuntu** Puppet on ENV['CLIENT'] with hostname ENV['HOSTNAME']"
task :ubustrap do
	client = ENV['CLIENT']
	hostname = ENV['HOSTNAME'] || client
	commands = <<BOOTSTRAP
sudo hostname #{hostname} && \
echo #{hostname} > ~/hostname && \
sudo cp -f ~/hostname /etc/hostname && \
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb && \
sudo dpkg -i puppetlabs-release-precise.deb && \
sudo apt-get update && sudo apt-get -y install git puppet && \
mkdir -p ~/.ssh && \
echo \"Host github.com\n\tStrictHostKeyChecking no\n\" >> ~/.ssh/config && \
git clone #{REPO} puppet && \
sudo puppet apply --modulepath=/home/confman/puppet/modules /home/confman/puppet/manifests/site.pp
BOOTSTRAP
	sh "#{SSH} #{client} '#{commands}'"
end

desc "Bootstrap **CentOS 6** Puppet on ENV['CLIENT']"
task :el6strap do
	client = ENV['CLIENT']
	commands = <<BOOTSTRAP
sudo rpm -ivh --force http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm && \
sudo yum -y update && sudo yum -y install git puppet && \
mkdir -p ~/.ssh && \
echo \"Host github.com\n\tStrictHostKeyChecking no\n\" >> ~/.ssh/config && \
chmod 0600 ~/.ssh/config && \
git clone #{REPO} puppet && \
sudo puppet apply --modulepath=/home/confman/puppet/modules /home/confman/puppet/manifests/site.pp
BOOTSTRAP
	sh "#{SSH} #{client} '#{commands}'"
end

desc "Bootstrap **CentOS 5** Puppet on ENV['CLIENT']"
task :el5strap do
	client = ENV['CLIENT']
	commands = <<BOOTSTRAP
sudo rpm -ivh --force --nodeps http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-7.noarch.rpm && \
sudo yum -y --skip-broken update && sudo yum -y install git puppet && \
mkdir -p ~/.ssh && \
echo \"Host github.com\n\tStrictHostKeyChecking no\n\" >> ~/.ssh/config && \
chmod 0600 ~/.ssh/config && \
git clone #{REPO} puppet && \
sudo puppet apply --modulepath=/home/confman/puppet/modules /home/confman/puppet/manifests/site.pp
BOOTSTRAP
	sh "#{SSH} #{client} '#{commands}'"
end

desc "Add syntax check hook to your git repo"
task :add_check do
  here = File.dirname(__FILE__)
  sh "chmod +x #{here}/hooks/check_syntax.sh"
  sh "ln -s #{here}/hooks/check_syntax.sh #{here}/.git/hooks/pre-commit"
  puts "Puppet syntax check hook added"
end
