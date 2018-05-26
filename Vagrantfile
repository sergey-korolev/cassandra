Vagrant.configure("2") do |c|
#  c.berkshelf.enabled = false if Vagrant.has_plugin?("vagrant-berkshelf")
  c.vm.box = "bento/ubuntu-16.04"
#  c.vm.hostname = "default-bento-ubuntu-1604.vagrantup.com"

  c.vm.synced_folder ".", "/vagrant", disabled: true

  c.vm.provider :digital_ocean do |p, override|
    override.ssh.private_key_path = ENV['DIGITALOCEAN_SSH_KEY_PATH']
    p.ssh_key_name = ENV['DIGITALOCEAN_SSH_KEY_NAME']
    p.token = ENV['DIGITALOCEAN_ACCESS_TOKEN']
    p.ssh_key_ids= ENV['DIGITALOCEAN_SSH_KEY_IDS']
    p.image = 'ubuntu-16-04-x64'
    p.size = '4gb'
    p.region = 'nyc1'
  end

  c.vm.provision :shell, inline: 'DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev build-essential && pip install --upgrade pip'

  c.vm.provision :ansible do |ansible|
    ansible.playbook      = "default.yml"
    ansible.sudo          = true
    ansible.groups        = {
        "cassandra_nodes" => ["node-1"],
        "cassandra_nodes:vars" => {
            "seed" => "true",
            "install_version" => "apache",
            "user" => "ubuntu",
            "install_user" => "cassandra",
            "deployment_environment" => "",
            "cluster_name" => "cassandra_cluster_1",
            "num_tokens" => "256",
            "dc" => "DC2",
            "rack" => "RAC1",
            "repair_weekday" => "*",
            "repair_start_hour" => "03",
            "repair_start_minute" => "15",
            "cron_repair_enabled" => "true"
        }
    }
  end

  (1..1).each do |i|
    c.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
    end
  end

end
