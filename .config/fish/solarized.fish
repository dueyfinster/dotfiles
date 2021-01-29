# http://ethanschoonover.com/solarized#the-values

# Use these settings if you've applied a Solarized theme to your terminal (for
# example, if "ls -G" produces Solarized output). i.e. if "blue" is #268bd2, not
# whatever the default is. (See "../etc/Solarized Dark.terminal" for OS X.)

set -g solarized_base03  --bold black
set -g solarized_base02  black
set -g solarized_base01  --bold green
set -g solarized_base00  --bold yellow
set -g solarized_base0   --bold blue
set -g solarized_base1   --bold cyan
set -g solarized_base2   white
set -g solarized_base3   --bold white
set -g solarized_yellow  yellow
set -g solarized_orange  --bold red
set -g solarized_red     red
set -g solarized_magenta magenta
set -g solarized_violet  --bold magenta
set -g solarized_blue    blue
set -g solarized_cyan    cyan
set -g solarized_green   green

# Use these settings if your terminal supports term256 and your terminal hasn't
# been configured with a Solarized theme.i.e. if "blue" is the default blue, not
# Solarized blue.
#
# set -l base03  002b36
# set -l base02  073642
# set -l base01  586e75
# set -l base00  657b83
# set -l base0   839496
# set -l base1   93a1a1
# set -l base2   eee8d5
# set -l base3   fdf6e3
# set -l yellow  b58900
# set -l orange  cb4b16
# set -l red     dc322f
# set -l magenta d33682
# set -l violet  6c71c4
# set -l blue    268bd2
# set -l cyan    2aa198
# set -l green   859900

# Used by fish's completion; see
# http://fishshell.com/docs/2.0/index.html#variables-color

set -g fish_color_normal      $solarized_base0
set -g fish_color_command     $solarized_base0
set -g fish_color_quote       $solarized_cyan
set -g fish_color_redirection $solarized_base0
set -g fish_color_end         $solarized_base0
set -g fish_color_error       $solarized_red
set -g fish_color_param       $solarized_blue
set -g fish_color_comment     $solarized_base01
set -g fish_color_match       $solarized_cyan
set -g fish_color_search_match --background $solarized_base02
set -g fish_color_operator    $solarized_orange
set -g fish_color_escape      $solarized_cyan

# Used by fish_prompt

set -g fish_color_user        $solarized_orange
set -g fish_color_host        $solarized_yellow
set -g fish_color_cwd         $solarized_green
set -g fish_color_git         $solarized_green
