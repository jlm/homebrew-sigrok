class Libsigrok < Formula
  homepage "https://sigrok.org/"
  url "https://sigrok.org/download/source/libsigrok/libsigrok-0.5.1.tar.gz"
  sha256 "e40fde7af98d29e922e9d3cbe0a6c0569889153fc31e47b8b1afe4d846292b9c"
  head "git://sigrok.org/libsigrok", :using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "doxygen"
  depends_on "glib"
  depends_on "glibmm"
  depends_on "libtool"
  depends_on "libusb"
  depends_on "libzip"
  depends_on "libftdi" => :optional
  depends_on "libserialport" => :optional

  def install
    ENV.delete "PYTHONPATH"
    if build.head?
      system "./autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}", "--disable-java", "--disable-sysclk-lwla"
    system "make", "install"
    system "ln", "-s", "/usr/local/share/", "#{share}"
  end
end
