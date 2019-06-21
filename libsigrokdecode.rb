class Libsigrokdecode < Formula
  homepage "https://sigrok.org/"
  url "https://sigrok.org/download/source/libsigrokdecode/libsigrokdecode-0.5.0.tar.gz"
  sha256 "4aa8579ecea9b421b8ac048a9b18c27e63206839f269374398d89c14a47bd1c1"
  head "git://sigrok.org/libsigrokdecode", :using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "jlm/sigrok/libsigrok"
  depends_on "python"

  def install
    ENV.delete "PYTHONPATH"
    if build.head?
      system "./autogen.sh"
    end
    py_ver = Formula["python"].pkg_version.to_s[0..2] # e.g "3.4"
    ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/#{py_ver}/lib/pkgconfig/"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
