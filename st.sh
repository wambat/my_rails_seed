#!/usr/bin/zsh

# Clear rbenv variables before starting tmux
unset RBENV_VERSION
unset RBENV_DIR

tmux start-server\; has-session -t drooms 2>/dev/null

if [ "$?" -eq 1 ]; then
  cd /home/wambat/work/ruby/droom_sandbox/drooms

  # Run pre command.
  

  # Create the session and the first window.
  TMUX= tmux new-session -d -s drooms -n editor /home/wambat/work/ruby/droom_sandbox/drooms


  # Create other windows.
  tmux new-window  -t drooms:1 -n server
  tmux new-window  -t drooms:2 -n logs


  # Window "editor"
  
  tmux send-keys -t drooms:0.0 '' C-m
  tmux send-keys -t drooms:0.0 emacs\ -nw C-m

  tmux splitw -c /home/wambat/work/ruby/droom_sandbox/drooms -t drooms:0
  tmux select-layout -t drooms:0 main-vertical
  
  tmux send-keys -t drooms:0.1 '' C-m
  tmux send-keys -t drooms:0.1 guard C-m

  tmux select-layout -t drooms:0 main-vertical

  tmux select-pane -t drooms:0.0

  # Window "server"
  
  tmux send-keys -t drooms:1 bundle\ exec\ rails\ s C-m

  # Window "logs"
  
  tmux send-keys -t drooms:2 tail\ -f\ log/development.log C-m

  tmux select-window -t 0
fi

if [ -z "$TMUX" ]; then
  tmux -u attach-session -t drooms
else
  tmux -u switch-client -t drooms
fi
