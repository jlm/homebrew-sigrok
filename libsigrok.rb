class Libsigrok < Formula
  homepage "https://sigrok.org/"
  url "https://sigrok.org/download/source/libsigrok/libsigrok-0.5.0.tar.gz"
  sha256 "4c8c86779b880a5c419f6c77a08b1147021e5a19fa83b0f3b19da27463c9f3a4"
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
