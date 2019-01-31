# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

e_header "Adding extra repos and packages"

# Pre-requisite
sudo apt-get install -y software-properties-common

# ADD ARRAY, THEN UPDATE FOR LOOP SEQUENCE!

# Array, with ppa name first, followed by packages
declare -a a1=(ppa:pi-rho/dev tmux)
declare -a a2=(ppa:jonathonf/vim vim)
#declare -a a2=(ppa:lvillani/i3 i3-wm)

for i in $(seq 2) # Update Number, then done..
do
	array="a$i"
	ppa_name=${array[0]}
	var=${array[@]:1}
	pkgs+=${!var}
  sudo add-apt-repository -y "${ppa_name}"
done

# Read packages as array
IFS=' ' read -a packages <<< "$pkgs"

# Update as we've added ppa repositories
sudo apt-get -qq update

for package in "${packages[@]}"
do
	echo "$package"
	sudo apt-get install -y $package
done
