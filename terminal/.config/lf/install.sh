#!/bin/bash

ensure-lfrun() {
	if [ -f /usr/bin/lfrun ]; then
		echo "lfimg is installed"
	else
		echo "installing lfimg"
		git clone https://github.com/cirala/lfimg &&
			cd lfimg &&
			make install &&
			mv cleaner preview ~/.config/lf/ &&
			cd .. &&
			rm -r lfimg
	fi
}

install-lf() {
	local deps_pacman=(
		"lf"
		"ueberzug"
		"ffmpegthumbnailer"
		"imagemagick"
		"poppler"
		"bat"
		# "chafa"
		"unzip"
		# "7z"
		"unrar"
		"catdoc"
		"docx2txt"
		"odt2txt"
		"gnumeric"
		# "cdrtools"
		# "perl-image-exiftool"
		"glow"
	)

	sudo pacman -S "${deps_pacman[@]}"

	local deps_aur=(
		"epub-thumbnailer-git"
		"wkhtmltopdf"
		# "transmission"   # not worth it except you want the torrent client as well
		# "mcomix"
	)

	yay -S "${deps_aur[@]}"

	ensure-lfrun
}

install-lf
