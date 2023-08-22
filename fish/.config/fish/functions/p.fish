function p --description "Show repositories and changedir"
  ls ~/repos | fzf | read -l result;
  cd ~/repos/$result
end
