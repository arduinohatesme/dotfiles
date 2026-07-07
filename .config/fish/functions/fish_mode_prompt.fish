function fish_mode_prompt
  set_color $fish_color_cwd
  switch $fish_bind_mode
    case default
      echo '[N] '
    case insert
      echo '[I] '
    case replace_one
      echo '[R] '
    case visual
      echo '[V] '
  end
  set_color normal
end
