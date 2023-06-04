function pi --wraps='sudo pacman -Sy' --description 'alias pi sudo pacman -Sy'
  sudo pacman -Sy $argv
        
end
