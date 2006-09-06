Name:	imlib2-1.2.2
Version:	1.2.2
Release:	1
License:	GPL
Group:	Applications/System
Summary:	Please Fill this for a formal package
Source0:	/workspace/Software/imlib2-1.2.2.tar.gz
BuildRoot:	%{_tmppath}/%{name}-%{version}-build
%description
Please Fill this for a formal package

%prep
%setup -n %{name}-%{version}

%build
./configure 

%install
cd %{name}-%{version}-build
make DESTDIR=$RPM_BUILD_ROOT install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%dir /usr/local/lib/imlib2
%dir /usr/local/lib/pkgconfig
%dir /usr/local/lib/imlib2/loaders
%dir /usr/local/lib/imlib2/filters
%dir /usr/local/share/imlib2
%dir /usr/local/share/imlib2/data
%dir /usr/local/share/imlib2/data/fonts
%dir /usr/local/share/imlib2/data/images
/usr/local/lib/libImlib2.so.1.2.1
/usr/local/lib/libImlib2.so.1
/usr/local/lib/libImlib2.so
/usr/local/lib/libImlib2.la
/usr/local/lib/libImlib2.a
/usr/local/lib/imlib2/loaders/jpeg.so
/usr/local/lib/imlib2/loaders/jpeg.la
/usr/local/lib/imlib2/loaders/jpeg.a
/usr/local/lib/imlib2/loaders/png.so
/usr/local/lib/imlib2/loaders/png.la
/usr/local/lib/imlib2/loaders/png.a
/usr/local/lib/imlib2/loaders/tiff.so
/usr/local/lib/imlib2/loaders/tiff.la
/usr/local/lib/imlib2/loaders/tiff.a
/usr/local/lib/imlib2/loaders/gif.so
/usr/local/lib/imlib2/loaders/gif.la
/usr/local/lib/imlib2/loaders/gif.a
/usr/local/lib/imlib2/loaders/zlib.so
/usr/local/lib/imlib2/loaders/zlib.la
/usr/local/lib/imlib2/loaders/zlib.a
/usr/local/lib/imlib2/loaders/bz2.so
/usr/local/lib/imlib2/loaders/bz2.la
/usr/local/lib/imlib2/loaders/bz2.a
/usr/local/lib/imlib2/loaders/pnm.so
/usr/local/lib/imlib2/loaders/pnm.la
/usr/local/lib/imlib2/loaders/pnm.a
/usr/local/lib/imlib2/loaders/argb.so
/usr/local/lib/imlib2/loaders/argb.la
/usr/local/lib/imlib2/loaders/argb.a
/usr/local/lib/imlib2/loaders/bmp.so
/usr/local/lib/imlib2/loaders/bmp.la
/usr/local/lib/imlib2/loaders/bmp.a
/usr/local/lib/imlib2/loaders/xpm.so
/usr/local/lib/imlib2/loaders/xpm.la
/usr/local/lib/imlib2/loaders/xpm.a
/usr/local/lib/imlib2/loaders/tga.so
/usr/local/lib/imlib2/loaders/tga.la
/usr/local/lib/imlib2/loaders/tga.a
/usr/local/lib/imlib2/loaders/lbm.so
/usr/local/lib/imlib2/loaders/lbm.la
/usr/local/lib/imlib2/loaders/lbm.a
/usr/local/lib/imlib2/filters/testfilter.so
/usr/local/lib/imlib2/filters/testfilter.la
/usr/local/lib/imlib2/filters/testfilter.a
/usr/local/lib/imlib2/filters/bumpmap.so
/usr/local/lib/imlib2/filters/bumpmap.la
/usr/local/lib/imlib2/filters/bumpmap.a
/usr/local/lib/imlib2/filters/colormod.so
/usr/local/lib/imlib2/filters/colormod.la
/usr/local/lib/imlib2/filters/colormod.a
/usr/local/lib/pkgconfig/imlib2.pc
/usr/local/include/Imlib2.h
/usr/local/bin/imlib2_conv
/usr/local/bin/imlib2_show
/usr/local/bin/imlib2_test
/usr/local/bin/imlib2_bumpmap
/usr/local/bin/imlib2_poly
/usr/local/bin/imlib2_colorspace
/usr/local/bin/imlib2_view
/usr/local/bin/imlib2_grab
/usr/local/bin/imlib2-config
/usr/local/share/imlib2/data/fonts/cinema.ttf
/usr/local/share/imlib2/data/fonts/grunge.ttf
/usr/local/share/imlib2/data/fonts/morpheus.ttf
/usr/local/share/imlib2/data/fonts/notepad.ttf
/usr/local/share/imlib2/data/images/audio.png
/usr/local/share/imlib2/data/images/bg.png
/usr/local/share/imlib2/data/images/bulb.png
/usr/local/share/imlib2/data/images/cal.png
/usr/local/share/imlib2/data/images/calc.png
/usr/local/share/imlib2/data/images/folder.png
/usr/local/share/imlib2/data/images/globe.png
/usr/local/share/imlib2/data/images/imlib2.png
/usr/local/share/imlib2/data/images/lock.png
/usr/local/share/imlib2/data/images/mail.png
/usr/local/share/imlib2/data/images/menu.png
/usr/local/share/imlib2/data/images/mush.png
/usr/local/share/imlib2/data/images/paper.png
/usr/local/share/imlib2/data/images/sh1.png
/usr/local/share/imlib2/data/images/sh2.png
/usr/local/share/imlib2/data/images/sh3.png
/usr/local/share/imlib2/data/images/stop.png
/usr/local/share/imlib2/data/images/tnt.png

%changelog
* Wed Sep 06 2006 rajagopal <packager@imlib.com>
- Basic Changes
