set current_stage 1

function title
  set_color green
  echo -e "\n - STAGE $current_stage $argv[1]\n"
  set_color normal
  set current_stage (math $current_stage + 1)
end

function update_all
  # title " - Fetching New Mirror List"
  # fetch new mirrors

  title "Refreshing Package Databases"
  sudo pacman -Syy

  title "Updating Arch Keyring"
  sudo pacman -S archlinux-keyring --needed

  title "Updating Official Packages"
  sudo pacman -Su --disable-download-timeout

  if test (command -v paru)
    title "Updating Unofficial Packages (paru)"
    paru --gendb  # make paru aware of all -git packages upstream updates if not installed by it
    paru -Su --disable-download-timeout
  else if test (command -v aura)
    title "Updating Unofficial Packages (aura)"
    sudo aura -Akuax
  else if test (command -v yay)
    title "Updating Unofficial Packages (yay)"
    yay -Su --disable-download-timeout
  end

  title "Removing Orphan Packages"
  sudo pacman -Rns (pacman -Qtdq)

  if test (command -v pkgfile)
    title "Updating Repo Files Lists"
    sudo pkgfile -u
  end

  if test (sudo bootctl is-installed)
    title "Updating SystemD Boot"
    sudo bootctl update

    set efi_shell_src_path "/usr/share/edk2-shell/x64/Shell_Full.efi"
    if test -e $efi_shell_src_path
        sudo cp $efi_shell_src_path /boot/shellx64.efi
        echo "EFI shell copied to /boot/shellx64.efi"
    else
        echo "EFI shell file not available"
    end
  end

  title "Updating Fish Completions"
  fish_update_completions

  # title "Rebuilding Font Cache Files"
  # fc-cache -frv

  title "Check For failed services"
  systemctl --failed

  title "Check For .pacnew/.pacsave Files"
  find /etc -regextype posix-extended -regex ".+\.pac(new|save)" 2> /dev/null
end
