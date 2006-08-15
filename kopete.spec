Name:	kopete
Version:	0.12
Release:	beta1
License:	GPL
Group:	Productivity/Networking
Summary:	KDE Instant Messenger
Source0:	http://superb-west.dl.sourceforge.net/sourceforge/kopete/kopete-0.12.0.tar.bz2
BuildRoot:	%{_tmppath}/%{name}-%{version}-build
%description
Kopete is an Instant Messaging client for AIM, Gadu-Gadu, ICQ, IRC, Jabber, GroupWise, MeanWhile, MSN, Yahoo and WinPopup. It uses the KDE platform and aims to provide integrated messaging that puts your contacts in the foreground, not the IM system they use.

%prep
cd %{_topdir}/BUILD
rm -rf %{name}-%{version}-build
tar -xjf %{_topdir}/SOURCES/

%build
cd %{name}-%{version}-build
./configure --enable-smpppd
%install
cd %{name}-%{version}-build
make install

%post
/sbin/ldconfig

%clean

%files
%defattr(-,root,root)
%dir /opt/kde3/share/services/kconfiguredialog
%dir /opt/kde3/%_lib/kconf_update_bin
%dir /opt/kde3/share/sounds
/opt/kde3/bin/kopete
/opt/kde3/bin/kopete_latexconvert.sh
/opt/kde3/share/icons/*/*/*/kopete*
/opt/kde3/share/mimelnk/application/x-icq.desktop
/opt/kde3/share/mimelnk/application/x-kopete-emoticons.desktop
/opt/kde3/share/services/aim.protocol
/opt/kde3/share/services/irc.protocol
/opt/kde3/%_lib/libkopete*
/opt/kde3/%_lib/kde3/kcm_kopete_*
/opt/kde3/%_lib/kde3/kopete_*
/opt/kde3/%_lib/kde3/libkrichtexteditpart.*
/opt/kde3/%_lib/kde3/kio_jabberdisco.*
/opt/kde3/%_lib/kde3/plugins/designer/libkopetewidgets.*
/opt/kde3/%_lib/kconf_update_bin/kopete-*
/opt/kde3/share/config.kcfg/historyconfig.kcfg
/opt/kde3/share/applications/kde/kopete.desktop
/opt/kde3/share/apps/kopete*
/opt/kde3/share/servicetypes/kopete*
/opt/kde3/share/services/kconfiguredialog/kopete*
/opt/kde3/share/services/kopete*.desktop
/opt/kde3/share/services/chatwindow.desktop
/opt/kde3/share/services/emailwindow.desktop
/opt/kde3/share/services/jabberdisco.protocol
/opt/kde3/share/sounds/Kopete*
/opt/kde3/share/apps/kconf_update/kopete-*
/opt/kde3/share/config.kcfg/latexconfig.kcfg
/opt/kde3/share/config.kcfg/kopete.kcfg
/opt/kde3/share/config.kcfg/kopeteidentityconfigpreferences.kcfg
/opt/kde3/share/config.kcfg/nowlisteningconfig.kcfg
/opt/kde3/include/kopete

%changelog
* Thu Mar 9 2006 Stephenson <<email>wstephenson@suse.de</email>>
- <Changes>Spec file created from dummy and kdenetwork3 by</Changes>
