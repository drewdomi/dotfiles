function pr --wraps='sudo pacman -Rsn' --description 'alias pr sudo pacman -Rsn'
  sudo pacman -Rsn $argv
        
end
