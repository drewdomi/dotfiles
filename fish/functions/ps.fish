function ps --wraps='pacman -Ss' --description 'alias ps pacman -Ss'
  pacman -Ss $argv
        
end
