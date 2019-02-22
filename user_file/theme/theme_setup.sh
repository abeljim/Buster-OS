#!/bin/bash
# scripts written for setting up a fresh RPM based system

gsettings set org.gnome.desktop.background picture-uri file:///usr/share/user_file/theme/rikka.png

mkdir -p $HOME/.config/autostart 
cat >> $HOME/.config/autostart/plank.desktop << EOF
[Desktop Entry]
Name=Plank
GenericName=Dock
Comment=Stupidly simple.
Comment[ar]=بسيط بغباء.
Comment[bg]=Пределно прост.
Comment[bs]=Glupavo jednostavan.
Comment[ca]=Estúpidament simple.
Comment[cs]=Stupidně jednoduchý.
Comment[de]=Lächerlich einfach.
Comment[el]=Βλακωδώς απλό.
Comment[en_AU]=Stupidly simple.
Comment[en_CA]=Stupidly simple.
Comment[en_GB]=Stupidly simple.
Comment[eo]=Stulte simple.
Comment[es]=Estúpidamente simple.
Comment[et]=Hämmastavalt lihtne.
Comment[eu]=Erraza baino errazagoa.
Comment[fi]=Todella yksinkertainen.
Comment[fr]=Stupidement simple.
Comment[ga]=Simplíocht shimplí.
Comment[gd]=Cho furasta 's a ghabhas.
Comment[gl]=Estupidamente simple.
Comment[he]=טפשי עד כמה שזה פשוט
Comment[hr]=Neviđeno jednostavan
Comment[hu]=Nagyszerűen egyszerű.
Comment[id]=Begitu sederhana.
Comment[it]=Stupidamente semplice.
Comment[ja]=超シンプル
Comment[ka]=ძალიან მარტივი აი ძალიან
Comment[ko]=어처구니없으리 만치 단순한.
Comment[lt]=Kvailai paprastas.
Comment[lv]=Muļķīgi vienkārši.
Comment[ml]=അനായാസം.
Comment[ms]=Ringkas la sangat.
Comment[nb]=Uforstandig enkelt.
Comment[ne]=एकदमै सरल
Comment[nl]=Belachelijk eenvoudig.
Comment[nn]=Idiotsikkert
Comment[pl]=Idiotycznie prosty.
Comment[pt]=Estupidamente simples.
Comment[pt_BR]=Estupidamente simples.
Comment[ro]=Stupid de simplu.
Comment[ru]=До безумного прост.
Comment[sk]=Primitívne jednoduchý.
Comment[sl]=Bedasto preprost.
Comment[sma]=dle dan aelhkies.
Comment[sr]=Шашаво једноставно.
Comment[sr@latin]=Glupavo jenostavan.
Comment[sv]=Galet enkelt.
Comment[ta]=மிகவும் எளிது
Comment[te]=చాలా సరళమైనది.
Comment[th]=ง่ายเหี้ยๆ
Comment[tr]=Son derece basit.
Comment[uk]=Просто легкий.
Comment[uz]=Ahmoqona darajada sodda.
Comment[vi]=Cực kì đơn giản.
Comment[zh_CN]=简单得无语。
Comment[zh_TW]=極簡。
Categories=Utility;
Type=Application
Exec=plank
Icon=plank
Terminal=false
NoDisplay=false
NotShowIn=Pantheon;
EOF


print_message "Theme installation setup done\n"